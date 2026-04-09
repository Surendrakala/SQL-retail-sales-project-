CREATE DATABASE sql_project1;

drop table if exists retail_sales ;
CREATE TABLE retail_sales (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(20),
    quantity INT,
    price_per_unit INT,
    cogs FLOAT,
    total_sale FLOAT
);










					
select * from retail_sales
limit 10



select count (*) from retail_sales



select * from retail_sales
where 
	transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantity is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null

--delete
delete from retail_sales
where transactions_id is null
	or
	sale_date is null
	or 
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantity is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null



-- show the data after the null values are deleted 
select * from retail_sales
select count (*) from retail_sales

-- exploring the data
--How many sales we have

select count (*) as total_sales from retail_sales

-- how many unique customer we have 

select count (distinct customer_id) as total_sales from retail_sales


-- what are the category we have

select distinct category from retail_sales



--total no:of males // total no:of females

select count(*) as male_count from retail_sales group by gender


-- sales on the 2022-11-05

select * from retail_sales where sale_date = '2022-11-05'


-- clothing more than 4 in the date of 2022 NOV
select * from retail_sales where category = 'Clothing' and to_char(sale_date, 'YYYY-MM')= '2022-11' and quantity >=4; 



-- to caluclate the total sales in the each category
select 
category, sum (total_sale)
 from retail_sales
 group by 1


-- avg age  of customer to purchased the item fromm the beauty category
select 
category = 'beauty',avg(age) as avg_age
from retail_sales
group by 1

-- to find transaction  where the total sales is  greater than 1000
 
select * from retail_sales where total_sale > 1000 


-- totla no:of transaction made my the each gender in each category


select
	category,
	gender,
	count(*) from retail_sales
group by gender, category
order by 1


--- avg sales in each month and best selling month in each year 

select
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale) as avg_sale,
	rank() over(partition by extract(year from sale_date) order by avg(total_sale)  desc)
		from retail_sales
	group by 1, 2 
	--order by 1, 3 desc

-- top 5 customer based on the based on highest total sales

select 
	customer_id,
	sum(total_sale) as total_sales
	from retail_sales
	group by 1
	order by 2 desc
	limit 5

-- no:of unique customer who are purchased item from each category


select 
	category,
	count(distinct customer_id) as unique_customer
	
from retail_sales
group by category
order by category

-- create the shift and number of orders (ex morning <12, afternoon 12-17 and evening >17)
with hourly_sale as
(
select *, 
	case
	when extract (hour from sale_time) <12 then 'morning'
	when extract(hour from sale_time) between 12 and 17 then 'afternoon'
	else  'evening' 
	end as shift
	from retail_sales
	)
	select shift, count(*) as total_orders from hourly_sale
	group by shift































































