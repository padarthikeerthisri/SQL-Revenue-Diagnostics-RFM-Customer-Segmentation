-- ============================================
-- PHASE 2: RFM ANALYSIS & BUSINESS METRICS
-- ============================================

-- Segment distribution
SELECT
    segment,
    COUNT(*) AS customers
FROM rfm_segments
GROUP BY segment
ORDER BY customers DESC;

-- Segment value summary
SELECT
    segment,
    ROUND(AVG(recency),1) AS avg_recency,
    ROUND(AVG(frequency),1) AS avg_orders,
    ROUND(AVG(monetary_value),2) AS avg_spend,
    ROUND(SUM(monetary_value),2) AS total_revenue
FROM rfm_segments
GROUP BY segment
ORDER BY avg_recency DESC;

-- Revenue contribution %
SELECT
    segment,
    ROUND(SUM(monetary_value),2) AS revenue,
    ROUND(
        SUM(monetary_value) /
        SUM(SUM(monetary_value)) OVER () * 100, 2
    ) AS revenue_pct
FROM rfm_segments
GROUP BY segment
ORDER BY revenue DESC;

-- Risk exposure index
SELECT
    segment,
    ROUND(SUM(monetary_value),2) AS revenue,
    ROUND(AVG(recency),1) AS avg_recency,
    ROUND(SUM(monetary_value) * AVG(recency), 0) AS risk_index
FROM rfm_segments
GROUP BY segment
ORDER BY risk_index DESC;

-- Top 10 customers per segment
SELECT *
FROM (
    SELECT
        customer_id,
        customer_name,
        segment,
        monetary_value,
        ROW_NUMBER() OVER (PARTITION BY segment ORDER BY monetary_value DESC) AS rn
    FROM rfm_segments
) t
WHERE rn <= 10
ORDER BY segment, monetary_value DESC;
