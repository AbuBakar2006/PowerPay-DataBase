import mysql.connector
from config import db_config

def seed_data():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        
        # Check if empty
        cursor.execute("SELECT COUNT(*) FROM CUSTOMER")
        if cursor.fetchone()[0] > 0:
            print("Data already exists. Skipping seed.")
            return

        print("Seeding sample data...")
        
        # Insert Customer
        # Using VALUES from the SQL file pattern
        cursor.execute("""
            INSERT INTO CUSTOMER (CustomerID, FirstName, LastName, PhoneNumber, Email, Address, City, ZipCode, AccountStatus)
            VALUES 
            ('CUST-001', 'Alice', 'Smith', 1234567, 'alice@example.com', '123 Maple St', 'New York', 10001, 'Active'),
            ('CUST-002', 'Bob', 'Jones', 8765432, 'bob@example.com', '456 Oak Ln', 'Los Angeles', 90001, 'Active')
        """)
        
        # Insert Account (If ACCOUNT table exists, which it should based on SQL file)
        # Checking just to be safe or assuming schema match
        cursor.execute("""
            INSERT INTO ACCOUNT (AccountID, CustomerID, AccountType, CardNumber, Balance, StartDate, BillingCycle, Status)
            VALUES
            ('ACCT-1001', 'CUST-001', 'Residential', 1111222233334444, 0.00, '2023-01-01', 'Monthly', 'Active'),
            ('ACCT-1002', 'CUST-002', 'Commercial', 5555666677778888, 1500.50, '2023-02-15', 'Monthly', 'Active')
        """)

        # Insert Charges (Needed for rates page)
        # Check if CHARGES table exists and is empty
        cursor.execute("SHOW TABLES LIKE 'CHARGES'")
        if cursor.fetchone():
            cursor.execute("SELECT COUNT(*) FROM CHARGES")
            if cursor.fetchone()[0] == 0:
                cursor.execute("""
                    INSERT INTO CHARGES (UtilityType, RatePerUnit, FixedCharge, TaxPercentage, ServiceFee)
                    VALUES
                    ('Electricity', 18.5, 500, 15, 100),
                    ('Gas', 12.0, 300, 10, 50),
                    ('Water', 8.0, 200, 5, 20)
                """)

        conn.commit()
        print("✅ Database seeded successfully!")
        
        cursor.close()
        conn.close()

    except mysql.connector.Error as err:
        print(f"Error seeding data: {err}")

if __name__ == "__main__":
    seed_data()
