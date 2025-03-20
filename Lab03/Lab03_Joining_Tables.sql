/*********************************************************************************

Lab 3 Joining Tables

 **********************************************************************************/
/*********************************************************************************
Question 1A, 1B, 1C
Use the tables in your schema.
For each country in Asia, display the country name and the region name. 
Sort the results by country name in ascendening sequence.
Give the answer in the requested SQL verisons using the requested keywords.
Write the query in SQL/86 and SQL/92.
 **********************************************************************************/
-- 1A -- SQL/86
SELECT
  c.country_name,
  r.region_name
FROM
  countries c,
  regions r
WHERE
  c.region_id = r.region_id
  AND r.region_name = "Asia"
ORDER BY
  c.country_name ASC;

-- 1B -- SQL/92 using "ON"
SELECT
  c.country_name,
  r.region_name
FROM
  countries c
  INNER JOIN regions r ON c.region_id = r.region_id
WHERE
  r.region_name = "Asia"
ORDER BY
  c.country_name ASC;

-- 1C -- SQL/92 using "USING"
SELECT
  c.country_name,
  r.region_name
FROM
  countries c
  INNER JOIN regions r USING (region_id)
WHERE
  r.region_name = "Asia"
ORDER BY
  c.country_name ASC;

/*********************************************************************************
Question 2A, 2B
Use the tables in your schema.
Write a query to display the last name, job title, department id, and 
department name for all employees who work in Southlake. 
Sort the results by last name in ascending sequence.
Write the query in SQL/86 and SQL/92.
 **********************************************************************************/
-- 2A --  SQL/86
SELECT
  e.last_name,
  j.job_title,
  d.department_id,
  d.department_name,
  l.city
FROM
  jobs j,
  employees e,
  departments d,
  locations l
WHERE
  l.city = "Southlake"
  AND l.location_id = d.location_id
  AND d.department_id = e.department_id
  AND e.job_id = j.job_id
ORDER BY
  e.last_name ASC;

-- 2B SQL/92
SELECT
  e.last_name,
  j.job_title,
  d.department_id,
  d.department_name,
  l.city
FROM
  locations l
  INNER JOIN departments d USING (location_id)
  INNER JOIN employees e USING (department_id)
  INNER JOIN jobs j USING (job_id)
WHERE
  l.city = "Southlake"
ORDER BY
  e.last_name ASC;

/*********************************************************************************

Question 3 
Use the tables in your schema.
Write a query that will list all of the employees (last names), whose last name
starts with 'G', and the departments (give the name of the department) to which 
they belong. Include all employees who have not yet been assigned to any department. 
If an employee does not belong to a department, use the string "unassigned" for 
the department name.
Sort the results by last name in ascending sequence.
Use the terms "Last Name" and "Department" for the column headings.

Note: do not use IS NULL or IS NOT NULL in your query. 
 **********************************************************************************/
SELECT
  e.last_name AS "Last Name",
  COALESCE(d.department_name, "unassigned") AS "Department"
FROM
  employees e
  LEFT JOIN departments d USING (department_id)
WHERE
  e.last_name LIKE "G%"
ORDER BY
  e.last_name ASC;

/*********************************************************************************
Question 4A, 4B  
Use the tables in your schema.
Display the employee last name and employee id along with their manager's last 
name and manager number (in other words the manager's employee id) for all 
employees whose last name begins with 'T'. 
Label the columns Employee, Emp#, Manager, and Mgr#, respectively (note the use of upper and lower 
case). 
Sort the results by employee last name in descending sequence.
Write the query in SQL/86 and SQL/92. 
 **********************************************************************************/
-- 4A -- SQL/86
SELECT
  e.last_name AS "Employee",
  e.employee_id AS "Emp#",
  m.last_name AS "Manager",
  m.employee_id AS "Mgr#"
FROM
  employees e,
  employees m
WHERE
  e.manager_id = m.employee_id
  AND e.last_name LIKE "T%"
ORDER BY
  e.last_name DESC;

-- 4B -- SQL/92
SELECT
  e.last_name AS "Employee",
  e.employee_id AS "Emp#",
  m.last_name AS "Manager",
  m.employee_id AS "Mgr#"
FROM
  employees e
  INNER JOIN employees m ON e.manager_id = m.employee_id
WHERE
  e.last_name LIKE "T%"
ORDER BY
  e.last_name DESC;

/*********************************************************************************
Question 5A, 5B 
Use the tables in your schema.
Display the region, the employee first and last name (separated by a space) in a 
column titled "Employee Name", and the employee's salary.  Only include employees 
with a salary between 9000 and 10000 (inclusive).
Sort the report by ascending region name, and then by descending salary.

Write the query in SQL/86 and SQL/92.
 **********************************************************************************/
-- 5A -- SQL/86
SELECT
  r.region_name AS "Region",
  CONCAT(e.first_name, " ", e.last_name) AS "Employee Name",
  e.salary AS "Salary"
FROM
  regions r,
  countries c,
  locations l,
  departments d,
  employees e
WHERE
  r.region_id = c.region_id
  AND c.country_id = l.country_id
  AND l.location_id = d.location_id
  AND d.department_id = e.department_id
  AND e.salary BETWEEN 9000 AND 10000
ORDER BY
  r.region_name ASC, e.salary DESC;


-- 5B -- SQL/92
SELECT
  r.region_name AS "Region",
  CONCAT(e.first_name, " ", e.last_name) AS "Employee Name",
  e.salary AS "Salary"
FROM
  regions r
  INNER JOIN countries c USING (region_id)
  INNER JOIN locations l USING (country_id)
  INNER JOIN departments d USING (location_id)
  INNER JOIN employees e USING (department_id)
WHERE
  r.region_id = c.region_id
  AND c.country_id = l.country_id
  AND l.location_id = d.location_id
  AND d.department_id = e.department_id
  AND e.salary BETWEEN 9000 AND 10000
ORDER BY
  r.region_name ASC, e.salary DESC;

/*********************************************************************************
Question 6A, 6B
Use the tables in your schema.
List the the employees (last name, job name, department name, salary) who make
more than 6400 dollars.  
Sort the results by salary in descending sequence. 
Write the query in SQL/86 and SQL/92.
 **********************************************************************************/
-- 6A -- SQL/86
SELECT
  e.last_name,
  j.job_title,
  d.department_name,
  e.salary
FROM
  jobs j,
  employees e,
  departments d
WHERE
  j.job_id = e.job_id
  AND e.department_id = d.department_id
  AND e.salary > 6400
ORDER BY
  e.salary DESC;


-- 6B -- SQL/92
SELECT
  e.last_name,
  j.job_title,
  d.department_name,
  e.salary
FROM
  jobs j
  INNER JOIN employees e USING (job_id)
  INNER JOIN departments d USING (department_id)
WHERE
  e.salary > 6400
ORDER BY
  e.salary DESC;

/*********************************************************************************
Question 7A, 7B, 7C
Use the tables in your schema.
What are all the employees who work in Europe, in Germany, in the Public Relations
department
Write the query in SQL/86 and SQL/92.
 **********************************************************************************/
-- 7A - SQL/86
SELECT
  CONCAT(e.first_name, " ", e.last_name) AS "Employee",
  c.country_name,
  r.region_name,
  d.department_name
FROM
  regions r,
  countries c,
  locations l,
  departments d,
  employees e
WHERE
  r.region_id = c.region_id
  AND r.region_name = "Europe"
  AND c.country_id = l.country_id
  AND c.country_name = "Germany"
  AND l.location_id = d.location_id
  AND d.department_id = e.department_id
  AND d.department_name = "Public Relations";



-- 7B - SQL/92 with ON
SELECT
  CONCAT(e.first_name, " ", e.last_name) AS "Employee",
  c.country_name,
  r.region_name,
  d.department_name
FROM
  regions r
  INNER JOIN countries c ON (r.region_id = c.region_id)
  INNER JOIN locations l ON (c.country_id = l.country_id)
  INNER JOIN departments d ON (l.location_id = d.location_id)
  INNER JOIN employees e ON (d.department_id = e.department_id)
WHERE
  r.region_name = "Europe"
  AND c.country_name = "Germany"
  AND d.department_name = "Public Relations";

-- 7C - SQL/92 with USING

SELECT
  CONCAT(e.first_name, " ", e.last_name) AS "Employee",
  c.country_name,
  r.region_name,
  d.department_name
FROM
  regions r
  INNER JOIN countries c USING (region_id)
  INNER JOIN locations l USING (country_id)
  INNER JOIN departments d USING (location_id)
  INNER JOIN employees e USING (department_id)
WHERE
  r.region_name = "Europe"
  AND c.country_name = "Germany"
  AND d.department_name = "Public Relations";
