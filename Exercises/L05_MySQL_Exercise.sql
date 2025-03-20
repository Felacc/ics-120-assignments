/************************************************************************ 
Lecture 05 Exercise
MySQL

 
Exercise 1
You have all been granted access to the ICS120_Student_Role, this role has 
SELECT access to the tables in the ICS120_DB database.

Activate the role by issuing the following command
************************************************************************/

SET ROLE ICS120_Student_Role;
 
/************************************************************************ 
 Exercise 2
 Use the show databaase command to verify that you have access to the 
 ICS120_DB database
*************************************************************************/

SHOW databases;
 
/************************************************************************ 
 Exercise 3
 Set the ICS120_DB to the database to be used 
*************************************************************************/

USE ICS120_DB;

/************************************************************************ 
  Exercise 4
  Show what table are in the database.
 ************************************************************************/

SHOW tables;

/************************************************************************ 
  Exercise 5
  For the employees table display the columns/structure of the the table.
***************************************************************************/

DESC employees;

/************************************************************************ 
  Exercise 6
  Run a simple query on the employees table selecting the first and last name
  and only they first 10 row.
***************************************************************************/

SELECT FIRST_NAME, LAST_NAME FROM employees LIMIT 10;

