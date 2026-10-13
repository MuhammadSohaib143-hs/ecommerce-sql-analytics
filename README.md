# E-commerce SQL Analytics

## 1. Project Overview

This project analyzes the Brazilian E-Commerce Public Dataset by Olist using Python and MySQL. The objective is to evaluate e-commerce performance and extract actionable business insights related to revenue, customers, product categories, sellers, customer reviews, and delivery operations.

The project follows a practical data analytics workflow: loading CSV files into MySQL using Python, analyzing the data with SQL, and documenting the results and their business implications.

## 2. Project Objectives

- Analyze overall e-commerce performance.
- Identify revenue trends and high-performing product categories.
- Evaluate customer purchasing and repeat-order behavior.
- Compare seller and payment-method performance.
- Measure delivery times and late-delivery rates.
- Analyze customer review scores.
- Translate SQL results into meaningful business recommendations.

## 3. Tools and Technologies

- **Python** — Data loading and database connectivity
- **Pandas** — Reading and processing CSV files
- **SQLAlchemy** — Connecting Python to MySQL
- **MySQL** — Relational database and SQL analytics
- **MySQL Workbench** — Query execution and database management
- **Jupyter Notebook** — Documenting the Python workflow
- **Git and GitHub** — Version control and project documentation

## 4. Dataset

**Dataset:** Brazilian E-Commerce Public Dataset by Olist

**Source:** [Kaggle — Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

The dataset contains information about orders, customers, sellers, products, payments, reviews, and geographical locations.

Nine CSV files are loaded into the `ecommerce_analytics` MySQL database:

1. `customers`
2. `geolocation`
3. `sellers`
4. `products`
5. `product_category_name_translation`
6. `orders`
7. `order_items`
8. `order_payments`
9. `order_reviews`

## 5. Project Structure

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
|   | └── BASIC E-COMMERCE PERFORMANCE ANALYSIS
|   └──     
│
├── screenshots/
│
└── README.md
```

- **python/** — Python notebook for CSV loading and MySQL connectivity.
- **sql/** — SQL queries used to analyze business performance.
- **results/** — Query outputs and analysis results.
- **screenshots/** — Screenshots documenting query execution and findings.
- **README.md** — Project documentation and progress tracking.

## 6. Data Analytics Workflow

1. Download the Olist dataset from Kaggle.
2. Read the CSV files using Python and Pandas.
3. Connect Python to MySQL using SQLAlchemy.
4. Load the nine datasets into the `ecommerce_analytics` database.
5. Execute SQL queries to answer business questions.
6. Review query outputs and interpret the results.
7. Document key findings, business benefits, and recommendations.
8. Update the project documentation as additional analysis is completed.

## 7. Initial E-commerce Performance Metrics

The initial performance analysis examines these six metrics:

| Metric | Business purpose |
|---|---|
| Total Orders | Measure overall order volume |
| Total Revenue | Establish the overall revenue baseline |
| Average Order Value (AOV) | Measure average revenue per order |
| Total Customers | Assess the customer base represented in the data |
| Total Products | Understand the number of products represented |
| Total Sellers | Assess the size of the seller base |

The initial SQL analysis produced these results:

| Metric | Result |
|---|---:|
| Total Orders | 99,441 |
| Total Revenue | 16,008,872.12 |
| Average Order Value | 160.99 |
| Total Customers | 99,441 |
| Total Products | 32,951 |
| Total Sellers | 3,095 |

**Note:** Revenue and AOV should be interpreted according to the calculation used in the initial SQL analysis. The dataset includes multiple payment records and order items, so different revenue definitions can produce different totals.

## 8. SQL Business Questions

The following questions reflect the current SQL analysis. We will update this list as new queries are completed or existing queries are improved.

### A. Sales and Revenue Analysis

**Q1. Monthly Revenue Analysis Using Payment Values**

- How does monthly revenue change over time when revenue is calculated from payment records?
- Business value: Identify revenue trends and periods of higher or lower sales.

**Q2. Revenue by Product Category**

- Which translated product categories generate the highest revenue among delivered orders?
- Business value: Identify high-revenue categories for merchandising and sales planning.

**Q3. Revenue by Payment Method**

- Which payment methods contribute the most revenue?
- Business value: Understand payment preferences and evaluate payment-channel performance.

**Q4. Revenue by Customer State**

- Which Brazilian states generate the highest revenue?
- Business value: Identify important geographic markets and regional opportunities.

**Q5. Top Sellers by Item Revenue**

- Which sellers generate the highest revenue from their sold items?
- Business value: Identify high-performing sellers and opportunities to strengthen seller relationships.

**Q6. Monthly Order Volume, Item Revenue, and Average Order Value**

- How do monthly order counts, item revenue, and average order value change over time?
- Business value: Evaluate sales activity and purchasing trends together.

### B. Customer and Product Analysis

**Q7. One-Time vs. Repeat Customers**

- How many customers place only one order compared with customers who place multiple orders?
- Business value: Understand repeat-purchase behavior and opportunities to improve retention.

**Q8. Top Product Categories by Order Volume**

- Which product categories receive the highest number of orders?
- Business value: Identify popular categories for inventory and demand planning.

**Q9. Average Item Revenue per Order by Category**

- How does average item revenue per order differ across product categories?
- Business value: Compare category-level order value and identify opportunities to increase basket value.

### C. Delivery and Operational Analysis

**Q10. Average Delivery Time by Month**

- How does the average delivery time change from month to month?
- Business value: Monitor delivery efficiency and identify periods requiring operational improvement.

**Q11. Overall On-Time vs. Late Delivery Performance**

- What proportion of delivered orders arrive on time compared with those that arrive late?
- Business value: Establish a baseline for delivery reliability.

**Q12. Late-Delivery Performance by Customer State**

- Which customer states have higher late-delivery rates among states with at least 1,000 eligible delivered orders?
- Business value: Identify geographic areas where logistics performance may need improvement.

**Q13. Monthly Late-Delivery Rate**

- How does the percentage of late deliveries change over time?
- Business value: Detect changes in delivery reliability and evaluate operational trends.

### D. Additional Revenue and Customer Satisfaction Analysis

**Q14. Top Product Categories by Item Revenue**

- Which product categories generate the highest item revenue, based on item-level prices?
- Business value: Compare category performance using item revenue.
- Documentation note: This overlaps with Q2, but uses a different revenue definition and filtering approach. We may refine or consolidate these questions as the analysis develops.

**Q15. Monthly Revenue Trend Using Item Prices**

- How does monthly item revenue change when revenue is calculated from order-item prices for delivered orders?
- Business value: Track delivered-order sales trends.
- Documentation note: This overlaps with Q1 and Q6 but uses item prices rather than payment values. Results should not be treated as directly interchangeable.

**Next planned question — Customer Review Score Distribution**

- How are customer reviews distributed across scores from 1 to 5?
- Business value: Understand customer satisfaction patterns and identify the prevalence of low and high ratings.
- Status: Planned for the next stage of analysis.

## 9. SQL Concepts Demonstrated

The project provides practical experience with:

- `SELECT`, `WHERE`, `ORDER BY`, and `GROUP BY`
- Aggregate functions such as `COUNT()`, `SUM()`, and `AVG()`
- Joins across relational tables
- Date extraction and monthly aggregation
- Conditional logic using `CASE`
- Common Table Expressions (CTEs)
- Window functions, including `ROW_NUMBER()`
- Revenue calculations and average order value
- Customer-level aggregation
- Delivery performance metrics
- Percentage and rate calculations

## 10. Results and Business Findings

Query results and screenshots will be added to the `results/` and `screenshots/` folders as they are prepared.

For each important analysis, the documentation will aim to capture:

1. **Business question** — The problem being investigated.
2. **SQL approach** — The tables, joins, filters, and calculations used.
3. **Key result** — The verified output of the query.
4. **Business interpretation** — What the result means.
5. **Business benefit** — What decision the analysis can support.

Findings and recommendations will be added only after the corresponding results have been verified.

## 11. How to Run the Project

1. Download the dataset from Kaggle.
2. Install Python and the required libraries, including Pandas and SQLAlchemy.
3. Install and configure MySQL.
4. Create the `ecommerce_analytics` database.
5. Update the database connection settings and CSV file paths in the notebook.
6. Run `python/mysql_connection_ecommerce_analytics.ipynb` to load the data.
7. Open `sql/ecommerece_sql_analytics.sql` in MySQL Workbench.
8. Execute the queries and review their outputs.

**Security note:** Do not commit database passwords, API keys, or other credentials to GitHub.

## 12. Project Progress

- [x] Load the nine Olist CSV datasets into MySQL.
- [x] Complete the initial performance metrics.
- [x] Create the Python database-loading notebook.
- [x] Create the SQL analytics script.
- [x] Upload the project files to GitHub's `main` branch.
- [ ] Document verified results for each business question.
- [ ] Add useful query outputs and screenshots.
- [ ] Refine overlapping revenue analyses where appropriate.
- [ ] Complete the planned customer review score analysis.
- [ ] Add consolidated findings and business recommendations.

This progress checklist will be updated as the project develops.

## 13. Author

**Sohaib**

GitHub: [MuhammadSohaib143-hs](https://github.com/MuhammadSohaib143-hs)
