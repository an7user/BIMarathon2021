# BIMarathon2021

Best performing supermarket branch

Project mission and goal

The growth of supermarkets in most populated cities is increasing and market competition among them is tough. The dataset is based on the sales transactions history of 3 different supermarket branches, collected for 3 consequitive months od 2019. 

Goal:

- analyze a top performing supermarket branch in Yangon, Naypyitaw, Mandalay cities. 
- find correlation of most popular product groups in each supermarket branch
- analyze customer satisfaction indicator regarding each group of products

Project attributes (dimensions and facts)

Dimensions:

Dim_Invoice (PK_Invoice_ID, Invoice, Payment, Product Line)
Dim_Customer (PK_Customer_ID, Gender, Membership)
Dim_Location (PK_Location_ID, Branch, City)
Facts: 

Facts:

FK_1_Invoice_ID

FK_2_Customer_ID

FK_3_Location_ID

Gross Income

Gross margin percentage

Quantity

Unit price

Date

Time

Rating

Tax

************************************************************************************
Metrics to analyze:

Will be comparaing branch supermarkets performance by modeling, benchmarking and analyzing gross income margin based on the metrics number of products purchased by customers, price of each product purchased by a customer, tax fee and subtracting the cost of goods sold at each branch.
