## all the sql queries

# creating database

    CREATE DATABASE EducationDB;
    USE EducationDB;

# creating tables for the DATABASE

1. Student Table

    CREATE TABLE Student (
   StudentID INT AUTO_INCREMENT PRIMARY KEY,
   Name VARCHAR(255),
   Gender VARCHAR(10),
   DateOfBirth DATE,
   RegionID INT,
   FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

2.  Course Table

    CREATE TABLE Course (
   CourseID INT AUTO_INCREMENT PRIMARY KEY,
   CourseName VARCHAR(255),
   Credits INT
);

3. Enrollment Table

    CREATE TABLE Enrollment (
   EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
   StudentID INT,
   CourseID INT,
   EnrollmentDate DATE,
   Status VARCHAR(50),
   GraduationDate DATE,
   FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
   FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

4. Region Table

    CREATE TABLE Region (
   RegionID INT AUTO_INCREMENT PRIMARY KEY,
   RegionName VARCHAR(255),
   Country VARCHAR(255)
);

5. Grade Table

    CREATE TABLE Grade (
   GradeID INT AUTO_INCREMENT PRIMARY KEY,
   StudentID INT,
   CourseID INT,
   Grade CHAR(2),
   Date DATE,
   FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
   FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


# Population of the table queries

1. Insertion of Data into Region Table

    INSERT INTO Region (RegionName, Country) 
    VALUES ('East Africa', 'Kenya');

2. Insertion of Data into Student Table

    INSERT INTO Student (Name, Gender, DateOfBirth, RegionID) 
    VALUES ('John Doe', 'Male', '1995-06-15', 1),
        ('Jane Smith', 'Female', '1994-08-20', 1),
        ('Emily Clark', 'Female', '1997-12-11', 1);

3. Insert Data into Course Table:

    INSERT INTO Course (CourseName, Credits) 
    VALUES ('Mathematics', 3), 
        ('Science', 4),
        ('History', 3),
        ('Literature', 2);

4. Insertion of Data into Enrollment Table

    INSERT INTO Enrollment (StudentID, CourseID, EnrollmentDate, Status, GraduationDate) 
    VALUES (1, 1, '2020-09-01', 'Active', NULL),
        (1, 2, '2020-09-01', 'Graduated', '2024-05-15'),
        (2, 3, '2021-09-01', 'Active', NULL),
        (3, 4, '2022-09-01', 'Active', NULL);

5. Insertion of Data into Grade Table

    INSERT INTO Grade (StudentID, CourseID, Grade, Date) 
    VALUES (1, 1, 'A', '2024-05-15'),
        (1, 2, 'B', '2024-05-15'),
        (2, 3, 'A', '2024-05-15'),
        (3, 4, 'B', '2024-05-15');


# part 3 SQL Programming

#  Data Retrieval

1. Retrieve all students and their enrollment details

    SELECT s.StudentID, s.Name, e.CourseID, c.CourseName, e.EnrollmentDate
    FROM Student s
    JOIN Enrollment e ON s.StudentID = e.StudentID
    JOIN Course c ON e.CourseID = c.CourseID;

2. Retrieve all students who have graduated 

    SELECT s.StudentID, s.Name, e.CourseID, c.CourseName, e.GraduationDate
    FROM Student s
    JOIN Enrollment e ON s.StudentID = e.StudentID
    JOIN Course c ON e.CourseID = c.CourseID
    WHERE e.GraduationDate IS NOT NULL;

3. Retrieve average grade for each student

    SELECT s.StudentID, s.Name, AVG(g.Grade) AS AverageGrade
    FROM Student s
    JOIN Grade g ON s.StudentID = g.StudentID
    GROUP BY s.StudentID, s.Name;


# Data Analysis

1. Get the total number of enrollments for each student

    SELECT s.StudentID, s.Name, COUNT(e.CourseID) AS TotalEnrollments
    FROM Student s
    JOIN Enrollment e ON s.StudentID = e.StudentID
    GROUP BY s.StudentID, s.Name;

2. Get the average number of enrollments per region

    SELECT r.RegionName, COUNT(e.CourseID) / COUNT(DISTINCT s.StudentID) AS AverageEnrollmentsPerStudent
    FROM Region r
    JOIN Student s ON r.RegionID = s.RegionID
    JOIN Enrollment e ON s.StudentID = e.StudentID
    GROUP BY r.RegionName;
