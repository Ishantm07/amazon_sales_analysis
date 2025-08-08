create schema silver_1;
use silver_1;


select * from bronze_1.buyers;
select * from bronze_1.products;
select * from bronze_1.orders;
select * from bronze_1.orders_items;

CREATE VIEW silver_amazon_data AS
select b.buyer_id,
b.country,
date_format(b.registration_date, '%Y-%m-%d') as registration_date,
b.prime_user,
b.gender,
p.product_id,
p.category,
p.price,
p.stock_quantity,
p.rating,
o.order_id,
date_format(o.order_date, '%Y-%m-%d') as order_date,
o.total_amount,
o.payment_method,
o.order_status,
ot.order_item_id,
ot.quantity,
ot.price_each,
ot.discount_applied
from bronze_1.buyers b
join bronze_1.orders o on b.buyer_id = o.buyer_id
join bronze_1.orders_items ot on o.order_id = ot.order_id
join bronze_1.products p on ot.product_id = p.product_id;

select * from silver_amazon_data;

