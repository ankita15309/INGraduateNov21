--SECTION 25

--transaction and concurrency control

--ACID TRANSACTION
a atomicity all operation work or none of them work
c consistency all the transaction change the database properly
i isolation transaction wontt interface each other  
d durabilitythe chages or result wont be losy if system failure


--simple transaction control
--update thr reorder level 	and find the count of item that need reordering in one transaction

BEGIN TRANSACTION;
	UPDATE products
	SET reorderlevel = reorderlevel - 5;

	SELECT COUNT(*)
	FROM products
	WHERE unitsinstock + unitsonorder < reorderlevel;


END TRANSACTION;

--CREATE SINGLE TRANSACTION TO INCRESE THE REQUIREDATE IN ORDERS BY ONE DAY FOR DECEMBER 
--2017 AND DECRESE IT BY ONE DAY FOR NOVEMBER 2017

BEGIN TRANSACTION;
	UPDATE orders
	SET requireddate = requireddate + INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-12-01' AND '1997-12-31';

	UPDATE orders
	SET requireddate = requireddate - INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-11-01' AND '1997-11-30';

END TRANSACTION;


--ROLLBACK AND SAVEPOINTS

--START TO UPDATE ORDERS AND ROILLBACK

START TRANSACTION;

UPDATE orders
SET orderdate = orderdate + INTERVAL '1 YEAR';

ROLLBACK;

--INSERT A NEW EMPLOYEE CREATE SAVEPOINT UPDATE HIREDATE AND ROLL BACK TO SAVEPOINT

START TRANSACTION;

INSERT INTO employees (employeeid,lastname,firstname,title,birthdate,hiredate)
VALUES (502,'Sue','Jones','Operations Assistant','1999-05-23','2017-06-13');

SAVEPOINT inserted_employee;


UPDATE employees
SET birthdate='2025-07-11';

ROLLBACK TO inserted_employee;

UPDATE employees
SET birthdate='1998-05-23'
WHERE employeeid=501;

COMMIT;

SELECT *
FROM employees
WHERE employeeid=501;



--SQL TRASACTION ISOLATION 

THREE PHENOMENA WHICH ARE PROHIBITED AT DIFFERENT ISOLATION LEVEL

DIRTY READS
NONREPEATABLE READS
PHANTONS READS

SQL ISOLATION LEVEL
READ UNCOMMITED
READ COMMITED 
REPEATABLE READS
SERIALIZATION


