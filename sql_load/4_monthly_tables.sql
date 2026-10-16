-- This SQL script generates separate table for each month

-- January jobs table
CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February jobs table
CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March jobs table
CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT * FROM january_jobs;
SELECT * FROM february_jobs;
SELECT * FROM march_jobs;

-- This SQL script is used to combine months together into a single table.

-- First-quarter jobs table
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs

-- Using the above queries, tables can be created for the other months, and further for the other 3 quaters, simply by changing the value of the month in the EXTRACT function.