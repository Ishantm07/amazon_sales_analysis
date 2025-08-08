create database amazon;

create schema bronze_1;

create table bronze_1.buyers(
buyer_id int,
buyer_name varchar(50),
email nvarchar(50),
phone int,
country varchar(50),
registration_date date,
prime_user varchar(50),
gender varchar(50));

create table bronze_1.products(
product_id int,
product_name nvarchar(50),
category nvarchar(50),
price int,
stock_quantity int,
rating int);

create table bronze_1.orders(
order_id int,
buyer_id int,
order_date datetime,
total_amount float,
payment_method nvarchar(50),
order_status nvarchar(50));

create table bronze_1.orders_items(
order_item_id int,
order_id int,	
product_id int,	
quantity int,	
price_each float,	
discount_applied nvarchar(50));

alter table bronze_1.buyers
modify phone bigint;
alter table bronze_1.buyers
modify registration_date datetime;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\New Project\\amazon_buyers.csv'
INTO TABLE bronze_1.buyers
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(buyer_id,
buyer_name,
email,
phone,
country,
registration_date,
prime_user,
gender) ;


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\New Project\\amazon_products.csv'
INTO TABLE bronze_1.products
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id,	
product_name,	
category,	
price,	
stock_quantity,	
rating);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\New Project\\amazon_orders.csv'
INTO TABLE bronze_1.orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id,	
buyer_id,	
order_date,	
total_amount,	
payment_method,
order_status
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\New Project\\amazon_order_items.csv'
INTO TABLE bronze_1.orders_items
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_item_id,
order_id ,	
product_id ,	
quantity ,	
price_each ,	
discount_applied
);

select * from bronze_1.buyers;
select * from bronze_1.products;
select * from bronze_1.orders;
select * from bronze_1.orders_items;
