CREATE DATABASE ecommerce_analytics;

USE ecommerce_analytics;
CREATE TABLE customers (
    customer_id VARCHAR(32) PRIMARY KEY,
    customer_unique_id VARCHAR(32) NOT NULL,
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);
CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat DECIMAL(10, 8),
    geolocation_lng DECIMAL(11, 8),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);
CREATE TABLE sellers (
    seller_id VARCHAR(32) PRIMARY KEY,
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);
CREATE TABLE products (
    product_id VARCHAR(32) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2)
);
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100)
);
CREATE TABLE orders (
    order_id VARCHAR(32) PRIMARY KEY,
    customer_id VARCHAR(32) NOT NULL,
    order_status VARCHAR(30),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);
CREATE TABLE order_items (
    order_id VARCHAR(32),
    order_item_id INT,
    product_id VARCHAR(32) NOT NULL,
    seller_id VARCHAR(32) NOT NULL,
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),

    PRIMARY KEY (order_id, order_item_id),

    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_order_items_seller
        FOREIGN KEY (seller_id)
        REFERENCES sellers(seller_id)
);
CREATE TABLE order_payments (
    order_id VARCHAR(32),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2),

    PRIMARY KEY (order_id, payment_sequential),

    CONSTRAINT fk_order_payments_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);
CREATE TABLE order_reviews (
    review_id VARCHAR(32) NOT NULL,
    order_id VARCHAR(32) NOT NULL,
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME,

    PRIMARY KEY (review_id, order_id),

    CONSTRAINT fk_order_reviews_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);
-- =====================================================
-- 1. BASIC E-COMMERCE PERFORMANCE ANALYSIS
-- =====================================================

-- Total number of orders
SELECT 
    COUNT(*) AS total_orders
FROM orders;

-- Average Order Value (AOV)
SELECT 
    ROUND(SUM(payment_value) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM order_payments;

-- Total Number of Customers
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

-- Total Number of Products
SELECT 
    COUNT(*) AS total_products
FROM products;

-- Total Number of Sellers
SELECT 
    COUNT(*) AS total_sellers
FROM sellers;
-- Total Revenue
SELECT
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM order_payments;


-- =====================================================
-- 2. SALES AND REVENUE ANALYSIS
-- =====================================================

-- Q.1: Monthly Revenue Trend

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    ROUND(SUM(op.payment_value), 2) AS monthly_revenue
FROM orders AS o
JOIN order_payments AS op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- Q.2: Revenue by Product Category

SELECT
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS product_category,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation AS pct
    ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'Unknown'
    )
ORDER BY total_revenue DESC
LIMIT 10;

-- Q.3: Revenue by Payment Type

SELECT
    op.payment_type,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(op.payment_value), 2) AS total_payment_value
FROM orders AS o
JOIN order_payments AS op
    ON o.order_id = op.order_id
WHERE o.order_status = 'delivered'
GROUP BY op.payment_type
ORDER BY total_payment_value DESC;


-- Q.4: Revenue by Customer State

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Q.5: Top 10 Sellers by Item Revenue

SELECT
    s.seller_id,
    s.seller_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN sellers AS s
    ON oi.seller_id = s.seller_id
WHERE o.order_status = 'delivered'
GROUP BY
    s.seller_id,
    s.seller_state
ORDER BY total_revenue DESC
LIMIT 10;

-- Q.6:Monthly Order Volume and Average Order Value

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_item_revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;


-- Q.7: One-Time vs Repeat Customers

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.price) AS total_item_revenue
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_item_revenue), 2) AS total_item_revenue,
    ROUND(AVG(total_item_revenue), 2) AS average_revenue_per_customer
FROM customer_orders
GROUP BY
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END
ORDER BY total_customers DESC;


-- Q.8: Top 10 Product Categories by Order Volume

SELECT
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS product_category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(*) AS total_items_sold
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation AS pct
    ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'Unknown'
    )
ORDER BY total_orders DESC
LIMIT 10;

-- Q.9: Average Item Revenue per Order by Category

SELECT
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'Unknown'
    ) AS product_category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_item_revenue,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_item_revenue_per_order
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation AS pct
    ON p.product_category_name = pct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY
    COALESCE(
        pct.product_category_name_english,
        p.product_category_name,
        'Unknown'
    )
ORDER BY average_item_revenue_per_order DESC
LIMIT 10;


-- Q.10: Average Delivery Time by Month

SELECT
    DATE_FORMAT(
        o.order_purchase_timestamp,
        '%Y-%m'
    ) AS order_month,
    COUNT(*) AS delivered_orders,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),
        2
    ) AS avg_delivery_days
FROM orders AS o
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_purchase_timestamp IS NOT NULL
GROUP BY DATE_FORMAT(
    o.order_purchase_timestamp,
    '%Y-%m'
)
ORDER BY order_month;


-- Q11: On-Time vs. Late Delivery Performance

SELECT
    COUNT(*) AS total_delivered_orders,

    SUM(
        CASE
            WHEN order_delivered_customer_date >
                 order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS late_orders,

    SUM(
        CASE
            WHEN order_delivered_customer_date <=
                 order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS on_time_or_early_orders,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_delivered_customer_date >
                     order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage,

    ROUND(
        AVG(
            CASE
                WHEN order_delivered_customer_date >
                     order_estimated_delivery_date
                THEN DATEDIFF(
                    order_delivered_customer_date,
                    order_estimated_delivery_date
                )
            END
        ),
        2
    ) AS avg_days_late

FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;


-- Q12: Late Delivery Performance by Customer State

SELECT
    c.customer_state,
    COUNT(*) AS total_delivered_orders,

    SUM(
        CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS late_orders,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage,

    ROUND(
        AVG(
            CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN DATEDIFF(
                    o.order_delivered_customer_date,
                    o.order_estimated_delivery_date
                )
            END
        ),
        2
    ) AS avg_days_late

FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL

GROUP BY c.customer_state

HAVING COUNT(*) >= 1000

ORDER BY late_delivery_percentage DESC;


-- Q13: Monthly Late Delivery Rate

SELECT
    DATE_FORMAT(
        o.order_purchase_timestamp,
        '%Y-%m'
    ) AS order_month,

    COUNT(*) AS total_delivered_orders,

    SUM(
        CASE
            WHEN o.order_delivered_customer_date >
                 o.order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS late_orders,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN o.order_delivered_customer_date >
                     o.order_estimated_delivery_date
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS late_delivery_percentage

FROM orders AS o

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
  AND o.order_purchase_timestamp IS NOT NULL

GROUP BY DATE_FORMAT(
    o.order_purchase_timestamp,
    '%Y-%m'
)

ORDER BY order_month;

-- Q14: Revenue Analysis by Product Category

SELECT
    COALESCE(
        p.product_category_name,
        'Unknown'
    ) AS product_category,

    ROUND(
        SUM(oi.price),
        2
    ) AS total_revenue,

    COUNT(DISTINCT oi.order_id) AS total_orders,

    COUNT(*) AS total_items_sold

FROM order_items AS oi

JOIN products AS p
    ON oi.product_id = p.product_id

GROUP BY COALESCE(
    p.product_category_name,
    'Unknown'
)

ORDER BY total_revenue DESC

LIMIT 10;


-- Q15: Revenue by Order Status

SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(oi.price),
        2
    ) AS total_item_revenue
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY o.order_status
ORDER BY total_item_revenue DESC;


-- Q16: Customer Review Score Analysis

SELECT
    r.review_score,
    COUNT(*) AS total_reviews,

    ROUND(
        100.0 * COUNT(*) / (
            SELECT COUNT(*)
            FROM order_reviews
            WHERE review_score IS NOT NULL
        ),
        2
    ) AS review_percentage

FROM order_reviews AS r

WHERE r.review_score IS NOT NULL

GROUP BY r.review_score

ORDER BY r.review_score DESC;


-- Q17: Monthly Revenue Growth Rate

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
        ROUND(SUM(oi.price), 2) AS total_revenue
    FROM orders AS o
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
),

revenue_comparison AS (
    SELECT
        order_month,
        total_revenue,
        LAG(total_revenue) OVER (
            ORDER BY order_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)

SELECT
    order_month,
    total_revenue,
    previous_month_revenue,
    ROUND(
        100.0 * (total_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS revenue_growth_percentage
FROM revenue_comparison
ORDER BY order_month;

-- Q18: Average Order Value by Customer State

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(
        SUM(oi.price) / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
HAVING COUNT(DISTINCT o.order_id) >= 100
ORDER BY average_order_value DESC;