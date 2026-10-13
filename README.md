# E-commerce SQL Analytics

## Project Overview

This project analyzes the Brazilian E-Commerce Public Dataset by Olist using MySQL to identify business trends, evaluate sales performance, and investigate customer behavior and delivery operations.

The project follows a practical data analytics workflow: loading raw CSV files into MySQL, writing SQL queries to answer business questions, and exporting query results as CSV files for reporting and further analysis.

## Business Objectives

- Measure overall e-commerce performance.
- Analyze monthly revenue and order trends.
- Identify high-performing product categories and sellers.
- Understand payment methods and customer purchasing patterns.
- Evaluate delivery times and late-delivery performance.
- Analyze customer review scores to understand customer experience.

## Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains information about orders, customers, sellers, products, payments, reviews, and geographic locations.

Nine CSV datasets were loaded into MySQL:

1. `customers`
2. `geolocation`
3. `sellers`
4. `products`
5. `product_category_name_translation`
6. `orders`
7. `order_items`
8. `order_payments`
9. `order_reviews`

## Tools and Technologies

- **MySQL 8.0** — SQL querying and business analysis
- **Python** — data loading and database connection
- **Pandas** — CSV data handling
- **SQLAlchemy** — Python-to-MySQL connection
- **Jupyter Notebook** — data-loading workflow
- **Git and GitHub** — version control and project hosting
- **CSV** — exported query results

## Initial Performance Metrics

| Metric | Result |
|---|---:|
| Total Orders | 99,441 |
| Total Revenue | 16,008,872.12 |
| Average Order Value | 160.99 |
| Total Customers | 99,441 |
| Total Products | 32,951 |
| Total Sellers | 3,095 |

*Note: Revenue and average order value depend on the calculation used in each query. Payment values and item prices represent different measures and should not be treated as interchangeable.*

## SQL Business Questions

### 1. Basic E-commerce Performance Analysis

- Calculate total orders.
- Calculate total revenue.
- Calculate average order value.
- Count total customers.
- Count total products.
- Count total sellers.

### 2. Sales and Revenue Analysis

**Q1. Monthly Revenue Analysis**  
Analyze revenue generated in each month using payment values.

**Q2. Revenue by Product Category**  
Identify product categories generating the most revenue for delivered orders.

**Q3. Revenue by Payment Type**  
Compare revenue across payment methods.

**Q4. Revenue by Customer State**  
Identify the customer states contributing the most revenue.

**Q5. Top 10 Sellers by Item Revenue**  
Rank sellers according to revenue generated from their sold items.

**Q6. Monthly Order Volume and Average Order Value**  
Compare monthly order volume, item revenue, and average order value.

**Q7. One-Time vs. Repeat Customers**  
Measure how many customers placed one order compared with customers who placed multiple orders.

**Q8. Top 10 Product Categories by Order Volume**  
Identify categories with the highest order-item volume.

**Q9. Average Item Revenue per Order by Category**  
Compare average item revenue per order across product categories.

### 3. Delivery Performance Analysis

**Q10. Average Delivery Time by Month**  
Analyze the average delivery duration over time.

**Q11. On-Time vs. Late Delivery Performance**  
Measure delivered orders against their estimated delivery dates.

**Q12. Late Delivery Performance by Customer State**  
Compare late-delivery rates and average delay across customer states, restricting the analysis to states with at least 1,000 eligible delivered orders.

**Q13. Monthly Late-Delivery Rate**  
Track how late-delivery performance changes from month to month.

### 4. Additional Revenue Analysis

**Q14. Top Product Categories by Item Revenue**  
Rank product categories by item-price revenue and compare their order and item volumes.

**Q15. Monthly Revenue Trend for Delivered Orders**  
Analyze monthly item-price revenue for delivered orders, independently of the payment-value analysis.

### 5. Customer Review Analysis

**Q16. Customer Review Score Distribution**  
Calculate the number and percentage of reviews for each review score to understand the distribution of customer feedback.

*Q16 is planned until the query has been executed and its output verified.*

## Project Structure

```text
ecommerce-sql-analytics/
│
├── python/
│   └── mysql_connection_ecommerce_analytics.ipynb
│
├── sql/
│   └── ecommerece_sql_analytics.sql
│
├── results/
│   ├── BASIC E-COMMERCE PERFORMANCE ANALYSIS/
│   │   ├── average_order_value.csv
│   │   ├── total_customers.csv
│   │   ├── total_products.csv
│   │   ├── total_revenue.csv
│   │   └── total_sellers.csv
│   │
│   └── SALES AND REVENUE ANALYSIS/
│       ├── Average Delivery Time by Month.csv
│       ├── Late Delivery Performance by Customer State.csv
│       ├── Monthly Order Volume and Average Order Value.csv
│       ├── Monthly Revenue Trend.csv
│       ├── On-Time vs. Late Delivery Performance.csv
│       ├── One-Time vs Repeat Customers.csv
│       ├── Revenue by Customer State.csv
│       ├── Revenue by Payment Type.csv
│       ├── Revenue by Product Category.csv
│       ├── Top 10 Product Categories by Order Volume.csv
│       └── Top 10 Sellers by Item Revenue.csv
│
└── README.md
```

## Business Value

This analysis can help e-commerce stakeholders:

- **Improve sales planning:** Identify monthly revenue trends and high-performing categories.
- **Optimize product strategy:** Understand which categories contribute the most revenue and order volume.
- **Evaluate seller performance:** Identify leading sellers and compare their item revenue.
- **Understand customers:** Measure repeat purchasing and examine review-score distribution.
- **Improve logistics:** Identify locations and periods associated with higher late-delivery rates.
- **Support decisions with data:** Convert raw transactional records into measurable business indicators.

These findings describe historical patterns in the dataset. They can inform business decisions but do not, by themselves, establish causal relationships.

## Skills Demonstrated

- SQL aggregations and grouping
- Filtering and conditional logic
- Multi-table joins
- Date and time analysis
- Common table expressions and window functions
- Ranking and customer segmentation
- Revenue and KPI calculations
- Business-oriented data analysis
- Python database integration
- Exporting query results for reporting
- Git and GitHub version control

## Current Project Status

- [x] Load nine CSV datasets into MySQL.
- [x] Complete initial e-commerce performance metrics.
- [x] Develop SQL analyses for sales, customers, categories, sellers, and delivery performance.
- [x] Export multiple query results to CSV files.
- [ ] Execute and verify the customer review score distribution query.
- [ ] Complete the final documentation with verified findings and business recommendations.

## Author

**Sohaib**

GitHub: [MuhammadSohaib143-hs](https://github.com/MuhammadSohaib143-hs)

## Disclaimer

This project is for educational and portfolio purposes. The analysis is based on the publicly available Olist dataset and reflects the data and definitions used in the SQL queries.
