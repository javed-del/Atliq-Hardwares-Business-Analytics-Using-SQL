CREATE DEFINER=`root`@`localhost` PROCEDURE `GetSalesBadgeByMarket`(IN marketName VARCHAR(255))
BEGIN
    SELECT 
        GetSalesBadge(market, Qty_Sold) AS Badge
    FROM (
        SELECT market, ROUND(SUM(sold_quantity), 2) AS Qty_Sold
        FROM gdb0041.fact_sales_monthly FSM
        LEFT JOIN dim_product DP USING (product_code)
        LEFT JOIN dim_customer DC USING (customer_code)
        LEFT JOIN fact_gross_price FGP ON FGP.product_code = FSM.product_code
            AND FGP.fiscal_year = get_fiscal_year(FSM.date)
        WHERE market = marketName
        GROUP BY market
    ) AS Q1;
END
