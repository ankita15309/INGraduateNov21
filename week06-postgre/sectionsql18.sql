--how to create view

CREATE VIEW customer_order_details AS

SELECT companyname, Orders.customerid, employeeid, orderdate, requireddate, shippeddate
Shipvia, freight, shipname, shipaddress, shipcity, shipregion, shippostalcode, shipcountry,
order_details.*
FROM customers
JOIN orders on customers.customerid=orders.customerid
JOIN order_details on order_details.orderid=orders.orderid;

SELECT *
FROM customer_order_details
WHERE customerid='TOMSP';

--create a view called supplier_ordder_detAIL THA T WILL SHIW all orders and order_details

CREATE VIEW supplier_order_details AS
SELECT companyname, suppliers.supplierid, Products.productid, productname,
Order_details.unitprice, quantity, discount, orders.*
FROM suppliers
JOIN products ON suppliers.supplierid=products.supplierid
JOIN order_details ON order_details.productid=products.productid
JOIN orders ON order_details.orderid=orders.orderid;
--select all the order details for supplierid=5
SELECT *  FROM supplier_order_details WHERE supplierid=5;

--how yo modify view

CREATE OR REPLACE VIEW customer_order_details AS
SELECT companyname, Orders.customerid,employeeid,requireddate,shippeddate,
Shipvia,freight,shipname,shipcity,shipregion,shippostalcode,shipcountry,
order_details.*,contactname
FROM customers
JOIN orders on customers.customerid=orders.customerid
JOIN order_details on order_details.orderid=orders.orderid;


ALTER VIEW customer_order_details RENAME TO customer_order_detailed;


CREATE OR REPLACE VIEW supplier_order_details AS
SELECT companyname,suppliers.supplierid,
Products.productid,productname,
Order_details.unitprice,quantity,discount,
orders.*,phone
FROM suppliers
JOIN products ON suppliers.supplierid=products.supplierid
JOIN order_details ON order_details.productid=products.productid
JOIN orders ON order_details.orderid=orders.orderid;


ALTER VIEW customer_order_details RENAME TO customer_order_detailed;



ALTER VIEW supplier_order_details RENAME TO supplier_orders;

--creating updatable view


CREATE VIEW north_america_customers AS
SELECT *
FROM customers
WHERE country in ('USA','Canada','Mexico');

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','USA','555-555-5555',null);


UPDATE north_america_customers SET fax='555-333-4141' WHERE customerid='CFDCM';

SELECT * FROM north_america_customers


DELETE FROM north_america_customers WHERE customerid='CFDCM';

--create updatble view of all products that are in dairy products ,meat/poulty	,and sea food
--categories (category of 4,6 and 8) call in protein products 

CREATE VIEW proteins_products AS
SELECT * FROM products
WHERE categoryid in (4,6,8);


INSERT INTO proteins_products
(productid,productname,supplierid,categoryid,discontinued)
VALUES (78,'Kobe Beef',12,8,0);


UPDATE proteins_products SET unitprice=55 WHERE productid=78;

SELECT * FROM proteins_products


DELETE FROM protein_products WHERE productid=78;


SELECT * FROM proteins_products

--with check option

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','Germany','555-555-5555',null);



SELECT FROM north_america_customers
WHERE customerid=’CFDCM’;

CREATE OR REPLACE VIEW north_america_customers  AS
SELECT *
FROM customers
WHERE country in ('USA','Canada','Mexico')
WITH LOCAL CHECK OPTION;

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES ('CFDCM','Catfish Dot Com','Will Bunker','President','Old Country Road','Lake Village','AR','71653','Germany','555-555-5555',null);
--modify protein_products to prevent bad data from being created 
CREATE OR REPLACE VIEW proteins_products AS
SELECT * FROM products
WHERE categoryid in (4,6,8)
WITH LOCAL CHECK OPTION;

INSERT INTO proteins_products
(productid,productname,supplierid,categoryid,discontinued)
VALUES (78,'Tasty Tea',12,1,0);

--deleting views

DROP VIEW IF EXISTS customer_order_detailed;


DROP VIEW IF EXISTS supplier_orders;






