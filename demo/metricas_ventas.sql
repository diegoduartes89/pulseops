-- Demo GitHub + ChatGPT: métricas de ventas
-- Datos ficticios. Compatible con Google BigQuery (Standard SQL).

WITH ventas AS (
  SELECT 'Costa Rica' AS mercado, 'Ganada' AS estado, 1200 AS monto UNION ALL
  SELECT 'Costa Rica', 'Ganada', 800 UNION ALL
  SELECT 'Costa Rica', 'Perdida', 500 UNION ALL
  SELECT 'Mexico', 'Ganada', 1500 UNION ALL
  SELECT 'Mexico', 'Perdida', 1000
)
SELECT
  mercado,
  COUNT(*) AS oportunidades,
  COUNTIF(estado = 'Ganada') AS oportunidades_ganadas,
  ROUND(SAFE_DIVIDE(COUNTIF(estado = 'Ganada'), COUNT(*)) * 100, 1) AS win_rate_pct,
  ROUND(SAFE_DIVIDE(SUM(IF(estado = 'Ganada', monto, 0)), COUNTIF(estado = 'Ganada')), 2) AS average_deal_value,
  SUM(IF(estado = 'Ganada', monto, 0)) AS revenue_ganado
FROM ventas
GROUP BY mercado
ORDER BY revenue_ganado DESC;
