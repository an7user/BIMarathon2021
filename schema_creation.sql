CREATE DATABASE  IF NOT EXISTS `bi_mm_ruslan`;
use `bi_mm_ruslan`;

-- CREATING Dimension table "dim_geo" --

DROP TABLE IF EXISTS `dim_geo`;

CREATE TABLE `dim_geo` (
`geo_id` int NOT NULL,
  `geo_type` varchar(30) DEFAULT NULL,
  `continent` varchar(30) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
   PRIMARY KEY (`geo_id`)
);

-- CREATING Dimension table 'dim_store' --

DROP TABLE IF EXISTS `dim_store`;

CREATE TABLE `dim_store` (
  `store_id`int NOT NULL,
  `geo_fkey`int,	
  `store_type` varchar(20),	
  `store_name` varchar(50),	
  `status`varchar(10),
  `employee_count`int,
  `selling_area_size`int,
   PRIMARY KEY (`store_id`),
   foreign key (`geo_fkey`) references dim_geo (`geo_id`) ON DELETE SET NULL
);

-- CREATING Dimension table "dim_product_cat" --

DROP TABLE IF EXISTS `dim_product_cat`;

CREATE TABLE `dim_product_cat` (
`product_cat_id` int NOT NULL,
  `product_cat` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`product_cat_id`)
);

-- CREATING Dimension table "dim_product_sub_cat" --

DROP TABLE IF EXISTS `dim_product_sub_cat`;

CREATE TABLE `dim_product_sub_cat` (
`product_sub_cat_id` int NOT NULL,
  `product_sub_cat` varchar(30) DEFAULT NULL,
  `product_cat_fkey` int,
   PRIMARY KEY (`product_sub_cat_id`),
   foreign key (`product_cat_fkey`) references dim_product_cat (`product_cat_id`) ON DELETE SET NULL
);

-- CREATING Dimension table "dim_product" --

DROP TABLE IF EXISTS `dim_product`;

CREATE TABLE `dim_product` (
  `name` TEXT DEFAULT NULL,
  `description` TEXT DEFAULT NULL,
  `manufacturer` varchar(30) DEFAULT NULL,
  `brand`varchar(30) DEFAULT NULL,
  `class_name`varchar(20) DEFAULT NULL,
  `unit_cost` decimal(10, 2),
  `unit_price`decimal(10, 2),
  `product_id` int NOT NULL,
  `product_sub_cat_fkey` int,
   PRIMARY KEY (`product_id`),
   foreign key (`product_sub_cat_fkey`) references dim_product_sub_cat (`product_sub_cat_id`) ON DELETE SET NULL
);

-- CREATING Dimension table "dim_promotion" --

DROP TABLE IF EXISTS `dim_promotion`;

CREATE TABLE `dim_promotion` (
`promotion_id` int NOT NULL,
`promo_name` varchar(30) DEFAULT NULL,
`discount_percent` decimal(8,2), 
`start_date` varchar(30) DEFAULT NULL,
`end_date` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`promotion_id`)
);


-- CREATING fact table "fact_sales" --

DROP TABLE IF EXISTS `fact_sales`;

CREATE TABLE `fact_sales` (
`fact_sales_id` int NOT NULL AUTO_INCREMENT,
`dim_date_fkey`varchar(30),
`dim_store_fkey`int,
`dim_product_fkey`int,
`dim_promotion_fkey`int,
`unit_cost`decimal(10,2),
`unit_price`decimal(10,2),
`sales_quantity`int,
`discount_amount`decimal(10,2),
`total_cost`decimal(10,2),
`sales_amount`decimal(10,2),
PRIMARY KEY (`fact_sales_id`),
 foreign key (`dim_store_fkey`) references dim_store (`store_id`) ON DELETE SET NULL,
 foreign key (`dim_product_fkey`) references dim_product (`product_id`) ON DELETE SET NULL,
foreign key (`dim_promotion_fkey`) references dim_promotion (`promotion_id`) ON DELETE SET NULL
);

