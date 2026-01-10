import mysql.connector
from config import db_config

def create_requests_table():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        
        # Create Table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS REQUESTS (
                RequestID VARCHAR(20) PRIMARY KEY,
                CustomerID VARCHAR(20) NOT NULL,
                UtilityType VARCHAR(50),
                Status VARCHAR(20) DEFAULT 'Pending',
                RequestDate DATETIME DEFAULT CURRENT_TIMESTAMP,
                FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)
            )
        """)
        
        print("[OK] Created REQUESTS table.")
        conn.commit()
        conn.close()

    except mysql.connector.Error as err:
        print(f"❌ Error: {err}")

if __name__ == "__main__":
    create_requests_table()
