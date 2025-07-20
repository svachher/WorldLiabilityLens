use debt_project ;

CREATE OR REPLACE VIEW top_10_countries_most_debt AS
SELECT 
    country_name, 
    ROUND(SUM(debt_amount_usd)/1000000, 2) AS total_debt_million
FROM international_debt_dataset_sample
GROUP BY country_name
ORDER BY total_debt_million DESC
LIMIT 10;


CREATE OR REPLACE VIEW bottom_10_countries_least_debt AS
SELECT 
    country_name, 
    ROUND(SUM(debt_amount_usd)/1000000, 2) AS total_debt_million
FROM international_debt_dataset_sample
GROUP BY country_name
ORDER BY total_debt_million ASC
LIMIT 10;


CREATE OR REPLACE VIEW avg_debt_across_indicators AS
SELECT 
    indicator_name,
    indicator_code,
    ROUND(AVG(debt_amount_usd)/1000000, 2) AS average_debt_million
FROM international_debt_dataset_sample
GROUP BY indicator_name, indicator_code
ORDER BY average_debt_million DESC;

CREATE OR REPLACE VIEW long_term_debt_avg AS
SELECT 
    country_name, 
    ROUND(AVG(debt_amount_usd)/1000000, 2) AS avg_long_term_debt_million
FROM international_debt_dataset_sample
WHERE indicator_code = 'DT.AMT.DLXF.CD'
GROUP BY country_name
ORDER BY avg_long_term_debt_million DESC
LIMIT 10;


CREATE OR REPLACE VIEW most_frequent_indicators AS
SELECT 
    indicator_name, 
    COUNT(indicator_code) AS indicator_frequency
FROM international_debt_dataset_sample
GROUP BY indicator_name
ORDER BY indicator_frequency DESC;

CREATE OR REPLACE VIEW top_20_country_indicator_combos AS
SELECT 
    country_name, 
    indicator_name, 
    MAX(debt_amount_usd) AS max_debt
FROM international_debt_dataset_sample
GROUP BY country_name, indicator_name
ORDER BY max_debt DESC
LIMIT 20;
 
 

CREATE OR REPLACE VIEW avg_debt_per_indicator AS
SELECT 
    indicator_name,
    indicator_code,
    ROUND(AVG(debt_amount_usd)/1000000, 2) AS average_debt_million
FROM 
    international_debt_dataset_sample
GROUP BY 
    indicator_name,
    indicator_code
ORDER BY 
    average_debt_million DESC;



CREATE OR REPLACE VIEW top_20_countries_relative_avg_total_debt AS
SELECT 
    country_name,
    ROUND(SUM(debt_amount_usd)/1000000, 2) AS sum_of_debt_million
FROM 
    international_debt_dataset_sample
GROUP BY 
    country_name
ORDER BY 
    sum_of_debt_million DESC
LIMIT 20;
