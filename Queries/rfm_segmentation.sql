-- ============================================
-- PHASE 2: RFM SEGMENTATION (FINAL, CORRECTED)
-- ============================================

DROP TABLE IF EXISTS rfm_segments;

CREATE TABLE rfm_segments AS
WITH cleaned AS (
    SELECT
        customer_id,
        customer_name,
        STR_TO_DATE(order_date, '%m/%d/%Y') AS order_dt,
        sales
    FROM orders
),

max_date AS (
    SELECT MAX(order_dt) AS last_date FROM cleaned
),

rfm_stage AS (
    SELECT
        customer_id,
        customer_name,
        MAX(order_dt) AS last_order_date,
        COUNT(*) AS frequency,
        SUM(sales) AS monetary_value
    FROM cleaned
    GROUP BY customer_id, customer_name
),

rfm_raw AS (
    SELECT
        r.customer_id,
        r.customer_name,
        DATEDIFF(m.last_date, r.last_order_date) AS recency,
        r.frequency,
        r.monetary_value
    FROM rfm_stage r
    CROSS JOIN max_date m
),

rfm_scored AS (
    SELECT
        *,
        NTILE(5) OVER (ORDER BY recency DESC)        AS r_score,
        NTILE(5) OVER (ORDER BY frequency DESC)      AS f_score,
        NTILE(5) OVER (ORDER BY monetary_value DESC) AS m_score
    FROM rfm_raw
)

SELECT
    customer_id,
    customer_name,
    recency,
    frequency,
    monetary_value,
    r_score,
    f_score,
    m_score,
    (r_score + f_score + m_score) AS total_rfm_score,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4
            THEN 'Champions'
        WHEN r_score >= 4 AND f_score >= 3
            THEN 'Loyal Customers'
        WHEN m_score >= 4 AND frequency >= 3
            THEN 'Big Spenders'
        WHEN r_score >= 4 AND f_score <= 2
            THEN 'Potential Loyalists'
        WHEN r_score <= 2 AND (f_score >= 3 OR m_score >= 3)
            THEN 'At Risk'
        WHEN r_score = 1 AND f_score <= 2 AND m_score <= 2
            THEN 'Lost'
        ELSE 'Others'
    END AS segment
FROM rfm_scored;
