section 11

----subquries using exist
SELECT companyname 
FROM customers
WHERE EXISTS (SELECT customerid FROM orders
			 WHERE orders.customerid=customers.customerid AND 
			 orderdate BETWEEN '1997-04-01' AND '1997-04-30')

--find the customers who did not have an order on april 1997


SELECT companyname 
FROM customers
WHERE NOT EXISTS (SELECT customerid FROM orders
			 WHERE orders.customerid=customers.customerid AND 
			 orderdate BETWEEN '1997-04-01' AND '1997-04-30')
--WHAT PRODUCTS NOT have an order in april 1997

SELECT productname
FROM products 
WHERE NOT EXISTS (SELECT productid FROM order_details 
				 JOIN orders ON orders.orderid=order_details.orderid
				 WHERE order_details.productid=products.productid AND 
				 orderdate BETWEEN '1997-04-01' AND '1997-04-30')

--find all suppliers with a product that costs more than 200
SELECT companyname
FROM suppliers
WHERE EXISTS (SELECT productid FROM  products 
			 WHERE products.supplierid=suppliers.supplierid
			 AND unitprice >200)
--find all suppliers that dont have an order in DECEMBER 1996

SELECT companyname 
FROM suppliers
WHERE EXISTS (SELECT products.productid from products
			 JOIN order_details on order_details.productid=products.productid
			 JOIN orders ON orders.orderid=order_details.orderid
			 WHERE products.supplierid=suppliers.supplierid
			 AND orderdate BETWEEN '1996-12-01' AND '1996-12-31')

--subqueries using any all
--find customers with an order details with more than 50 item in a single product

SELECT companyname 
FROM customers
WHERE customerid = ANY (SELECT customerid FROM orders
					   JOIN order_details ON orders.orderid=order_details.orderid
					   WHERE quantity >50);

--inbd all suppliers that have had an order with 1 item

SELECT companyname
FROM suppliers
WHERE supplierid =ANY (SELECT products.supplierid FROM  order_details 
					  JOIN products  ON  products.productid=order_details.productid
					  WHERE quantity=1) 

--which had order amounts that were higher than the avg of all products

SELECT DISTINCT productname 
FROM products 
JOIN order_details ON products.productid=order_details.productid
WHERE order_details.unitprice*quantity > ALL
	(SELECT AVG(order_details .unitprice*quantity)
		   FROM order_details 
		   GROUP BY productid);

--find all distinct customer that ordered more in one item than the avg order amount per item of all customers

SELECT DISTINCT companyname
FROM customers
JOIN orders ON  orders.customerid=customers.customerid
JOIN order_details on orders.orderid=order_details.orderid
WHERE order_details .unitprice*quantity > ALL
	(SELECT AVG (order_details.unitprice*quantity)
		FROM order_details 
		JOIN orders on orders.orderid=order_details.orderid
		GROUP BY orders.customerid)

--using in 

--fnd customers that are in same countries as suppliers

SELECT companyname
FROM customers
WHERE country IN (SELECT country FROM suppliers)

--find all suppliers that are in the same city as a customer

SELECT companyname
FROM suppliers
WHERE city IN (SELECT city FROM customers)