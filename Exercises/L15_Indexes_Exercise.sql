/************************************************************************ 
Lecture 15  Indexes  Exercise



************************************************************************/


--
-- Setup
--

USE ICS120X01_W24_DB;

   


/************************************************************************ 
  1. Create a composite index called  students on last_name and first_name
      for the students table.

      Why can the index have the same name as the table?
************************************************************************/




/************************************************************************  
  2. What are the indexes on the students table.

     How many indexes are there on the table?

     Where did the other index come from?
************************************************************************/




/************************************************************************  
  3. Create an index called courses_idx01 on course_name, make it unique
************************************************************************/




/************************************************************************  
  4. Drop the courses_idx from question 3.
************************************************************************/




/************************************************************************  
  5. Create a FULLTEXT index on the body column for the books table called 
     books_idx
************************************************************************/



/************************************************************************  
  6. Create a non-unique index on the first 5 columns of the body column for
     the books table called books_idx02.     
************************************************************************/


  

/************************************************************************  
  7. Display the information on the indexes for the books table.  Confiming
     that the books_idx02 is non-unique.  Is there a unique index?  
************************************************************************/



/************************************************************************  
  8. Looks for any books that have the word data in the body using the
     match/against key words.  
     How many books were there?
     Write the same query without using match/against keyword and instead
     use wildcards and like.
     How many books were there?  
     Is there a difference in the answer, if so why?
************************************************************************/
