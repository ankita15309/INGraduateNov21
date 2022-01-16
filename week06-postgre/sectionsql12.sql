SECTION 12

INSERT INTO orders
(orderid,customerid,employeeid,orderdate,requireddate,
shipvia,freight,shipname,shipaddress,shipcity,shippostalcode,shipcountry)
VALUES(11078,'VINET',4,	'2017-09-03','2017-03-03',3,42.5,'vins et alcools Chevalier','59 rue de l''Abbaye','Remis','51100','France');


----insert an order details for order we just created make it quantity of 20 of queso cabrales 
--with the price of $14

SELECT *
FROM PRODUCTS
WHERE productname='Queso Cabrales'
productid=11;

INSERT INTO order_details
(orderid, productid, unitprice,quantity,discount)
VALUES (11078,11,14,20,0);


--update

UPDATE orders
SET requireddate='2017-09-20',freight=50
WHERE orderid=11078;


UPDATE order_details
SET quantity=40,discount=.05
WHERE orderid=11078 AND productid=11;

--delete


UPDATE order_details
SET quantity=40,discount=.05
WHERE orderid=11078 AND productid=11;

DELETE FROM orders
WHERE orderid=11078;


--select into

SELECT *
INTO suppliers_northamerica
FROM suppliers
WHERE country in ('USA','Canada');



SELECT *
INTO orders_1997
FROM orders
WHERE orderdate BETWEEN '1997-01-01' AND '1997-12-31';


--select inser
INSERT INTO suppliers_northamerica
SELECT *
FROM suppliers
WHERE country IN ('Brazil','Argentina')



INSERT INTO orders_1997
SELECT * FROM orders
WHERE orderdate BETWEEN '1996-12-01' AND '1996-12-31'

INSERT INTO employees
(firstname,lastname,address,city,country,postalcode,homephone,title,employeeid,reportsto)
VALUES
('Bob','Smith','463-4613 Ipsum Street','New Orleans','USA','73-638','741-0423','Chief Strategy',50,NULL)
RETURNING employeeid;


INSERT INTO orders (customerid,employeeid,requireddate,shippeddate,orderid)
VALUES ('VINET',5,'1996-08-01','1996-08-10',500) RETURNING orderid;


UPDATE products
SET unitprice = unitprice * 1.2
WHERE productid=1
RETURNING productid,unitprice AS new_price;


UPDATE order_details
SET quantity = quantity * 2
WHERE orderid=10248 AND productid=11
RETURNING quantity AS new_quantity;


DELETE FROM employees
WHERE employeeid=50
RETURNING *;


DELETE FROM orders
WHERE orderid=500
RETURNING *;
