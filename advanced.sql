
-- Using CASE WHEN function to find the best product for income generation (highest price and the biggest amount sold) --

SELECT *,
case 
when unit_price > 2800 and sales_quantity > 10 then 'Best product'
ELSE 'other'
END as 'Best product'
FROM fact_sales f
join dim_promotion pm on f.dim_promotion_fkey = pm.promotion_id
ORDER BY sales_quantity desc
; 

-- Replacing NULL value with the 'N/A' value in table: "dim_promotion" using a COALESCE function --

SELECT trans_date, promo_name, start_date, end_date,
COALESCE (promo_name, 'N/A') as `UNDEFINED`
FROM fact_sales f
join dim_promotion pm on f.dim_promotion_fkey = pm.promotion_id
GROUP by promo_name
;

-- USING NULLIF function to substitute the 'European Spring Promotion' promotion name in table: "dim_promotion" with `NULL`

SELECT trans_date, promo_name, start_date, end_date,
NULLIF (promo_name, 'European Spring Promotion') AS NULLIFIED
FROM fact_sales f
join dim_promotion pm on f.dim_promotion_fkey = pm.promotion_id
GROUP by promo_name
; 

--  Using GREATEST function to return the unit price of all the products with the price below 50 USD as 50 --

SELECT *,
GREATEST(50, unit_price) AS LOW_PRICE
FROM fact_sales 
order by unit_price asc
; 


--  Using LEAST function to return the unit price of all the products with the price above 2800 USD -- 

SELECT *,
LEAST(2800, unit_price) AS BIG_PRICE
FROM fact_sales f
ORDER BY unit_price DESC
; 

-- USING DISTINCT function to find the unique values for the unit price --

SELECT distinct unit_price
FROM fact_sales;


-- Finding the same price instances from "fact sales" table --

SELECT *,
COUNT(*) AS CNT
FROM fact_sales
GROUP BY unit_price
HAVING COUNT(unit_price) >1
;


-- updating string values to date
update fact_sales
set dim_date_fkey = date_format(str_to_date(dim_date_fkey, '%m/%d/%Y'), '%m-%d-%Y');


/* Using Common Table Expressions to find unit prices with higher than average price of the items sold under 'North America Spring Promotion'  
for months of January and Februaty 2020 */


WITH CTE_1 as (
SELECT distinct promotion_id
FROM dim_promotion
WHERE promo_name IN ('North America Spring Promotion')
)

, CTE_2 as (
SELECT avg(unit_price) as avg_price
FROM fact_sales 
)

SELECT
promotion_id,
promo_name,
unit_price,
date_format(str_to_date(dim_date_fkey, '%Y-%m-%d'), '%Y-%m-%d') as `Date`
FROM fact_sales f
join dim_promotion pm on f.dim_promotion_fkey = pm.promotion_id 
WHERE promotion_id IN (SELECT distinct promotion_id from CTE_1)
AND unit_price > (SELECT avg_price FROM CTE_2)
AND date_format(str_to_date(dim_date_fkey, '%Y-%m-%d'), '%m-%Y') between '01-2020' and '02-2020'
ORDER BY unit_price asc
;


/* Recursive CTE* for finding stores with zero sales for a certain date */


with recursive all_dates(dt) as (
   SELECT  min(trans_date) dt from fact_sales                              -- ANchor memeber
    union all 
    select dt + interval 1 day from all_dates                              -- Recursive mmeber
    where dt + interval 1 day < '2020-12-31'                               --  Termination condition
)
select d.dt `date`, coalesce (t.dim_store_fkey, 0) dim_store_fkey			-- Query that uses a recursive CTE
from all_dates d
left join fact_sales t on t.trans_date = d.dt
order by dim_store_fkey;


-- Pivoting data for Jan- Mar 2020 with CASE WHEN clause --


SELECT *,
SUM(CASE WHEN date_format(str_to_date(dim_date_fkey, '%Y-%m-%d'), '%m-%Y') = '01-2020' then unit_price end) as 'Jan-2020',
SUM(CASE WHEN date_format(str_to_date(dim_date_fkey, '%Y-%m-%d'), '%m-%Y') = '02-2020' then unit_price end) as 'Feb-2020',
SUM(CASE WHEN date_format(str_to_date(dim_date_fkey, '%Y-%m-%d'), '%m-%Y') = '03-2020' then unit_price end) as 'Mar-2020'
FROM fact_sales
WHERE date_format(str_to_date(dim_date_fkey, '%Y-%m-%d'), '%m-%Y') between '01-2020' and '03-2020'
GROUP BY 1,2,3,4,5,6;

-- USING SELF JOIN to find instances of unit price being bigger than the gross income --

SELECT
a.dim_store_fkey, a.unit_cost as bigger_cost
FROM fact_sales a
JOIN fact_sales b ON a.dim_store_fkey = b.fact_sales_id
WHERE a.unit_cost > b.unit_cost;

-- Using window functions RANK, DENSE_RANK to rank the biggest sales amounts with the corresponding stores in different countries --

SELECT total_cost,
sales_amount,
store_name, 
employee_count, 
selling_area_size,
country,
ROW_NUMBER () OVER (order by sales_amount) AS 'Row number',
RANK() OVER (ORDER BY sales_amount DESC) AS `rank`,
DENSE_RANK() OVER (ORDER BY sales_amount DESC) AS `dense rank`
FROM fact_sales f
join dim_store d on f.dim_store_fkey = d.store_id
join dim_geo g on d.geo_fkey = g.geo_id;
;



-- Using CTE and LAG function statement that returns sales quantity of every brand and product sub category in a specific month and the previous month --

WITH brand_sales AS
( SELECT brand,
product_sub_cat,
SUM(sales_quantity) sum_sales,
Month(trans_date) order_month
FROM fact_sales f
join dim_product p on f.dim_product_fkey = p.product_id
join dim_product_sub_cat sc on p.product_sub_cat_fkey = sc.product_sub_cat_id
join dim_product_cat pc on sc.product_cat_fkey = pc.product_cat_id
GROUP BY brand, order_month
)
SELECT  brand,
product_sub_cat,
sum_sales,
order_month,
LAG(sum_sales, 1) OVER (partition by brand
order by order_month) prev_month_sales_quantity
FROM brand_sales;


-- Using LEAD WINDOW function to the order date and the next order date of each product name --

SELECT `name`,
trans_date,
LEAD (trans_date, 1) OVER (
PARTITION BY `name` ORDER BY trans_date) next_order_date
FROM fact_sales f
join dim_product p on f.dim_product_fkey = p.product_id
join dim_product_sub_cat sc on p.product_sub_cat_fkey = sc.product_sub_cat_id
join dim_product_cat pc on sc.product_cat_fkey = pc.product_cat_id;


-- Convertig varchar dim_date_fkey values from "fact_sales" table intto the DATE values by adding the new column "trans_date" and casting the values from "dim_date_fkey" column --

update fact_sales
set dim_date_fkey = date_format(str_to_date(dim_date_fkey, '%M-%d-%Y'), '%Y-%m-%d');

alter table fact_sales ADD trans_date date;

update fact_sales set trans_date = cast(dim_date_fkey as DATE);
