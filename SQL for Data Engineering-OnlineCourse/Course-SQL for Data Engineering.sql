-- SQL Basic
select * from products order by price 

select * from customer order by customer_name

select * from customer order by customer_name desc

select * from products order by price, name

select * from products where is not price>100  order by price

-- SQL Basic
-- Filter
select * from products where price>100 and category_id =2

select * from products where price>100 or category_id =2 order by product_id

-- SQL Basic
-- Insert
select * from categories

select * from products
INSERT INTO Products (name, price, description, tags, category_id,Supplier)
VALUES
    ('Ipad', 100, 'High-performance ipad for professionals', 'electronics, portable, tech', 1, 'SupplierA')
	
-- SQL Basic
-- Update
select * from products

update products set price=500 where product_id =7

update products set price =700, category_id =2 where product_id =7

-- SQL Basic
-- Delete
delete from products where product_id =7

delete from public."FruitJuice"

truncate public."FruitJuice"

drop table public."FruitJuice"

-- SQL Basic
-- Remove order ID#10 from order list
delete from orders where order_id = 10

-- SQL Advance
-- Join
select name, description, total_amount from orders o INNER JOIN Products p on p.product_id = o.product_id

select customer_name, total_amount from orders o join customer c on c.customer_id = o.customer_id  

-- SQL Advance
-- Join
select customer_name, total_amount from customer c left join orders o on c.customer_id = o.customer_id

select name, total_quantity from orders o left join products p on p.product_id = o.product_id

-- SQL Advance
-- Join
select customer_name, total_quantity from customer c full outer join orders o on c.customer_id = o.customer_id

select customer_name, name, total_quantity from customer c full outer join orders o on c.customer_id = o.customer_id full outer join
products p on p.product_id = o.product_id 

-- SQL Advance
-- Case
select name, description,
price,
case
 when price<100 then 'Cheap'
 when price >100 and price <500 then 'Affordable'
 else 'Expensive'
 End as ProductType

from products

-- SQL Advance
-- Group by
select city, COUNT(customer_id) from customer group by city, email

-- SQL Advance
-- AVG
select count(customer_id) as Total_Row_Count from customer

select count(*) as Total_Row_Count from customer

select count( distinct customer_id) as Total_Row_Count from customer

select sum(total_amount) from orders

select max(total_amount) from orders

select min(total_amount) from orders


select avg(total_amount) from orders
select stddev(total_amount) from orders

-- SQL Advance
-- Having
select city, count(*) from customer group by city having count(*)>100

select c.name, c.category_id,  count(p.product_id)  from categories c join products p on c.category_id = p.category_id
group by c.category_id having count(p.product_id)>1

-- SQL Advance
-- Find all product name along with ID numbers
-- that belong to the category called 'Electronics'
select
	p.product_id,
	p.name,
	c.name
from products p
join categories c
on p.category_id = c.category_id
where c.name = 'Electronics'

-- Function
-- math
select abs(2.6)

select ceil(2.7)

select floor(2.7)

select round(2.3456, 2)

select round(sqrt(4.0), 0)

-- Function
-- date
select current_date

select extract(Day from current_date)


select extract(Month from current_date)

select extract(Year from current_date)

select date_part('day', current_date)
select date_part('month', current_date)
select date_part('year', current_date)

select date_trunc('month', current_date)

select date_trunc('year', current_date)

select age(timestamp '2024-01-01')

select age( timestamp '2024-01-01', timestamp '2024-01-31')

select to_date('01/01/2024', 'DD/MM/YYYY')

select to_char(current_date, 'DD-MM-YYYY')

-- Function
-- time
select current_time
select current_timestamp

select localtime

select localtimestamp

select extract(hour from order_timestamp) from orders


select extract(minute from order_timestamp) from orders


select extract(second from order_timestamp) from orders

select date_trunc('day', order_timestamp) from orders

select age(order_timestamp) from orders

select age(delivery_timestamp, order_timestamp) from orders

select current_timestamp at Time Zone 'America/New_York'

-- Function
-- cancat
select city || '----'|| address from customer

select concat(city, address) from customer

select concat_ws('--', city, address) from customer

select trim('    helllo     ')
select trim('X' from 'XXXHelloXXX')

select ltrim('   hello   ')
select btrim('   hello   ')

-- Function
-- extracting
select upper(customer_name) from customer

select lower(customer_name) from customer

select initcap(customer_name) from customer

select substring('Hello from Deepak' from 1 for 5)

select substring('Hello from Deepak' from 7 for 5)

select left('Hello from Deepak', 5)

select right('Hello from Deepak', 6)

select position('Alice' in 'Hello from Deepak')

select length('Hello from Deepak')

-- Analytical over (partition by
-- RANK()
select customer_id,
RANK() over (partition by customer_id order by total_amount desc) as order_rank,
total_amount
from orders

-- Analytical over (partition by
-- row_number()
select customer_id,

row_number() over (partition by customer_id order by total_amount desc) as Order_Rank,
total_amount
from orders

-- Analytical over (partition by
-- lag
select customer_id, order_id, order_timestamp,
lag(order_timestamp, 1) over (partition by customer_id order by order_timestamp) as prev_order
from orders

select customer_id, order_id, order_timestamp,
lead(order_timestamp, 1) over (partition by customer_id order by order_timestamp) as next_order
from orders

-- Analytical over (partition by
-- sum
select customer_id, order_id, total_amount, ordeR_timestamp,

sum(total_amount) over(partition by customer_id order by order_timestamp) as running_total

from orders

select product_id, order_timestamp,total_quantity,

sum(total_quantity) over(partition by product_id order by order_timestamp) as running_qty

from orders

-- Analytical over (partition by
-- avg
select order_id, customer_id, order_timestamp, total_amount,

avg(total_amount) over (partition by customer_id order by order_timestamp
	rows between 1 preceding and current row) as mvg_avg
	from orders

-- Cumulative
-- Find the cumulative sales volume of each product overtime
select
	product_id,
	order_timestamp,
	total_quantity,
	sum(total_quantity) over(partition by product_id
	order by order_timestamp) as running_num
from orders

-- view
create view customer_order_summary AS

select customer_id,
count(order_id),
sum(total_amount)
from
orders
group by customer_id

select * from customer_order_summary where customer_id =1

-- procedure
create procedure add_category(cat_id int, cat_name varchar)
language plpgsql
AS
$$
BEGIN
 insert into categories values (cat_id, cat_name);
END;
$$;

Call add_category(6, 'Fashion')

select * from categories

drop procedure add_category

-- index
create index idx_customer_email on customer(email);

create index idx_prod_cat on products(category_id)

create unique index idx_prod_name on products(name)

create index idx_cust_order on orders(customer_id, order_timestamp)

-- index query performance
explain analyze select * from orders where order_id=1

select * from pg_stat_user_indexes where relname ='orders'

explain  select * from orders where order_id=1

-- Index performance tunning
select * from orders where customer_id =1  order by order_timestamp desc
create index idx_cust on orders(customer_id, order_timestamp)


select * from orders where customer_id =1  order by order_timestamp desc limit 2

-- user the index to improve order searching using the timestamp column
create index order_idx on orders(order_timestamp)

-- Database security and user management
-- role
create role mike with login

create role tom with login password 'tom@123';

create role John with login password 'John@123' superuser

create role John1 with login password 'John@123' createdb;

create role John2 with login password 'John@123' createrole

create role John3 with login password 'John@123' valid until '2024-05-31'

create role John4 with login password 'John@123' connection limit 10

create role John5 with login password 'John@123' in role John4

create user John6 with password 'John@123'

-- Database security and user management
-- grant and unrole
grant select on customer to john1

grant insert, delete on customer to john1

grant select on all tables in schema public to john1

grant select on customer to john1 with grant option

revoke select on customer from john1

revoke select, insert on customer from john1

revoke all on customer from john1

-- Database security and user management
-- permission
create role sales_team

create role admins

grant select on all tables in schema public to sales_team

grant all privileges on all tables in schema public to admins

create role sales_managers in role sales_team

-- New team member 'Bob'
-- grant access to view product
create role bob with login password 'bob123'
grant select on products to bob

-- Debug
select * from customer

select *  from customer where city = 'City1'

select *  from customer where city = 'City1'

select *  from customer where city  in ('City1', 'City2')

select avg(customer_name) from customer

select * from orders join customer on 

-- Debug null
select * from products where price is not null

select true and null

avg
max
min
count(*)

-- Debug real issue
SELECT
    DATE_TRUNC('month', o.order_timestamp) AS order_month,
    SUM(o.total_quantity * p.price) AS total_sales
FROM
    orders o
JOIN
    products p ON o.product_id = p.product_id
WHERE
    o.order_timestamp >= '2023-01-01' AND
    o.order_timestamp < '2025-04-01'
GROUP BY
    order_month
ORDER BY
    order_month;

select * from orders where total_quantity is null

select * from products where price is null

select * from orders where product_id in (1, 4)

update products set price =200 where product_id =4

-- ETL
