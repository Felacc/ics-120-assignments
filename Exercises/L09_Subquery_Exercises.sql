/************************************************************************ 
Lecture 09 Exercise
Subqueries


Note - Write these queries using subqueries when ever ppossible instead 
of doing joins

 ************************************************************************/
USE ICS120X01_W24_DB;

/************************************************************************
Exercise 1
Using a subquery, find out the number of employees who make less than 
the average salary
 ************************************************************************/
SELECT
       COUNT(salary)
FROM
       employees
WHERE
       salary < (
              SELECT
                     avg(salary)
              FROM
                     employees
       );

/************************************************************************
Exercise 2

Multi-row Subquery
Find any employee whoes name starts with a T and is in a department where 
the average salary in the  department is < 5000.  Print out their name, 
department and salary. Order the report by employee last name.

HINT: Have the subquery return a list of departments that have an average
salary of < 5000.
 ************************************************************************/
SELECT
       e.first_name,
       e.last_name,
       e.department_id,
       e.salary
FROM
       (
              SELECT
                     department_id,
                     AVG(salary) AS avg_sal
              FROM
                     employees
              GROUP BY
                     department_id
       ) AS das,
       employees e
WHERE
       e.department_id = das.department_id
       AND das.avg_sal < 5000
       AND e.first_name LIKE "T%";

/************************************************************************
Exercise 3
Print a report for all employee whose last names starts with B, showing 
the employee's last names, their salary, their manager's last name and the 
average  salary for all the employees under their manager. Order the
report by employee last name asending.
HINT: Have a subquery that returns a table containing each manager's id,
their last name and the average salary of all their employees.
 ************************************************************************/
SELECT
       e.last_name,
       m.manager_id,
       m.last_name,
       m.avg_sal
FROM
       employees e
       INNER JOIN (
              SELECT
                     manager_id,
                     last_name,
                     AVG(salary) AS avg_sal
              FROM
                     employees
              GROUP BY
                     manager_id
       ) AS m USING (manager_id)
WHERE
       e.last_name LIKE "B%"
ORDER BY
       e.last_name ASC;

/************************************************************************
Exercise 4
Print out all employees that are in a department, where there are multiple
departments in the same location.
 ************************************************************************/
--- Find out which locations have multiple departments at that location ---
SELECT
       location_id
FROM
       departments
GROUP BY
       location_id
HAVING
       COUNT(department_id) > 1;

--- Find out what departments are at that location, use IN in case there are multiple locations ---
SELECT
       department_name
FROM
       departments
WHERE
       location_id IN (
              SELECT
                     location_id
              FROM
                     departments
              GROUP BY
                     location_id
              HAVING
                     COUNT(department_id) > 1
       );

--- Now find the employees that are in those departments ---
SELECT
       e.first_name,
       e.last_name,
       d.department_name
FROM
       employees e
       INNER JOIN departments d USING (department_id)
WHERE
       d.location_id IN (
              SELECT
                     location_id
              FROM
                     departments
              GROUP BY
                     location_id
              HAVING
                     COUNT(department_id) > 1
       );

/************************************************************************
Exercise 5
Take the previous question, add the location id for each employee and sort
the results by location id, department id and employee last name all in ascending 
order.
 ************************************************************************/
SELECT
       e.first_name,
       e.last_name,
       d.department_name,
       d.location_id
FROM
       employees e
       INNER JOIN departments d USING (department_id)
WHERE
       d.location_id IN (
              SELECT
                     location_id
              FROM
                     departments
              GROUP BY
                     location_id
              HAVING
                     COUNT(department_id) > 1
       )
ORDER BY
       d.location_id ASC,
       d.department_id ASC,
       e.last_name ASC;

/************************************************************************
Exercise 6
List the names of all current employees that have had at least 2 previous 
positions.
 ************************************************************************/
--- get those employees that have had more than 2 previous positions ---
SELECT
       employee_id
FROM
       job_history
GROUP BY
       employee_id
HAVING
       COUNT(job_id) >= 2;

--- select the current employees who are in the previous list ---
SELECT
       first_name,
       last_name,
       employee_id
FROM
       employees
WHERE
       employee_id IN (
              SELECT
                     employee_id
              FROM
                     job_history
              GROUP BY
                     employee_id
              HAVING
                     COUNT(job_id) >= 2
       );

/************************************************************************
Exercise 7
List the names of the current employee(s) that have held the most 
number of positions.
 ************************************************************************/
--- Get the max number of positions that any employee has had ---
SELECT
       MAX(job_count) AS max_positions
FROM
       (
              SELECT
                     employee_id,
                     COUNT(job_id) AS job_count
              FROM
                     job_history
              GROUP BY
                     employee_id
       ) job_counts;

--- Get those employees that have had that maximum ---
SELECT
       employee_id,
       job_count
FROM
       (
              SELECT
                     employee_id,
                     COUNT(job_id) AS job_count
              FROM
                     job_history
              GROUP BY
                     employee_id
       ) job_counts
WHERE
       job_count = (
              SELECT
                     MAX(job_count) AS max_positions
              FROM
                     (
                            SELECT
                                   employee_id,
                                   COUNT(job_id) AS job_count
                            FROM
                                   job_history
                            GROUP BY
                                   employee_id
                     ) job_counts
       );

--- See if the current employees are in that list ---
SELECT
       e.first_name,
       e.last_name,
       job_counts.job_count
FROM
       employees e,
       (
              SELECT
                     employee_id,
                     COUNT(job_id) AS job_count
              FROM
                     job_history
              GROUP BY
                     employee_id
       ) job_counts
WHERE
       e.employee_id = job_counts.employee_id
       AND job_counts.job_count = (
              SELECT
                     MAX(job_count) AS max_positions
              FROM
                     (
                            SELECT
                                   employee_id,
                                   COUNT(job_id) AS job_count
                            FROM
                                   job_history
                            GROUP BY
                                   employee_id
                     ) job_counts
       );