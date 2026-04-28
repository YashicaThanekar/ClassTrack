CREATE DATABASE ClassTrack;
USE ClassTrack;

-- =========================
-- USERS (LOGIN SYSTEM)
-- =========================
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    login_id VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);

-- Sample users (students + teachers)
INSERT INTO users (login_id, name, password, role) VALUES
('24106040', 'Yashica Thanekar', '24106040@Apsit', 'student'),
('24106007', 'Aarya Vardhan Vankeepuram', '24106007@Apsit', 'student'),
('24106100', 'Simrun Yadav', '24106100@Apsit', 'student'),
('24106086', 'Suraj Yadav', '24106086@Apsit', 'student'),
('24106001', 'Bob Brown', '24106001@Apsit', 'student'),
('24106002', 'Carol Davis', '24106002@Apsit', 'student'),
('24106003', 'David Wilson', '24106003@Apsit', 'student'),
('24106004', 'Eva Green', '24106004@Apsit', 'student'),
('24106005', 'Frank Miller', '24106005@Apsit', 'student'),
('24106006', 'Grace Lee', '24106006@Apsit', 'student'),
('24106008', 'Henry Taylor', '24106008@Apsit', 'student'),
('24106009', 'Ivy Chen', '24106009@Apsit', 'student'),
('24106010', 'Jack White', '24106010@Apsit', 'student'),
('24106011', 'Kate Black', '24106011@Apsit', 'student'),
('24106012', 'Liam Brown', '24106012@Apsit', 'student'),
('24106013', 'Mia Davis', '24106013@Apsit', 'student'),
('24106014', 'Noah Wilson', '24106014@Apsit', 'student'),
('24106015', 'Olivia Martinez', '24106015@Apsit', 'student'),
('Yashica Thanekar', 'Yashica Thanekar', 'Yashica@Apsit', 'teacher'),
('Aarya Vardhan', 'Aarya Vardhan', 'Aarya@Apsit', 'teacher'),
('Priyanshu Upadhyay', 'Priyanshu Upadhyay', 'Priyanshu@Apsit', 'teacher');

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
-- TEACHER-SUBJECT MAPPING
-- =========================
CREATE TABLE teacher_subjects (
    teacher_id INT,
    subject_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Assignments:
INSERT INTO teacher_subjects (teacher_id, subject_id) VALUES
((SELECT id FROM users WHERE name='Yashica Thanekar'), 1), -- DBMS 
((SELECT id FROM users WHERE name='Aarya Vardhan'), 2),    -- DSA
((SELECT id FROM users WHERE name='Aarya Vardhan'), 3),    -- Operating Systems
((SELECT id FROM users WHERE name='Priyanshu Upadhyay'), 4); -- Computer Networks

-- =========================
-- ATTENDANCE (CORE TABLE)
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