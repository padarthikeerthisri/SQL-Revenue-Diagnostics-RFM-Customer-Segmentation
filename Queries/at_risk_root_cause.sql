-- ============================================================================
-- PHASE 3: CUSTOMER CHURN ROOT CAUSE ANALYSIS
-- Focus: At Risk & Lost Customers
-- Assumes rfm_segments table already exists
-- ============================================================================

USE revenue_analysis;

-- ----------------------------------------------------------------------------
-- 1. Last Purchase Details for At Risk & Lost Customers
-- ----------------------------------------------------------------------------

DROP VIEW IF EXISTS last_purchase_details;

CREATE VIEW last_purchase_details AS
SELECT
    o.customer_id,
    r.customer_name,
    r.segment,
    STR_TO_DATE(o.order_date, '%m/%d/%Y') AS last_order_date,
    o.category,
    o.sub_category,
    o.sales,
    o.discount,
    o.profit,
    o.ship_mode,
    DATEDIFF(
        STR_TO_DATE(o.ship_date, '%m/%d/%Y'),
        STR_TO_DATE(o.order_date, '%m/%d/%Y')
    ) AS shipping_days
FROM orders o
JOIN rfm_segments r
    ON o.customer_id = r.customer_id
WHERE r.segment IN ('At Risk', 'Lost')
AND STR_TO_DATE(o.order_date, '%m/%d/%Y') = (
    SELECT MAX(STR_TO_DATE(o2.order_date, '%m/%d/%Y'))
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

-- ----------------------------------------------------------------------------
-- 2. Shipping Delay Comparison Across Segments
-- ----------------------------------------------------------------------------

SELECT
    r.segment,
    ROUND(AVG(
        DATEDIFF(
            STR_TO_DATE(o.ship_date, '%m/%d/%Y'),
            STR_TO_DATE(o.order_date, '%m/%d/%Y')
        )
    ), 2) AS avg_shipping_days
FROM orders o
JOIN rfm_segments r
    ON o.customer_id = r.customer_id
WHERE r.segment IN ('Champions', 'Loyal Customers', 'At Risk', 'Lost')
GROUP BY r.segment
ORDER BY avg_shipping_days DESC;

-- ----------------------------------------------------------------------------
-- 3. Discount Given on Last Purchase (By Segment)
-- ----------------------------------------------------------------------------

WITH last_discount AS (
    SELECT
        o.customer_id,
        r.segment,
        o.discount,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY STR_TO_DATE(o.order_date, '%m/%d/%Y') DESC
        ) AS rn
    FROM orders o
    JOIN rfm_segments r
        ON o.customer_id = r.customer_id
)
SELECT
    segment,
    ROUND(AVG(discount), 2) AS avg_last_discount
FROM last_discount
WHERE rn = 1
GROUP BY segment
ORDER BY avg_last_discount DESC;

-- ----------------------------------------------------------------------------
-- 4. Category of Last Purchase (Churn Signal)
-- ----------------------------------------------------------------------------

WITH last_category AS (
    SELECT
        o.customer_id,
        r.segment,
        o.category,
        ROW_NUMBER() OVER (
            PARTITION BY o.customer_id
            ORDER BY STR_TO_DATE(o.order_date, '%m/%d/%Y') DESC
        ) AS rn
    FROM orders o
    JOIN rfm_segments r
        ON o.customer_id = r.customer_id
)
SELECT
    segment,
    category,
    COUNT(*) AS customers
FROM last_category
WHERE rn = 1
  AND segment IN ('At Risk', 'Lost', 'Loyal Customers')
GROUP BY segment, category
ORDER BY segment, customers DESC;

-- ----------------------------------------------------------------------------
-- 5. Profitability of Last Purchase (Negative Experience Check)
-- ----------------------------------------------------------------------------

SELECT
    segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_orders,
    ROUND(
        100 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS loss_order_percentage
FROM last_purchase_details
GROUP BY segment
ORDER BY loss_order_percentage DESC;

-- ----------------------------------------------------------------------------
-- 6. High-Value Customers That Were Lost
-- ----------------------------------------------------------------------------

SELECT
    customer_id,
    customer_name,
    segment,
    monetary_value,
    recency,
    frequency
FROM rfm_segments
WHERE segment IN ('Lost', 'At Risk')
  AND monetary_value > (
        SELECT AVG(monetary_value) FROM rfm_segments
  )
ORDER BY monetary_value DESC;

-- ============================================================================
-- END OF PHASE 3
-- ============================================================================
