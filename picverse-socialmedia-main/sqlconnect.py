import mysql.connector
from PicVerse import app

db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'picversedb',
    'auth_plugin': ''
}
conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()