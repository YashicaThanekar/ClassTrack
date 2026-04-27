
from flask import Flask, request, jsonify
import mysql.connector
from flask_cors import CORS
from dotenv import load_dotenv
import os

app = Flask(__name__)
CORS(app)

# Load environment variables from .env file
load_dotenv()

db = mysql.connector.connect(
    host=os.getenv("MYSQL_HOST"),
    user=os.getenv("MYSQL_USER"),
    password=os.getenv("MYSQL_PASSWORD"),
    database=os.getenv("MYSQL_DATABASE")
)

@app.route('/login', methods=['POST'])
def login():
    data = request.json

    login_id = data['login_id']
    password = data['password']
    role = data['role']

    cursor = db.cursor(dictionary=True)

    query = """
        SELECT * FROM users 
        WHERE login_id=%s AND password=%s AND role=%s
    """

    cursor.execute(query, (login_id, password, role))
    user = cursor.fetchone()

    if user:
        return jsonify({
            "message": "Login successful",
            "role": user["role"]
        }), 200
    else:
        return jsonify({
            "message": "Invalid credentials"
        }), 401

if __name__ == '__main__':
    app.run(debug=True)