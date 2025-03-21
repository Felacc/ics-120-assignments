/*********************************************************************************

 Assignment - Lab 8 - Table Constraints

 **********************************************************************************/

USE MichelF_W25_DB;
 
/*********************************************************************************
 Question 1
 
 In your schema create a table called NEW_STUDENTS with the following structure 
 (Note: case is not important).  
 
          temp_id	integer(5)
          prog_id	char(4)
          fname	        varchar(25)
          lname	        varchar(25)
          reg_date	date

**********************************************************************************/

CREATE TABLE NEW_STUDENTS (
	temp_id integer(5),
	prog_id char(4),
	fname varchar(25),
	lname varchar (25),
	reg_date date
	
);

SHOW tables;
DESC NEW_STUDENTS;


/*********************************************************************************
 Question 2
 
 Add 2 columns to the table you created in #1 as follows (again, case is not important):
 
         created_by     varchar(30)
         created_date	date
		 
When you add these columns to the table, add a constraint for created_by and a default value for created_date:

         - created_by should not allow NULL values
         - created_date should default to the system date

**********************************************************************************/


ALTER TABLE NEW_STUDENTS
	ADD (created_by varchar(30) NOT NULL), 
	ADD (created_date date DEFAULT SYSDATE());


/*********************************************************************************
 Question 3

 Confirm your modifications using the describe command. 
 
**********************************************************************************/


DESC NEW_STUDENTS;


/*********************************************************************************
 Question 4
  
  Confirm if those constraint are in the information_schema.TABLE_CONSTRAINTS data dictionary table.
  Show ONLY the constraints for your new_students table. 
  See if the constraints are in the DESC of the table.
  
**********************************************************************************/

SELECT *
FROM information_schema.TABLE_CONSTRAINTS tc
WHERE TABLE_NAME = "NEW_STUDENTS";


/*********************************************************************************
 Question 5
 
 Create another table called programmes with the following structure. 
 
       prog_id	    char(4)
       prog_desc    varchar(30)

**********************************************************************************/


CREATE TABLE programmes (
	prog_id char(4),
	prod_desc varchar(30)
);


/*********************************************************************************
 Question 6 
 
 Insert the following data into the new_students table. 
  
 (9516, 'comp','Ted','Codd',sysdate,user)


  Confirm that the data is in the table by using a select command.

**********************************************************************************/

INSERT INTO NEW_STUDENTS
	VALUES (9516, 'comp', 'Ted', 'Codd', sysdate(), 'user', DEFAULT);

SELECT * FROM NEW_STUDENTS;


/*********************************************************************************
 Question 7 
 
 Insert the following data into the programmes table. 
  
 ('comp','Computer Technology')
 
  Confirm that the data is in the table by using a select command.
   
**********************************************************************************/


INSERT INTO programmes
	VALUES('comp', 'Computer Technology');

SELECT * FROM programmes;


/*********************************************************************************
 Question 8  
 
 Alter the PROGRAMMES table to make prog_id a primary key. Name your constraint prog_id_pk. 
 
**********************************************************************************/

ALTER TABLE programmes
	ADD CONSTRAINT prog_id_pk
	PRIMARY KEY (prog_id);

DESC programmes;

/*********************************************************************************
 Question 9
 
 Alter the NEW_STUDENTS table to make temp_id plus prog_id (both columns) the primary key. 
 Name your constraint tempid_progid_pk.   
 
 **********************************************************************************/

ALTER TABLE NEW_STUDENTS
	ADD CONSTRAINT tempid_progid_pk
	PRIMARY KEY (temp_id, prog_id);

DESC NEW_STUDENTS;

/*********************************************************************************
 Question 10
 
 The column prog_id should be a foreign key in the NEW_STUDENTS table,
 so create the foreign key. Name your constraint prog_id_fk. 
 
**********************************************************************************/

ALTER TABLE NEW_STUDENTS
	ADD CONSTRAINT prog_id_fk
	FOREIGN KEY (prog_id) REFERENCES programmes(prog_id);


/*********************************************************************************
 Question 11
 
 Confirm that the constraints were added by querying the information_schema.TABLE_CONSTRAINTS 
 data dictionary table.  Show ONLY the constraints for your new_students and programmes tables. 
 Order the results by the table name.   
 
**********************************************************************************/


SELECT * 
FROM information_schema.TABLE_CONSTRAINTS tc
WHERE TABLE_NAME IN ('NEW_STUDENTS', 'programmes')
ORDER BY TABLE_NAME;


/*********************************************************************************
 Question 12
 
 Try and insert the following values into your NEW_STUDENTS table as a new record. 
 
   temp_id = 9517
   prog_id = econ
   name = Bill
   lname = Gates
   reg_date = today's date
   created_by = your name

 
**********************************************************************************/

INSERT INTO NEW_STUDENTS (temp_id, prog_id, fname, lname, reg_date, created_by)
	VALUES (9517, 'econ', 'Bill', 'Gates', sysdate(), 'Felix Michel');


desc NEW_STUDENTS;


/*********************************************************************************
 Question 13
 
 You should have gotten an error in #12 when you tried to insert therecord. 
 Explain EXACTLY what caused the error, don’t just repeat the error message? 
 
**********************************************************************************/

-- The insert statement fails because there is no reference to a row with the value 'econ' in the prog_id column
-- since the prog_id in new_students has a foreign key constraint there must be a reference to it in programmes


-- see here:
SELECT * FROM programmes WHERE prog_id = 'econ';


/*********************************************************************************
 Question 14 
 
 Insert the following data into the programmes table. 
  
 ('econ','Ecnomics')
 
  Confirm that the data is in the table by using a select command.
   
**********************************************************************************/

INSERT INTO programmes
	VALUES('econ', 'Economics');

SELECT * FROM programmes;
	
SELECT * FROM programmes WHERE prog_id = 'econ';


/*********************************************************************************
 Question 15 
 
 Now try the insert from question 12 again.  Does it now work?
 
 Confirm if the data is in the table by using a select command.
   
**********************************************************************************/


INSERT INTO NEW_STUDENTS (temp_id, prog_id, fname, lname, reg_date, created_by)
	VALUES (9517, 'econ', 'Bill', 'Gates', sysdate(), 'Felix Michel');

SELECT * FROM NEW_STUDENTS;

/*********************************************************************************
 Question 16
 
 New students have only been registered since the year 1997. Add a constraint to
 the reg_date column to ensure that only registration dates as of January 1, 1997 
 can be entered. Name your constraint dates_ck. 
 
**********************************************************************************/


ALTER TABLE NEW_STUDENTS
	ADD CONSTRAINT dates_ck
	CHECK (reg_date >= '1997-01-01');


/*********************************************************************************
 Question 17
 
 Try and insert the following values into your NEW_STUDENTS table to test your new constraint. 
 
   temp_id = 9519
   prog_id = comp
   fname = Grace
   lname = Hopper
   reg_date = January 2, 1948
   created_by = your name
  
**********************************************************************************/


INSERT INTO NEW_STUDENTS (temp_id, prog_id, fname, lname, reg_date, created_by)
	VALUES (9519, 'comp', 'Grace', 'Hopper', '1948-01-02', 'Felix Michel');
/*********************************************************************************
 Question 18
 
 You should get an error when you tried to insert the record in #15. 
 Explain EXACTLY what caused the error, don’t just repeat the error message?  
 
**********************************************************************************/

-- The error occured because the date of 1948-01-02 breaks the
-- constraint set by dates_ck where the reg_date must be at a date from 1997-01-01 or later



/*********************************************************************************
 Question 19
 
 Change the date to  to January 2, 2018 and try and insert the following values into your 
 NEW_STUDENTS table to test your new constraint. 

    temp_id = 9519
    prog_id = comp
    fname = Grace
    lname = Hopper
    reg_date = January 2, 2018
    created_by = your name

**********************************************************************************/


INSERT INTO NEW_STUDENTS (temp_id, prog_id, fname, lname, reg_date, created_by)
	VALUES (9519, 'comp', 'Grace', 'Hopper', '2018-01-02', 'Felix Michel');

-- works like a charm

/*********************************************************************************
 Question 20
 
List all the constraints (as described in #11 above) for your new_students 
and programmes tables (and these ONLY). 
 
**********************************************************************************/


SELECT * 
FROM information_schema.TABLE_CONSTRAINTS tc 
WHERE TABLE_NAME = 'NEW_STUDENTS';


/*********************************************************************************
 Question 21
 
 Clean up your schema by dropping both the NEW_STUDENTS and PROGRAMMES tables. 
 
**********************************************************************************/

DROP TABLE NEW_STUDENTS;
DROP TABLE programmes;
