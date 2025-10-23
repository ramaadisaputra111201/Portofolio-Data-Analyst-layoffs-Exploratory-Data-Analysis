-- Explorasi Data Analys (EDA)

-- 1. find the maximum value of total laid off and percentage laid off
select max(total_laid_off), max(percentage_laid_off) from `rama adi`.layoffs_staging;

-- 2. find rows where percentage laid off = 1 and ordered by funds raised (in millions)
select * from `rama adi`.layoffs_staging
	where percentage_laid_off = 1 
    order by funds_raised_millions desc;

-- 3. List of Companies with the Highest Total Layoffs
select company, sum(total_laid_off) 
from `rama adi`.layoffs_staging
group by company
order by 2 desc;

-- 4. find the maximum and minimum values of the date
select min(date), max(date) 
from `rama adi`.layoffs_staging;

-- 5. Display the total number of laid-off employees for each industry, ordered from the highest to the lowest
select industry, sum(total_laid_off) 
from `rama adi`.layoffs_staging
group by industry
order by 2 desc;

-- 6. Display the total number of laid-off employees for each country, ordered from the highest to the lowest.
select country, sum(total_laid_off) 
from `rama adi`.layoffs_staging
group by country
order by 2 desc;

-- 7. Display the total number of laid-off employees for each year, ordered by year from the most recent to the oldest.
select year(date), sum(total_laid_off) 
from `rama adi`.layoffs_staging
group by year(date)
order by 1 desc;

-- 8. Display the total number of laid-off employees by company funding stage, ordered by stage name in descending order.
select stage, sum(total_laid_off) 
from `rama adi`.layoffs_staging
group by stage
order by 1 desc;

-- 9. Display the average percentage of employees laid off for each company, ordered from the highest to the lowest average percentage.
select company, avg(percentage_laid_off) 
from `rama adi`.layoffs_staging
group by company
order by 2 desc;

-- 10. Display the total number of employees laid off for each month, excluding rows with null date values, and order the results by month in ascending order
select substring(date, 1,7) as month, sum(total_laid_off)
from `rama adi`.layoffs_staging
where substring(date, 1, 7) is not null
group by month
order by 1 asc;

-- 11. Display the total number of employees laid off each month, along with a rolling total that shows the cumulative number of layoffs over time (month by month).
with rolling_total as(
select substring(date, 1, 7) as month, 
	sum(total_laid_off) as total_off
from `rama adi`.layoffs_staging
where substring(date, 1, 7) is not null
group by month
order by 1 asc
)
select month,  total_off, sum(total_off)
	over(order by month) as rolling_total
from rolling_total;

-- 12. Display the total number of employees laid off for each company per year, ordered by the highest total layoffs first.
select company, year(date) as year, sum(total_laid_off) as total_off
from `rama adi`.layoffs_staging
group by company, year(date)
order by 3 desc;

-- 13. Display the top 5 companies with the highest number of layoffs for each year.
with company_year (company, year, total_laid_off) as(
select company, year(date), sum(total_laid_off)
from `rama adi`.layoffs_staging
group by company, year(date)
), 
company_year_rank as(
select * , dense_rank() over(partition by year order by total_laid_off desc) as Ranking
from company_year
where year is not null
)
select * from company_year_rank
where Ranking <= 5
;

-- atau dengan 

with company_years as (
select company, 
	year(date) as years, 
    sum(total_laid_off) as total_off,
    rank() over(partition by year(date) order by sum(total_laid_off) desc) as Ranking_best
from `rama adi`.layoffs_staging
where year(date) is not null
group by company, years
)
select * from company_years where Ranking_best <= 5;