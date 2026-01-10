import mysql.connector
from config import db_config

try:
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    print("Inspecting CUSTOMER table schema:")
    cursor.execute("DESCRIBE CUSTOMER")
    for col in cursor.fetchall():
        print(col)
        
    conn.close()

except mysql.connector.Error as err:
    print(f"Error: {err}")
