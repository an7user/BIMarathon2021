-- Method 1: Using  COUNT function to find duplicates in "dim_product" table using Group BY and HAVING --

SELECT 
name, 
unit_cost,
COUNT(*) AS CNT
FROM
    dim_product 
    GROUP BY 
    name 
       HAVING COUNT(*) > 1;
      
/* Method 2: finding duplicates in table: "dim_product" using Group BY and HAVING
Using  COUNT function to find duplicates in "dim_product_sub_cat" table */

SELECT 
product_sub_cat,
product_cat_fkey,
COUNT(*) AS CNT
FROM
    dim_product_sub_cat 
    GROUP BY 
    product_sub_cat 
       HAVING COUNT(*) > 1;
       
     -- method 1: finding duplicates in table: "dim_store" using GROUP BY and HAVING Caluses
     
       SELECT 
store_name,
geo_fkey,
COUNT(*) AS CNT
FROM
    dim_store 
    GROUP BY 
    store_name 
       HAVING COUNT(*) > 1;
       
       
     -- method 2: finding duplicates in table: fact_sales using Common Table Expression
             
WITH CTE as  
(  
   SELECT*, ROW_NUMBER() over (PARTITION BY fact_sales_id ORDER BY fact_sales_id) as Duplicates  
   FROM fact_sales  
)  
SELECT * FROM CTE
WHERE Duplicates > 1;


-- method 3: finding duplicates in table: fact_sales using ROW_MUMBER function
   
   SELECT * FROM (SELECT *, ROW_NUMBER() over (PARTITION BY fact_sales_id ORDER BY fact_sales_id) as Duplicates  
   FROM fact_sales) as temp_table WHERE Duplicates >= 1;
 
-- Deliting duplicates from table: fact_sales using the ROW_NUMBER() Function 

 DELETE FROM fact_sales WHERE fact_id IN(
   SELECT fact_id FROM (SELECT fact_id, ROW_NUMBER() 
   over (PARTITION BY fact_sales_id ORDER BY fact_sales_id) as Duplicates  
   FROM fact_sales) AS temp_table WHERE Duplicates >1
   );
    
  select * from fact_sales;     

