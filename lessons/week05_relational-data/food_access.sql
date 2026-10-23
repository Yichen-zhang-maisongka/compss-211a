-- Your answers as a script that can run again.
--
-- 1. Save a copy of this file as food_access_mine.sql in this folder.
-- 2. Write each query in your copy, under its question.
--    To run one, copy it and paste it at the DuckDB prompt.
-- 3. At the end, in the terminal, in this folder, run:  duckdb -f food_access_mine.sql

-- Load the two CSV files from the course data folder as tables.
CREATE TABLE tracts AS SELECT * FROM '../../data/week05_food_access_tracts.csv';
CREATE TABLE counties AS SELECT * FROM '../../data/week05_ca_counties.csv';

-- Question 1
SELECT
             COUNT(*) AS total_tracts,
             SUM(low_income_low_access) AS flagged_tracts
         FROM tracts;
┌──────────────┬────────────────┐

-- Question 2
SELECT
             c.county_name,
             SUM(t.low_income_low_access) AS flagged_tracts
         FROM tracts AS t
         JOIN counties AS c
             ON t.county_fips = c.county_fips
         GROUP BY c.county_name
         ORDER BY flagged_tracts DESC
         LIMIT 5;

-- Question 3
ELECT
             c.county_name,
             COUNT(*) AS total_tracts,
             SUM(t.low_income_low_access) AS flagged_tracts,
             100.0 * AVG(t.low_income_low_access) AS flagged_percent
         FROM tracts AS t
         JOIN counties AS c
             ON t.county_fips = c.county_fips
         GROUP BY c.county_name
         ORDER BY flagged_percent DESC
         LIMIT 5;
