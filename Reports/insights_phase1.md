# Phase 1 — Revenue Trend Insights (with Actual SQL Results)

This document summarizes key insights from SQL-based revenue diagnostics 
performed on the Superstore dataset. The analysis investigates monthly trends, 
year-over-year growth, category performance, and seasonal patterns, supported 
by actual SQL output tables.

---

# 1. Month-wise Revenue Trend (Actual Output)

The following table shows total revenue for each month across all years:

| Month   | Revenue |
|---------|---------|
| 2014-01 | 14236.90 |
| 2014-02 | 4519.92 |
| 2014-03 | 55691.04 |
| 2014-04 | 28295.35 |
| 2014-05 | 23648.28 |
| 2014-06 | 34595.14 |
| 2014-07 | 33946.37 |
| 2014-08 | 27909.47 |
| 2014-09 | 81777.34 |
| 2014-10 | 31453.37 |
| 2014-11 | 78628.74 |
| 2014-12 | 69545.64 |
| 2015-01 | 18174.08 |
| 2015-02 | 11951.40 |
| 2015-03 | 38726.26 |
| 2015-04 | 34195.25 |
| 2015-05 | 30131.72 |
| 2015-06 | 24797.31 |
| 2015-07 | 28765.32 |
| 2015-08 | 36898.32 |
| 2015-09 | 64595.87 |
| 2015-10 | 31404.90 |
| 2015-11 | 75972.51 |
| 2015-12 | 74919.52 |
| 2016-01 | 18542.52 |
| 2016-02 | 22978.82 |
| 2016-03 | 51715.86 |
| 2016-04 | 38750.04 |
| 2016-05 | 56987.75 |
| 2016-06 | 40344.54 |
| 2016-07 | 39261.99 |
| 2016-08 | 31115.35 |
| 2016-09 | 73410.09 |
| 2016-10 | 59687.80 |
| 2016-11 | 79412.03 |
| 2016-12 | 96999.07 |
| 2017-01 | 43971.37 |
| 2017-02 | 20301.12 |
| 2017-03 | 58872.35 |
| 2017-04 | 36521.52 |
| 2017-05 | 44261.08 |
| 2017-06 | 52981.73 |
| 2017-07 | 45264.43 |
| 2017-08 | 63120.85 |
| 2017-09 | 87866.66 |
| 2017-10 | 77776.96 |
| 2017-11 | 118447.81 |
| 2017-12 | 83829.31 |

### Insight:
Q4 months (Sep–Dec) dominate revenue across all observed years.

---

# 2. Year-over-Year Revenue (Actual Output)

| Year | Revenue |
|------|----------|
| 2014 | 484,247.56 |
| 2015 | 470,532.46 |
| 2016 | 609,205.86 |
| 2017 | 733,215.19 |

### Insight:
Revenue shows strong upward growth, with 2017 outperforming 2014 by over 51%.

---

# 3. Category Revenue & Profit (Actual Output)

| Category        | Revenue   | Profit      |
|-----------------|-----------|-------------|
| Technology      | 836,154.10 | 145,455.66 |
| Furniture       | 741,999.98 | 18,451.25  |
| Office Supplies | 719,046.99 | 122,490.88 |

### Insight:
Furniture produces high revenue but extremely low profit — indicating a margin problem.

---

# 4. Declining Months (LAG Window Function Output)

The following table shows months where revenue decreased vs. previous month:

| Month | Revenue | Previous | Difference |
|--------|---------|----------|-------------|
| 2014-02 | 4519.92 | 14236.90 | -9716.98 |
| 2014-04 | 28295.35 | 55691.04 | -27395.69 |
| 2014-05 | 23648.28 | 28295.35 | -4647.07 |
| 2014-07 | 33946.37 | 34595.14 | -648.77 |
| 2014-08 | 27909.47 | 33946.37 | -6036.90 |
| 2014-10 | 31453.37 | 81777.34 | -50323.97 |
| 2014-12 | 69545.64 | 78628.74 | -9083.10 |
| 2015-01 | 18174.08 | 69545.64 | -51371.56 |
| 2015-02 | 11951.40 | 18174.08 | -6222.68 |
| 2015-04 | 34195.25 | 38726.26 | -4531.01 |
| 2015-05 | 30131.72 | 34195.25 | -4063.53 |
| 2015-06 | 24797.31 | 30131.72 | -5334.41 |
| 2015-10 | 31404.90 | 64595.87 | -33190.97 |
| 2015-12 | 74919.52 | 75972.51 | -1052.99 |
| 2016-01 | 18542.52 | 74919.52 | -56377.00 |
| 2016-04 | 38750.04 | 51715.86 | -12965.82 |
| 2016-06 | 40344.54 | 56987.75 | -16643.21 |
| 2016-07 | 39261.99 | 40344.54 | -1082.55 |
| 2016-08 | 31115.35 | 39261.99 | -8146.64 |
| 2016-10 | 59687.80 | 73410.09 | -13722.29 |
| 2017-01 | 43971.37 | 96999.07 | -53027.70 |
| 2017-02 | 20301.12 | 43971.37 | -23670.25 |
| 2017-04 | 36521.52 | 58872.35 | -22350.83 |
| 2017-07 | 45264.43 | 52981.73 | -7717.30 |
| 2017-10 | 77776.96 | 87866.66 | -10089.70 |
| 2017-12 | 83829.31 | 118447.81 | -34618.50 |

### Insight:
The largest declines occur in:
- January (post-holiday drop)
- Early Q2 (seasonal softening)

---

# 5. Day-of-Month Revenue (Actual Output)

| Day | Revenue | Orders |
|-----|----------|----------|
| 17 | 112,155.14 | 352 |
| 2 | 105,139.10 | 379 |
| 8 | 101,577.97 | 356 |
| 21 | 95,784.30 | 396 |
| 1 | 95,524.55 | 337 |
| ... | ... | ... |
| 31 | 49,703.55 | 183 |
| 29 | 44,806.74 | 239 |

### Insight:
There is no strong "beginning vs. end" day-of-month pattern.  
Seasonality depends more on **months**, not dates.

---

# Summary of Phase 1
- Strong Q4 seasonality  
- Weak performance in Jan–Feb  
- Furniture needs margin restructuring  
- Category-month combinations repeat predictably  
- Provides a foundation for RFM segmentation and deeper customer profitability analysis  

