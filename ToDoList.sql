CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(255) NOT NULL,
    CategoryDescription VARCHAR(MAX)
);
GO

CREATE TABLE Priorities (
    PriorityID INT PRIMARY KEY IDENTITY(1,1),
    PriorityName VARCHAR(50) NOT NULL,
    PriorityLevel INT
);
GO

CREATE TABLE Tasks (
    TaskID INT PRIMARY KEY IDENTITY(1,1),
    TaskName VARCHAR(255) NOT NULL,
    Description VARCHAR(MAX),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    PriorityID INT FOREIGN KEY REFERENCES Priorities(PriorityID),
    DueDate DATE,
    IsCompleted BIT DEFAULT 0,
    ReminderDateTime DATETIME
);
GO

INSERT INTO Categories (CategoryName, CategoryDescription)
VALUES
    ('Academics', 'Tasks related to college studies'),
    ('Personal', 'Personal tasks'),
    ('Social', 'Tasks related to social life'),
    ('Skills', 'Tasks to learn new skills');
GO

INSERT INTO Priorities (PriorityName, PriorityLevel)
VALUES
    ('High', 1),
    ('Medium', 2),
    ('Low', 3);
GO

INSERT INTO Tasks (TaskName, Description, CategoryID, PriorityID, DueDate, ReminderDateTime)
VALUES
    ('Study for DSA Exam', 'Revise data structures and algorithms', 1, 1, '2024-06-18', '2024-06-17 18:00'),
    ('Complete DBMS Assignment', 'Finish the database management system assignment', 1, 2, '2024-06-16', '2024-06-15 20:00'),
    ('Submit AI Project', 'Finalize the artificial intelligence project report', 1, 1, '2024-06-20', '2024-06-19 22:00'),
    ('Apply for Internships', 'Search and apply for summer internship opportunities', 4, 2, '2024-06-25', '2024-06-24 15:00'),
    ('Learn React Basics', 'Start learning the basics of React framework', 4, 3, '2024-07-01', '2024-06-30 18:00'),
    ('Attend College Fest', 'Participate in the college cultural festival', 3, 3, '2024-06-12', '2024-06-12 10:00'),
    ('Hostel Room Cleaning', 'Clean and organize the hostel room', 2, 2, '2024-06-09', '2024-06-09 11:00'),
    ('Laundry', 'Wash and dry clothes', 2, 3, '2024-06-10', '2024-06-10 14:00'),
    ('Call Parents', 'Call parents and update them about college life', 2, 1, '2024-06-11', '2024-06-11 19:00'),
    ('Prepare Presentation', 'Prepare slides for the upcoming seminar', 1, 2, '2024-06-14', '2024-06-13 21:00'),
    ('Practice Coding', 'Solve coding problems on LeetCode or Codeforces', 4, 1, '2024-06-19', '2024-06-18 20:00'),
    ('Attend Guest Lecture', 'Attend the guest lecture on machine learning', 1, 3, '2024-06-17', '2024-06-17 10:00'),
    ('Buy Stationary', 'Purchase essential stationary items for college', 2, 3, '2024-06-13', '2024-06-13 14:00'),
    ('Meet Friends', 'Meet friends for a hangout', 3, 2, '2024-06-15', '2024-06-15 17:00'),
    ('Complete Project Documentation', 'Finalize project reports and other documentation', 1, 1, '2024-06-22', '2024-06-21 23:00');
GO

UPDATE Tasks
SET IsCompleted = 1
WHERE TaskID = 1;
GO

SELECT * FROM Tasks WHERE IsCompleted = 0;
GO

SELECT
    t.TaskName AS Task,
    c.CategoryName AS Category
FROM Tasks AS t
INNER JOIN Categories AS c ON t.CategoryID = c.CategoryID;
GO

SELECT
    c.CategoryName AS Category,
    COUNT(t.TaskID) AS TaskCount
FROM Categories AS c
LEFT OUTER JOIN Tasks AS t ON c.CategoryID = t.CategoryID
GROUP BY c.CategoryName
ORDER BY TaskCount DESC;
GO

SELECT
    TaskName,
    CASE
        WHEN DueDate < GETDATE() THEN 'Overdue'
        ELSE 'Not Overdue'
    END AS Status
FROM Tasks;
GO

SELECT
    c.CategoryName,
    COUNT(t.TaskID) AS TaskCount
FROM Tasks AS t
INNER JOIN Categories AS c ON t.CategoryID = c.CategoryID
GROUP BY c.CategoryName
HAVING COUNT(t.TaskID) > 0;
GO

SELECT TaskName
FROM Tasks
WHERE PriorityID IN (SELECT PriorityID FROM Priorities WHERE PriorityLevel < (SELECT AVG(PriorityLevel) FROM Priorities));
GO

SELECT TaskName, DueDate
INTO #OverdueTasks
FROM Tasks
WHERE DueDate < GETDATE() AND IsCompleted = 0;

SELECT * FROM #OverdueTasks;
GO

SELECT TaskName, LEFT(Description, 3) AS ShortDescription FROM Tasks;
GO

SELECT TaskName, DueDate FROM Tasks WHERE DueDate > GETDATE()
UNION
SELECT TaskName, DueDate FROM Tasks WHERE IsCompleted = 1;
GO

SELECT
    TaskName,
    CategoryName,
    PriorityName,
    ROW_NUMBER() OVER (PARTITION BY CategoryName ORDER BY PriorityLevel) AS PriorityRank
FROM Tasks t
JOIN Categories c ON t.CategoryID = c.CategoryID
JOIN Priorities p ON t.PriorityID = p.PriorityID
ORDER BY CategoryName, PriorityRank;
GO