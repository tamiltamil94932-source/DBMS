mysql> CREATE DATABASE IF NOT EXISTS university_db;
Query OK, 1 row affected, 1 warning (0.06 sec)

mysql> USE university_db;
Database changed
mysql> CREATE TABLE students (
    -> student_id INT AUTO_INCREMENT PRIMARY KEY,
    -> name VARCHAR(100) NOT NULL,
    -> email VARCHAR(100) NOT NULL UNIQUE
    -> );
Query OK, 0 rows affected (0.80 sec)

mysql> CREATE TABLE courses (
    -> course_id INT AUTO_INCREMENT PRIMARY KEY,
    -> course_name VARCHAR(100) NOT NULL,
    -> credits INT NOT NULL,
    -> CHECK (credits > 0 AND credits <= 6)
    -> );
Query OK, 0 rows affected (1.21 sec)

mysql> CREATE TABLE enrollments (
    -> enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    -> tudent_id INT NOT NULL,
    -> student_id INT NOT NULL,
    -> course_id INT NOT NULL,
    -> enrollment_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    -> -- Foreign Key Constraints
    -> FOREIGN KEY (student_id) REFERENCES students(student_id)
    -> ON DELETE CASCADE
    -> ON UPDATE CASCADE,
    -> FOREIGN KEY (course_id) REFERENCES courses(course_id)
    -> ON DELETE CASCADE
    -> ON UPDATE CASCADE,
    -> UNIQUE (student_id, course_id) -- Prevent duplicate enrollments
    -> );
Query OK, 0 rows affected (1.07 sec)

mysql> ALTER TABLE enrollments DROP COLUMN tudent_id;
Query OK, 0 rows affected (2.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> INSERT INTO students (name, email) VALUES
    -> ('Alice Johnson', 'alice@example.com'),
    -> ('Bob Smith', 'bob@example.com');
Query OK, 2 rows affected (0.18 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM students;
+------------+---------------+-------------------+
| student_id | name          | email             |
+------------+---------------+-------------------+
|          1 | Alice Johnson | alice@example.com |
|          2 | Bob Smith     | bob@example.com   |
+------------+---------------+-------------------+
2 rows in set (0.00 sec)

mysql> INSERT INTO courses (course_name, credits) VALUES
    -> ('Database Systems', 3),
    -> ('Computer Networks', 4);
Query OK, 2 rows affected (0.15 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM courses;
+-----------+-------------------+---------+
| course_id | course_name       | credits |
+-----------+-------------------+---------+
|         1 | Database Systems  |       3 |
|         2 | Computer Networks |       4 |
+-----------+-------------------+---------+
2 rows in set (0.00 sec)

mysql> INSERT INTO enrollments (student_id, course_id) VALUES
    -> (1, 1), -- Alice in Database Systems
    -> (2, 1), -- Bob in Database Systems
    -> (1, 2); -- Alice in Computer Networks
Query OK, 3 rows affected (0.15 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM enrollments;
+---------------+------------+-----------+-----------------+
| enrollment_id | student_id | course_id | enrollment_date |
+---------------+------------+-----------+-----------------+
|             1 |          1 |         1 | 2026-07-29      |
|             2 |          2 |         1 | 2026-07-29      |
|             3 |          1 |         2 | 2026-07-29      |
+---------------+------------+-----------+-----------------+
3 rows in set (0.00 sec)

mysql> DELETE FROM students WHERE student_id = 2;
Query OK, 1 row affected (0.44 sec)

mysql> DELETE FROM courses WHERE course_id = 2;
Query OK, 1 row affected (0.41 sec)

mysql> SELECT * FROM students;
+------------+---------------+-------------------+
| student_id | name          | email             |
+------------+---------------+-------------------+
|          1 | Alice Johnson | alice@example.com |
+------------+---------------+-------------------+
1 row in set (0.00 sec)

mysql> SELECT * FROM courses;
+-----------+------------------+---------+
| course_id | course_name      | credits |
+-----------+------------------+---------+
|         1 | Database Systems |       3 |
+-----------+------------------+---------+
1 row in set (0.00 sec)

mysql> DROP TABLE IF EXISTS enrollments;
Query OK, 0 rows affected (0.48 sec)

mysql> DROP TABLE IF EXISTS students;
Query OK, 0 rows affected (0.46 sec)

mysql> DROP TABLE IF EXISTS courses;
Query OK, 0 rows affected (0.68 sec)

mysql> DROP DATABASE university_db;
Query OK, 0 rows affected (0.19 sec)
