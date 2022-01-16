Section 4
-- where cluase
---select specific text
-- all suppliers in berline
---select companyname
--from suppliers
--where city='berlin';

--find all name and contacts that are in mexico
--select companyname,contactname
--from suppliers
--where city='mexico';

--select numberic feild
--find order where eid is 3

--select count(*)
--from orders
--where employeeid=3;

--number of order details that had more than 20 items ordered
select count(*)
from order_details
where quantity>20;

--how many orders had a fright cost eqal to or more than $250

--select count(*)
--from orders
--where freight >= 250;

--searching date feilds
--find the orders 
--that were ordered on or after jan 01 1998

--select count(*)
--from orders
--where orderdate >='1998-01-01';

--hpw many orders shipped befire july 5,1997

--select count(*)
--from orders
--where shippeddate <'1997-07-06';

--where using AND

--shipped to germany and the freight cost more than $100
select count(*)
from orders
where shipcountry='germany'  AND freight>100;

-- we want distinct customer where orders were shipped via united package (id=2)
-- and the ship country is brazil

select DISTINCT (customerid)
from orders
where shipcountry='Brazil' AND shipvia=2;

-- where using or

-- how many cust do we hav in us and canada

--select count(*)
--from customers
--where country='USA' or country='Canada'

--how many suppliers do we have in germany ang spain
--select count(*)
--from suppliers
--where country='Germany' or country='Spain'
--how many orders shipped yo USA brazil and argentina
--select count(*)
--from orders
--where shipcountry='USA' or shipcountry='Brazil' or shipcountry='Argentina';

--where using not

--how many custyomer not in ftrance

--select count(*)
--from customers
--where not country ='France';

--how many suppliers noit in usa

select count(*)
from suppliers 
where NOT country ='USA';

--where combining and or and not

--how many orders shipped to germany and frieght cost < 50 or >175

select count(*)
from orders
where shipcountry='Germany' and (freight < 50 or freight >175);
--how many orders shipped to canada or spain and shipdate after may 1 1997

select count(*)
from orders
where (shipcountry='Canada' or shipcountry='Spain') 
and shippeddate >'1997-05-01' ;

--using between

--how many unit pricebetwwen 10 and 20
SELECT COUNT(*)
from order_details
where unitprice BETWEEN 10 AND 20;

--how many orders shipped between june 1,1996 and septemnber 30 1996

SELECT COUNT(*)
from orders
where shippeddate BETWEEN '1996-06-01' AND '1996-09-30';

--using in 

--how many suppliers are located in germany france spain OR ITALY
SELECT COUNT(*)
from suppliers
where country IN('France','Germany','Spain','Italy');

--how many productas do we have in category id 1,4,6,or 7

SELECT COUNT(*)
from products 
where categoryid IN (1,4,6,7);

QURIES ON USDA

--1
SELECT * FROM data_src
WHERE journal = 'Food Chemistry';

--2
SELECT * FROM nutr_def
WHERE nutrdesc = 'Retinol';

--3
SELECT * FROM food_des
WHERE manufacname = 'Kellogg, Co.';

--4
SELECT COUNT(*) FROM data_src
WHERE year > 2000;

--5
SELECT COUNT(*) FROM food_des
WHERE fat_factor<4;

--6
SELECT * FROM weight
WHERE gm_wgt = 190;

--7
SELECT COUNT(*)
FROM food_des
WHERE pro_factor > 1.5 AND fat_factor < 5;

--8
SELECT * FROM data_src
WHERE year=1990 AND journal='Cereal Foods World';

--9
SELECT COUNT(*) FROM weight
WHERE gm_wgt > 150 and gm_wgt < 200;

--10
SELECT *
FROM nutr_def
WHERE units = 'kj' or units='kcal';

--11
SELECT * FROM data_src
WHERE year=2000 OR journal='Food Chemistry';

--12
-- lookup the fdgrp_cd for Breakfast Cereals
SELECT fdgrp_cd FROM fd_group
WHERE fddrp_desc = 'Breakfast Cereals';
-- find the count
SELECT COUNT(*) FROM food_des
WHERE NOT fdgrp_cd = '0800';

--13
SELECT * FROM data_src
WHERE (year >= 1990 AND year <=2000) AND
	(journal = 'J. Food Protection' OR Journal='Food Chemistry');

--14
SELECT COUNT(*)
FROM weight
WHERE gm_wgt BETWEEN 50 AND 75;

--15
SELECT * FROM data_src
WHERE year IN (1960,1970,1980,1990,2000);

