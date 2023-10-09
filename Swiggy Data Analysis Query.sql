--Lets see how many Distinct Items are Ordered
Select count(distinct name) from items

--Lets See What is Disribution on Veg Items and Non-Veg Items
Select is_veg, count(name) as Items from items
group by is_veg

--We Have Found the Item its Not Veg and Non-Veg
--Lets Know that Item Name 
select * from items
where is_veg=2

--Lets Find out How Many Distinct Orders are Made
Select count(distinct order_id) from items


--Lets Look How many "Chicken" Items are Ordered
select * from items
where name like '%chicken%'

--Lets see How many "Paratha" Items are Ordered?
select * from items
where name like '%Paratha%'

--How to Find the Average Numbers of Items per Order 
select count(name)/count(distinct order_id) as AvgItemsPerOrder from items

--How Many Items Ordered the Most Number of Times 
select name,count(*) from items
group by name
order by count(*) desc


--How Many Orders Are Made During Rainy Time
select distinct rain_mode from orders


--Lets Find Out How Many Distinct Restaurant Got the Orders
select count(distinct restaurant_name) from orders


--Lets Find The Restaurant With Most Orders
select restaurant_name,count(*) Orders_Got from orders 
group by restaurant_name
order by count(*) desc


--Lets Find Out How Many Orders Were Placed per Month and Year
select CONCAT(YEAR(order_time), '-', MONTH(order_time)) as Date,count(distinct order_id) as NumberOfOrders 
from orders 
group by  CONCAT(YEAR(order_time), '-', MONTH(order_time))
order by count(distinct order_id) desc


--The Latest Order Made Date
select max(order_time) FROM orders


--Revenue Made By Each Month
select CONCAT(YEAR(order_time), '-', MONTH(order_time)) as Date, sum(order_total) as TotalRevenue
from orders
group by CONCAT(YEAR(order_time), '-', MONTH(order_time))
order by totalrevenue desc

--Average Orders Value(AOV)
select sum(order_total)/count(distinct order_id) as AOV
from Orders


--Year On Year Change in Revenue Using Lag Function and Raning the Highest Year
--Year On Year Revenue
select Year(order_time) as Year,sum(order_total) as Revenue
from orders
group by  year(order_time)


--Lag Function
with final as (
SELECT year(order_time) as Year,sum(order_total) as Revenue
FROM orders
group by  year(order_time))

select Year,Revenue,lag(Revenue) over (order by Year) as PreviousRevenue 
from final


--Years with Highest Revenue Ranking 
with final as (
SELECT year(order_time) as Year,sum(order_total) as Revenue
FROM orders
group by  year(order_time))
select Year,Revenue,
rank() over (order by revenue desc) as Ranking from final


--Restaurant with Highest Revenue Ranking
with final as (
SELECT Restaurant_Name,sum(order_total) as Revenue
FROM orders 
group by  Restaurant_Name)

select Restaurant_Name,Revenue,
rank() over (order by revenue desc) as Ranking from final
order by revenue desc



--Joining Order and items tables and finding Product Combos using self join
SELECT a.Name,a.is_veg,b.Restaurant_Name,b.Order_Id,b.Order_Time 
FROM items a
join orders  b
on a.order_id=b.order_id



SELECT a.Order_Id,a.Name,b.Name as Name2,concat(a.name,b.name) as OrderName
FROM items a
join items b
on a.order_id=b.order_id
where a.name!=b.name
and a.name<b.name











