/*********************************************************************************tetx

 Assignment - Lab 9 - Sequences, Views and Indexes

 **********************************************************************************/

USE MichelF_W25_DB;
 
/*********************************************************************************
 Question 1
 Create a new table called mytextbook in your schema. The attributes of the table are:
 
     text_id	      integer(5)
     text_name	      varchar(25)
     text_author      varchar(50)
     text_publisher   varchar(25)
 
Set the text_id to be the primary key and have it auto incremented. 
**********************************************************************************/

CREATE TABLE mytextbook (
	text_id integer(5) AUTO_INCREMENT,
	text_name varchar(25),
	text_author varchar(50),
	text_publisher varchar(25),
	PRIMARY KEY (text_id)
);

DESC mytextbook;


/*********************************************************************************
 Question 2
 Add the following data values to your mytextbook table using the insert statement: 
 
 	text_name = All computers	
	text_author = Know It All	
	text_publisher = Self	
	
	
 	text_name = No homework!	
	text_author = Tired Student	
	text_publisher = Publish	
**********************************************************************************/

INSERT INTO mytextbook 
	(text_name, text_author, text_publisher)
VALUES 
	("All computers", "Know it all", "Self"),
	("No homework", "Tired Student", "Publish");

SELECT * FROM mytextbook;


/*********************************************************************************
 Question 3

 What are the text_ids that were created  
**********************************************************************************/

-- 1 and 2 (auto increment starts at 1)

/*********************************************************************************
 Question 4
 
 Add the following data values to your mytextbook table using the insert statement: 
 
        text_id = 100
 	text_name = All games	
	text_author = Know Nothing	
	text_publisher = Self	
	
	
 	text_name = Lots of homework!	
	text_author = Tired Student	
	text_publisher = Publish	
	
**********************************************************************************/

INSERT INTO mytextbook 
	(text_id, text_name, text_author, text_publisher)
VALUES 
	(100, "All games", "Know Nothing", "Self");

INSERT INTO mytextbook 
	(text_name, text_author, text_publisher)
VALUES
	("Lots of homework", "Tired Student", "Publish");

SELECT * FROM mytextbook;
/*********************************************************************************
 Question 5

What is the text_ids for the Lots of homework book and why
 
**********************************************************************************/

-- 100 and 101 (when you forcefully set the text_id, auto increment starts incrementing from the highest value id you set)


/*********************************************************************************
 Question 6
 
  Create a unique index called textname_idx on the text_name. 
 
 **********************************************************************************/

CREATE UNIQUE INDEX textname_idx on mytextbook(text_name);



/*********************************************************************************
 Question 7
 
 Trying add the following data values to your mytextbook table using the insert statement: 
 
        
 	text_name = Lots of homework!	
	text_author = Another Tired Student	
	text_publisher = Self Publish	
	
 Why did it fail?
**********************************************************************************/


INSERT INTO mytextbook
	(text_name, text_author, text_publisher)
VALUES
	("Lots of homework", "Another Tired Student", "Self Publish");

-- duplicate entry on text_name; fails because of unique index txtname_idx

/*********************************************************************************
 Question 8
 
 Show the indexes for the mytextbook table. 
 
**********************************************************************************/


SHOW INDEX FROM mytextbook;

/*********************************************************************************
 Question 9
 
 Drop the textname_idx and confirm it is gone. 
 
**********************************************************************************/


DROP INDEX textname_idx ON mytextbook;


/*********************************************************************************
 Question 10
 
 Trying doing the insert from question 7 again and confirm there are now 2 books with
 the same title.
 
**********************************************************************************/

INSERT INTO mytextbook
	(text_name, text_author, text_publisher)
VALUES
	("Lots of homework", "Another Tired Student", "Self Publish");

SELECT *
FROM mytextbook
WHERE text_name IN (
	SELECT text_name
	FROM mytextbook
	GROUP BY text_name
	HAVING COUNT(*) > 1
);


/*********************************************************************************
 Question 11
 
 Using your employee and department tables, create a view called emp_dep_vw
 that shows each employee's id, first name, last name, department id and department name.
 
**********************************************************************************/


CREATE VIEW emp_dep_vw
	AS SELECT e.employee_id, e.first_name, e.last_name, d.department_id, d.department_name
	FROM employees e, departments d
	WHERE e.department_id = d.department_id;

DESC emp_dep_vw;
SELECT * FROM emp_dep_vw;


/*********************************************************************************
 Question 12
 
 Using your emp_dep_vw view, create a emp_dep_vw_100 that only has employees in
 department 100. Select from your view.
 
**********************************************************************************/

CREATE VIEW emp_dep_vw_100
	AS SELECT *
	FROM emp_dep_vw
	WHERE department_id = 100;

DESC emp_dep_vw_100;
SELECT * FROM emp_dep_vw_100;



/*********************************************************************************
 Question 13
 
Drop the emp_dep_vw. 

**********************************************************************************/

DROP VIEW emp_dep_vw;

/*********************************************************************************
 Question 14
 
Try selecting from the emp_dep_vw_100.  What happens and why?  

**********************************************************************************/

SELECT * FROM emp_dep_vw_100;

-- since views get their values by referencing other tables/views and we have deleted the view that holds the values it references...
-- we can no longer select values from emp_dep_vw_100 

/*********************************************************************************
 Question 15
 
List the name of your views using the information_schema.views table.

**********************************************************************************/

SELECT TABLE_NAME FROM information_schema.VIEWS;


/*********************************************************************************
 Question 16
 
Create a view on your employees table for employees that work in department 90
called emp_dep_vw_90, Only include there employee id, last name and department id 
in the view.
**********************************************************************************/

CREATE VIEW emp_dep_vw_90
	AS SELECT employee_id, first_name, last_name, department_id	
	FROM employees
	WHERE department_id = 90;

SELECT * FROM emp_dep_vw_90;


/*********************************************************************************
 Question 17
 
Using your view, move King to department 10. Confirm he is no longer in the view.
**********************************************************************************/

UPDATE emp_dep_vw_90
SET department_id = 10
WHERE last_name = "King";

SELECT * FROM emp_dep_vw_90;


/*********************************************************************************
 Question 18
 
Replace the emp_dep_vw_90 view so that people can't be moved out of it, but we could
still update other information in the view.
**********************************************************************************/

CREATE OR REPLACE VIEW emp_dep_vw_90
	AS SELECT employee_id, first_name, last_name, department_id
	FROM employees
	WHERE department_id = 90
	WITH CHECK OPTION;

SELECT * FROM emp_dep_vw_90;


/*********************************************************************************
 Question 19
 
Using your view, try and move Kochhar to department 10. Why does it fail.
**********************************************************************************/

UPDATE emp_dep_vw_90
SET department_id = 10
WHERE last_name = "Kochhar";

-- doesn't pass the enforced where clause set in the view with check option

/*********************************************************************************
 Question 20
 
Using your view, change Kochhar name tp Smith. Confirm your change.
**********************************************************************************/

UPDATE emp_dep_vw_90
SET last_name = "Smith"
WHERE last_name = "Kochhar";

SELECT * FROM emp_dep_vw_90;

DROP TABLE mytextbook;
