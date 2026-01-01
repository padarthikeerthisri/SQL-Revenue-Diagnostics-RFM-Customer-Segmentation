# Phase 3 — RFM Segmentation & Churn Root Cause Insights

This phase extends RFM segmentation by diagnosing **why high-value customers
become At Risk or Lost**, using order-level, shipping, discount, category,
and profitability signals.

The analysis combines RFM scores with **last-purchase behavior**, enabling
actionable churn mitigation strategies.

---

## 1. Segment Distribution Highlights Structural Risk

Customer distribution across segments shows a **large concentration in
non-loyal states**:

- Others: 341 customers  
- At Risk: 109 customers  
- Lost: significant high-recency subset  
- Champions + Loyal Customers: comparatively smaller base  

This indicates **revenue vulnerability**, where a substantial share of value
comes from customers who are not strongly retained.

---

## 2. Recency Confirms Clear Churn Progression

Average recency (days since last purchase):

- Lost: ~434 days  
- At Risk: ~309 days  
- Big Spenders: ~243 days  
- Others: ~97 days  
- Loyal / Champions: ~25 days  

**Interpretation**:
- Customers follow a clear path:  
  `Champions → Loyal → Others → At Risk → Lost`
- Recency is the **strongest churn indicator**, validating the RFM framework.

---

## 3. High-Value Customers Exist Inside At Risk & Lost Segments

Despite churn risk:

- At Risk customers still show:
  - Avg spend ≈ 2855  
  - Avg frequency ≈ 10 orders  

- Lost customers include **very high historical spenders**
  (some exceeding overall average monetary value).

**Insight**:  
Churn is not driven by low customer value — it is driven by **experience and timing**.

---

## 4. Shipping Time Is NOT a Primary Churn Driver

Average shipping days by segment:

- Lost: ~4.17 days  
- Loyal Customers: ~3.96 days  
- At Risk: ~3.90 days  
- Champions: ~3.85 days  

Differences are marginal.

**Conclusion**:  
Shipping delays are **not a statistically strong differentiator** for churn
in this dataset.

---

## 5. Discount Levels Do Not Guarantee Retention

Average discount on last purchase:

- Champions: ~18%  
- Big Spenders / Others: ~17%  
- At Risk: ~13%  
- Lost: ~7%  

**Key insight**:
- High discounts do **not ensure loyalty**
- Lost customers often received **lower discounts** before churn
- Discounting alone is insufficient without timing and relevance

---

## 6. Category-Level Churn Signals Are Strong

Last purchased category distribution:

### At Risk
- Office Supplies: dominant
- Furniture: secondary
- Technology: lower share

### Lost
- Office Supplies: majority
- Furniture: meaningful presence
- Technology: minimal

**Interpretation**:
- Churn is **concentrated in low-engagement, low-differentiation categories**
- Technology purchases correlate more strongly with retained customers

---

## 7. Profitability of Last Purchase Shows Negative Experience Risk

A significant fraction of At Risk and Lost customers had:
- Negative-profit last orders
- High discounts or low-margin products (Furniture, Tables, Binders)

**Implication**:
- Margin erosion may coexist with customer dissatisfaction
- Poor last-purchase experience accelerates disengagement

---

## 8. “Others” Segment Is a Transitional Risk Pool

The Others segment shows:
- Moderate recency (~97 days)
- High average spend (~4400)
- High order frequency (~16)

**Insight**:
- Others is **not a stable segment**
- It represents customers **on the verge of becoming At Risk**
- Early intervention here yields highest ROI

---

## Summary of Root Causes

Primary churn drivers identified:
- High recency (time since last order)
- Low-engagement categories (Office Supplies, Furniture)
- Loss-making or low-margin last purchases
- Insufficient or poorly timed incentives
- Absence of proactive retention during transition phase

Non-drivers:
- Shipping time (minimal variation)

---

## Business Implication

Retention strategy must shift from:
> “Discount everyone”  
to  
> “Intervene early, by segment, with relevance”

This segmentation framework enables:
- Targeted win-back campaigns
- Margin-aware retention
- Lifecycle-based customer management

---

This Phase 3 analysis completes a **full SQL-driven customer intelligence
pipeline**, comparable to analytics workflows used in consulting and data
science roles at ZS, Fractal, Tiger Analytics, and Deloitte.
