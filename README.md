# Bike Store Sales Analysis

## Table of Contents
- [Introduction](#introduction)
- [Dataset](#dataset)
- [Database Creation](#database-creation)
- [Data Import](#data-import)
- [Business Questions](#business-questions)
- [Insights](#insights)
- [Power BI Dashboard](#power-bi-dashboard)
- [Conclusion](#conclusion)
- [License](#license)
- [Example SQL Queries](#example-sql-queries)

## Introduction
This project is an analysis of a bike store's sales data using SQL and Power BI. The objective is to extract valuable business insights to help increase sales and profitability. The analysis covers aspects like bestsellers, top stores, customer segmentation, revenue trends, and more.

## Dataset
The dataset consists of the following tables:
- **Customers**: Information about customers
- **Orders**: Order details
- **Order_Items**: Items included in each order
- **Products**: Details of products sold
- **Categories**: Categories of products
- **Stores****: Store details
- **Staff**: Information about staff members

## Database Creation
The database schema is created using SQL. The structure includes tables for customers, orders, order items, products, categories, stores, and staff. Each table is designed with relevant attributes and primary/foreign keys to establish relationships.

## Data Import
Data was imported into the database from various source files. The data was cleaned and transformed to fit the database schema.

##Business Question
1. Which products are the top 5 bestsellers?
2. What are the top stores in terms of sales revenue?
3. Which categories of products are the most popular?
4. Deviving cusyomers into tupers according to their purchase quantity.
5. What are the purchasing patterns of high-value customers and how can they be incentivized to increase their purchase frequency?
6.How did monthly sales revenue trend in 2016 and 2017, and what strategies can be implemented to capitalize on periods of high revenue?

## Insights
1. **Bestselling Products**: The top 5 bestselling products are priced well below the average list price, indicating a preference for affordable products.
2. **Top-Selling Brands**: Baldwin Bikes emerged as the top-selling brand, significantly outperforming competitors.
3. **Popular Categories**: Cruiser Bicycles are the most popular, with Electra leading within this category.
4. **Customer Segmentation**: Silver customers are the largest group, showing a preference for affordable Electra brand bikes.
5. **Customer Behavior**: High-value customers make fewer, larger purchases over longer timeframes.
6. **Revenue Trends**: There was a notable increase in revenue from 2016 to 2017, with a 42.2% increase in average monthly revenue.

## PowerBi Dashboard
A Power BI dashboard was created to visualize the analysis results. The dashboard includes various interactive visuals like bar charts, pie charts, line charts, and more, with slicers for dynamic filtering.

  ### Visuals Included:
    Bestselling Products Bar Chart
    Top-Selling Brands Pie Chart
    Popular Product Categories Column Chart
    Customer Segmentation Stacked Bar Chart
    Revenue Trends Line Chart
    Customer Behavior Patterns Table
    High Revenue Periods Area Chart
  ### Slicers:
    Date
    Customer Segment
    Product Category
    Brand
    Store Location
    Customer City

## Conclusion
The analysis of the bike store data reveals several critical insights into customer purchasing behavior, product popularity, and revenue trends over 2016 and 2017. Key findings indicate a preference for lower-priced products, a dominant market position for Baldwin Bikes, and significant popularity for Cruiser Bicycles, especially those from the Electra brand. Furthermore, Silver customers form the largest customer segment, showing a strong inclination towards the affordability of Electra bikes. The revenue analysis highlights a substantial increase in both average monthly and total annual revenue from 2016 to 2017, underscoring successful business strategies and growth.


## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contact
For any questions or inquiries, please contact [Ritik Sunil Khapre](mailto:ritik.khapre5202.com).
