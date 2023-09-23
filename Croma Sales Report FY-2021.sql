use gdb0041;
  select  FSM.DATE as month,
  DP.Product_Code as Product_Code,
  DP.PRODUCT as Product,
  DP.VARIANT as Variant, 
  SUM(FSM.SOLD_QUANTITY) as Sold_Quantity ,
  sum(FGP.GROSS_PRICE) as Gross_Price_Per_Item ,
  round(sum(Sold_Quantity)*sum(FGP.GROSS_PRICE),2) as Gross_Price_Total
  FROM FACT_SALES_MONTHLY FSM 
  left join dim_Customer DC using(customer_code)
  left join dim_product DP 
  using(product_code) 
  left join 
  fact_gross_price FGP 
  on ( get_fiscal_year(FSM.date)= FGP.fiscal_year and  FSM.product_code = FGP.product_code)
  where customer_code = '90002002' and get_fiscal_year(FSM.date) = 2021
  GROUP BY FSM.DATE,DC.Customer_Code,DP.PRODUCT,DP.PRODUCT_CODE,DP.VARIANT
  order by FSM.Date,DP.Product_Code
  