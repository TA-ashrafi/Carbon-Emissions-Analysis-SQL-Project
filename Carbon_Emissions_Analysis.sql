-- ================================================================
-- ████████╗░█████╗░██╗░░██╗░██████╗███████╗███████╗███╗░░██╗
-- ╚══██╔══╝██╔══██╗██║░░██║██╔════╝██╔════╝██╔════╝████╗░██║
-- ░░░██║░░░███████║███████║╚█████╗░█████╗░░█████╗░░██╔██╗██║
-- ░░░██║░░░██╔══██║██╔══██║░╚═══██╗██╔══╝░░██╔══╝░░██║╚████║
-- ░░░██║░░░██║░░██║██║░░██║██████╔╝███████╗███████╗██║░╚███║
-- ░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚══════╝╚══════╝╚═╝░░╚══╝
--            Terminal ID: #TAHSEEN | Project: Emissions.sql
-- ================================================================

CREATE DATABASE carbon_emissions;
USE carbon_emissions;

CREATE TABLE emissions (
    entity VARCHAR(100),
    code VARCHAR(10),
    year INT,
    annual_emissions_tonnes BIGINT
);

SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/co2_emission.csv'
INTO TABLE emissions
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM emissions;

-- ===============================================================
-- ========================= TASKs ===============================
-- ===============================================================

-- Task 1: Total CO₂ Emissions for Each Country
SELECT entity, SUM(annual_emissions_tonnes) AS total_emission
FROM emissions
GROUP BY entity
ORDER BY total_emission DESC
LIMIT 10;


-- Task 2: Trend of Global Emissions Over Time
SELECT year, SUM(annual_emissions_tonnes) AS total_emission
FROM emissions
GROUP BY year
ORDER BY year ASC;


-- Task 3: India's Emissions Over Time
SELECT year, annual_emissions_tonnes AS total_emission
FROM emissions
WHERE entity = 'India'
ORDER BY year DESC;


-- Task 4: Countries with Decreasing Emissions (last 5 years)
SELECT entity,
       SUM(CASE WHEN year = 2012 THEN annual_emissions_tonnes ELSE 0 END) AS emissions_2012,
       SUM(CASE WHEN year = 2017 THEN annual_emissions_tonnes ELSE 0 END) AS emissions_2017,
       (SUM(CASE WHEN year = 2012 THEN annual_emissions_tonnes ELSE 0 END) - 
        SUM(CASE WHEN year = 2017 THEN annual_emissions_tonnes ELSE 0 END)) AS reduction
FROM emissions
GROUP BY entity
HAVING reduction > 0
ORDER BY reduction DESC
LIMIT 20;


-- Task 5: Average Annual Emissions by Country
SELECT entity, ROUND(AVG(annual_emissions_tonnes), 2) AS average_emission
FROM emissions
GROUP BY entity
ORDER BY average_emission DESC
LIMIT 20;


-- Task 6: First Year of Emissions Data for Each Country
SELECT entity, MIN(year) AS first_year
FROM emissions
GROUP BY entity;


-- Task 7: Highest Emission Recorded by a Country in a Single Year
SELECT entity, year, annual_emissions_tonnes
FROM emissions
ORDER BY annual_emissions_tonnes DESC
LIMIT 1;


-- Task 8: Emissions Growth Rate of India (Using JOIN)
SELECT curr.year,
       curr.annual_emissions_tonnes,
       pre.annual_emissions_tonnes AS previous_year,
       ROUND(((curr.annual_emissions_tonnes - pre.annual_emissions_tonnes) / pre.annual_emissions_tonnes) * 100, 2) AS growth_rate
FROM emissions curr
JOIN emissions pre ON curr.entity = pre.entity AND curr.year = pre.year + 1
WHERE curr.entity = 'India'
ORDER BY curr.year DESC;


-- Task 8 (Alternate): Emissions Growth Rate of India (Using LAG)
SELECT year,
       annual_emissions_tonnes,
       LAG(annual_emissions_tonnes) OVER (PARTITION BY entity ORDER BY year) AS previous_year,
       ROUND((annual_emissions_tonnes - LAG(annual_emissions_tonnes) OVER (PARTITION BY entity ORDER BY year)) / 
             LAG(annual_emissions_tonnes) OVER (PARTITION BY entity ORDER BY year) * 100, 2) AS growth_percent
FROM emissions
WHERE entity = 'India'
ORDER BY year DESC;

-- Task 9: Compare Emissions in 1990 vs 2020 for Each Country
SELECT entity,
       SUM(CASE WHEN year = 1990 THEN annual_emissions_tonnes END) AS em_1990,
       SUM(CASE WHEN year = 2020 THEN annual_emissions_tonnes END) AS em_2020
FROM emissions
GROUP BY entity
HAVING em_1990 IS NOT NULL AND em_2020 IS NOT NULL;


-- Task 10: Top 20 Countries by Total Emissions
SELECT entity, SUM(annual_emissions_tonnes) AS total_emission
FROM emissions
GROUP BY entity
ORDER BY total_emission DESC
LIMIT 20;
