from flask import Flask, request, jsonify
from sqlconnect import conn, cursor
from PicVerse import app
from werkzeug.security import generate_password_hash

# Route to add admin
@app.route('/api/reactAdminAdd', methods=['POST'])
def reactAdminAdd():
    try:
        data = request.get_json()
        username = data.get('username')
        password = data.get('password')

        # Check if username already exists
        if checkAdminUsername(username):
            return jsonify({"success": False, "message": "Admin username already exists"})

        encPass = generate_password_hash(password, method='scrypt')
        insertAdmin(username, encPass)
        return jsonify({"success": True, "message": "Admin added successfully"})

    except Exception as e:
        return jsonify({"success": False, "message": str(e)})

# Route to get all admins
@app.route('/api/getAdmins', methods=['GET'])
def getAdmins():
    cursor.execute("SELECT admin_id, admin_username, created_at FROM admins")
    result = cursor.fetchall()
    admins_data = [{'id': row[0], 'username': row[1], 'created_at': row[2]} for row in result]
    return jsonify({'success': True, 'admins': admins_data})

# Route to delete an admin
@app.route('/api/deleteAdmin/<int:admin_id>', methods=['DELETE'])
def deleteAdmin(admin_id):
    try:
        cursor.execute("DELETE FROM admins WHERE admin_id = %s", (admin_id,))
        conn.commit()
        return jsonify({"success": True, "message": "Admin deleted successfully"})

    except Exception as e:
        return jsonify({"success": False, "message": str(e)})

# Function to insert an admin
def insertAdmin(username, password):
    cursor.execute("INSERT INTO admins(admin_username, admin_password, created_at) VALUES(%s, %s, NOW())", (username, password))
    conn.commit()

# Function to check if username exists
def checkAdminUsername(username):
    cursor.execute("SELECT * FROM admins WHERE admin_username=%s", (username,))
    return cursor.fetchone() is not None
