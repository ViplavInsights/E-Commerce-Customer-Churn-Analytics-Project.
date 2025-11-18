# E-Commerce-Customer-Churn-Analytics-Project.
Analyze customer churn to find key insights and inform retention strategies.
# Customer Churn Analysis: Ecommerce Dataset

This project analyzes customer churn using real-world ecommerce data from Kaggle. Data preparation and cleaning were performed in **Jupyter Notebook**, followed by advanced SQL analysis in **PostgreSQL** and data visualization in **Python** (Pandas, Matplotlib, Seaborn).

## Key Analyses & Insights

- **Overall Churn Rate:** 26.1%; *26.1% customers churned, 73.9% retained*.
- **Device-Based Churn:** Tablet users had the highest churn (~29%), Mobile/Desktop users ~26%.
- **Premium vs Non-Premium:** Non-Premium customers churned at 32.04%, Premium at 20.36%.
- **Tenure Impact:** New customers (0-6 months) churn rate: 35.16% (highest).
- **Revenue Lost:** Total revenue lost due to churn: **₹7,316,316.59**.
- **Correlation Analysis:** Support ticket volume had the strongest positive correlation with churn (0.20).

### Actionable Recommendations

- Focus retention on new customers (first 6 months).
- Improve product quality/support, especially for heavy support ticket creators.
- Audit tablet platform for UX/performance issues.
- Reassess Premium membership value/proposition.

## Workflow

1. **Data Source:** Kaggle (CSV)
2. **Cleaning:** Jupyter Notebook (Python)
3. **SQL Analysis:** PostgreSQL (`customer_churn` table)
4. **Visualization:** Python (Pandas, Matplotlib, Seaborn)
5. **Reporting:** Exported insights as HTML

## 

  
  `[View Full Analysis Report](reports/churn_insights.html)`
-

