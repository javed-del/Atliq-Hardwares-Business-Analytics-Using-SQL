 select market,Qty_Sold,GetSalesBadge(market,Qty_Sold) as Badge
 from (SELECT market,
round(sum(sold_quantity),2) as Qty_Sold 
FROM gdb0041.fact_sales_monthly FSM 
left join dim_product DP using(product_code)
left join dim_customer DC using(customer_code)
left join fact_gross_price FGP on FGP.product_code = FSM.product_code
 and FGP.fiscal_year = get_fiscal_year(FSM.date)
group by market)
Q1