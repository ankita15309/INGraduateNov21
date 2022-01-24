
--section 17
---sequence

--create sequqence test_sequence
CREATE SEQUENCE test_sequence;


SELECT nextval('test_sequence');

SELECT nextval('test_sequence');

SELECT nextval('test_sequence');
--to see the current value

SELECT currval('test_sequence');

--most recent next  value


SELECT lastval();

--set values


SELECT setval('test_sequence',14);
SELECT nextval('test_sequence');
SELECT nextval('test_sequence');


-- set value and next value will be what you set
SELECT setval('test_sequence',25,false);
SELECT nextval('test_sequence');

--spacing


CREATE SEQUENCE IF NOT EXISTS test_sequence2 INCREMENT 5;


SELECT nextval('test_sequence2');

--full control


CREATE SEQUENCE IF NOT EXISTS test_sequence_3
INCREMENT 50 
MINVALUE 350 
MAXVALUE 5000 
START WITH 550;

SELECT nextval('test_sequence_3');

CREATE SEQUENCE IF NOT EXISTS test_sequence_4 
INCREMENT 7 
START WITH 33;
SELECT nextval('test_sequence_4');


SELECT MAX(employeeid) FROM employees;


CREATE SEQUENCE IF NOT EXISTS employees_employeeid_seq
START WITH 10 OWNED BY employees.employeeid;


--This insert will fail
INSERT INTO employees
(lastname,firstname,title,reportsto)
VALUES ('Smith','Bob', 'Assistant', 2);


--must alter the default value
ALTER TABLE employees
ALTER COLUMN employeeid SET DEFAULT nextval('employees_employeeid_seq');

SELECT * FROM employees


--Now Insert will work
INSERT INTO employees
(lastname,firstname,title,reportsto)
VALUES ('Smith','Bob', 'Assistant', 2);


CREATE SEQUENCE IF NOT EXISTS orders_orderid_seq START WITH 11077;

ALTER TABLE orders
ALTER COLUMN orderid SET DEFAULT nextval('orders_orderid_seq');

SELECT * FROM orders;


INSERT INTO orders (customerid,employeeid,requireddate,shippeddate)
VALUES ('VINET',5,'1996-08-01','1996-08-10') RETURNING orderid;
--alter and delete sequence

--employees_employeeid start with 100

ALTER SEQUENCE employees_employeeid_seq RESTART WITH 1000


SELECT nextval('employees_employeeid_seq')


ALTER SEQUENCE orders_orderid_seq RESTART WITH 200000


SELECT nextval('orders_orderid_seq')


ALTER SEQUENCE test_sequence RENAME TO test_sequence_1


SELECT nextval('test_sequence_1')



ALTER SEQUENCE test_sequence_4  RENAME TO test_sequence_four


SELECT nextval('test_sequence_four')


DROP SEQUENCE test_sequence_1

DROP SEQUENCE test_sequence_four

--using serial datatype
DROP TABLE IF EXISTS exes;

CREATE TABLE exes (
exid SERIAL,
name varchar(255)
);


INSERT INTO exes (name) VALUES ('Carrie') RETURNING exid


DROP TABLE IF EXISTS pets;


CREATE TABLE pets (
petid SERIAL,
name varchar(255)
);

INSERT INTO pets (name) VALUES ('Fluffy') RETURNING petid;

