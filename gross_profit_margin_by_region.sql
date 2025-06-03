-- Gross Profit and Gross Margin % by Region

SELECT
  DATE_FORMAT(date, '%Y-%m-01') AS month,
  region,
  SUM(CASE WHEN account = 'Revenue' THEN amount ELSE 0 END) AS revenue,
  -SUM(CASE WHEN account = 'COGS' THEN amount ELSE 0 END) AS cogs,
  SUM(CASE WHEN account = 'Revenue' THEN amount ELSE 0 END) +
  SUM(CASE WHEN account = 'COGS' THEN amount ELSE 0 END) AS gross_profit,

  ROUND(
    (
      SUM(CASE WHEN account = 'Revenue' THEN amount ELSE 0 END) +
      SUM(CASE WHEN account = 'COGS' THEN amount ELSE 0 END)
    ) / NULLIF(SUM(CASE WHEN account = 'Revenue' THEN amount ELSE 0 END), 0) * 100,
    2
  ) AS gross_margin_percent
FROM financials
WHERE account IN ('Revenue', 'COGS')
GROUP BY month, region
ORDER BY month, region;
