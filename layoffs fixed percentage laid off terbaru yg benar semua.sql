# Problem Utama : Terjadi peningkatan signifikan kasus PHK secara global, termasuk pada perusahaan dengan pendanaan besar. Namun, belum jelas faktor utama apa yang paling berkontribusi terhadap skala dan pola PHK tersebut.
-- Tujuan : untuk mengetahui faktor utama apa yang paling berkontribusi terhadap skala dan pola PHK tersebut.

select * from `rama adi`.layoffs_fixed;

-- >> DATA CLEANING <<--
# Hapus Dupikat
with duplikat as(
select *, 
	row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from `rama adi`.layoffs_fixed
)
select * 
from duplikat
where row_num > 1;

alter table `rama adi`.layoffs_fixed
add column id int auto_increment primary key;

with hapus_duplikat as(
	select 
		id,
        row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from `rama adi`.layoffs_fixed
)
delete from `rama adi`.layoffs_fixed
where id in (select id from hapus_duplikat where row_num > 1);

alter table `rama adi`.layoffs_fixed
drop column id;

# Cek company
select distinct company, trim(company)
from `rama adi`.layoffs_fixed
order by 1 asc
;

update `rama adi`.layoffs_fixed
set company = trim(company);

# Cek Location
select distinct location
from `rama adi`.layoffs_fixed
order by 1 asc;

# cek Industri
select distinct industry
from `rama adi`.layoffs_fixed
order by 1 asc;

-- mengganti crypto%
select industry 
from `rama adi`.layoffs_fixed
where industry like '%Crypto%';

update `rama adi`.layoffs_fixed
set industry = 'Crypto Curency' 
where industry like 'Crypto%';

-- null or ''
select industry 
from `rama adi`.layoffs_fixed
where industry is null or industry like ''; 

select * 
from `rama adi`.layoffs_fixed
where industry is null or industry like '';

select * 
from `rama adi`.layoffs_fixed
where location = 'SF Bay Area' and company = 'Airbnb'; 

select * 
from `rama adi`.layoffs_fixed a
join `rama adi`.layoffs_fixed b
on a.location = b.location
	and
		a.company = b.company
where a.industry is null or a.industry = ''
	and
		b.industry is not null;

select a.industry,
	b.industry 
from `rama adi`.layoffs_fixed a
join `rama adi`.layoffs_fixed b
	on a.company = b.company
		and 
		a.location = b.location
where a.industry is null or a.industry = ''
	and b.industry is not null;
    
update `rama adi`.layoffs_fixed
set industry = null 
where industry like '';    

update `rama adi`.layoffs_fixed a
join `rama adi`.layoffs_fixed b
	on a.company = b.company
    and
		a.location = b.location
set a.industry = b.industry
where (a.industry is null or a.industry like '')
	and
		b.industry is not null;
        
# Cek total_laid_off AND percentage_laif_off
select distinct total_laid_off
from `rama adi`.layoffs_fixed
order by 1 asc;

select *
from `rama adi`.layoffs_fixed
where total_laid_off is null;

select distinct percentage_laid_off
from `rama adi`.layoffs_fixed
order by 1 asc;

select *
from `rama adi`.layoffs_fixed
where percentage_laid_off is null;

delete from `rama adi`.layoffs_fixed
where total_laid_off is null and percentage_laid_off is null;

# Cek tanggal
select date 
from `rama adi`.layoffs_fixed
order by 1 asc; 

select * 
from `rama adi`.layoffs_fixed
where date is null; 

select date, str_to_date(date, '%m/%d/%Y') as updated
from `rama adi`.layoffs_fixed
order by 1 asc; 

update `rama adi`.layoffs_fixed
set date = str_to_date(date, '%m/%d/%Y');

alter table `rama adi`.layoffs_fixed
modify column `date` Date;

# Cek Stage
select distinct stage
from `rama adi`.layoffs_fixed
order by 1 asc;

select *
from `rama adi`.layoffs_fixed
where stage is null;

select *
from `rama adi`.layoffs_fixed
where company = 'Verily';

select *
from `rama adi`.layoffs_fixed
where stage = 'Unknown';

# Cek Country
select distinct country
from `rama adi`.layoffs_fixed
order by 1 asc;

update `rama adi`.layoffs_fixed
set country = 'United States'
where country like 'United States%';

# Cek funds_raised_millions
select distinct funds_raised_millions
from `rama adi`.layoffs_fixed
order by 1 asc;

select * from 
`rama adi`.layoffs_fixed
where funds_raised_millions is null;

-- >> EXPLORATORY DATA ANALYZE << --

select * from `rama adi`.layoffs_fixed;

describe `rama adi`.layoffs_fixed;

# 1. Apakah besarnya pendanaan berbanding terbalik dengan risiko PHK?
SELECT 
    CASE 
        WHEN funds_raised_millions < 50 THEN 'Low Funding'
        WHEN funds_raised_millions BETWEEN 50 AND 200 THEN 'Medium Funding'
        ELSE 'High Funding'
    END AS funding_category,
    COUNT(*) AS total_company,
    SUM(total_laid_off) AS total_layoffs,
    ROUND(AVG(total_laid_off),2) AS avg_layoffs
FROM `rama adi`.layoffs_fixed
WHERE funds_raised_millions IS NOT NULL
GROUP BY funding_category
ORDER BY total_layoffs DESC;

-- Banyak perusahaan high funding tetap melakukan PHK besar
-- Funding ≠ efisiensi operasional

# 2. Industri apa yang paling rentan terhadap PHK massal?
select industry,
	count(distinct company) as `Total Company`,
	sum(total_laid_off) as `Total Laid Off`,
	round(avg(total_laid_off), 2) as `Avg Total Laid Off`,
    round(avg(percentage_laid_off), 2) as `Avg Percentage Laid Off`,
    sum(funds_raised_millions) as `Total Pendanaan`
from `rama adi`.layoffs_fixed
group by 1
order by 3 desc;

-- Consumer, Retail, Other, Transportation, Finance menjadi industri yang paling tertinggi PHKnya dan rentan terhadap PHK.

# Company apa yang paling banyak melakukan PHK?
select company,
	sum(total_laid_off) as `Total Laid off`,
	round(avg(total_laid_off), 2) as `Avg Total Laid off`,
    round(avg(percentage_laid_off), 2) as `Avg Presentase Laid Off`,
	sum(funds_raised_millions) as `Total Dana`
from `rama adi`.layoffs_fixed
group by company
order by 2 desc;

select industry,
	company,
	sum(total_laid_off) as `Total Laid off`,
	round(avg(total_laid_off), 2) as `Avg Total Laid off`,
    round(avg(percentage_laid_off), 2) as `Avg Presentase Laid Off`,
	sum(funds_raised_millions) as `Total Dana`
from `rama adi`.layoffs_fixed
group by 1, 2
order by 3 desc;

# 3. Apakah PHK terkonsentrasi secara geografis?
select location,
	sum(total_laid_off) as `Total Laid Off`,
	round(avg(total_laid_off), 2) as `Avg Total Laid Off`,
    round(avg(percentage_laid_off), 2) as `Avg Presentase Laid Off`,
    sum(funds_raised_millions) as `Total Dana`
from `rama adi`.layoffs_fixed
group by 1
order by 2 desc;

select country,
	sum(total_laid_off) as `Total Laid Off`,
	round(sum(total_laid_off) / (select sum(total_laid_off) from `rama adi`.layoffs_fixed) * 100, 2) as `Presentase Total Laid Off`,
	round(avg(total_laid_off), 2) as `Avg Total Laid Off`,
    round(avg(percentage_laid_off), 2) as `Avg Presentase Laid Off`,
    sum(funds_raised_millions) as `Total Dana`
from `rama adi`.layoffs_fixed
group by 1
order by 2 desc;

-- United States mendominasi PHK gobal, sejalan dengan konsentrasi startup dan bightech. 

# 4. Pada periode waktu apa gelombang PHK mencapai puncaknya?
-- Tahun
select year(date) as Year,
	sum(total_laid_off) as `Total Laid Off`,
	round(avg(total_laid_off), 2) as `Avg Total Laid Off`,
    round(avg(percentage_laid_off), 2) as `Avg Presentase Laid Off`,
    sum(funds_raised_millions) as `Total Dana`
from `rama adi`.layoffs_fixed
where year(date) is not null
group by 1
order by 2 desc;

with cte as(
	select year(date) as Year,
		sum(total_laid_off) as `Total Laid Off`,
		round(avg(total_laid_off), 2) as `Avg Total Laid Off`,
		round(avg(percentage_laid_off), 2) as `Avg Presentase Laid Off`,
		sum(funds_raised_millions) as `Total Dana`
	from `rama adi`.layoffs_fixed
	where year(date) is not null
	group by 1
)
select 
	Year,
    `Total Laid Off`,
	round((`Total Laid Off` - lag(`Total Laid Off`) over(order by Year)) / lag(`Total Laid Off`) over(order by Year) * 100, 2) as `Presentase Perubahan Total Laid Off`,
    `Avg Presentase Laid Off`,
    `Total Dana`
from cte;

-- Lonjakan PHK Massal terbesar terjadi pada tahun 2022 yang mencapai 915.36% lebih besar daripada tahun sebelumnya. 

select year(date),
	company,
	sum(total_laid_off) as `Total Laid Off`,
	round(avg(total_laid_off), 2) as `Avg Total Laid Off`,
    round(avg(percentage_laid_off), 2) as `Avg Presentase Laid Off`,
    sum(funds_raised_millions) as `Total Dana`
from `rama adi`.layoffs_fixed
where year(date) is not null
group by 1, 2
order by 1, 3 desc;

select year(date),
	industry,
	sum(total_laid_off) as `Total Laid Off`,
	round(avg(total_laid_off), 2) as `Avg Total Laid Off`,
    round(avg(percentage_laid_off), 2) as `Avg Presentase Laid Off`,
    sum(funds_raised_millions) as `Total Dana`
from `rama adi`.layoffs_fixed
where year(date) is not null
group by 1, 2
order by 1, 3 desc;



-- Bulan
select date_format(date, '%Y-%m') as Month,
	sum(total_laid_off) as `Total Laid Off`,
	round(avg(total_laid_off), 2) as `Avg Total Laid Off`,
    round(avg(percentage_laid_off), 2) as `Avg Presentase Laid Off`,
    sum(funds_raised_millions) as `Total Pendanaan`
from `rama adi`.layoffs_fixed
where date is not null
group by 1
order by 1 asc;

-- PHK meningkat konsisten dari pertengahan 2022 hingga awal 2023.

# 5. Apakah funding stage memengaruhi skala PHK?
select stage,
	count(*) as `Total Case`,
	sum(total_laid_off) as `Total Laid Off`, 
    round(avg(total_laid_off), 2) as `Avg Total Laid Off`,
    avg(percentage_laid_off) as `Avg Presentase Laid Off`,
    sum(funds_raised_millions) as `Total Dana`
from `rama adi`.layoffs_fixed
group by 1
order by 2 desc;

-- PHK paling banyak terjadi pada Post-IPO mengindikasikan koreksi setelah fase hyper-growth.

# 6. Apakah PHK mencerminkan kegagalan bisnis atau strategi efisiensi?
select stage,
	count(*) as `Total Company`
from `rama adi`.layoffs_fixed
where percentage_laid_off = 1
group by 1
order by 2 desc;


# 7. Apa ciri perusahaan yang tutup total?
SELECT 
    industry,
    stage,
    COUNT(*) AS total_shutdown
FROM `rama adi`.layoffs_fixed
WHERE percentage_laid_off = 1
GROUP BY industry, stage
ORDER BY total_shutdown DESC;

