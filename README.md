# ToDoList-SQL

## Overview

This repository contains a SQL-based To-Do List application designed to help users manage their tasks efficiently. The database schema is specifically tailored for B.Tech students living in hostels, with categories and tasks relevant to their daily lives. This project showcases basic database design, querying, and data manipulation skills using SQL.

## Features

*   **Categorized Tasks:** Organizes tasks into categories like Academics, Personal, Social, and Skills.
*   **Prioritized Tasks:** Assigns priorities (High, Medium, Low) to tasks.
*   **Due Dates and Reminders:** Sets due dates and reminders for tasks.
*   **Task Completion Status:** Tracks whether a task is completed or not.
*   **Advanced Queries:** Includes various SQL queries to analyze and retrieve task data.

## Database Schema

The database consists of the following tables:

*   **Categories:** Stores task categories.
    *   `CategoryID` (INT, Primary Key, Identity)
    *   `CategoryName` (VARCHAR(255), Not Null)
    *   `CategoryDescription` (VARCHAR(MAX))

*   **Priorities:** Stores task priorities.
    *   `PriorityID` (INT, Primary Key, Identity)
    *   `PriorityName` (VARCHAR(50), Not Null)
    *   `PriorityLevel` (INT)

*   **Tasks:** Stores individual tasks.
    *   `TaskID` (INT, Primary Key, Identity)
    *   `TaskName` (VARCHAR(255), Not Null)
    *   `Description` (VARCHAR(MAX))
    *   `CategoryID` (INT, Foreign Key referencing Categories)
    *   `PriorityID` (INT, Foreign Key referencing Priorities)
    *   `DueDate` (DATE)
    *   `IsCompleted` (BIT, Default 0)
    *   `ReminderDateTime` (DATETIME)

## SQL Queries and Demonstrations

The project includes a variety of SQL queries demonstrating various concepts:

*   **Basic SELECT and WHERE clauses:** Retrieving tasks based on completion status.
*   **INNER JOIN:** Combining task names and category names.
*   **LEFT OUTER JOIN:** Displaying all categories along with the number of tasks in each category.
*   **CASE statement:** Categorizing tasks based on their due date.
*   **GROUP BY and HAVING clauses:** Grouping tasks by category and filtering based on task count.
*   **Subqueries:** Finding tasks with higher priority than the average priority level.
*   **Temp Tables:** Creating temporary tables to store overdue tasks.
*   **String Functions:** Displaying a shortened description of each task.
*   **UNION:** Combining tasks based on due date and completion status.
*   **Partition By:** Ranking tasks by priority within each category.

## Getting Started

To use this project, follow these steps:

1.  **Clone the repository:**
   `git clone https://github.com/ShivangiSinha06/ToDoList-SQL.git`
2.  **Create a database:** Create a new database named `ToDoListDB` in SQL Server Management Studio.
3.  **Run the SQL script:** Execute the `ToDoList.sql` file in SQL Server Management Studio to create the tables and populate them with sample data.

## How to Import the ToDoList.sql file

1. **Connect to SQL Server:** Open SQL Server Management Studio (SSMS) and connect to your SQL Server instance.
2. **Create the database:** Right-click on "Databases" in the Object Explorer and select "New Database...". Name the database "ToDoListDB".
3. **Open the SQL file:** In SSMS, go to File > Open > File... and select the ToDoList.sql file you downloaded.
4. **Execute the script:** Ensure that the database selected in the dropdown list next to the "Execute" button is set to ToDoListDB. Click the "Execute" button or press F5 to run the script.
5. **Verify the import:** Once the script completes, refresh the ToDoListDB database in the Object Explorer. Expand the "Tables" folder to see the imported tables: Categories, Priorities, and Tasks.
