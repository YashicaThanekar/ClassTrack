CREATE DATABASE ClassTrack;
USE ClassTrack;

-- =========================
-- USERS (LOGIN SYSTEM)
-- =========================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    login_id VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);

-- Sample users (students + teachers)
INSERT INTO users (login_id, password, role) VALUES
('24106040', '24106040@Apsit', 'student'),
('24106007', '24106007@Apsit', 'student'),
('24106100', '24106100@Apsit', 'student'),
('24106086', '24106086@Apsit', 'student'),
('24106001', '24106001@Apsit', 'student'),
('24106002', '24106002@Apsit', 'student'),
('24106003', '24106003@Apsit', 'student'),
('24106004', '24106004@Apsit', 'student'),
('24106005', '24106005@Apsit', 'student'),
('24106006', '24106006@Apsit', 'student'),
('24106008', '24106008@Apsit', 'student'),
('24106009', '24106009@Apsit', 'student'),
('24106010', '24106010@Apsit', 'student'),
('24106011', '24106011@Apsit', 'student'),
('24106012', '24106012@Apsit', 'student'),
('24106013', '24106013@Apsit', 'student'),
('24106014', '24106014@Apsit', 'student'),
('24106015', '24106015@Apsit', 'student'),
('Yashica Thanekar', 'Yashica@Apsit', 'teacher'),
('Aarya Vardhan', 'Aarya@Apsit', 'teacher'),
('Priyanshu Upadhyay', 'Priyanshu@Apsit', 'teacher');

-- =========================
-- STUDENTS
-- =========================
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    branch VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES users(id)
);

-- =========================
-- TEACHERS
-- =========================
CREATE TABLE teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    subject VARCHAR(50),
    FOREIGN KEY (teacher_id) REFERENCES users(id)
);

-- =========================
-- SUBJECTS
-- =========================
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(50)
);

INSERT INTO subjects (subject_name) VALUES
('DBMS'),
('DSA'),
('Operating Systems'),
('Computer Networks');

-- =========================
-- ATTENDANCE 
-- =========================
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    date DATE,
    status VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- =========================
-- EVENTS
-- =========================
CREATE TABLE events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100),
    event_date DATE,
    proof_link VARCHAR(200)
);