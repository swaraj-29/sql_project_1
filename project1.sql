#SQL Retail Sales Analysis - P1
CREATE database sql_projects;
-- Create TABLE
drop table if exists retail_sales;
create table retail_sales 
(transactions_id int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender	varchar(10),
age	int ,
category varchar(20),	
quantiy	int,
price_per_unit float,	
cogs	float,
total_sale float
);
select * from retail_sales
limit 10;
use sql_projects;
SHOW TABLES;
select count(*) from retail_sales;

-- Data Cleaning
select * from retail_sales
where transactions_id is null
	or
	sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration
-- How many sales we have?

select count(*) as total_sale from retail_sales;

-- How many uniuque customers we have ?
select count(distinct customer_id) from retail_sales;

#1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales
where
sale_date = ' 2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select *
from retail_sales
where category = 'Clothing'
and
quantiy >= 4
and
month(sale_date) = 11
and
year(sale_date) = 2022;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category , sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select  round(avg(age),2)
from retail_sales
where category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from retail_sales
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select category, gender , count(*)
from retail_sales
group by category, gender
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select * from
(
select 
year(sale_date) as year,
month(sale_date) as month ,
round(avg(total_sale),0) as avg_sales ,
rank () over(partition by year(sale_date)  order by avg(total_sale) desc) as rnk
from retail_sales
group by year(sale_date) ,month(sale_date)
order by 1 , 3 desc) as t1
where rnk <=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id, sum(total_sale)
from retail_sales
group by 1
order by sum(total_sale) desc
limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category, count(distinct customer_id) as unique_customer  
from retail_sales
group by 1;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

select 
		CASE
			WHEN Hour(sale_time) < 12 THEN 'Morning'
            WHEN Hour(sale_time) between 12 and 17 THEN 'Afternoon'
            ELSE 'Evening'
		END AS Shift,
        count(*) as number_of_orders
from retail_sales
group by 1
order by 2;

-- End of project






