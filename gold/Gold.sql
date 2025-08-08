-- KPIs

-- Total Revenue
create schema gold_1;

use silver_1;
select round(sum(total_amount),2) as total_revenue
from silver_amazon_data;


select prime_user, count(prime_user) as total_user
from silver_amazon_data
group by prime_user;

with total_user as(
select count(*) as total_user
from silver_amazon_data
)

select s.prime_user,count(prime_user) as total_subs,
count(*)/t.total_user*100 as percentile_users
from silver_amazon_data s 
cross join
total_user t
group by s.prime_user,t.total_user;


select * from silver_amazon_data;

create view top_10_products_by_revenue as 
with top_product as (
select *,row_number()
over(order by rating desc ,quantity desc) as rnk
from silver_amazon_data)

select category , rnk from top_product 
where rnk <=10;




with first_order as (
select buyer_id,
min(order_date) as first_order
from silver_amazon_data
group by buyer_id),
category as(
select s.order_id,
s.buyer_id,
case
when s.order_date = f.first_order then "New"
when s.order_date > f.first_order then "Returning"
else "Nothing"
end as Order_category
from silver_amazon_data s
join first_order f
on s.buyer_id = f.buyer_id)
select Order_category, count(distinct buyer_id) as total_count
from category
group by Order_category;


with monthly_sales as(
select date_format(order_date,'%Y-%m') as monthly,
sum(quantity) as total_sales
from silver_amazon_data
group by date_format(order_date,'%Y-%m'))
select monthly,
lag(total_sales) over(order by monthly) as last_month_sale,
total_sales-lag(total_sales)  over(order by monthly) as m_o_m_changes
from monthly_sales;

create view monthly_sales_by_category as
with monthly_sales_2 as(
select category,
sum(quantity) as total_sales
from silver_amazon_data
group by category)
select category,
lag(total_sales) over(order by category) as last_month_sale,
total_sales-lag(total_sales)  over(order by category) as m_o_m_changes
from monthly_sales_2;

drop view monthly_sales_by_category;


create view monthly_sales_by_category as
select category,
date_format(order_date,'%Y-%m') as monthly,
count(quantity) as total_sales,
round(sum(total_amount),2) as revenue,
round(sum((price*quantity)-total_amount),2) as profit
from silver_amazon_data
group by category,
date_format(order_date,'%Y-%m');

select * from top_10_products_by_revenue;
select * from monthly_sales_by_category;


drop procedure sp_get_buyer_summary;

DELIMITER $$

CREATE PROCEDURE sp_get_buyer_summary(IN input_buyer_id INT)
BEGIN
    SELECT 
        buyer_id,
        prime_user,
        COUNT(order_id) AS total_orders,
        SUM(total_amount) AS total_spend
    FROM 
        silver_amazon_data
    GROUP BY 
        buyer_id, prime_user;
END $$

DELIMITER ;

CALL sp_get_buyer_summary(1001);

