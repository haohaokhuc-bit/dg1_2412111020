import json
import os
from flask import Flask, jsonify

app = Flask(__name__)

DATA_FILE = os.path.join(os.path.dirname(__file__), 'data', 'students.json')

def load_students():
    if not os.path.exists(DATA_FILE):
        return []
    with open(DATA_FILE, 'r', encoding='utf-8') as f:
        return json.load(f)

@app.route('/')
def index():
    return "Hệ thống quản lý sinh viên - ĐG1"

@app.route('/api/students', methods=['GET'])
def get_students():
    students = load_students()
    return jsonify(students)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
