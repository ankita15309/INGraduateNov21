SECTION 7

--ORDERBY

--select name in assending order
SELECT DISTINCT country
FROM suppliers
ORDER BY country ASC;
--select name in assending order
SELECT DISTINCT country,city
FROM suppliers
ORDER BY country ASC , city DESC;

--get a list of product names and unit price order by price highest to lowest and product name a to z (if they have same price)


SELECT  unitprice,productname
FROM products
ORDER BY unitprice DESC , productname ASC;

--min and max

--orders from italy

SELECT MIN(orderdate)
FROM orders
where shipcountry='Italy';

--when was last order shipped to canada

SELECT MAX(shippeddate)
FROM orders
where shipcountry='Canada';

--find the slowest order sent to france based on order date versus ship date 

SELECT MAX(shippeddate-orderdate)
FROM orders--what was avg number of styleese sout (product id=35) perorder

SELECT AVG(quantity)
FROM order_details
WHERE productid=35;
WHERE shipcountry='France';

--using avg and sum

--what was avg feigth of orders shipped to brazil

SELECT AVG(freight)
FROM orders
WHERE shipcountry='Brazil';

--how many individual items of tofu (product id=14 ) were orderd

SELECT SUM(quantity)
FROM order_details
WHERE productid=14;

--using like match

--have contct whose name starts with d

SELECT companyname,contactname
FROM customers
WHERE contactname LIKE 'D%';

--have 'or' the 2nd and 3 letter n the compony name 

SELECT companyname
FROM suppliers
WHERE companyname LIKE '-OR%';

--whih customer compony name ends with er

SELECT companyname,contactname
FROM customers
WHERE companyname LIKE '%er';

--renaming columns
--find total spent 

SELECT unitprice*quantity AS totalspent
FROM order_details;

--order the prev query by totalspent desc

SELECT unitprice*quantity as Totalspent
FROM order_details
ORDER BY Totalspent DESC;

--calculate inventory values of product (need unit price and unit stock feilds ) and return as totalinventory and order by this column desc


SELECT unitprice * unitsinstock as TotalInventory
FROM products
ORDER BY TotalInventory DESC
LIMIT 2;

--dont have region value

SELECT COUNT(*)
FROM customers
WHERE region IS NULL;

--how many supplies have regioin value

SELECT COUNT(*)
FROM suppliers
WHERE region IS NOT NULL;

--how many orders did not have a ship region 

SELECT COUNT(*)
FROM orders
WHERE shipregion IS NULL;

QURIES ON ADVENTURE 

--1
SELECT name,weight,productnumber
FROM production.product
ORDER BY weight ASC;

--2
SELECT *
FROM purchasing.productvendor
WHERE productid=407
ORDER BY averageleadtime ASC;

--3
SELECT *
FROM sales.salesorderdetail
WHERE productid=799
ORDER BY orderqty DESC;

--4
SELECT MAX(discountpct)
FROM sales.specialoffer;

--5
SELECT MIN(sickleavehours)
FROM humanresources.employee;

--6
SELECT MAX(rejectedqty)
FROM purchasing.purchaseorderdetail;

--7
SELECT AVG(rate)
FROM humanresources.employeepayhistory;

--8
SELECT AVG(standardcost)
FROM production.productcosthistory
WHERE productid=738;

--9
SELECT SUM(scrappedqty)
FROM production.workorder
WHERE productid = 529;

--10
SELECT name
FROM purchasing.vendor
WHERE name LIKE 'G%';

--11
SELECT name
FROM purchasing.vendor
WHERE name LIKE '%Bike%';

--12
SELECT firstname
FROM person.person
WHERE firstname LIKE '_t%';

--13
SELECT *
FROM person.emailaddress
LIMIT 20;

--14
SELECT *
FROM production.productcategory
LIMIT 2;

--15
SELECT COUNT(*)
FROM production.product
WHERE weight IS NULL;

--16
SELECT COUNT(*)
FROM person.person
WHERE additionalcontactinfo IS NOT NULL;
