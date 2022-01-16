SECTION 15

CREATE TABLE subscribers (
	firstname varchar(200),
	 lastname varchar(200),
	email varchar(250),
	signup timestamp,
	frequency integer,
	iscustomer boolean
);

CREATE TABLE returns (
	returnrid serial,
	customerid char(5),
	returndate timestamp,
	productid integer,
	quantity smallint,
	orderid integer
);


ALTER TABLE subscribers
RENAME firstname TO first_name;

ALTER TABLE returns
RENAME returndate TO return_date;

ALTER TABLE subscribers
RENAME TO email_subscribers;

ALTER TABLE returns
RENAME TO bad_orders;

ALTER TABLE email_subscribers
ADD COLUMN last_visit_date timestamp;

ALTER TABLE bad_orders
ADD COLUMN reason text;


ALTER TABLE email_subscribers
DROP COLUMN last_visit_date;

ALTER TABLE bad_orders
DROP COLUMN reason;


ALTER TABLE email_subscribers
ALTER COLUMN email SET DATA TYPE varchar(225);

ALTER TABLE bad_orders
ALTER COLUMN quantity SET DATA TYPE int;


DROP TABLE email_subscribers;

DROP TABLE bad_orders;
