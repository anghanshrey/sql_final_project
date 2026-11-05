-- =====================================================
-- UNIVERSITY COURSE MANAGEMENT SYSTEM
-- SQL FINAL PROJECT
-- =====================================================

-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS university_management;
USE university_management;


-- 2. CREATE DEPARTMENTS TABLE
CREATE TABLE departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
);


-- 3. CREATE STUDENTS TABLE
CREATE TABLE students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    BirthDate DATE,
    EnrollmentDate DATE
);


-- 4. CREATE COURSES TABLE
CREATE TABLE courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100),
    DepartmentID INT,
    Credits INT,
    FOREIGN KEY (DepartmentID)
    REFERENCES departments(DepartmentID)
);


-- 5. CREATE INSTRUCTORS TABLE
CREATE TABLE instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID)
    REFERENCES departments(DepartmentID)
);


-- 6. CREATE ENROLLMENTS TABLE
CREATE TABLE enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID)
    REFERENCES students(StudentID),
    FOREIGN KEY (CourseID)
    REFERENCES courses(CourseID)
);


-- =====================================================
-- 7. INSERT SAMPLE DATA
-- =====================================================

-- DEPARTMENTS
INSERT INTO departments (DepartmentName)
VALUES
('Computer Science'),
('Mathematics');


-- STUDENTS
INSERT INTO students
(FirstName, LastName, Email, BirthDate, EnrollmentDate)
VALUES
('John', 'Doe', 'john@gmail.com', '2000-01-15', '2021-08-01'),
('Jane', 'Smith', 'jane@gmail.com', '1999-05-25', '2022-08-01'),
('Rahul', 'Patel', 'rahul@gmail.com', '2001-03-10', '2023-06-15'),
('Amit', 'Shah', 'amit@gmail.com', '2000-07-20', '2021-07-10'),
('Priya', 'Mehta', 'priya@gmail.com', '2002-02-14', '2024-01-10'),
('Neha', 'Patel', 'neha@gmail.com', '2001-09-12', '2022-06-01'),
('Ravi', 'Kumar', 'ravi@gmail.com', '2000-11-05', '2021-08-15'),
('Karan', 'Joshi', 'karan@gmail.com', '2002-04-18', '2023-07-01'),
('Pooja', 'Desai', 'pooja@gmail.com', '2001-12-22', '2024-02-01'),
('Jay', 'Trivedi', 'jay@gmail.com', '2000-06-30', '2022-09-01'),
('Mehul', 'Parmar', 'mehul@gmail.com', '2001-10-10', '2023-08-01'),
('Anjali', 'Verma', 'anjali@gmail.com', '2002-08-08', '2025-01-01');


-- COURSES
INSERT INTO courses
(CourseName, DepartmentID, Credits)
VALUES
('Introduction to SQL', 1, 3),
('Data Structures', 1, 4),
('Python Programming', 1, 3),
('Calculus', 2, 4),
('Statistics', 2, 3);


-- INSTRUCTORS
INSERT INTO instructors
(FirstName, LastName, Email, DepartmentID, Salary)
VALUES
('Alice', 'Johnson', 'alice@gmail.com', 1, 50000),
('Bob', 'Lee', 'bob@gmail.com', 2, 60000),
('David', 'Smith', 'david@gmail.com', 1, 55000),
('Sara', 'Patel', 'sara@gmail.com', 2, 65000);


-- ENROLLMENTS
INSERT INTO enrollments
(StudentID, CourseID, EnrollmentDate)
VALUES
(1, 1, '2021-08-01'),
(2, 1, '2022-08-01'),
(3, 1, '2023-06-15'),
(4, 1, '2021-07-10'),
(5, 1, '2024-01-10'),
(6, 1, '2022-06-01'),
(7, 1, '2021-08-15'),
(8, 1, '2023-07-01'),
(9, 1, '2024-02-01'),
(10, 1, '2022-09-01'),
(11, 1, '2023-08-01'),
(12, 1, '2025-01-01'),
(1, 2, '2021-08-02'),
(2, 2, '2022-08-02'),
(3, 3, '2023-06-20'),
(4, 4, '2021-07-15'),
(5, 5, '2024-01-15'),
(6, 2, '2022-06-05'),
(7, 3, '2021-08-20'),
(8, 4, '2023-07-05');


-- =====================================================
-- 8. CHECK ALL TABLES
-- =====================================================

SHOW TABLES;

SELECT * FROM departments;
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM instructors;
SELECT * FROM enrollments;


-- =====================================================
-- 9. CRUD OPERATIONS
-- =====================================================

-- INSERT
INSERT INTO departments (DepartmentName)
VALUES ('Physics');

-- SELECT
SELECT * FROM departments;

-- UPDATE
UPDATE departments
SET DepartmentName = 'Applied Physics'
WHERE DepartmentID = 3;

-- DELETE
DELETE FROM departments
WHERE DepartmentID = 3;


-- =====================================================
-- 10. PROJECT QUESTIONS
-- =====================================================

-- Q2. Students enrolled after 2022
SELECT *
FROM students
WHERE EnrollmentDate > '2022-12-31';


-- Q3. Mathematics courses with limit 5
SELECT c.CourseName
FROM courses c
INNER JOIN departments d
ON c.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Mathematics'
LIMIT 5;


-- Q4. Count students in each course having more than 5
SELECT CourseID,
COUNT(StudentID) AS TotalStudents
FROM enrollments
GROUP BY CourseID
HAVING COUNT(StudentID) > 5;


-- Q5. Students enrolled in BOTH SQL and Data Structures
SELECT s.FirstName, s.LastName
FROM students s
INNER JOIN enrollments e
ON s.StudentID = e.StudentID
INNER JOIN courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName IN
('Introduction to SQL', 'Data Structures')
GROUP BY s.StudentID, s.FirstName, s.LastName
HAVING COUNT(DISTINCT c.CourseName) = 2;


-- Q6. Students enrolled in EITHER course
SELECT DISTINCT s.FirstName, s.LastName
FROM students s
INNER JOIN enrollments e
ON s.StudentID = e.StudentID
INNER JOIN courses c
ON e.CourseID = c.CourseID
WHERE c.CourseName IN
('Introduction to SQL', 'Data Structures');


-- Q7. Average credits of all courses
SELECT AVG(Credits) AS AverageCredits
FROM courses;


-- Q8. Maximum salary in Computer Science
SELECT MAX(i.Salary) AS MaximumSalary
FROM instructors i
INNER JOIN departments d
ON i.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Computer Science';


-- Q9. Count students enrolled in each department
SELECT d.DepartmentName,
COUNT(DISTINCT e.StudentID) AS TotalStudents
FROM departments d
INNER JOIN courses c
ON d.DepartmentID = c.DepartmentID
INNER JOIN enrollments e
ON c.CourseID = e.CourseID
GROUP BY d.DepartmentID, d.DepartmentName;


-- Q10. INNER JOIN students and courses
SELECT s.FirstName, s.LastName, c.CourseName
FROM students s
INNER JOIN enrollments e
ON s.StudentID = e.StudentID
INNER JOIN courses c
ON e.CourseID = c.CourseID;


-- Q11. LEFT JOIN all students and their courses
SELECT s.FirstName, s.LastName, c.CourseName
FROM students s
LEFT JOIN enrollments e
ON s.StudentID = e.StudentID
LEFT JOIN courses c
ON e.CourseID = c.CourseID;


-- Q12. Students enrolled in courses having more than 10 students
SELECT DISTINCT FirstName, LastName
FROM students
WHERE StudentID IN (
    SELECT StudentID
    FROM enrollments
    WHERE CourseID IN (
        SELECT CourseID
        FROM enrollments
        GROUP BY CourseID
        HAVING COUNT(StudentID) > 10
    )
);


-- Q13. Extract year from EnrollmentDate
SELECT StudentID,
FirstName,
YEAR(EnrollmentDate) AS EnrollmentYear
FROM students;


-- Q14. Concatenate instructor names
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM instructors;


-- Q15. Running total of enrollments
SELECT
EnrollmentID,
StudentID,
EnrollmentDate,
COUNT(*) OVER (
    ORDER BY EnrollmentDate, EnrollmentID
) AS RunningTotal
FROM enrollments;


-- Q16. Senior or Junior using CASE
SELECT
FirstName,
LastName,
EnrollmentDate,
CASE
    WHEN EnrollmentDate < DATE_SUB(CURDATE(), INTERVAL 4 YEAR)
    THEN 'Senior'
    ELSE 'Junior'
END AS StudentLevel
FROM students;


-- =====================================================
-- 11. ADDITIONAL SQL PRACTICE
-- =====================================================

-- GROUP BY
SELECT DepartmentID, COUNT(*) AS TotalCourses
FROM courses
GROUP BY DepartmentID;


-- ORDER BY
SELECT * FROM students
ORDER BY FirstName ASC;


-- DISTINCT
SELECT DISTINCT DepartmentID
FROM courses;


-- LIKE
SELECT * FROM students
WHERE FirstName LIKE 'A%';


-- BETWEEN
SELECT * FROM instructors
WHERE Salary BETWEEN 50000 AND 60000;


-- DATE_ADD
SELECT DATE_ADD(CURDATE(), INTERVAL 10 DAY);


-- DATE_SUB
SELECT DATE_SUB(CURDATE(), INTERVAL 10 DAY);


-- DATEDIFF
SELECT DATEDIFF(CURDATE(), EnrollmentDate) AS TotalDays
FROM students;


-- UPPER
SELECT UPPER(FirstName)
FROM students;


-- LOWER
SELECT LOWER(FirstName)
FROM students;


-- CONCAT
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM students;


-- UNION
SELECT FirstName FROM students
UNION
SELECT FirstName FROM instructors;


-- UNION ALL
SELECT FirstName FROM students
UNION ALL
SELECT FirstName FROM instructors;


-- ROW_NUMBER
SELECT
FirstName,
Salary,
ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
FROM instructors;


-- RANK
SELECT
FirstName,
Salary,
RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM instructors;


-- DENSE_RANK
SELECT
FirstName,
Salary,
DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM instructors;


-- SUM
SELECT SUM(Credits) AS TotalCredits
FROM courses;


-- MIN
SELECT MIN(Salary) AS MinimumSalary
FROM instructors;


-- MAX
SELECT MAX(Salary) AS MaximumSalary
FROM instructors;


-- COUNT
SELECT COUNT(*) AS TotalStudents
FROM students;


-- =====================================================
-- END OF UNIVERSITY COURSE MANAGEMENT SYSTEM
-- =====================================================