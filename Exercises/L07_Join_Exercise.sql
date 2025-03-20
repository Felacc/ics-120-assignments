/************************************************************************ 
Lecture 07 Exercise
Join

 ************************************************************************/
USE MichelF_W25_DB;

/************************************************************************ 
Exercise 1 
Use the tables in your schema.
Find the city and country name for each location.
 *************************************************************************/
-- SQL/86 --
SELECT
    l.city l.location_id,
    c.country_name,
FROM
    countries c,
    locations l
WHERE
    c.country_id = l.country_id;

-- SQL/92 with ON --
SELECT
    l.city l.location_id,
    c.country_name,
FROM
    countries c
    INNER JOIN locations l ON c.country_id = l.country_id;

--SQL/92 with USING --
SELECT
    l.city l.location_id,
    c.country_name,
FROM
    countries c
    INNER JOIN locations l USING (country_id);

/************************************************************************ 
Exercise 2
Use the tables in your schema. 
Find the country name and region name for each country
 **************************************************************************/
-- SQL/86 --
SELECT
    c.country_name,
    r.region_name
FROM
    countries c,
    regions r
WHERE
    c.region_id = r.region_id;

-- SQL/92 with ON --
SELECT
    c.country_name,
    r.region_name
FROM
    countries c
    INNER JOIN regions r ON c.region_id = r.region_id;

--SQL/92 with USING --
SELECT
    c.country_name,
    r.region_name
FROM
    countries c
    INNER JOIN regions r USING (region_id);

/************************************************************************ 
Exercise 3
Use the tables in your schema. 
Do a 3-table join working off of the previous example. 
Find the city, country name, and region name for each city 
 ************************************************************************/
-- SQL/86 --
SELECT
    l.city,
    c.country_name,
    r.region_name
FROM
    locations l,
    countries c,
    regions r
WHERE
    c.region_id = r.region_id
    AND l.country_id = c.country_id;

-- SQL/92 with ON --
SELECT
    l.city,
    c.country_name,
    r.region_name
FROM
    countries c
    INNER JOIN regions r ON (c.region_id = r.region_id)
    INNER JOIN locations l ON (l.country_id = c.country_id);

--SQL/92 with USING --
SELECT
    l.city,
    c.country_name,
    r.region_name
FROM
    countries c
    INNER JOIN regions r USING (region_id)
    INNER JOIN locations l USING (country_id);

/************************************************************************ 
Exercise 4
Use the tables in your schema. 
Using their job history, find the employees (by first name and last name) 
who were working on January 1, 1997.

 ************************************************************************/
-- SQL/86 --
SELECT
    e.first_name,
    e.last_name,
    j.job_id,
    j.start_date,
    j.end_date
FROM
    employees e,
    job_history j
WHERE
    e.employee_id = j.employee_id
    AND "1997-01-01" BETWEEN j.start_date AND j.end_date;

-- SQL/92 with ON --
SELECT
    e.first_name,
    e.last_name,
    j.job_id,
    j.start_date,
    j.end_date
FROM
    employees e
    INNER JOIN job_history j ON (e.employee_id = j.employee_id)
WHERE
    "1997-01-01" BETWEEN j.start_date and j.end_date;

-- SQL/92 with USING --
SELECT
    e.first_name,
    e.last_name,
    j.job_id,
    j.start_date,
    j.end_date
FROM
    employees e
    INNER JOIN job_history j USING (employee_id)
WHERE
    "1997-01-01" BETWEEN j.start_date AND j.end_date;

/********************************************************************************
Exercise 5
Use the tables in your schema. 
Find the employees (last name, job name, department name, city, country, salary) 
who make more than 1500 dollars.  
 *********************************************************************************/
-- SQL/86 --
SELECT
    e.last_name AS lname,
    j.job_title AS job,
    d.department_name AS dname,
    l.city AS city,
    c.country_name AS cname,
    e.salary AS sal
FROM
    employees e,
    jobs j,
    departments d,
    locations l,
    countries c
WHERE
    e.job_id = j.job_id
    AND e.department_id = d.department_id
    AND d.location_id = l.location_id
    AND l.country_id = c.country_id
    AND e.salary >= 1500
ORDER BY
    e.salary DESC;

-- SQL/92 with ON --
SELECT
    e.last_name AS lname,
    j.job_title AS job,
    d.department_name AS dname,
    l.city AS city,
    c.country_name AS cname,
    e.salary AS sal
FROM
    jobs j
    INNER JOIN employees e ON (j.job_id = e.job_id)
    INNER JOIN departments d ON (e.department_id = d.department_id)
    INNER JOIN locations l ON (d.location_id = l.location_id)
    INNER JOIN countries c ON (l.country_id = c.country_id)
WHERE
    e.salary >= 1500
ORDER BY
    e.salary DESC;

-- SQL/92 with USING --
SELECT
    e.last_name AS lname,
    j.job_title AS job,
    d.department_name AS dname,
    l.city AS city,
    c.country_name AS cname,
    e.salary AS sal
FROM
    jobs j
    INNER JOIN employees e USING (job_id)
    INNER JOIN departments d USING (department_id)
    INNER JOIN locations l USING (location_id)
    INNER JOIN countries c USING (country_id)
WHERE
    e.salary >= 1500
ORDER BY
    e.salary DESC;

/********************************************************************************
Exercise 6
Use the tables in your schema. 
Display all the departments and employees who work in those departments,
include departments that have no employees and sort by department_id. 
 *********************************************************************************/
-- SQL/92 with ON --
SELECT
    d.department_id,
    d.department_name,
    e.first_name,
    e.last_name
FROM
    departments d
    LEFT JOIN employees e ON (d.department_id = e.department_id)
ORDER BY
    d.department_id;

-- SQL/92 with USING --