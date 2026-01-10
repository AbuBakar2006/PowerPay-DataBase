import mysql.connector
from config import db_config

try:
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    for table_name in ['BILL', 'CHARGES', 'REQUESTS']: # Checking REQUESTS too just in case
        print(f"\n--- {table_name} Schema ---")
        try:
            cursor.execute(f"DESCRIBE {table_name}")
            for col in cursor.fetchall():
                print(col)
        except mysql.connector.Error as e:
            print(f"Error describing {table_name}: {e}")
        
    conn.close()

except mysql.connector.Error as err:
    print(f"Error: {err}")
