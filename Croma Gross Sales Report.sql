SELECT date,sum(FGP.gross_price*FSM.sold_quantity) as Gross_Price_Total
FROM gdb0041.fact_sales_monthly FSM
left join dim_customer DC 
using(customer_code) 
left join fact_gross_price FGP on FSM.product_code = FGP.product_code and get_fiscal_year(FSM.date) = FGP.fiscal_year 
where customer_code = '90002002'
group by date