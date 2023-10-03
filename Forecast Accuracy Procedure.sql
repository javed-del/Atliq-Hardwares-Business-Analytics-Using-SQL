CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculateForecastAccuracy`(IN FY INT)
BEGIN
    WITH abs_error_cte AS (
        SELECT FAE.customer_code,
               DC.customer AS customer_name,
               DC.market,
               SUM(sold_quantity) AS total_sold_qty,
               SUM(forecast_quantity) AS total_forecast_qty,
               SUM(forecast_quantity - sold_quantity) AS net_error,
               ROUND(100 * SUM(forecast_quantity - sold_quantity) / SUM(forecast_quantity), 2) AS net_error_pct,
               SUM(ABS(forecast_quantity - sold_quantity)) AS abs_error,
               ROUND(100 * SUM(ABS(forecast_quantity - sold_quantity)) / SUM(forecast_quantity), 2) AS abs_error_pct
        FROM gdb0041.fact_act_est FAE
        JOIN dim_customer DC USING (customer_code)
        WHERE fiscal_year = FY
        GROUP BY customer_code
    )
    SELECT *,
           IF(abs_error_pct < 0, 0, 100 - abs_error_pct) AS Forecast_Accuracy
    FROM abs_error_cte
    ORDER BY Forecast_Accuracy DESC;
END
