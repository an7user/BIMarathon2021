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
9.	
### Metrics to analyze:

Total and net sales by brand, gross profit percentage by country, total sales by month, gross profit percentage by month, gross profit percentage by product subcategory, average discount by promotion, total discount amount offered by brand, total cost of sales per store in relation to the selling area size and number of employees, total sales by store type.

### <a href="https://github.com/an7user/BIMarathon2021/blob/main/dataset.zip"> The dataset for the project can be foung follwing this link. </a>

### Physical Data Model (A4tech Sales Physical model)

Out database will be based on a snowflake schema as the product and store dimensions have hierarchical subdimensions as shown in the images below.

![sales_physical](https://user-images.githubusercontent.com/90646142/141209407-653c38e6-e6e5-44fb-84c6-ad17e4375e91.png)

