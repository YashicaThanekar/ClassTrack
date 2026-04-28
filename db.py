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

# Add the /students endpoint after db is initialized
@app.route('/students', methods=['GET'])
def get_students():
    cursor = db.cursor(dictionary=True)
    query = """
        SELECT login_id AS moodle_id, name
        FROM users
        WHERE role = 'student'
    """
    cursor.execute(query)
    students = cursor.fetchall()
    return jsonify(students)

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

@app.route('/mark_attendance', methods=['POST'])
def mark_attendance():
    data = request.json
    attendance_list = data.get('attendance', [])
    from datetime import date
    today = date.today().isoformat()
    cursor = db.cursor()
    for entry in attendance_list:
        # Get student id from moodle_id (login_id)
        cursor.execute("SELECT id FROM users WHERE login_id=%s", (entry['moodle_id'],))
        result = cursor.fetchone()
        if result:
            student_id = result[0]
            # Save attendance for today
            cursor.execute(
                "INSERT INTO attendance (student_id, date, status) VALUES (%s, %s, %s)",
                (student_id, today, entry['status'])
            )
    db.commit()
    return jsonify({'message': 'Attendance saved for today!'})

if __name__ == '__main__':
    app.run(debug=True)