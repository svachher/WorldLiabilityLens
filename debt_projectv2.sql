use debt_project ;

ALTER TABLE international_debt_dataset_sample
MODIFY COLUMN country_name VARCHAR(100),
MODIFY COLUMN country_code CHAR(3),
MODIFY COLUMN indicator_name VARCHAR(255),
MODIFY COLUMN indicator_code VARCHAR(50),
CHANGE COLUMN debt debt_amount_usd DOUBLE;

ALTER TABLE international_debt_dataset_sample
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

select* from international_debt_dataset_sample
limit 19;

-- step 2 identify all the countries 
select count(distinct(country_name)) as Total_Distinct_Countries 
from international_debt_dataset_sample;


-- step 3 identify distinct debt indicators 

select distinct(indicator_code) as debt_indicators
from international_debt_dataset_sample
group by debt_indicators
order by debt_indicators;

-- Step 4: Total Amount of Debt Owed to World Bank by Countries

SELECT ROUND(SUM(debt_amount_usd)/1000000, 2) AS total_debt_million
FROM international_debt_dataset_sample;

-- Step 5: Find the Country with the Highest Debt
SELECT country_name, ROUND(SUM(debt_amount_usd)/1000000, 2) AS total_debt_million
FROM international_debt_dataset_sample
GROUP BY country_name
ORDER BY total_debt_million DESC
LIMIT 1;


-- Step 6: Find average debt amount across debt indicators

SELECT 
    indicator_code AS debt_indicator, 
    ROUND(AVG(debt_amount_usd)/1000000, 2) AS average_debt_million,
    indicator_name
FROM international_debt_dataset_sample
GROUP BY indicator_code, indicator_name
ORDER BY average_debt_million DESC
LIMIT 20;

-- Step 7: Country with the highest amount of external debt repayments  Top 10 Countries with Highest Average Long-Term Debt (in Millions USD)
SELECT 
    country_name, 
    ROUND(AVG(debt_amount_usd)/1000000, 2) AS average_debt_million, 
    indicator_name, 
    indicator_code
FROM international_debt_dataset_sample
WHERE indicator_code = 'DT.AMT.DLXF.CD'
GROUP BY country_name, indicator_name, indicator_code
ORDER BY average_debt_million DESC
LIMIT 10;

-- Step 8: Most common debt indicator
SELECT 
    indicator_name, 
    COUNT(indicator_code) AS debt_indicator_count
FROM international_debt_dataset_sample
GROUP BY indicator_code, indicator_name
ORDER BY debt_indicator_count DESC
LIMIT 20;

-- Step 9: See the bigger picture   (Top 20 Country & Indicator Combinations by Maximum Debt)

SELECT 
    country_name, 
    indicator_name, 
    MAX(debt_amount_usd) AS max_debt
FROM international_debt_dataset_sample
GROUP BY country_name, indicator_name
ORDER BY max_debt DESC
LIMIT 20;


