--section 24

--function
--section 24
--waf called fix_homepage that upate all suppliers with null home page feild to 'N/A'

CREATE  OR REPLACE FUNCTION fix_homepage() RETURNS void AS $$
	UPDATE suppliers
	SET homepage='N/A'
	WHERE homepage IS NULL;
$$ LANGUAGE SQL;


SELECT fix_homepage();

--create a function called set_employee_default_photo to update any missing photopath to a default .. and run


CREATE OR REPLACE FUNCTION set_employee_default_photo() RETURNS void AS $$
	UPDATE employees
	SET photopath='http://accweb/emmployees/default.bmp'
	WHERE photopath IS NULL;
$$ LANGUAGE SQL;


SELECT set_employee_default_photo();

--waf to return single value

--find max price of any product

CREATE OR REPLACE FUNCTION max_price() RETURNS real AS $$
	SELECT MAX(unitprice)
	FROM products;
$$ LANGUAGE SQL;

SELECT max_price();

--biggest_order that returns the largest order in term of total money spent

CREATE OR REPLACE FUNCTION biggest_order() RETURNS double precision AS $$
	SELECT MAX(amount)
	FROM
	(SELECT SUM(unitprice*quantity) as amount,orderid
	FROM order_details
	GROUP BY orderid) as totals;

$$ LANGUAGE SQL;

SELECT biggest_order();


--functions with parameter

---largest order amount given a specific customer

CREATE OR REPLACE FUNCTION customer_largest_order(cid bpchar) RETURNS double precision AS $$
	SELECT MAX(order_total) FROM
	(SELECT SUM(quantity*unitprice) as order_total,orderid
	FROM order_details
	NATURAL JOIN orders
	WHERE customerid=cid
	GROUP BY orderid) as order_total;
$$ LANGUAGE SQL;

SELECT customer_largest_order('ANAR');

--most orderd product of particular customer by numbers of itmes ordered 

CREATE OR REPLACE FUNCTION most_ordered_product(customerid bpchar) RETURNS varchar(40) AS $$
	SELECT productname
	FROM products
	WHERE productid IN
	(SELECT productid FROM
	(SELECT SUM(quantity) as total_ordered, productid
	FROM order_details
	NATURAL JOIN orders
	WHERE customerid= $1
	GROUP BY productid
	ORDER BY total_ordered DESC
	LIMIT 1) as ordered_products);
$$ LANGUAGE SQL;

SELECT most_ordered_product('CACTU');


--functions that have composite parameters

--function that takes a product and price increse percent and retunrs the new price

CREATE OR REPLACE FUNCTION new_price(products, increase_percent numeric)
RETURNS double precision AS $$
	SELECT $1.unitprice * increase_percent/100
$$ LANGUAGE SQL

SELECT productname,unitprice,new_price(products.*,110)
FROM products;


--create function full_name that takes employyes and return title ,fname and lname concated together 
CREATE OR REPLACE FUNCTION full_name(employees) RETURNS varchar(62) AS $$
	SELECT $1.title || ' ' || $1.firstname || ' ' || $1.lastname
$$ LANGUAGE SQL;

SELECT full_name(employees.*),city,country
FROM employees;


--function that returns a compositr

--return most recent hire

CREATE OR REPLACE FUNCTION newest_hire() RETURNS employees AS $$
	SELECT *
	FROM employees
	ORDER BY hiredate DESC
	LIMIT 1;
$$ LANGUAGE SQL;

SELECT newest_hire();

--to access individual feild

SELECT (newest_hire()).lastname;

SELECT (newest_hire()).firstname;

SELECT lastname(newest_hire());

SELECT hiredate(newest_hire());


--create a function called highest inventory that return the product row that has the most amount of money tied uo in inventory 

CREATE OR REPLACE FUNCTION highest_inventory() RETURNS products AS $$

	SELECT * FROM products
	ORDER BY (unitprice*unitsinstock) DESC
	LIMIT 1;

$$ LANGUAGE SQL;


SELECT (highest_inventory()).productname;

SELECT productname(highest_inventory());


--function with output parameter

--create function to add and multiply two numbers

CREATE OR REPLACE FUNCTION sum_n_product (x int, y int, OUT sum int, OUT product int) AS $$
	SELECT x + y, x * y
$$ LANGUAGE SQL;

SELECT sum_n_product(5, 20);
SELECT (sum_n_product(5, 20)).*;

--create a function that takes single number and returns the square and returnthe cube of the number using out 

CREATE OR REPLACE FUNCTION square_n_cube(IN x int, OUT square int, OUT cube int) AS $$
	SELECT x * x, x*x*x;
$$ LANGUAGE SQL;

SELECT (square_n_cube(55)).*;
SELECT square_n_cube(20);

--function with default values

--redo new_price with a default 5% price increse


CREATE OR REPLACE FUNCTION new_price(products, increase_percent numeric DEFAULT 105)
RETURNS double precision AS $$
	SELECT $1.unitprice * increase_percent/100
$$ LANGUAGE SQL;

SELECT productname,unitprice,new_price(products)
FROM products;


--redo square_n_cube create function that takes a single number and returns the square and cube
--of the number using out parameter .give default input 10

CREATE OR REPLACE FUNCTION square_n_cube(IN x int DEFAULT 10, OUT square int, OUT cube int) AS $$
	SELECT x * x, x*x*x;
$$ LANGUAGE SQL;

SELECT (square_n_cube()).*;

--usning function as table source

--select fname lname and hiredate from newest hire function

SELECT firstname,lastname,hiredate
FROM newest_hire();

--use highest inventory to pull back productname and supplier companyname 

SELECT productname,companyname
FROM highest_inventory() AS hi
JOIN suppliers ON hi.supplierid=suppliers.supplierid;


--function that return more than on row
--return all products that have total sales greater than some input values

CREATE OR REPLACE FUNCTION sold_more_than(total_sales real)
RETURNS SETOF products AS $$
 SELECT * FROM products
 WHERE productid IN (
	 SELECT productid FROM
 	 (SELECT SUM(quantity*unitprice),productid
	 FROM order_details
	 GROUP BY productid
	 HAVING SUM(quantity*unitprice) > total_sales) as qualified_products
 )
$$ LANGUAGE SQL;

SELECT productname, productid, supplierid
FROM sold_more_than(25000);

--create function next birthdate and return fname lname and next birthdate,hiredate

CREATE OR REPLACE FUNCTION next_birthday()
RETURNS TABLE (birthday date,firstname varchar(10),lastname varchar(20),hiredate date ) AS $$
SELECT(birthdate +  INTERVAL '1 YEAR' * (EXTRACT (YEAR FROM age (birthdate))+1))::date,
firstname,lastname,hiredate
FROM employees
$$LANGUAGE SQL

SELECT * FROM next_birthday()


--Create a function that returns ALL suppliers that have products that need to be ordered 
--use setof syntax
CREATE OR REPLACE FUNCTION suppliers_to_reorder_from()
RETURNS SETOF suppliers AS $$
  SELECT * FROM suppliers
  WHERE supplierid IN (
	 SELECT supplierid FROM products
	  WHERE unitsinstock + unitsonorder < reorderlevel
  )
$$ LANGUAGE SQL;

SELECT * FROM suppliers_to_reorder_from()


--create a function that returns excess inventory productid and productname from products 
--table based on an input parameter of percent of inventory threshold use return type syntax

CREATE OR REPLACE FUNCTION excess_inventory_level(percent numeric)
RETURNS TABLE (excess int ,productid smallint,productname varchar (40)) AS $$

SELECT CEIL ((unitsinstock + unitsonorder )-reorderlevel * percent /100) ::int,
productid,productname
FROM products 
WHERE  (unitsintock + unitsonorder )-(reorderlevel * percent /100) >0;

$$LANGUAGE SQL;

SELECT * from excess_level_inventory;


--procedure the function that dont returnd anything

--add two number

CREATE OR REPLACE PROCEDURE add_em(x int, y int) AS $$

	SELECT x + y

$$ LANGUAGE SQL;

CALL add_em(5,3);

--cretae a procedure that takes supplierid and amount and increse all the units price in products table that suppier

CREATE OR REPLACE PROCEDURE change_supplier_prices(supplierid smallint, amount real) AS $$

	UPDATE products
	SET unitprice = unitprice + amount
	WHERE supplierid = $1

$$ LANGUAGE sql;

CALL change_supplier_prices(20::smallint, 0.50);


	