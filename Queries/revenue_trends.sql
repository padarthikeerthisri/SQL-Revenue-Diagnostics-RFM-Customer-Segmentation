-- 1. Monthly Revenue Trend
SELECT 
    DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m') AS month,
    SUM(sales) AS total_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- 2. Year-over-Year Revenue Trend
SELECT 
    YEAR(STR_TO_DATE(order_date, '%m/%d/%Y')) AS year,
    SUM(sales) AS revenue
FROM orders
GROUP BY year
ORDER BY year;

-- 3. Category-wise Revenue
SELECT 
    category,
    SUM(sales) AS revenue,
    SUM(profit) AS total_profit
FROM orders
GROUP BY category
ORDER BY revenue DESC;

-- 4. Region-wise Revenue
SELECT 
    region,
    SUM(sales) AS revenue,
    SUM(profit) AS total_profit
FROM orders
GROUP BY region
ORDER BY revenue DESC;

-- 5. Declining Months Using LAG
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m') AS month,
        SUM(sales) AS revenue
    FROM orders
    GROUP BY month
),
lagged AS (
    SELECT 
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS prev_revenue
    FROM monthly_revenue
)
SELECT 
    month,
    revenue,
    prev_revenue,
    (revenue - prev_revenue) AS difference
FROM lagged
WHERE revenue < prev_revenue;

-- 6. Category-wise Monthly Revenue (Ranked High → Low)
SELECT
    category,
    DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m') AS month,
    SUM(sales) AS total_revenue
FROM orders
GROUP BY category, month
ORDER BY category ASC, total_revenue DESC;

-- 7. Day-of-Month Revenue (1–31 Insight)
SELECT
    DAY(STR_TO_DATE(order_date, '%m/%d/%Y')) AS day_of_month,
    SUM(sales) AS total_revenue,
    COUNT(*) AS total_orders
FROM orders
GROUP BY day_of_month
ORDER BY total_revenue DESC;