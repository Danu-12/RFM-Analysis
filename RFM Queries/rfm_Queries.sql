-- 1. Append all monthly sales tables together in a single tabel

 CREATE OR REPLACE TABLE `rfm111.Sales.Sales_2025` AS 
 SELECT * FROM `rfm111.Sales.sales202501` 
 UNION ALL SELECT * FROM `rfm111.Sales.sales202502`
 UNION ALL SELECT * FROM `rfm111.Sales.sales202503`
 UNION ALL SELECT * FROM  `rfm111.Sales.sales202504`
 UNION ALL SELECT * FROM `rfm111.Sales.sales202505`
 UNION ALL SELECT * FROM `rfm111.Sales.sales202506`
 UNION ALL SELECT * FROM  `rfm111.Sales.sales202507`
 UNION ALL SELECT * FROM `rfm111.Sales.sales202508`
 UNION ALL SELECT * FROM `rfm111.Sales.sales202509`
 UNION ALL SELECT * FROM  `rfm111.Sales.sales202510`
 UNION ALL SELECT * FROM `rfm111.Sales.sales202511`
 UNION ALL SELECT * FROM  `rfm111.Sales.sales202512` ;

-- 2. Calculate recency, frequency, monetary | r, f, m ranks
--    Combine views with CTEs

CREATE OR REPLACE VIEW `rfm111.Sales.rfm_metrics`
AS
WITH Current_Date AS (
  SELECT DATE('2026-03-06') AS Analysis_Date -- Today's Date
),
rfm AS (
  Select 
    CustomerID,
    MAX(OrderDate) AS Last_Order_Date,
    DATE_DIFF((SELECT Analysis_Date FROM Current_Date),MAX(OrderDate),DAY) AS Recency,
    COUNT(*) AS Frequency,
    SUM(OrderValue) AS Monetary
  FROM `rfm111.Sales.Sales_2025`
  GROUP BY CustomerID
)
SELECT 
 rfm.*,
 ROW_NUMBER() OVER(ORDER BY Recency ASC ) AS r_rank,
 ROW_NUMBER() OVER(ORDER BY Frequency DESC) AS f_rank,
 ROW_NUMBER() OVER(ORDER BY Monetary DESC) AS m_rank
FROM rfm;


-- Assign deciles (10=Best, 1=Worst )

CREATE OR REPLACE VIEW `rfm111.Sales.rfm_Score`
AS
SELECT 
  *,
  NTILE(10) OVER (ORDER BY r_rank DESC) AS r_score,
  NTILE(10) OVER (ORDER BY f_rank DESC) AS f_score,
  NTILE(10) OVER (ORDER BY m_rank DESC) AS m_score
FROM `rfm111.Sales.rfm_metrics`;


-- Total Score

CREATE OR REPLACE VIEW `rfm111.Sales.rfm_Total_Score`
AS
SELECT
  CustomerID,
  Recency,
  Frequency,
  Monetary,
  r_score,
  f_score,
  m_score,
  (r_score + f_score + m_score) AS Total_score
FROM `rfm111.Sales.rfm_Score`
ORDER BY Total_Score DESC;


-- Dashboard ready rfm segment table 


CREATE OR REPLACE TABLE `rfm111.Sales.rfm_segment`
AS
SELECT 
  CustomerID,
  Recency,
  Frequency,
  Monetary,
  r_score,
  f_score,
  m_score,
  Total_score,
  CASE 
   WHEN Total_score >=28 THEN 'Champions' --28-30
   WHEN Total_score >=24 THEN 'Loyal VIPs'
   WHEN Total_score >=20 THEN 'Potential Loyalists'
   WHEN Total_score >=16 THEN 'Promising'
   WHEN Total_score >=12 THEN 'Engaged'
   WHEN Total_score >=8 THEN 'Require Attention'
   WHEN Total_score >=4 THEN 'AT Risk'
   ELSE 'Lost/Inactive'
  END AS rfm_segment
FROM `rfm111.Sales.rfm_Total_Score` ;
