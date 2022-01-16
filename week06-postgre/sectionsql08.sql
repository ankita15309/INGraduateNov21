SECTION 8:

--need A report that give custname orderdate and shipcountry 

SELECT companyname,orderdate,shipcountry
FROM orders
JOIN customers
ON customers.customerid=orders.customerid;

--connect empolyees to orders and pull back first name and last name and order date for all orders 
SELECT firstname,lastname ,orderdate
FROM employees
JOIN orders
on employees.employeeid=orders.employeeid;

--connect product to suppliers pull back compony name ,unit cost and unit in stocks

SELECT companyname,unitprice , unitsinstock
FROM suppliers
JOIN products
ON suppliers.supplierid=products.supplierid;

--company name order date productid,unit price and quantity

SELECT companyname,orderdate,productid,unitprice,quantity
FROM orders
JOIN order_details on orders.orderid=order_details.orderid
JOIN customers ON customers.customerid=orders.customerid;

--connect product to previous query and ass product name 
--company name order date productid,unit price and quantity
--bring back category name 
--connect product to previous query and ass product name 
--company name order date productid,unit price and quantity
--bring back category name 

SELECT companyname,orderdate,order_details.unitprice,quantity,productname,categoryname 
FROM orders
JOIN order_details on orders.orderid=order_details.orderid
JOIN customers ON customers.customerid=orders.customerid
JOIN products ON products.productid=order_details.productid
JOIN categories ON categories.categoryid=products.categoryid
WHERE categoryname='Seafood' AND order_details.unitprice*quantity >=500;

--left join

--bring back 	company name and orderid

SELECT companyname , orderid
FROM customers
LEFT JOIN orders
ON orders.customerid=customers.customerid
WHERE orderid IS NULL;

--do a left join products and order details

SELECT productname ,orderid
FROM products 
LEFT JOIN order_details
ON products.productid=order_details.productid
WHERE orderid IS NULL;

--RIGHT JOIN

--company name orderid using reverse table order from last lesson

SELECT companyname,orderid
FROM orders
RIGHT JOIN customers
ON customers.customerid=orders.customerid;

--do a right join to customer demo and customers

SELECT companyname ,customercustomerdemo.customerid
FROM customercustomerdemo
RIGHT JOIN customers ON customers.customerid=customercustomerdemo.customerid;

--full join

--compony name and orderid

SELECT companyname ,orderid
FROM customers
FULL JOIN orders ON customers.customerid=orders.customerid;

--do full join between product and categories

SELECT productid ,categoryname
FROM products
FULL JOIN categories
ON products.categoryid=categories.categoryid;

--self join

--who are in same city order by city

SELECT c1.companyname AS CustomerName1 ,c2.companyname AS CustomerName2 ,c1.city 
FROM customers AS c1
JOIN customers AS c2 ON c1.city=c2.city
ORDER BY city;

--to using
SELECT * 
FROM orders
JOIN order_details USING (orderid);
--add products


SELECT *
FROM orders
JOIN order_details USING (orderid)
JOIN products USING (productid);

--typing with natural

---join order and order details using naturals
SELECT *
FROM orders 
NATURAL JOIN order_details;

--add customers

--typing with natural

---join order and order details using naturals
SELECT *
FROM customers 
NATURAL JOIN orders
NATURAL JOIN order_details;

SELECT COUNT(*)
FROM products 
JOIN order_details USING (productid);


	QURIES ON ADVENTURE

--01

-- this is spelling out the ON
SELECT firstname,middlename,lastname,phonenumber,name
FROM person.personphone AS ph
JOIN person.businessentity AS be ON be.businessentityid=ph.businessentityid
JOIN person.person AS pe ON pe.businessentityid=be.businessentityid
JOIN person.phonenumbertype AS pnt ON pnt.phonenumbertypeid=ph.phonenumbertypeid
ORDER BY ph.businessentityid DESC;

--this is with USING
SELECT firstname,middlename,lastname,phonenumber,name
FROM person.personphone AS ph
JOIN person.businessentity USING (businessentityid)
JOIN person.person USING (businessentityid)
JOIN person.phonenumbertype USING (phonenumbertypeid)
ORDER BY ph.businessentityid DESC;


--02
SELECT pm.name,c.name,description
FROM production.productdescription
JOIN production.productmodelproductdescriptionculture USING (productdescriptionid)
JOIN production.culture AS c USING (cultureid)
JOIN production.productmodel AS pm USING (productmodelid)
ORDER BY pm.name ASC;

--03
SELECT p.name,pm.name,c.name,description
FROM production.productdescription
JOIN production.productmodelproductdescriptionculture USING (productdescriptionid)
JOIN production.culture AS c USING (cultureid)
JOIN production.productmodel AS pm USING (productmodelid)
JOIN production.product AS p USING (productmodelid)
ORDER BY pm.name ASC;

--04
SELECT name, rating, comments
FROM production.product
LEFT JOIN production.productreview USING (productid)
ORDER BY rating ASC;

--05
SELECT p.name,orderqty,scrappedqty
FROM production.workorder
RIGHT JOIN production.product AS p USING (productid)
ORDER BY p.productid ASC;
