Select * from House_sales;

--Date with the highest Price
Select CAST(datesold as DATE) Date,price
from House_Sales
where price = (Select Max(price) from House_sales)

-- Year with the lowest Price
Select Top 1 year(datesold) Year, SUM(cast(price as bigint)) TotalSales
from House_Sales
group by year(datesold)
order by (SUM(cast(price as bigint))) 

-- PostCode with the highest Average Price
Select Top 1 postcode, Avg(cast(price as bigint)) AverageSales
from House_Sales
group by postcode
order by Avg(cast(price as bigint)) desc
select avg(price)
from House_sales

-- Top six postcode by year's price
WITH ranked_prices AS (SELECT postcode, price, year(datesold) year,
        RANK() OVER (PARTITION BY year(datesold) ORDER BY price DESC) AS price_rank
    FROM House_Sales)
SELECT postcode, price, year
FROM ranked_prices
WHERE price_rank <= 6
ORDER BY year, price_rank;
