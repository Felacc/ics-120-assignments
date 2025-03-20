/************************************************************************ 
Lecture 10 Exercise
Changing Table Contents
 ************************************************************************/
/************************************************************************
These exercise require that you have the tables created from the 
Lecture 10 Changing Table Contents Examples created.
 ************************************************************************/
USE ICS120X01_W24_DB;

/************************************************************************
Exercise 1
Use the dept table.
Write a query to add a new department to the dept table with a department
number of 2, a name of Remote Site and a location of Portland. 
 ************************************************************************/
INSERT INTO
    dept (deptno, dname, loc)
VALUES
    (2, 'Remote Site', 'Portland');

/************************************************************************
Exercise 2
Write a query to insert everything from the regions table into the 
regions1 table.
 ************************************************************************/
INSERT INTO
    regions1 (region_id, region_name)
SELECT
    region_id,
    region_name
FROM
    regions;

/************************************************************************
Exercise 3
Use the emp table.
Write a query to update the department number of Smith to 3.  
What happens and why?
 ************************************************************************/
UPDATE emp
SET
    deptno = 3 
WHERE
    ename = 'Smith';

--- the query doesn't work because deptno is a foreign key from dept, and dept doesn't contain any rows with a deptno = 3;

/************************************************************************
Exercise 4
Turn autocommitt off
Use the emp table.
Write a query to set all the deptno to 1.  
Confirm the query worked.
Roll back all the changes.
What is the deptno of Smith and why is it that?
 ************************************************************************/

SET autocommit = OFF;

UPDATE emp 
SET deptno = 1;

ROLLBACK;

--- after updating the deptno are rolled back to null;

/************************************************************************
Exercise 5
Use the regions1 table.
Delete the row for region id 1.
 ************************************************************************/ 

DELETE FROM regions1
WHERE region_id = 1;


/************************************************************************
Exercise 6
Create a save point called SP1.
Delete all the rows from the regions1 table.
Confirm that the regions1 table is empty.
Recovery to the SP1 savepoint.
Confirm that the data has been restored.
 ************************************************************************/

START TRANSACTION;
SAVEPOINT SP1;

DELETE FROM regions1;

SELECT * FROM regions1;

ROLLBACK TO SAVEPOINT SP1;

SELECT * FROM regions1;