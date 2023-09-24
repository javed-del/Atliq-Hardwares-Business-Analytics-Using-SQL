select DD.fiscal_year,sum(round(FSM.sold_quantity * FGP.gross_price,2)) as yearly_sales from  fact_sales_monthly FSM 
left join dim_date DD using(date)
left join dim_product DP using(product_code)
left join dim_customer DC using(customer_code)
left join fact_gross_price FGP on FSM.product_code = FGP.product_code and 
DD.fiscal_year = FGP.fiscal_year
where customer like "%croma%"
group by DD.fiscal_year
