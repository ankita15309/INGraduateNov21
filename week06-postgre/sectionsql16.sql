--null constraints

CREATE TABLE IF NOT EXISTS practices (
	practiceid integer NOT NULL
);


INSERT INTO practices (practiceid)
VALUES (null);

DROP TABLE IF EXISTS practices;

CREATE TABLE IF NOT EXISTS practices (
practiceid integer NOT NULL,
practice_field varchar(50) NOT NULL
);

ALTER TABLE products
ALTER COLUMN unitprice SET NOT NULL;

ALTER TABLE employees
ALTER COLUMN lastname SET NOT NULL;




--UNIQUE

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer UNIQUE,
  fieldname varchar(50) NOT NULL
);

INSERT INTO practices (practiceid,fieldname)
VALUES (1, 'field1');
INSERT INTO practices (practiceid,fieldname)
VALUES (1, 'field2');


DROP TABLE IF EXISTS pets;

create TABLE pets (
	petid integer UNIQUE,
    name varchar(25) NOT NULL
)

ALTER TABLE region
ADD CONSTRAINT region_description UNIQUE(regiondescription);

ALTER TABLE shippers
ADD CONSTRAINT shippers_companyname UNIQUE(companyname);


--PRIMARY KEY

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
fieldname varchar(50) NOT NULL
);

INSERT INTO practices (practiceid,fieldname)
VALUES (1, null);
INSERT INTO practices (practiceid,fieldname)
VALUES (1, 'field1');
INSERT INTO practices (practiceid,fieldname)
VALUES (1, 'field2');

DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
	petid integer PRIMARY KEY,
name varchar(25) NOT NULL
);

ALTER TABLE practices
DROP CONSTRAINT practices_pkey;

ALTER TABLE practices
ADD PRIMARY KEY (practiceid);

ALTER TABLE pets
DROP CONSTRAINT pets_pkey;

ALTER TABLE pets
ADD PRIMARY KEY (petid);


--foreign key

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	practicefield varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
)


DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
)

ALTER TABLE practices
DROP CONSTRAINT practices_employeeid_fkey;

ALTER TABLE practices
ADD CONSTRAINT practices_employee_fkey
FOREIGN KEY (employeeid) REFERENCES employees(employeeid);

ALTER TABLE pets
DROP CONSTRAINT pets_customerid_fkey;

ALTER TABLE pets
ADD CONSTRAINT pets_customerid_fkey
FOREIGN KEY (customerid) REFERENCES customers(customerid);


--chech constraint

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	practicefield varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	cost integer CONSTRAINT practices_cost CHECK (cost >= 0 AND cost <= 1000),
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
);

DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	weight integer CONSTRAINT pets_weight CHECK (weight > 0 AND weight < 200),
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

ALTER TABLE orders
ADD CONSTRAINT orders_freight CHECK (freight > 0);

ALTER TABLE products
ADD CONSTRAINT products_unitprice CHECK (unitprice > 0);

--default values

DROP TABLE IF EXISTS practices;

CREATE TABLE practices (
	practiceid integer PRIMARY KEY,
	practicefield varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	cost integer DEFAULT 50 CONSTRAINT practices_cost CHECK (cost >= 0 AND cost <= 1000),
	FOREIGN KEY (employeeid) REFERENCES employees(employeeid)
);

DROP TABLE IF EXISTS pets;

CREATE TABLE pets (
	petid integer PRIMARY KEY,
	name varchar(25) NOT NULL,
	customerid char(5) NOT NULL,
	weight integer DEFAULT 5 CONSTRAINT pets_weight CHECK (weight > 0 AND weight < 200),
	FOREIGN KEY (customerid) REFERENCES customers(customerid)
);

ALTER TABLE orders
ALTER COLUMN shipvia SET DEFAULT 1;
SELECT * FROM orders;
ALTER TABLE products
ALTER COLUMN reorderlevel SET DEFAULT 5;


--changing columans default value

ALTER TABLE products
ALTER COLUMN reorderlevel SET DEFAULT 5

SELECT * FROM products

ALTER TABLE products
ALTER COLUMN reorderlevel DROP DEFAULT

SELECT * FROM products

ALTER TABLE suppliers
ALTER COLUMN homepage SET DEFAULT 'N/A'

SELECT * FROM suppliers

ALTER TABLE suppliers
ALTER COLUMN homepage DROP DEFAULT


SELECT * FROM suppliers


ALTER TABLE products
ADD CHECK ( reorderlevel > 0);

-- All rows must meet the condition
UPDATE products
SET reorderlevel = 0
WHERE reorderlevel is null or reorderlevel < 0;

ALTER TABLE products
ALTER COLUMN discontinued SET NOT NULL;

SELECT * FROM products

ALTER TABLE products
DROP CONSTRAINT products_reorderlevel_check;

ALTER TABLE products
ALTER COLUMN discontinued DROP NOT NULL;

SELECT * FROM products

ALTER TABLE order_details
ADD CHECK (unitprice > 0);

SELECT * FROM order_details

ALTER TABLE order_details
ALTER COLUMN discount SET NOT NULL;


SELECT * FROM order_details

ALTER TABLE order_details
DROP CONSTRAINT order_details_unitprice_check;


SELECT * FROM order_details

ALTER TABLE order_details
ALTER COLUMN discount DROP NOT NULL;


SELECT * FROM order_details

