SELECT companyname, orderid, amount , average_order FROM
( SELECT companyname, orderid, amount ,AVG(amount) OVER (PARTITION BY companyname) AS average_order
FROM
(SELECT companyname,orders.orderid,SUM(unitprice*quantity) AS amount
FROM customers
JOIN orders ON orders.customerid=customers.customerid
JOIN order_details ON orders.orderid=order_details.orderid
GROUP BY companyname,orders.orderid) as order_amounts) as order_averages
WHERE amount > 5 * average_order
ORDER BY companyname


--using window function with subquries

SELECT companyname, orderid, amount , average_order FROM
( SELECT companyname, orderid, amount ,AVG(amount) OVER (PARTITION BY companyname) AS average_order
FROM
(SELECT companyname,orders.orderid,SUM(unitprice*quantity) AS amount
FROM customers
JOIN orders ON orders.customerid=customers.customerid
JOIN order_details ON orders.orderid=order_details.orderid
GROUP BY companyname,orders.orderid) as order_amounts) as order_averages
WHERE amount > 5 * average_order
ORDER BY companyname

SELECT companyname,month,year,total_orders,average_monthly
FROM (
SELECT companyname,total_orders,month,year,
AVG(total_orders) OVER (PARTITION BY companyname) as average_monthly
FROM (
SELECT companyname,SUM(quantity) as total_orders,date_part('month',orderdate) as month,date_part('year',orderdate) as year
FROM order_details
JOIN products ON order_details.productid = products.productid
JOIN suppliers ON suppliers.supplierid=products.supplierid
JOIN orders ON orders.orderid=order_details.orderid
GROUP BY companyname,month,year)  as order_by_month) as average_monthly
WHERE total_orders > 3 * average_monthly

--using rank to find first n records in oin

SELECT * FROM
(SELECT orders.orderid, productid, unitprice, quantity,
 	rank() OVER (PARTITION BY order_details.orderid ORDER BY (quantity*unitprice) DESC) AS rank_amount
FROM orders
NATURAL JOIN order_details) as ranked
WHERE rank_amount <=2;

SELECT companyname,productname,unitprice FROM
(SELECT companyname,productname,unitprice,
rank() OVER (PARTITION BY products.supplierid ORDER BY unitprice ASC) AS price_rank
FROM suppliers
NATURAL JOIN products) as ranked_products
WHERE price_rank <=3;

