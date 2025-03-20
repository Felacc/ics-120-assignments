/************************************************************************ 
Lecture 08 Exercise
Simple Functions, Aggregate Functions

 ************************************************************************/
USE ICS120X01_W24_DB;

/************************************************************************
Exercise 1 
Find the average salary for all employees.Format the result to display in 
dollars with 2 decimal places
 ************************************************************************/
SELECT
    COUNT(salary),
    ROUND(AVG(salary), 2)
FROM
    employees;

/************************************************************************
Exercise 2 
Find the average salary for each department.
Format the result to display in dollars with 2 decimal places.
Sorted the results by department id.
 ************************************************************************/
SELECT
    d.department_id,
    ROUND(AVG(e.salary), 2)
FROM
    employees e
    INNER JOIN departments d USING (department_id)
GROUP BY
    d.department_id
ORDER BY
    d.department_id;

/************************************************************************
Exercise 3
Find the average salary for each department. 
Format the result to display  with 2 decimal places.
Display the department id and name.
Only display departments that have an average salary above $8000.
Sorted the results by the average salary from high to low.
(as SQL/92 implementing USING statement).
 ************************************************************************/
SELECT
    d.department_id,
    d.department_name,
    ROUND(AVG(e.salary), 2) AS avg_sal
FROM
    employees e
    INNER JOIN departments d USING (department_id)
GROUP BY
    d.department_id
HAVING
    ROUND(AVG(e.salary), 2) > 8000
ORDER BY
    ROUND(AVG(e.salary), 2) desc;

/************************************************************************
Exercise 4
Find the min, max and avg salary by employee for each job title.
Format the average salary to 2 decimal places 
Sort the results by average salary from high to low.
 ************************************************************************/
--SQL/86 --
SELECT
    j.job_title,
    MIN(e.salary),
    MAX(e.salary),
    ROUND(AVG(e.salary), 2)
FROM
    jobs j,
    employees e
WHERE
    j.job_id = e.job_id
GROUP BY
    job_title
ORDER BY
    ROUND(AVG(e.salary), 2) DESC;

-- SQL/92 --
SELECT
    j.job_title,
    MIN(e.salary) AS min,
    MAX(e.salary) AS max,
    ROUND(AVG(e.salary), 2) AS avg_sal
FROM
    employees e
    INNER JOIN jobs j USING (job_id)
GROUP BY
    j.job_title
ORDER BY
    avg_sal DESC;

/************************************************************************
Exercise 5
Use the CASE statement to qualify when someone was hired.
If they were hired before 1990, they are an 'Old Timer', 
before 1994 'Senior', before 1997 'Experienced', before 1999 'Junior'
and everyone else is a 'Rookie' 
Display their name, when they were hired and the results of the case.
Sort the results from oldest to newest hire.
 ************************************************************************/
SELECT
    e.first_name,
    e.last_name,
    jh.start_date,
    CASE
        WHEN jh.start_date < '1990-01-01' THEN "Old Timer"
        WHEN jh.start_date < '1994-01-01' THEN "Senior"
        WHEN jh.start_date < '1997-01-01' THEN "Experienced"
        WHEN jh.start_date < '1999-01-01' THEN "Junior"
        ELSE "Rookie"
    END AS rank
FROM
    employees e,
    job_history jh
WHERE
    jh.employee_id = e.employee_id
ORDER BY
    jh.start_date;

/************************************************************************
Exercise 6
Find all employees who have a last name beginning with the letter “W”.
Display first name and last name concatenated as LAST NAME, first name 
(All uppercase last name, a comma, a space and all lower case first name) 
give this result an alias of “Full Name”.
Display the total length of first name and last name,
give this result an alias of “Full Name Length”
 ************************************************************************/
SELECT
    CONCAT (UPPER(last_name), ", ", first_name) AS "Full Name",
    LENGTH (CONCAT (UPPER(last_name), ", ", first_name)) AS "Full Name Length"
FROM
    employees
WHERE
    UPPER(last_name) LIKE "W%";

/************************************************************************
Exercise 7
Display the hire date for all employees as:
“John Doe was hired on July 1st, 1987”
with a column header of 'Hire Date'

 ************************************************************************/
SELECT
    first_name,
    last_name,
    DATE_FORMAT (
        hire_date,
        CONCAT (
            first_name,
            " ",
            last_name,
            " was hired on %M %D, %Y"
        )
    ) AS "Hire Date"
FROM
    employees;