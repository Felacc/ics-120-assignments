/*********************************************************************************

 Assignment - Lab 7 - Creating and Modifying Tables
 
 **********************************************************************************/
USE MichelF_W25_DB;

/*********************************************************************************
 Question 1
 
 Create a new table named my_student (case matters here) with the following attributes:
 
   mystudent_id	   integer(5)
   mylname	       varchar(25)
   mystartdate	   date

 Make the column mystartdate  default to the system date. 
**********************************************************************************/
CREATE TABLE my_student (
	mystudent_id INTEGER(5),
    mylname VARCHAR(25),
    mystartdate DATE DEFAULT SYSDATE();
);

select SYSDATE();

/*********************************************************************************
 Question 2
 
 Use the describe command to show the structure of your new my_student table. 
**********************************************************************************/

  
DESCRIBE my_student;

/*********************************************************************************
 Question 3

 Modify the my_student table to allow for longer last names (i.e. mylname). 
 Increase its size to 50. 
**********************************************************************************/

  
ALTER TABLE my_student
MODIFY COLUMN mylname VARCHAR(50);

/*********************************************************************************
 Question 4
 Confirm your modification by using the DESC command. 
 
**********************************************************************************/

 
DESCRIBE my_student;

/*********************************************************************************
 Question 5
 
 Pretend you are a student being added to the table. Make up a student id and insert 
 your name into the my_student table. Allow the start date to default to the system 
 date - in other words, do NOT insert a valid for the mystartdate column.
**********************************************************************************/

INSERT
	INTO
	my_student (mystudent_id,
	mylname)
VALUES (3,
'Michel');

/*********************************************************************************
 Question 6 
 
 List the contents of the table to show that your record has been entered correctly. 
**********************************************************************************/

SELECT
	*
FROM
	my_student;

/*********************************************************************************
 Question 7 
 
 Add a comment on the table which says "Lab 7 Table". Use the ALTER TABLE command.
 Look in the MySQL manual on how to add a comment.  This is not adding a new column
 to the table.
**********************************************************************************/
ALTER TABLE my_student
 COMMENT = "Lab 7 Table";

/*********************************************************************************
 Question 8  
 
 Using a data dictionary table,
verify that this comment has been added to your table.
 Only show the table name, database and comment for your table. 
 Hint - use the   information_schema.TABLES
 
**********************************************************************************/

SELECT
	TABLE_NAME,
	TABLE_SCHEMA,
	TABLE_COMMENT
FROM
	information_schema.TABLES
WHERE
	TABLE_NAME = 'my_student';

/*********************************************************************************
 Question 9
 
 Create a table called MY_STUDENT (case matters) based on the structure of your 
 my_student table. Use the CREATE  TABLE … AS SELECT command.
 Name the columns in your new table StudentNo, Last Name, BeginDate.
 Note the use of upper, lower case and spaces.  In the subquery, use the alias
 option for a column to give the columns their new name.
 **********************************************************************************/
CREATE TABLE MY_STUDENT AS
SELECT
	mystudent_id AS StudentNo,
	mylname AS "Last Name",
	mystartdate AS BeginDate
FROM
	my_student;



/*********************************************************************************
 Question 10
 
 Show the structure of your new MY_STUDENT table
**********************************************************************************/

DESC MY_STUDENT;

/*********************************************************************************
 Question 11
 Using a data dictionary table, confirm that both the MY_STUDENT and my_student tables  
 are in your schema. Only display those 2 tables. 
 Hint - use the   information_schema.TABLES
**********************************************************************************/


SELECT
	TABLE_NAME
FROM
	information_schema.TABLES
WHERE
	TABLE_NAME = 'MY_STUDENT'
	OR
	TABLE_NAME = 'my_student';

/*********************************************************************************
 Question 12
 
 Drop the my_student table.
**********************************************************************************/

DROP TABLE my_student;


/*********************************************************************************
 Question 13
 
 Confirm the table is gone.
**********************************************************************************/

SELECT
	TABLE_NAME
FROM
	information_schema.TABLES
WHERE
	TABLE_NAME = 'MY_STUDENT'
	OR
	TABLE_NAME = 'my_student';


/*********************************************************************************
 Question 14
 
 Rename the MY_STUDENT table to my_student. 
**********************************************************************************/

  RENAME TABLE MY_STUDENT TO my_student;

/*********************************************************************************
 Question 15
 Using a data dictionary table, confirm that only the my_student table remains in your schema. 
 Hint - use the   information_schema.TABLES
**********************************************************************************/
  

SELECT
	TABLE_NAME
FROM
	information_schema.TABLES
WHERE
	TABLE_NAME = 'MY_STUDENT'
	OR
	TABLE_NAME = 'my_student';




/*********************************************************************************
 Question 16
 
 Verify that the columns in my_student are StudentNo, Last Name, BeginDate
**********************************************************************************/

select * from my_student;

-- Cleanup

drop table my_student;