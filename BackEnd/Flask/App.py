from flask import Flask, jsonify, request
from flask_cors import CORS
import mysql.connector
from config import db_config

import json
from datetime import date, datetime
from decimal import Decimal

app = Flask(__name__)
# Enable CORS to allow frontend (e.g. file:// or localhost:5500) to access API
CORS(app) 

class CustomJSONEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, (date, datetime)):
            return obj.isoformat()
        if isinstance(obj, Decimal):
            return float(obj)
        return super().default(obj)

app.json_encoder = CustomJSONEncoder # For older Flask
app.json_provider_class = CustomJSONEncoder # For newer Flask? 
# Actually newer Flask uses app.json.provider. 
# Best way for Flask 2.2+ is:

from flask.json.provider import DefaultJSONProvider

class CustomJSONProvider(DefaultJSONProvider):
    def default(self, obj):
        if isinstance(obj, (date, datetime)):
            return obj.isoformat()
        if isinstance(obj, Decimal):
            return float(obj)
        return super().default(obj)

app.json = CustomJSONProvider(app) 

def get_db_connection():
    try:
        conn = mysql.connector.connect(**db_config)
        return conn
    except mysql.connector.Error as err:
        print(f"Error connecting to DB: {err}")
        return None

@app.route('/')
def home():
    return jsonify({"message": "UBMS Backend API is Running", "status": "active"})

# --- CUSTOMERS & AUTH ---

@app.route('/api/login', methods=['POST'])
def login():
    data = request.json
    role = data.get('role')
    
    if role == 'admin':
        # Simple admin check (in real app, use better auth)
        return jsonify({"success": True, "role": "admin"})
    
    customer_id = data.get('customerId')
    conn = get_db_connection()
    if conn is None:
        return jsonify({"success": False, "message": "Database connection failed"}), 500
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM CUSTOMER WHERE CustomerID = %s", (customer_id,))
    user = cursor.fetchone()
    cursor.close()
    conn.close()
    
    if user:
        return jsonify({"success": True, "role": "customer", "user": user})
    return jsonify({"success": False, "message": "Customer not found"}), 404

@app.route('/api/signup', methods=['POST'])
def signup():
    data = request.json
    conn = get_db_connection()
    if conn is None:
        return jsonify({"success": False, "message": "Database connection failed"}), 500
    cursor = conn.cursor()
    
    try:
        # Generate IDs (Auto-increment logic manually for strings 'CUST-XXXX')
        # Note: Ideally DB triggers or INT auto_increment, but following current schema pattern
        cursor.execute("SELECT CustomerID FROM CUSTOMER ORDER BY CustomerID DESC LIMIT 1")
        last_cust = cursor.fetchone()
        
        last_num = 0
        if last_cust:
            # Assuming format CUST-XXXX
            last_num = int(last_cust[0].split('-')[1])
            
        new_cust_id = f"CUST-{str(last_num + 1).zfill(4)}"
        new_acc_id = f"ACC-{str(last_num + 1).zfill(4)}"
        
        # Insert Customer
        sql_cust = """INSERT INTO CUSTOMER (CustomerID, FirstName, LastName, PhoneNumber, Email, ServiceAddress, City, ZipCode, AccountStatus) 
                      VALUES (%s, %s, %s, %s, %s, %s, %s, %s, 'Active')"""
        val_cust = (
            new_cust_id, data['FirstName'], data['LastName'], data['PhoneNumber'], 
            data['Email'], data['ServiceAddress'], data['City'], data['ZipCode']
        )
        cursor.execute(sql_cust, val_cust)
        
        # Insert Account
        sql_acc = "INSERT INTO ACCOUNT (AccountID, CustomerID, ServiceStartDate) VALUES (%s, %s, CURDATE())"
        val_acc = (new_acc_id, new_cust_id)
        cursor.execute(sql_acc, val_acc)
        
        conn.commit()
        return jsonify({"success": True, "customerId": new_cust_id, "accountId": new_acc_id})
        
    except Exception as e:
        conn.rollback()
        return jsonify({"success": False, "error": str(e)}), 500
    finally:
        cursor.close()
        conn.close()

# --- DATA FETCHING ---

@app.route('/api/customers', methods=['GET'])
def get_customers():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM CUSTOMER")
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(result)

@app.route('/api/meters/<customer_id>', methods=['GET'])
def get_meters(customer_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    # Join nicely to get meters for a customer via Account
    query = """
        SELECT m.* 
        FROM METER m
        JOIN ACCOUNT a ON m.AccountID = a.AccountID
        WHERE a.CustomerID = %s
    """
    cursor.execute(query, (customer_id,))
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(result)

@app.route('/api/bills', methods=['GET'])
def get_all_bills():
    # Admin endpoint to fetch all bills
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query = "SELECT * FROM BILL ORDER BY IssueDate DESC"
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(result)

@app.route('/api/bills/<customer_id>', methods=['GET'])
def get_bills(customer_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    query = """
        SELECT b.* 
        FROM BILL b
        JOIN ACCOUNT a ON b.AccountID = a.AccountID
        WHERE a.CustomerID = %s
        ORDER BY b.IssueDate DESC
    """
    cursor.execute(query, (customer_id,))
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(result)

@app.route('/api/customer-details/<customer_id>', methods=['GET'])
def get_customer_details(customer_id):
    conn = get_db_connection()
    if conn is None:
        return jsonify({"success": False, "message": "DB Error"}), 500
        
    cursor = conn.cursor(dictionary=True)
    
    # 1. Get Accounts
    cursor.execute("SELECT * FROM ACCOUNT WHERE CustomerID = %s", (customer_id,))
    accounts = cursor.fetchall()
    
    # 2. Get Meters (linked via AccountID or just by CustomerID if schema allows, but METER usually has AccountID)
    # Let's fetch all meters for these accounts
    meters = []
    if accounts:
        account_ids = [a['AccountID'] for a in accounts]
        # Format list for SQL IN clause
        format_strings = ','.join(['%s'] * len(account_ids))
        cursor.execute(f"SELECT * FROM METER WHERE AccountID IN ({format_strings})", tuple(account_ids))
        meters = cursor.fetchall()
        
    cursor.close()
    conn.close()
    
    return jsonify({
        "accounts": accounts,
        "meters": meters
    })

@app.route('/api/charges', methods=['GET', 'PUT'])
def handle_charges():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    if request.method == 'GET':
        cursor.execute("SELECT * FROM CHARGES")
        res = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(res)
    
    if request.method == 'PUT':
        data = request.json
        # Expect list of charges to update
        try:
            for item in data:
                sql = """UPDATE CHARGES SET RatePerUnit=%s, FixedCharge=%s, TaxPercentage=%s, ServiceFee=%s 
                         WHERE UtilityType=%s"""
                val = (item['RatePerUnit'], item['FixedCharge'], item['TaxPercentage'], item['ServiceFee'], item['UtilityType'])
                cursor.execute(sql, val)
            conn.commit()
            return jsonify({"success": True})
        except Exception as e:
            return jsonify({"success": False, "error": str(e)}), 500
        finally:
            cursor.close()
            conn.close()

# --- REQUESTS (Mock Table Logic if not in DB, assuming we create a REQUESTS table or use a file) ---
# Since SQL didn't have REQUESTS table originally, let's assume we need to handle it.
# For now, to keep Backend Robust, we SHOULD create a table.
# But for immediate usage without altering DB schema heavily, I will simulate or check if I should run a CREATE TABLE.
# I'll Assume there is a REQUESTS table. If not, this endpoint will fail until Migration.

@app.route('/api/requests', methods=['GET', 'POST', 'PUT'])
def handle_requests():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    
    if request.method == 'GET':
        # Admin View
        try:
            cursor.execute("SELECT * FROM REQUESTS") 
            res = cursor.fetchall()
            return jsonify(res)
        except:
            return jsonify([]) # Return empty if table doesn't exist yet

    if request.method == 'POST':
        # Create Request
        data = request.json
        try:
             # Check if table exists, if not create strictly for this flow (Optional, but good for "Make Backend")
            create_table_sql = """
            CREATE TABLE IF NOT EXISTS REQUESTS (
                RequestID VARCHAR(20) PRIMARY KEY,
                CustomerID VARCHAR(20),
                UtilityType VARCHAR(50),
                Status VARCHAR(20),
                RequestDate DATETIME
            )
            """
            cursor.execute(create_table_sql)
            
            sql = "INSERT INTO REQUESTS (RequestID, CustomerID, UtilityType, Status, RequestDate) VALUES (%s, %s, %s, %s, NOW())"
            val = (data['RequestID'], data['CustomerID'], data['UtilityType'], data['Status'])
            cursor.execute(sql, val)
            conn.commit()
            return jsonify({"success": True})
        except Exception as e:
            conn.rollback()
            return jsonify({"success": False, "error": str(e)}), 500
            
    if request.method == 'PUT':
        # Update Status
        data = request.json
        req_id = data.get('RequestID')
        status = data.get('Status')
        
        try:
            cursor.execute("UPDATE REQUESTS SET Status=%s WHERE RequestID=%s", (status, req_id))
            
            # If Approved and its a connection request, create Meter
            if status == 'Approved' and data.get('action') == 'connect':
                 # Mock Meter Creation Logic in DB
                 pass # Logic to insert into METER would go here
                 
            conn.commit()
            return jsonify({"success": True})
        except Exception as e:
            return jsonify({"success": False, "error": str(e)}), 500

    cursor.close()
    conn.close()


if __name__ == '__main__':
    app.run(debug=True, port=5000)
