/*********************************************************************************

Lab 4 Functions


 *********************************************************************************/
/*********************************************************************************
Question 1
What is the total salary of all employees label the column as Total Salary.  
 **********************************************************************************/
SELECT
  SUM(salary) as "Total Salary"
FROM
  employees;

/*********************************************************************************
Question 2
For all employees whose last name starts with the letter R (protect against
upper/lowercase anomalies using a function), display the employee's last name 
and give the length of their last name.  Give the first column a label of 
"Last Name" and the second "Length".  Sort the results in descending order 
by the employee's last name. 
 **********************************************************************************/
SELECT
  last_name as "Last Name",
  LENGTH (last_name) as "Length"
FROM
  employees
WHERE
  UPPER(last_name) LIKE "R%";

/*********************************************************************************
Question 3 
For each employee, generate a userid by taking the first letter of their first
name, concatenating that with the first 5 letters of their last name and then
adding the last 2 digits of their phone number label this "USERID".  All letters 
must be in lower case.  Show the employee, first name, last name, phone number 
and userid sorted by employee last name in ascending sequence. 
HINT: Phone numbers are not all the same length, so you will need to use the
LENGTH function.
 **********************************************************************************/
SELECT
  employee_id,
  first_name,
  last_name,
  phone_number,
  CONCAT (
    REGEXP_SUBSTR (first_name, '^.'),
    REGEXP_SUBSTR (last_name, '^.{1,5}'),
    REGEXP_SUBSTR (phone_number, '[^0-9|.]*..$')
  ) AS "USERID"
FROM
  employees
ORDER BY
  last_name asc;

/*********************************************************************************
Question 4
Find the average salary for employees in the IT department (the department name
will be 'IT').  Round the average to 2 decimal places.  Label this column 
as "Average IT Salary".   Write it in all 3 formats.
 **********************************************************************************/
-- SQL/86 --
SELECT
  ROUND(AVG(e.salary), 2) as "Average IT Salary"
FROM
  employees e,
  departments d
WHERE
  e.department_id = d.department_id
  AND d.department_name LIKE "IT";

-- SQL/92 with ON --
SELECT
  ROUND(AVG(e.salary), 2) as "Average IT Salary"
FROM
  employees e
  INNER JOIN departments d ON (e.department_id = d.department_id)
WHERE
  d.department_name LIKE "IT";

-- SQL/92 with USING --
SELECT
  ROUND(AVG(e.salary), 2) as "Average IT Salary"
FROM
  employees e
  INNER JOIN departments d USING (department_id)
WHERE
  d.department_name LIKE "IT";

/*********************************************************************************
Question 5
Write a query to display the number of people with the same job. Use JOB_ID 
in your query and list the jobs by JOB_ID along with the number of people having
that job.
 **********************************************************************************/
SELECT
  j.job_id,
  COUNT(e.employee_id) as "# of Employees"
FROM
  employees e,
  jobs j
WHERE
  e.job_id = j.job_id
GROUP BY
  j.job_id;

/*********************************************************************************
Question 6
Display the maximum, minimum, sum, and average 
salary for each job type  (assume each job_id represents a job type). Be 
sure to give the job type in your output.
 **********************************************************************************/
SELECT
  j.job_id,
  MAX(e.salary) as max,
  MIN(e.salary) as min,
  SUM(e.salary) as sum,
  AVG(e.salary) as avg
FROM
  jobs j
  INNER JOIN employees e USING (job_id)
GROUP BY
  j.job_id;

/*********************************************************************************
Question 7
Alter the query in question 4 to print out the average salary (changing the 
column title to  "Average Salary") for all departments and the the department name. 
(Hint: use the  "group by" clause ).  Order the output by department name. 
Write this using SQL/92 with USING. 
 **********************************************************************************/
SELECT
  department_name as "Department",
  ROUND(AVG(e.salary), 2) as "Average Salary"
FROM
  employees e
  INNER JOIN departments d USING (department_id)
GROUP BY
  d.department_name
ORDER BY
  d.department_name;

/*********************************************************************************
Question 8
Alter the previous query to only print out those departments that have an average
salary greater than 10,000.   
 **********************************************************************************/
SELECT
  department_name as "Department",
  ROUND(AVG(e.salary), 2) as "Average Salary"
FROM
  employees e
  INNER JOIN departments d USING (department_id)
GROUP BY
  d.department_name
HAVING
  ROUND(AVG(e.salary), 2) > 10000
ORDER BY
  d.department_name;

/*********************************************************************************
Question 9
For each job, display the job title followed by the number of employees with that
job title, then the min, max, and avg salary for that job for those employees in 
the job (use the employee table).  Round the dollars to zero decimal places. Set the 
column headers to be Num Employees, Min Salary, Max Salary and Average Salary.  
Use  SQL/92 - Implement  with USING  statement. Hint: you will need to  use a "group by"    clause.  
Keep the  ordering by   ascending average salary. 
 **********************************************************************************/
SELECT
  j.job_title,
  COUNT(e.employee_id) as "Num Employees",
  ROUND(MIN(e.salary)) as "Min Salary",
  ROUND(MAX(e.salary)) as "Max Salary",
  ROUND(AVG(e.salary)) as "Average Salary"
FROM
  employees e
  INNER JOIN jobs j USING(job_id)
GROUP BY
  j.job_title
ORDER BY
  ROUND(AVG(e.salary)) asc;
/*********************************************************************************
Question 10
Alter the previous query to only print out those job titles that have more than
1 employee for the job title.
 **********************************************************************************/
 SELECT
  j.job_title,
  COUNT(e.employee_id) as "Num Employees",
  ROUND(MIN(e.salary)) as "Min Salary",
  ROUND(MAX(e.salary)) as "Max Salary",
  ROUND(AVG(e.salary)) as "Average Salary"
FROM
  employees e
  INNER JOIN jobs j USING(job_id)
GROUP BY
  j.job_title
HAVING
  COUNT(e.employee_id) > 1
ORDER BY
  ROUND(AVG(e.salary)) asc;
/*********************************************************************************
Question 11
Display the manager number and the salary of the lowest paid employee for 
that manager. Exclude anyone whose manager is not known - in other words, 
exclude anyone who has a NULL manager_id. Sort by manager id.
 **********************************************************************************/
SELECT
  manager_id,
  MIN(salary) as min_sal
FROM
  employees
WHERE
  manager_id IS NOT NULL
GROUP BY
  manager_id
ORDER BY
  manager_id;
/*********************************************************************************
Question 12
Modify your query from above  to exclude any groups where the minimum 
salary is less than or equal to $6,000. Sort the output in descending order of 
min salary. 
 **********************************************************************************/
SELECT
  manager_id,
  MIN(salary) as min_sal
FROM
  employees
WHERE
  manager_id IS NOT NULL
GROUP BY
  manager_id
HAVING
  min_sal > 6000
ORDER BY
  min_sal desc;
/*********************************************************************************
Question 13
write a query showing the number of employees that have been hired in each month in 
each department (include the department title). Sort the output by department name 
and alphabetic month (January, Febuary, etc).
 **********************************************************************************/
SELECT
  d.department_name as "Department",
  DATE_FORMAT(hire_date, "%M") as "Month",
  COUNT(e.employee_id) as "Num Employees"
FROM
  employees e
  INNER JOIN departments d USING (department_id)
GROUP BY
  d.department_name, DATE_FORMAT(hire_date, "%M")
ORDER BY
  d.department_name, DATE_FORMAT(hire_date, "%M");
