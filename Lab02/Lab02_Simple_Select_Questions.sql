/*********************************

Assignment - Lab 2 Simple SQL Select Statements

 **********************************/
 
--
-- 1. 
-- Select everything from the regions table, how many regions are there 
--

SELECT
    *
FROM
    regions;

-- There are 4 regions

--
-- 2. 
-- Display all the jobs with their min and maximum salary 
--

SELECT
    job_title,
    min_salary,
    max_salary
FROM
    jobs;

--
-- 3.
-- What is the difference between the minimum and maximum salary for each job 
--

SELECT
    job_title,
    (max_salary - min_salary) AS sal_diff
FROM
    jobs;

-- +---------------------------------+----------+
-- | job_title                       | sal_diff |
-- +---------------------------------+----------+
-- | President                       |    20000 |
-- | Administration Vice President   |    15000 |
-- | Administration Assistant        |     3000 |
-- | Finance Manager                 |     7800 |
-- | Accountant                      |     4800 |
-- | Accounting Manager              |     7800 |
-- | Public Accountant               |     4800 |
-- | Sales Manager                   |    10000 |
-- | Sales Representative            |     6000 |
-- | Purchasing Manager              |     7000 |
-- | Purchasing Clerk                |     3000 |
-- | Stock Manager                   |     3000 |
-- | Stock Clerk                     |     3000 |
-- | Shipping Clerk                  |     3000 |
-- | Programmer                      |     6000 |
-- | Marketing Manager               |     6000 |
-- | Marketing Representative        |     5000 |
-- | Human Resources Representative  |     5000 |
-- | Public Relations Representative |     6000 |
-- +---------------------------------+----------+

--
-- 4. 
-- What is 7 + 100 * 2 + 3?   What operator gets done first? 
--

SELECT
    7 + 100 * 2 + 3;

-- The multiplication operator "*" gets done first
-- Output: 210

--
-- 5.
-- For question 4 give it a column alias of Math Question.  
--

SELECT
    (7 + 100 * 2 + 3) AS "Math Question";

--
-- 6.
-- Select the combined street address and postal code for each location
-- (i.e. 1 column contains both values)
--

SELECT
    CONCAT (street_address, ", ", postal_code) AS "Full Address"
FROM
    locations;

--
--  7.
-- What employees do not have a commission  
--

SELECT
    CONCAT (first_name, " ", last_name) AS "Employee Name"
FROM
    employees
WHERE
    commission_pct IS NULL;

-- Answer: Steven King and Neena Kochhar
--
-- 8.
-- What departments  have a manager 
--

SELECT
    department_name
FROM
    departments
WHERE
    manager_id IS NOT NULL;

-- +------------------+
-- | department_name  |
-- +------------------+
-- | Administration   |
-- | Marketing        |
-- | Purchasing       |
-- | Human Resources  |
-- | Shipping         |
-- | IT               |
-- | Public Relations |
-- | Sales            |
-- | Executive        |
-- | Finance          |
-- | Accounting       |
-- +------------------+
-- 11 rows in set (0.000 sec)

--
-- 9.
-- Select all departments and their manager id.  If a department
-- has no manager than display N/A. Give that column a title of ManagerID 
--

SELECT
    department_name,
    IFNULL (manager_id, "N/A") AS "ManagerID"
FROM
    departments;

--
-- 10.
-- Select all the unique employee_ids in the job history table.  Where there
-- any employees with more than one row in the job history table.
--

SELECT DISTINCT
    employee_id
FROM
    job_history;

-- ?Not sure if this is what I needed to do

--
-- 11.
-- What employee that have a salary greater than $10,000 
--

SELECT
    CONCAT (first_name, " ", last_name) AS "Emp. Name",
    employee_id,
    salary
FROM
    employees
WHERE
    salary >= 10000
ORDER BY
    salary;

--
-- 12. 
-- What departments are in location 1700 or location 2400 (use OR) 
--

SELECT
    department_name,
    location_id
FROM
    departments
WHERE
    location_id = 1700
    OR location_id = 2400;

--
-- 13. 
-- What employees have a first name of Den or Nancy use the IN operator
--

SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    first_name IN ("Den", "Nancy");

--
-- 14.
-- What departments are in location 1700 or location 2400 and have a manager.
--

SELECT
    department_name,
    location_id,
    manager_id
FROM
    departments
WHERE
    manager_id IS NOT NULL
    AND location_id = 1700
    OR location_id = 2400;

--
-- 15.
-- Display the employee and their salary from highest salary to lowest salary 
--

SELECT
    CONCAT (first_name, " ", last_name) AS "Emp. Name",
    salary
FROM
    employees
ORDER BY
    salary DESC;

-- 
-- 16.
-- Display all the distinct commission percentages from the employees table 
--  (ensure the commission percentage is non null).
--

SELECT DISTINCT
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NOT NULL;

--
-- 17.
-- Display all the employee who have a phone numbers that start with 603 
--

SELECT
    CONCAT (first_name, " ", last_name) AS "Emp. Name",
    phone_number
FROM
    employees
WHERE
    phone_number LIKE "603%";

--
-- 18.
-- Display all the employee who do not have a phone numbers that have a 6 in it. 
--

SELECT
    CONCAT (first_name, " ", last_name) AS "Emp. Name",
    phone_number
FROM
    employees
WHERE
    phone_number NOT LIKE "%6%";

--
-- 19 
-- Display the first name, department id, and salary from employees
-- whose first name begins with A. 
-- Order the results by descending department id, and ascending salary; 
--

SELECT
    first_name,
    department_id,
    salary
FROM
    employees
WHERE
    first_name LIKE "A%"
ORDER BY
    department_id DESC,
    salary ASC;

-- 
-- 20.
-- Write a query to display the first name, last name, and hire date
-- of the employees that have been hired on or after September 1, 1987
--

SELECT
    first_name,
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE "1987-09%";

--
-- 21. 
-- Write a query to display an employee's first and last name
-- (separated by a space) under a single column titled "Employee Name",
-- along with their yearly salary (salary * 12) under a column titled 
-- "Yearly Salary". Only include records with a yearly salary above $200,000.
-- Sort the results by the yearly salary from high to low.
--

SELECT
    CONCAT (first_name, " ", last_name) AS "Employee Name",
    (salary * 12) AS "Yearly Salary"
FROM
    employees
WHERE
    (salary * 12) > 200000
ORDER BY
    (salary * 12) DESC;

-- 
-- 22.
-- Write a query to display the last name and salary for 
-- all employees whose salary falls in the range of $2,500 
-- to $2,600 inclusive. Label the columns Poor Employee and 
-- Monthly Salary respectively.
--

SELECT
    last_name AS "Poor Employee :(",
    salary AS "Monthly Salary :'("
FROM 
    employees
WHERE
    salary BETWEEN 2500 AND 2600
ORDER BY
    salary;

--
-- 23 
-- Write a query to display the last name and department 
-- number of all employees in departments 60, 70 and 90 
-- in alphabetical order by last name in descending sequence
--

SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN (60, 70, 90)
ORDER BY
    last_name DESC;


--
-- 24
-- Write a query to display the last names of all employees 
-- where the third letter of their last name is an e. 
--

SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE "__e%";

--
-- 25 
-- Write a query to display the first name, last name, salary, and 
-- commission for all employees who earn commissions and have a 
-- last name beginning with the letter S. Sort data in 
-- descending order of salary and commission. 
--

SELECT
    first_name,
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NOT NULL
    AND last_name LIKE "S%"
ORDER BY
    salary, commission_pct DESC;

--
-- 26.
-- Which employees were were hired before the 1st of January, 1995, 
-- and who have a salary of more than 9000. 
-- Order the results from highest salary to lowest. 
--

SELECT
    CONCAT (first_name, " ", last_name) AS "Employee Name",
    hire_date,
    salary
FROM
    employees
WHERE
    hire_date BETWEEN "0000-00-00" AND "1995-01-01"
    AND salary > 9000
ORDER BY
    salary DESC;