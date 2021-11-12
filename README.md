# Data Analysis Marathon - mentoring BI program 2021

## Project name: 
### A4TECH COMPUTER HARDWARE AND DIGITAL PRODUCTS GLOBAL SALES PERFORMANCE ANALYSIS FOR 2020

### Problem:
Developing a scalable and sustainable organizational structure and growing strong partnerships to achieve an unbeatable online shopping experience for the latest and greatest products and services is of topmost importance for any retailer nowadays. Which country, store type, brand is selling the best? What is the impact sales areas and number of employees on the total cost of sales? Which discounts are most effective? Which product categories are top selling across different regions?

### Project mission:
Project’s mission is to provide sales effectiveness analytics for the marketing and business development solutions for the top management of the company. This will help to analyze and benchmark company’s retail and online sales, discount periods’ impact on the amount of sales, influence of retail stores areas and number of employees on the total cost of sales.

### Project goal:

Project’s goal is to provide a visualized detailed report dashboard that offers a profound understanding of a A4tech’s company sales performance, bestselling brands, emerging trends, customer data, gross margin percentage and revenue per each store and country for a period of 12 months of 2020.
Project attributes (dimensions and facts)

### Dimensions: 

1.	Product dimension (product name, product description, manufacturer name, brand, class name - deluxe, economy, regular)
1.1.	Product subcategory (product subcategory name)
1.2.	Product category (product category name)
2.	Store dimension (store ID, store type – online, retail, store name, status – operational, non-operational)
2.1.	Geographical location (continent, country, city)
3.	Promotion (promotion name, discount percent, promotion start date, promotion end date)

### Facts:

1.	Unit cost
2.	Unit price
3.	Sales quantity
4.	Discount amount 
5.	Total cost
6.	Total sales amount
7.	Sales date
8.	Store ID

### Metrics to analyze:

Total and net sales by brand, gross profit percentage by country, total sales by month, gross profit percentage by month, gross profit percentage by product subcategory, average discount by promotion, total discount amount offered by brand, total cost of sales per store in relation to the selling area size and number of employees, total sales by store type.

### <a href="https://github.com/an7user/BIMarathon2021/tree/main/dataset"> The dataset for the project can be foung follwing this link. </a>

### Physical Data Model (A4tech Sales Physical model)

Out database will be based on a snowflake schema as the product and store dimensions have hierarchical subdimensions as shown in the images below.

![sales_physical](https://user-images.githubusercontent.com/90646142/141209407-653c38e6-e6e5-44fb-84c6-ad17e4375e91.png)

### <a href="https://github.com/an7user/BIMarathon2021/blob/main/schema_creation.sql">SQL script (Creating schema, fact and dimension tables)</a>

### Analyzing the Database for the presence of duplicates and NULL values (deleting if found)

 *Method 1. Using   COUNT function to find duplicates in "dim_product_sub_cat" table*
 
 ![image](https://user-images.githubusercontent.com/90646142/141211916-3fdde30a-7264-40d1-8c0a-5ad50a2de505.png)

No duplicates retrieved from the query.

*Method 2. Finding duplicates in "fact_sales" table using Common Table Expression*

![image](https://user-images.githubusercontent.com/90646142/141212675-a4bf10a0-cbbc-42d6-a360-99115ffd5e19.png)

No duplicates retrieved from the query.

*Method 3. Finding duplicates in table: fact_sales using ROW_MUMBER function*
   
 ![image](https://user-images.githubusercontent.com/90646142/141212983-eb76d2eb-7211-44a8-8454-8cb8f07a28a4.png)

Each row returned value equal to 1, no duplicates found.

We haven't found any duplicates in the schema tables, if any duplicates could be found, the following SQL using the ROW_NUMBER() Function script would come in handy.

![image](https://user-images.githubusercontent.com/90646142/141213205-7d41b170-c832-4d75-9ce7-000e0e386bf0.png)

*Replacing NULL value with the 'N/A' value in table: "dim_promotion" using a COALESCE function*

![image](https://user-images.githubusercontent.com/90646142/141214655-75c2e3ad-b3fe-47be-a6be-354b3209b77b.png)

*Using NULLIF function to substitute the 'European Spring Promotion' promotion name in table: "dim_promotion" with `NULL`*

![image](https://user-images.githubusercontent.com/90646142/141214953-a497c590-9a48-465a-ad95-02b11f18facc.png)

### <a href="https://github.com/an7user/BIMarathon2021/blob/main/duplicates_check.sql">The full script for finding duplicates</a>

### Using advanced SQL functions to analyze the dataset

*Using CASE WHEN function to find the best product for income generation (highest price and the biggest amount sold)*

![image](https://user-images.githubusercontent.com/90646142/141214120-bbfd8fcf-8195-4d97-9a07-bb82a0d96a3f.png)

*Using GREATEST function to return the unit price of all the products with the price below 50 USD as 50*

![image](https://user-images.githubusercontent.com/90646142/141215335-1eb9486e-7640-4844-989c-f0174ef452fb.png)

*Using LEAST function to return the unit price of all the products with the price above 2800 USD*

![image](https://user-images.githubusercontent.com/90646142/141215419-fb3f2920-6e58-4154-be7d-29e9d9d5fb6c.png)

*USING DISTINCT function to find the unique values for the unit price from "fact_sales" table*

![image](https://user-images.githubusercontent.com/90646142/141215592-410f4bfa-38ff-46b6-b581-35fca7e14f08.png)

*Finding the same price instances from "fact sales" table*

![image](https://user-images.githubusercontent.com/90646142/141215778-2754bb54-0f8b-4334-9170-cd805da9ae83.png)

*Using Common Table Expressions to find unit prices with higher than average price of the items sold under 'North America Spring Promotion'  
for months of January and Februaty 2020*

![image](https://user-images.githubusercontent.com/90646142/141380212-a1b8d462-954d-402f-bbe1-448cc10ca380.png)

*Using  Recursive CTE* for finding stores with zero sales for a certain date*

![image](https://user-images.githubusercontent.com/90646142/141217451-ec4e3dd3-752a-4322-8947-f03c931a1454.png)

*Pivoting data for Jan- Mar 2020 with CASE WHEN clause*

![image](https://user-images.githubusercontent.com/90646142/141217656-20af1705-109e-49f6-94dc-a6c201130e3f.png)

*Using SELF JOIN to find unit prices higher than the gross income*

![image](https://user-images.githubusercontent.com/90646142/141217863-273171a3-5055-4d1b-b1b6-17a8fefad05b.png)

*Using window functions RANK, DENSE_RANK to rank the biggest sales amounts with the corresponding stores in different countries*

![image](https://user-images.githubusercontent.com/90646142/141370842-b6e88a80-a64a-4fbe-9a3b-fb48c9f85fd6.png)

*Using CTE and WINDOW LAG function statement that returns sales quantity of every brand and product sub category in a specific month and the previous month*

![image](https://user-images.githubusercontent.com/90646142/141376516-4d323127-7b41-4c9c-8e21-864992b59014.png)

*Using LEAD WINDOW function to the order date and the next order date of each product name*

![image](https://user-images.githubusercontent.com/90646142/141378520-6b3ee72a-7ff8-482b-874f-ce295ebd1ee7.png)

*Convertig varchar dim_date_fkey values from "fact_sales" table intto the DATE values by adding the new column "trans_date" and casting the values from "dim_date_fkey" column*

![image](https://user-images.githubusercontent.com/90646142/141379205-7eb42c15-d4af-4cb0-97b4-7fabe61a65c7.png)

### <a href="https://github.com/an7user/BIMarathon2021/blob/main/advanced.sql">The full script for advanced MySQL statements described in this section</a>

### Data Visualization with Power BI

### <a href="https://app.powerbi.com/view?r=eyJrIjoiMjZhMTY5OGItMmZhMy00ZjgzLWE5YTQtM2I2YjFjMTg5YjkxIiwidCI6IjI0OTc5ODI4LTIwNGUtNDZlYi04ZGM2LWU2Y2ZhNjI4ZGM4MiJ9&pageName=ReportSection">The Dashboard - A4tech Sales Overview Analytics </a>

<a href="https://app.powerbi.com/view?r=eyJrIjoiMjZhMTY5OGItMmZhMy00ZjgzLWE5YTQtM2I2YjFjMTg5YjkxIiwidCI6IjI0OTc5ODI4LTIwNGUtNDZlYi04ZGM2LWU2Y2ZhNjI4ZGM4MiJ9&pageName=ReportSection">![image](https://user-images.githubusercontent.com/90646142/141515893-3e82354a-0e6a-4dfe-b420-abf62540a32b.png)</a>

The Dashboard is the representation of 6 reports.

Report 1 is the general overview of the total sales across different continents, stratified by the total store number, total sales by brand, total sales by country and product type.

![image](https://user-images.githubusercontent.com/90646142/141519692-7e21b8a3-8e69-43ac-a1a2-a0ecf4fd50c6.png)

Report 2 is the further breakdown of the sales including the total and net sales by brand, gross profit percentage for each country where the business is operating, total sales breakdown for each month of 2020, gross profit percentage for each month of 2020.

![image](https://user-images.githubusercontent.com/90646142/141522781-5cdc0f5e-c381-4abe-9ed1-032d8361c31e.png)

Report 3 is the visual representation of the products and product subcategories offered by different manufacturers, gross profit generated by each product class and category and subcategory.

![image](https://user-images.githubusercontent.com/90646142/141523272-bbda8684-aeaa-4481-a903-4ebd81f5362e.png)

Report 4 is the visualization of different discount promotions – duration (days), total discount by brand of the product, number of products with prices over $ 200 offered by the manufacturers as compared to the general number of products offered by the company, discount per unit with the average unit price.

![image](https://user-images.githubusercontent.com/90646142/141524239-2e5707dc-a64a-48f3-b5bc-9c0f38cc4e31.png)

Report 5 is the visual representation of online and retail stores performance by the country, selling area size, total cost as impacted by the store’s selling area size, employee per selling area density.

![image](https://user-images.githubusercontent.com/90646142/141528823-81a604fe-7dd8-41b2-a834-0c84383dc769.png)

