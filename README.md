# SQL Revenue Diagnostics & RFM Customer Segmentation

This project demonstrates an end-to-end **SQL-driven business analytics workflow**
using the *Sample Superstore* dataset.  
The objective is to move beyond descriptive reporting and perform **revenue
diagnostics, customer segmentation, and churn root-cause analysis** using
structured SQL queries.

The project is designed to mirror real-world analytics work done in
consulting and data teams (ZS, Fractal, Deloitte, Tiger Analytics, etc.).

---

## Dataset

**Source:** Sample Superstore  
**Format:** CSV  
**Records:** Orders, customers, products, sales, discounts, and profit data  
**Time Span:** Multi-year transactional data  

Key columns:
- Order Date, Ship Date  
- Customer ID, Customer Name  
- Category, Sub-Category, Product  
- Sales, Discount, Profit  
- Ship Mode, Region  

Dataset file:
Data/Sample - Superstore.csv

yaml
Copy code

---

## Project Structure

SQL-REVENUE-DIAGNOSTICS/
│
├── Data/
│ └── Sample - Superstore.csv
│
├── Queries/
│ ├── revenue_trends.sql
│ ├── rfm_analysis.sql
│ ├── rfm_segmentation.sql
│ └── at_risk_root_cause.sql
│
├── Reports/
│ ├── insights_phase1.md
│ ├── recommendations.md
│ └── RFM_Segmentation_insight.md
│
└── README.md

yaml
Copy code

---

## Phase 1 — Revenue Trend Diagnostics

**Objective:**  
Identify seasonality, revenue concentration, and category-level performance.

Key analyses:
- Month-wise revenue trends
- Peak season identification
- Category and sub-category revenue contribution
- Discount vs profitability patterns

**Outcome:**  
Clear Q4 seasonality and margin erosion in Furniture category.

---

## Phase 2 — RFM Customer Segmentation

**Objective:**  
Segment customers based on purchasing behavior using RFM methodology.

Metrics:
- **Recency**: Days since last purchase  
- **Frequency**: Number of orders  
- **Monetary**: Total customer revenue  

Method:
- NTILE(5) scoring for R, F, M
- Composite RFM score
- Business-oriented segmentation logic

Segments created:
- Champions  
- Loyal Customers  
- Potential Loyalists  
- Big Spenders  
- At Risk  
- Lost  
- Others  

**Output Table:** `rfm_segments`

---

## Phase 3 — Churn Root Cause Analysis

**Objective:**  
Understand *why* customers become **At Risk** or **Lost**.

Analyses performed:
- Last purchase behavior
- Recency progression across segments
- Discount impact on churn
- Shipping time comparison
- Category and sub-category churn concentration
- Profitability of last transaction

Key findings:
- Churn is driven by **time since last purchase**, not shipping delays
- Office Supplies and Furniture dominate churned customers
- Discounting alone does not ensure retention
- High-value customers exist inside At Risk and Lost segments

---

## Business Insights & Recommendations

- Early intervention in “Others” segment yields highest ROI
- Discounting must be targeted and time-based
- Technology category correlates with stronger retention
- Margin-negative last purchases accelerate churn
- RFM provides a scalable lifecycle management framework

Detailed recommendations are documented in:
Reports/recommendations.md

yaml
Copy code

---

## Skills Demonstrated

- Advanced SQL (CTEs, window functions, NTILE, segmentation logic)
- Business analytics and storytelling
- Customer lifecycle analysis
- Revenue and churn diagnostics
- Data-driven decision framing
- Consulting-style insight generation

---

## Tools Used

- MySQL (Window functions, CTEs)
- CSV data ingestion
- Markdown reporting
- GitHub version control

---

## How to Run

1. Load `Sample - Superstore.csv` into MySQL
2. Execute SQL files in this order:
   - `revenue_trends.sql`
   - `rfm_analysis.sql`
   - `rfm_segmentation.sql`
   - `at_risk_root_cause.sql`
3. Review insights in the `Reports/` folder

---

## Future Enhancements

- Python / Matplotlib visualizations
- Power BI dashboard
- Predictive churn modeling
- Campaign uplift simulation

---

This project is intended as a **portfolio-grade analytics case study**,
not a toy SQL exercise.
