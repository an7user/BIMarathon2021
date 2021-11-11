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

### <a href="https://github.com/an7user/BIMarathon2021/blob/main/dataset.zip"> The dataset for the project can be foung follwing this link. </a>

### Physical Data Model (A4tech Sales Physical model)

Out database will be based on a snowflake schema as the product and store dimensions have hierarchical subdimensions as shown in the images below.

![sales_physical](https://user-images.githubusercontent.com/90646142/141209407-653c38e6-e6e5-44fb-84c6-ad17e4375e91.png)

<a href="https://github.com/an7user/BIMarathon2021/blob/main/schema_creation.sql">SQL script (Creating schema, fact and
dimension tables)</a>

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

*USING NULLIF function to substitute the 'European Spring Promotion' promotion name in table: "dim_promotion" with `NULL`*

![image](https://user-images.githubusercontent.com/90646142/141214953-a497c590-9a48-465a-ad95-02b11f18facc.png)

### The full script for finding duplicates can be found <a href="https://github.com/an7user/BIMarathon2021/blob/main/duplicates_check.sql">here</a>.

### Using advanced SQL functions to analyze the dataset

*Using CASE WHEN function to find the best product for income generation (highest price and the biggest amount sold)*

![image](https://user-images.githubusercontent.com/90646142/141214120-bbfd8fcf-8195-4d97-9a07-bb82a0d96a3f.png)
