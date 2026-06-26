
-- TASK DATE: 25/06/26
-- 1. Add More Records in Existing Employee Table
INSERT INTO Employee (emp_id, emp_name, department, salary, hire_date) VALUES
(13,'Meena','HR',58000,'2025-05-20'),
(14,'Suresh','IT',95000,'2024-10-10'),
(15,'Riya','Finance',72000,'2025-02-18'),
(16,'Ajay','Sales',68000,'2025-04-12'),
(17,'Nisha','Marketing',61000,'2025-03-05');

-- 2. Window Functions

-- 1. ROW_NUMBER()
-- Assigns a unique sequential number to each row.
SELECT emp_id, emp_name, department, salary,
       ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM Employee;

-- 2. RANK()
-- Gives the same rank for ties and skips the next rank.

SELECT emp_id, emp_name, department, salary,
       RANK() OVER(ORDER BY salary DESC) AS rank_no
FROM Employee;

-- 3. DENSE_RANK()
-- Gives the same rank for ties without skipping ranks.

SELECT
    emp_id,
    emp_name,
    department,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM Employee;


-- 4. NTILE()
-- Divides rows into equal groups.
SELECT emp_id, emp_name, salary,
       NTILE(4) OVER(ORDER BY salary DESC) AS quartile
FROM Employee;

-- 5. LAG()
-- Returns the previous row value.

SELECT emp_id, emp_name, salary,
       LAG(salary,1) OVER(ORDER BY salary) AS previous_salary
FROM Employee;

-- 6. LEAD()
-- Returns the next row value.

SELECT emp_id, emp_name, salary,
       LEAD(salary,1) OVER(ORDER BY salary) AS next_salary
FROM Employee;


-- 7. FIRST_VALUE()
-- Returns the first value in the window.

SELECT emp_id, emp_name, salary,
       FIRST_VALUE(salary) OVER(ORDER BY salary DESC) AS highest_salary
FROM Employee;

-- 8. LAST_VALUE()
-- Returns the last value in the window.

SELECT emp_id, emp_name, salary,
       LAST_VALUE(salary) OVER(
           ORDER BY salary
           ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
       ) AS last_salary
FROM Employee;

-- 9. CUME_DIST()
-- Returns cumulative distribution of each row.

SELECT emp_id, emp_name, salary,
       CUME_DIST() OVER(ORDER BY salary) AS cumulative_distribution
FROM Employee;

-- 3. Create View

CREATE VIEW HighSalaryEmployees AS
SELECT emp_id,
       emp_name,
       department,
       salary
FROM Employee
WHERE salary >= 70000;

-- View Data
SELECT * FROM HighSalaryEmployees;

-- 4. Trigger
CREATE TABLE Employee_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    emp_name VARCHAR(50),
    action_type VARCHAR(20),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER trg_after_insert
AFTER INSERT ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit(emp_id, emp_name, action_type)
    VALUES (NEW.emp_id, NEW.emp_name, 'INSERT');
END $$

DELIMITER ;

INSERT INTO Employee
VALUES (18,'Kunal','IT',67000,'2025-06-20');

SELECT * FROM Employee_Audit;

-- 5. CASE WHEN

SELECT emp_name,
       salary,
       CASE
            WHEN salary >= 80000 THEN 'High Salary'
            WHEN salary >= 60000 THEN 'Medium Salary'
            ELSE 'Low Salary'
       END AS Salary_Category
FROM Employee;

-- CASE WHEN with Department

SELECT emp_name,
       department,
       CASE
            WHEN department='IT' THEN 'Technical'
            WHEN department='HR' THEN 'Administration'
            WHEN department='Finance' THEN 'Accounts'
            ELSE 'Other'
       END AS Department_Type
FROM Employee;