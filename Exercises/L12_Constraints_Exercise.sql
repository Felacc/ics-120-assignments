/************************************************************************ 
Lecture 12 Exercise
Constraints


************************************************************************/

USE ICS120X01_W24_DB;

/************************************************************************ 
  1. Add a primary key on the student_id column called students_pk
     to the students tables.
************************************************************************/

ALTER TABLE students
	ADD CONSTRAINT students_students_id_pk
	PRIMARY KEY (student_id);

/************************************************************************ 
2. ADD a NOT NULL CONSTRAINT TO the first_name
AND last_name columns
     OF the students tables. Verify
************************************************************************/

ALTER TABLE students
	MODIFY first_name varchar(25) NOT NULL
	MODIFY last_name varchar(25) NOT NULL;

DESC students;

/************************************************************************   
  3.  Add a primary key on the course_id column to the courses table.
      Verify.
************************************************************************/

ALTER TABLE courses
	ADD CONSTRAINT courses_course_id_pk
	PRIMARY ket (course_id);

DESC courses;

/************************************************************************ 
  4. Add a NOT NULL constraint to course_name in the courses table.
     Verify.
************************************************************************/

ALTER TABLE courses
	MODIFY course_name varchar(25) NOT NULL;

DESC courses;

/************************************************************************ 
  5.  Change the classes table to add a primary key called classes_id_pk 
       on student_id and course_id. Verify
************************************************************************/
ALTER TABLE classes
	ADD CONSTRAINT classes_id_pk
	PRIMARY KEY (student_id,
	course_id);

DESC classes;

/************************************************************************ 
  6. Alter the classes table to add a foreign key called classes_student_id_fk 
      on student_id which references the student_id in the students table.
************************************************************************/

ALTER TABLE classes
	ADD CONSTRAINT classes_student_id_fk
	FOREIGN KEY (student_id) REFERENCES students(student_id);

/************************************************************************ 
  7.  Alter the classes table to add a foreign key called classes_course_id_fk 
       on course_id which references the course_id in the courses table.
************************************************************************/

ALTER TABLE classes
	ADD CONSTRAINT classes_course_id_fk
	FOREIGN KEY (course_id) REFERENCES courses(course_id);

/************************************************************************ 
  8.  Alter the classe table so that the grades columns can only contain
      A,B,C,D,E and F
************************************************************************/
ALTER TABLE classes
	ADD CONSTRAINT classes_grades_ck
	CHECK (grades IN ("A", "B", "C", "E", "F");



/************************************************************************ 
  9.  Try and insert into the classes table a row with sudent_id = 1, coourse_id = 1
      and a grade of 'X'.  What happenes?  Fix that with a grade of A.
      Then what happens?  Fix that with course_id = 1, course_name = ICS120 Database and
      short_name = C120.  Then try the insert again.
************************************************************************/


INSERT INTO classes VALUES (1,1,'X');

-- will fail because of grades check constraint

INSERT INTO classes VALUES (1,1,'A');

-- will fail vecause the foreign key course_name must be a string

INSERT INTO classes VALUES (1,1,'A');

-- works

