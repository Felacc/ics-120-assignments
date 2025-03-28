/*********************************************************************************

Assignment - Lab 5  Subqueries


 **********************************************************************************/
/*********************************************************************************
Question 1
Write a query that will display the last name and salary of all employees who earns    more than Gerald Cambrault. Order the results  by salary high to low.
 **********************************************************************************/
SELECT
  last_name,
  salary
FROM
  employees
WHERE
  salary > (
    SELECT
      salary
    FROM
      employees
    WHERE
      UPPER(CONCAT (first_name, " ", last_name)) = UPPER("Gerald Cambrault")
  )
ORDER BY
  salary DESC;

/*********************************************************************************
Question 2
Create a query to display the employee numbers, last names and salaries of all 
employees who earn more than the average salary and whose last_name begins with
a 'G' or 'P' (be sure to handle case). Sort the results in descending order of salary. 
Hint Ensure you use brackets around AND and OR clauses in the WHERE clause.
 **********************************************************************************/
SELECT
  employee_id,
  last_name,
  salary
FROM
  employees
WHERE
  salary > (
    SELECT
      AVG(salary)
    FROM
      employees
  )
  AND (
    UPPER(last_name) LIKE "P%"
    OR UPPER(last_name) LIKE "G%"
  );

/*********************************************************************************
Question 3
Write a query that will display the last name and salary of every employee who 
reports to Gerald Cambrault. (There is more than one Cambrault in the database 
so you must be careful to check the first name too.) Be sure to handle case. 
 **********************************************************************************/
SELECT
  last_name,
  salary
FROM
  employees
WHERE
  manager_id = (
    SELECT
      employee_id
    FROM
      employees
    WHERE
      UPPER(first_name) = "GERALD"
      AND UPPER(last_name) = "CAMBRAULT"
  );

/*********************************************************************************
Question 4
How many people work in the same department as Gerald Cambrault?  Write a query 
to count the number employees in Gerald's department.  Exclude Gerald from your 
count. (Remember, there is more than one Cambrault in the database so be sure to
check the first name too.) 
 **********************************************************************************/
SELECT
  COUNT(*) AS "# of Underlings"
FROM
  employees
WHERE
  manager_id = (
    SELECT
      employee_id
    FROM
      employees
    WHERE
      UPPER(first_name) = "GERALD"
      AND UPPER(last_name) = "CAMBRAULT"
  );

/*********************************************************************************
Question 5

Display the last name, salary and department name for each employee who earns
the least in each department.
 **********************************************************************************/
SELECT
  e.last_name,
  e.salary,
  d.department_name
FROM
  employees e,
  departments d
WHERE
  e.department_id = d.department_id
  AND e.salary = (
    SELECT
      MIN(salary) AS min_sal
    FROM
      employees
    WHERE
      department_id = e.department_id
  );

/*********************************************************************************
Question 6

For each employee who makes less than the average salary for their job id, display
their name, job title, salary and the average salary for their job id. Order by
job_title ascending and salary descending. Round the salary and average salary to 0  decimal places.
 **********************************************************************************/
SELECT
  e.first_name,
  e.last_name,
  j.job_title,
  ROUND(e.salary, 2) AS avg_sal,
  ROUND(ajs.avg_job_sal, 2) AS avg_job_sal
FROM
  employees e,
  jobs j,
  (
    SELECT
      job_id,
      AVG(salary) AS avg_job_sal
    FROM
      employees
    GROUP BY
      job_id
  ) ajs
WHERE
  e.job_id = j.job_id
  AND ajs.job_id = j.job_id
  AND e.salary < ajs.avg_job_sal
ORDER BY
  j.job_title ASC,
  e.salary DESC;

/*********************************************************************************
Question 7
Write a query to display the department IDs, employee IDs, last names, and salaries
of all employees who earn more than twice (2 times) the average salary for the company,
and who work in a department with any employee with a "u" anywhere in their last name. 
Order your output by employee IDs. 
Hint: This is 2 subselects one for department and one for salary
 **********************************************************************************/
SELECT
  department_id,
  employee_id,
  last_name,
  salary
FROM
  employees
WHERE
  salary > (
    SELECT
      (2 * AVG(salary))
    FROM
      employees
  )
  AND department_id IN (
    SELECT
      department_id
    FROM
      employees
    WHERE
      LOWER(last_name) LIKE "%u%"
  )
ORDER BY
  employee_id;

/*********************************************************************************
Question 8
Display the number of employees in each country that have more employees than Canada
has.
 **********************************************************************************/
SELECT
  c.country_name,
  COUNT(e.employee_id) AS emp_count
FROM
  employees e,
  departments d,
  locations l,
  countries c
WHERE
  e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
GROUP BY
  c.country_id
HAVING
  emp_count > (
    SELECT
      COUNT(e.employee_id)
    FROM
      employees e,
      departments d,
      locations l,
      countries c
    WHERE
      e.department_id = d.department_id
      AND d.location_id = l.location_id
      AND l.country_id = c.country_id
      AND LOWER(c.country_name) = "canada"
  );