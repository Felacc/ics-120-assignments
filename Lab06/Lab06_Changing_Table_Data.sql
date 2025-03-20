/*********************************************************************************

Assignment - Lab 6 - Changing Table Data

 **********************************************************************************/
/*********************************************************************************
Question 1
Startup a transaction. 
 **********************************************************************************/
SET
    autocommit = OFF;

START TRANSACTION;

SAVEPOINT SP1;

/*********************************************************************************
Question 2
Add the following data to the customers table (be sure the dates are entered as 
dates and in the same format as shown, e.g.. as December 9, 1906, not as "9-DEC-06"
- STR_TO_DATE is helpful here). 

customer_id   first_name   last_name   dob                phone
-----------   ----------   ---------   -----------------  --------------
50            Grace        Hopper      December 9, 1906   800-555-1250
51            Steve        Jobs        February 24, 1955  800-555-1251
52            Larry        Ellison     August 17, 1944    800-555-1252
53            Tom          Thomson     August 4, 1877     NULL

 **********************************************************************************/
SELECT
    *
FROM
    customers;

INSERT INTO
    customers (customer_id, first_name, last_name, dob, phone)
VALUES
    (
        50,
        'Grace',
        'Hopper',
        STR_TO_DATE ('December 9, 1906', '%M %d, %Y'),
        '800-555-1250'
    ),
    (
        51,
        'Steve',
        'Jobs',
        STR_TO_DATE ('February 24, 1955', '%M %d, %Y'),
        '800-555-1251'
    ),
    (
        52,
        'Larry',
        'Ellison',
        STR_TO_DATE ('August 17, 1944', '%M %d, %Y'),
        '800-555-1252'
    ),
    (
        53,
        'Tom',
        'Thomson',
        STR_TO_DATE ('August 4, 1877', '%M %d, %Y'),
        NULL
    );

/*********************************************************************************
Question 3
Confirm your addition to the table. Order by customer_id.
(Hint: Use a SELECT statement.) */
/**********************************************************************************/
SELECT
    *
FROM
    customers
ORDER BY
    customer_id;

/*********************************************************************************
Question 4 
The last_name for customer_id 53 is "Thomson" but should be "Thomas". Correct it. 
Then select that customer to confirm it has been changed.
 **********************************************************************************/
UPDATE customers
SET
    last_name = 'Thomas'
WHERE
    customer_id = 53;

/*********************************************************************************
Question 5 
Steve Jobs has closed his account. Remove his record from the table. 
Remove him by name NOT by id number.
Confirm he is no longer in the table.
 **********************************************************************************/
DELETE FROM customers
WHERE
    last_name = 'Jobs'
    AND first_name = 'Steve';

SELECT
    *
FROM
    customers;

/*********************************************************************************
Question 6  
There is a legacy data problem. You need to change all the customer_id values. 
Update the customer_id values by adding 100 to all the customer_id values in the table.
The update should apply to ALL records not just the ones you entered.
 **********************************************************************************/
UPDATE customers
SET
    customer_id = customer_id + 100;

/*********************************************************************************
Question 7
Confirm your changes to the table. Order by customer_id.
 **********************************************************************************/
SELECT
    *
FROM
    customers
ORDER BY
    customer_id;

/*********************************************************************************
Question 8
Create a SAVEPOINT named CUST_SAVEP. 
 **********************************************************************************/
SAVEPOINT CUST_SAVEP;

/*********************************************************************************
Question 9
Add yourself to the customers table. 
Feel free to make up your customer_id, birth date and phone number. 
 **********************************************************************************/
INSERT INTO
    customers
VALUES
    (
        333,
        'Felix',
        'Michel',
        '2003-03-03',
        '778-676-9629'
    );

/*********************************************************************************
Question 10
Confirm your changes to the table. Order by customer_id. 
 **********************************************************************************/
SELECT
    *
FROM
    customers
ORDER BY
    customer_id;

/*********************************************************************************
Question 11
ROLLBACK To the CUST_SAVEP SAVEPOINT. 
 **********************************************************************************/
ROLLBACK TO SAVEPOINT CUST_SAVEP;

/*********************************************************************************
Question 12
Confirm you have been removed by listing the table contents. Order by customer_id.
 **********************************************************************************/
SELECT
    *
FROM
    customers
ORDER BY
    customer_id;

/*********************************************************************************
Question 13
Now issue a general ROLLBACK command. 
 **********************************************************************************/
ROLLBACK;

/*********************************************************************************
Question 14
List the table contents. Order by customer_id. What is the table now back to?
 **********************************************************************************/
SELECT
    *
FROM
    customers
ORDER BY
    customer_id;

-- Goes back to the start of the transaction
/*********************************************************************************
Question 15
Now insert yourself again. 
 **********************************************************************************/
INSERT INTO
    customers
VALUES
    (
        333,
        'Felix',
        'Michel',
        '2003-03-03',
        '778-676-9629'
    );

/*********************************************************************************
Question 16
Now issue the COMMIT command.
 **********************************************************************************/


COMMIT;


/*********************************************************************************
Question 17
List the table contents. Order by customer_id 
 **********************************************************************************/


SELECT
    *
FROM
    customers
ORDER BY
    customer_id;

/*********************************************************************************
Question 18
ROLLBACK to the CUST_SAVEP SAVEPOINT. Did anything happen?
Enter a at least one statement (in the comment below) if not both, saying why
you got the result you did from the "ROLLBACK to CUST_SAVEP" command. 
 **********************************************************************************/


 ROLLBACK TO SAVEPOINT CUST_SAVEP;

 -- The savepoint CUST_SAVEP was lost when the COMMIT command was issued.
 -- Transactions end after the COMMIT command is given. When a transaction ends all savepoints are lost and you can no longer rollback;