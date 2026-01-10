import mysql.connector
from config import db_config
import sys

# Force output buffering off
sys.stdout.reconfigure(encoding='utf-8')

print(f"Attempting to connect to: {db_config['database']} at {db_config['host']}")

try:
    conn = mysql.connector.connect(**db_config)
    print("[OK] Connection Successful!")
    
    cursor = conn.cursor()
    
    # Check Tables
    cursor.execute("SHOW TABLES")
    tables = [t[0] for t in cursor.fetchall()]
    print(f"Found Tables: {tables}")
    
    for t in tables:
        try:
            cursor.execute(f"SELECT COUNT(*) FROM {t}")
            count = cursor.fetchone()[0]
            print(f"[OK] Table '{t}' has {count} rows.")
        except mysql.connector.Error as err:
             print(f"[ERR] Failed to count '{t}': {err}")

    conn.close()

except mysql.connector.Error as err:
    print(f"[ERR] Connection Failed: {err}")
