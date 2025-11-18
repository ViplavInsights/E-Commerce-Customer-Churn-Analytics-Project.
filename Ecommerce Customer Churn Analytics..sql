CREATE TABLE Customer_churn(
CustomerID VARCHAR (50) PRIMARY KEY,
Age INT,
Gender VARCHAR(10),
TenureMonths INT,
TotalPurchases INT,
AveragePurchaseValue FLOAT,
TotalSpend FLOAT,
MonthlySpend FLOAT,
SessionsPerMonth FLOAT,
AvgSessionDurationMinutes FLOAT,
PagesViewedPerSession FLOAT,
SupportTickets INT,
DeviceUsed VARCHAR(20),
HasPremiumMembership INT,
LastInteractionDaysAgo INT,
Churn INT
);


SELECT * FROM customer_churn;

COPY Customer_churn
FROM 'C:\Users\HP\Downloads\E-Commerce_Customer_Churn.csv'
DELIMITER '_'
CSV HEADER;

---KEY PERFORMANCE INDICATORS.
---1.OVERALL CHURN RATE.

SELECT ROUND(100.0 * SUM(Churn) / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn;

---2.Churn Rate by Segment
---By Device Used. 
SELECT DeviceUsed, AVG(Churn)*100 AS churn_percent
FROM customer_churn
GROUP BY DeviceUsed;

---By Gender.
SELECT Gender, AVG(Churn)*100 AS churn_percent
FROM customer_churn
GROUP BY Gender;

---By Age Group.
SELECT Age, AVG(Churn)*100 AS churn_percent
FROM customer_churn
GROUP BY HasPremiumMembers;

---3.Average Customer Lifetime/Retention.
SELECT TenureMonths, ROUND(AVG(Churn), 2) AS AVG
FROM customer_churn 
GROUP BY TenureMonths;

---4.Average Total Spend and Purchases.
SELECT Churn, AVG(TotalSpend), AVG(TotalPurchases)
FROM customer_churn
GROUP BY Churn;

---5. Premium vs Non-Premium Churn Rate.
SELECT
  HasPremiumMembership,
  ROUND(100.0 * AVG(Churn), 2) AS churn_rate_percent,
  COUNT(*) AS user_count
FROM customer_churn
GROUP BY HasPremiumMembership;

---6. Engagement Comparison (Active vs Churned Users).
SELECT
  Churn,
  AVG(SessionsPerMonth) AS avg_sessions,
  AVG(AvgSessionDurationMinutes) AS avg_session_duration,
  AVG(PagesViewedPerSession) AS avg_pages_viewed
FROM customer_churn
GROUP BY Churn;

---7.  Average Support Tickets Before Churn.
SELECT
  Churn,
  AVG(SupportTickets) AS avg_support_tickets
FROM customer_churn
GROUP BY Churn;

---8. High-Churn Segments to Target (Retention Opportunities).
SELECT
  DeviceUsed,
  ROUND(100.0 * AVG(Churn), 2) AS churn_rate_percent,
  COUNT(*) AS user_count
FROM customer_churn
GROUP BY DeviceUsed
ORDER BY churn_rate_percent DESC;

---9. Total Revenue Lost Due to Churn.
SELECT
  SUM(TotalSpend) AS total_revenue_lost
FROM customer_churn
WHERE Churn = 1
;

---10. Average Revenue Lost per Churned Customer.
SELECT
  AVG(TotalSpend) AS  avg_total_revenue_lost
FROM customer_churn
WHERE Churn = 1
;

---IMPORTANT KPIS.
---1. Churn by Tenure Bucket (New vs Long-Term Customers).
SELECT
  CASE
    WHEN TenureMonths < 6 THEN 'New (0-6 mo.)'
    WHEN TenureMonths < 24 THEN 'Mid-Term (6-24 mo.)'
    ELSE 'Long-Term (24+ mo.)'
  END AS tenure_group,
  ROUND(100.0 * AVG(Churn), 2) AS churn_rate_percent,
  COUNT(*) AS user_count
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate_percent DESC;

---2. High-Value Customer Churn Rate.
SELECT
  CASE
    WHEN TotalSpend >= 6000 THEN 'High Value'
    WHEN TotalSpend >= 3000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS spend_group,
  ROUND(100.0 * AVG(Churn), 2) AS churn_rate_percent,
  AVG(TotalSpend) AS avg_spend,
  COUNT(*) AS user_count
FROM customer_churn
GROUP BY spend_group
ORDER BY churn_rate_percent DESC;

---3. Churn by Support Ticket Volume.
SELECT
  CASE
    WHEN SupportTickets = 0 THEN 'No Tickets'
    WHEN SupportTickets < 3 THEN 'Low Tickets'
    ELSE 'High Tickets'
  END AS support_group,
  ROUND(100.0 * AVG(Churn), 2) AS churn_rate_percent,
  AVG(SupportTickets) AS avg_tickets,
  COUNT(*) AS user_count
FROM customer_churn
GROUP BY support_group
ORDER BY churn_rate_percent DESC;

---4. Retention KPIs (Monthly Retained Rate).
SELECT
  ROUND(100.0 * SUM(CASE WHEN Churn = 0 THEN 1 ELSE 0 END) / COUNT(*), 2) AS retention_rate_percent
FROM customer_churn;

---5. Churn by Device AND Membership Status.
SELECT
  DeviceUsed,
  HasPremiumMembership,
  ROUND(100.0 * AVG(Churn), 2) AS churn_rate_percent,
  COUNT(*) AS user_count
FROM customer_churn
GROUP BY DeviceUsed, HasPremiumMembership
ORDER BY churn_rate_percent DESC;

---6. Advanced Bonus: Top Predictors Mini-Analysis
---Why: Rank features to see which ones are most correlated 
---with churn—a starting point for predictive modeling.

SELECT
  ROUND(CORR(Churn, TenureMonths)::numeric, 2) AS TenureChurnCorr,
  ROUND(CORR(Churn, TotalSpend)::numeric, 2) AS SpendChurnCorr,
  ROUND(CORR(Churn, SupportTickets)::numeric, 2) AS TicketChurnCorr
FROM customer_churn;






