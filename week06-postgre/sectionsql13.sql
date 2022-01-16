--CREATE INDEX
CREATE UNIQUE INDEX idx_employees_employeeid
ON employees (employeeid);

CREATE INDEX idx_orders_customerid_orderid
ON orders (customerid, orderid);

--drop index

--the idx_employees_employteeid index on employees table
DROP INDEX idx_employees_employeeid;


--dropn idx_orders_customerid index on orders table

DROP INDEX idx_orders_customerid_orderid;



DROP TABLE IF EXISTS performance_test;
CREATE TABLE performance_test (
  id serial,
  location text
);


--See what is running
SELECT * FROM pg_stat_activity WHERE state = 'active';

---polite way to stop
SELECT pg_cancel_backend(PID);

INSERT INTO performance_test (location)
SELECT 'Katmandu, Nepal' FROM generate_series(1,500000000);


--stop at all costs - can lead to full database restart
SELECT pg_terminate_backend(PID);


DROP TABLE IF EXISTS performance_test;

CREATE TABLE performance_test (
  id serial,
  location text
);


INSERT INTO performance_test (location)
SELECT md5(random()::text) FROM generate_series(1,10000000);


-- this takes forever 332
SELECT COUNT(*) FROM performance_test;


-- this takes 331 msec
SELECT * FROM performance_test
WHERE id = 2000000;


-- notice that it does a sequential scan
EXPLAIN SELECT COUNT(*) FROM performance_test;

EXPLAIN SELECT * FROM performance_test
WHERE id = 2000000;


CREATE INDEX idx_performance_test_id ON performance_test (id);

-- now will use an index scan
EXPLAIN SELECT * FROM performance_test
WHERE id = 2000000;

-- now count runs in 26 msec
SELECT * FROM performance_test
WHERE id = 2000000;

-- still does sequence scan
EXPLAIN SELECT COUNT(*) FROM performance_test;

-- still takes 319 msec
SELECT COUNT(*) FROM performance_test;

--QUERY PLAN COST
SET max_parallel_workers_per_gather = 0;
EXPLAIN SELECT * FROM performance_test
WHERE location like 'ab%';

-- size of table
SELECT pg_relation_size('performance_test'),
  pg_size_pretty(pg_relation_size('performance_test'));


-- number of relation pages
SELECT relpages
FROM pg_class
WHERE relname='performance_test';

--
SELECT relpages, pg_relation_size('performance_test') / 8192
FROM pg_class
WHERE relname='performance_test';

-- I/O cost per relationship page read
SHOW seq_page_cost;

-- total I/O cost
SELECT relpages * current_setting('seq_page_cost')::numeric
FROM pg_class
WHERE relname='performance_test';

-- number of rows
SELECT reltuples
FROM pg_class
WHERE relname='performance_test';

--CPU cost per row processed
SHOW cpu_tuple_cost;
SHOW cpu_operator_cost;

-- Total CPU Costs
SELECT reltuples * current_setting('cpu_tuple_cost')::numeric +
reltuples * current_setting('cpu_operator_cost')::numeric
FROM pg_class
WHERE relname='performance_test';

-- Total Costs for a table scan
SELECT relpages * current_setting('seq_page_cost')::numeric +
reltuples * current_setting('cpu_tuple_cost')::numeric +
reltuples * current_setting('cpu_operator_cost')::numeric
FROM pg_class
WHERE relname='performance_test';

SHOW parallel_setup_cost;
SHOW parallel_tuple_cost;

SET max_parallel_workers_per_gather = 4;
EXPLAIN (ANALYZE, VERBOSE) SELECT * FROM performance_test
WHERE location like 'ab%';


ALTER TABLE performance_test
ADD COLUMN name text;

UPDATE performance_test
SET name = md5(location);

-- takes above 900ms after data cached
EXPLAIN ANALYZE SELECT *
FROM  performance_test
WHERE location LIKE 'df%' AND name LIKE 'cf%';

CREATE INDEX idx_peformance_test_location_name
ON performance_test(location,name);

-- takes 55 ms
EXPLAIN ANALYZE SELECT *
FROM  performance_test
WHERE location LIKE 'df%' AND name LIKE 'cf%';

-- this can't use index
EXPLAIN ANALYZE SELECT *
FROM  performance_test
WHERE  name LIKE 'cf%';

-- this can
EXPLAIN ANALYZE SELECT *
FROM  performance_test
WHERE location LIKE 'df%';


-- This is for AdventureWorks database

--Make sure we don't have indexes to see the effect
DROP INDEX IF EXISTS production.idx_product_name;
DROP INDEX IF EXISTS production.idx_product_upper_name;

-- you should see a sequential scan
-- "Seq Scan on product  (cost=0.00..17.56 rows=3 width=139)"
EXPLAIN select *
from production.product
WHERE name LIKE 'Flat%';

-- create normal index
CREATE INDEX idx_product_name
ON production.product (name);

-- this becomes an bitmap index scan
-- "  ->  Bitmap Index Scan on idx_product_name  (cost=0.00..4.32 rows=5 width=0)"
EXPLAIN select *
from production.product
WHERE name LIKE 'Flat%';

-- this is back to sequential scan
-- "Seq Scan on product  (cost=0.00..17.56 rows=3 width=139)"
EXPLAIN select *
from production.product
WHERE UPPER(NAME) LIKE UPPER('Flat%');

-- create an expression scan
CREATE INDEX idx_product_upper_name
ON production.product (UPPER(name));

-- now we get a bitmap index scan
-- "  ->  Bitmap Index Scan on idx_product_upper_name  (cost=0.00..4.30 rows=3 width=0)"
EXPLAIN select *
from production.product
WHERE UPPER(NAME) LIKE UPPER('Flat%');

--your turn
CREATE INDEX idx_person_fullname
ON person.person ( (firstname  || ' ' || lastname) );

--show that it uses the index
EXPLAIN SELECT *
FROM person.person
WHERE firstname || ' ' || lastname = 'Terri Duffy';



CREATE EXTENSION pg_trgm;

CREATE INDEX trgm_idx_performance_test_location
ON performance_test USING gin (location gin_trgm_ops);

CREATE INDEX idx_performance_test_name
ON performance_test (name);


-- terrible performance
EXPLAIN ANALYZE SELECT location
FROM  performance_test
WHERE name LIKE '%dfe%';

--only situation where pattern matching works
EXPLAIN ANALYZE SELECT location
FROM  performance_test
WHERE name LIKE 'dfe%';


-- much better performance
EXPLAIN ANALYZE SELECT location
FROM  performance_test
WHERE location LIKE '%dfe%';

EXPLAIN ANALYZE SELECT location
FROM  performance_test
WHERE location LIKE 'dfe%';
