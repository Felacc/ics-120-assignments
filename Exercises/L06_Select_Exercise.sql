/************************************************************************ 
Lecture 06 Exercise
Select 

************************************************************************/


--
-- Setup - If you have not done lab 1 then do the following
--

-- SET ROLE ICS120_Student_Role;
-- USE ICS120_DB;

--
-- Setup - If you have  done lab 1 then do the following but using your own database
--
USE MichelF_W25_DB;

 
/************************************************************************ 
 Exercise 1
 Write a query to display the first name and the last
 name from the employee table. 
*************************************************************************/

SELECT FIRST_NAME, LAST_NAME FROM employees;

-- How many rows were retreived ?

-- ans: 107
 
/************************************************************************ 
 Exercise 2
 Write a query to display all countries that are in region 1 
*************************************************************************/
SELECT REGION_ID FROM countries WHERE REGION_ID = 1;

/************************************************************************ 
  Exercise 3
  Write a query to display the first name and last names of all 
  employees who have the first name 'Ron'.
 ************************************************************************/

SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS "FULL NAME" FROM employees WHERE FIRST_NAME LIKE "Ron";

-- Did we get any rows returned ?
-- No

/*** Question 4 ************************************************************
  Write a query to display all the jobs that have sale in the title
***************************************************************************/

SELECT JOB_TITLE FROM jobs WHERE JOB_TITLE LIKE "%sale%";

/************************************************************************ 
  Exercise 5
  Write a query to display all the employees that have a salary
  that is greater than or equal to $2400 but less than or equal to $4000 (inclusive). 
  Display their first name and last name together as one column and salary.
  Change the heading for name to "Full Name" .
  Sort the rows from high salary to low salary.
  Do this first using >= , <= operators and then using BETWEEN
***************************************************************************/

SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS "FULL NAME" FROM employees WHERE SALARY >= 2400 AND SALARY <= 4000;
SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS "FULL NAME" FROM employees WHERE SALARY BETWEEN 2400 AND 4000;


/************************************************************************ 
 Exercise 6
 Write a query to display all the unique employees that are in the job history 
 table and that worked in departments 20 or 50.  Sort the rows by employee_id.
 Write 2 separate queries one using IN and the other OR.
****************************************************************************/

SELECT DISTINCT EMPLOYEE_ID FROM job_history WHERE DEPARTMENT_ID = 20 OR DEPARTMENT_ID = 50;
SELECT DISTINCT EMPLOYEE_ID FROM job_history WHERE DEPARTMENT_ID IN (20, 50);

/************************************************************************ 
 Exercise 7
 Write a query to display all departments that do not have a manager.    
 Sort the results by department name.
******************************************************************************/


SELECT DEPARTMENT_NAME from departments WHERE MANAGER_ID IS NULL;