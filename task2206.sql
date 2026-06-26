
CREATE TABLE Employee (

    emp_id INT PRIMARY KEY,

    emp_name VARCHAR(50),

    department VARCHAR(50),

    salary DECIMAL(10,2),

    hire_date DATE

);


INSERT INTO Employee (emp_id, emp_name, department, salary, hire_date) VALUES

(1,'Amit','HR',50000,'2025-01-15'),

(2,'Rahul','IT',65000,'2025-03-10'),

(3,'Priya','IT',75000,'2024-12-20'),

(4,'Sneha','Finance',55000,'2025-05-12'),

(5,'Vikas','IT',80000,'2024-08-25'),

(6,'Neha','HR',45000,'2025-04-18'),

(7,'Ankit','Sales',70000,'2025-02-28'),

(8,'Pooja','Marketing',62000,'2025-06-01'),

(9,'Rohit','Finance',90000,'2024-11-05'),

(10,'Kiran','Sales',85000,'2025-01-30'),

(11,'Amit','HR',50000,'2025-01-15'),

(12,'Deepak',NULL,40000,'2025-06-15');

-- 1. Top 5 Highest Salary Employees
SELECT *

FROM Employee

ORDER BY salary DESC

LIMIT 5;

-- 2. Department-wise Employee Count
SELECT department,

       COUNT(*) AS employee_count

FROM Employee

GROUP BY department;

-- 3. Second Highest Salary

SELECT MAX(salary) AS second_highest_salary

FROM Employee

WHERE salary < (SELECT MAX(salary) FROM Employee);

-- 4. Employees Whose Salary > Department Average

SELECT e.*

FROM Employee e

JOIN (

    SELECT department,

           AVG(salary) AS avg_salary

    FROM Employee

    GROUP BY department

) d

ON e.department = d.department

WHERE e.salary > d.avg_salary;

-- 5. INNER JOIN (Self Join)
SELECT e1.emp_name,

       e2.emp_name AS colleague,

       e1.department

FROM Employee e1

INNER JOIN Employee e2

ON e1.department = e2.department

AND e1.emp_id <> e2.emp_id;

-- 6. LEFT JOIN (Self Join)
SELECT e1.emp_name,

       e2.emp_name AS colleague

FROM Employee e1

LEFT JOIN Employee e2

ON e1.department = e2.department

AND e1.emp_id <> e2.emp_id;

-- 7. GROUP BY with HAVING
SELECT department,

       COUNT(*) AS total_employees

FROM Employee

GROUP BY department

HAVING COUNT(*) > 2;

-- 8. Employees Hired in Last 6 Months

SELECT *

FROM Employee

WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 9. Find Duplicate Records
SELECT emp_name,department,salary,hire_date,

       COUNT(*) AS duplicate_count FROM Employee

GROUP BY emp_name, department, salary, hire_date

HAVING COUNT(*) > 1;


-- 10. Remove Duplicate Records

WITH CTE AS (

    SELECT *,

           ROW_NUMBER() OVER (

               PARTITION BY emp_name, department, salary, hire_date

               ORDER BY emp_id

           ) AS rn

    FROM Employee

)

DELETE FROM CTE

WHERE rn > 1;