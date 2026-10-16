# Project Scope

This project focuses on the following 5 questions:

- What are the top paying remote jobs for Data and Business analysis?
- What are the skills needed to get the highest salary?
- Which Data and Business analysis skills are the most in-demand?
- What are the salaries for the most in-demand jobs?
- What are the most optimal skills for Data and Business analysts?

Using these questions as baselines, table were created from the dataset to generate a much more readable data for further analysis, which could be completed via spreadsheets or BI tools.

## Results

The 4 main tables were filtered for a more simplistic data, based on the questions mentioned above.

### What are the top paying remote jobs for Data and Business analysis?

```sql
SELECT
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```

The table created from the above query is provided as [CSV file](/SQL_Project/Result_Tables/Table_1.csv).

### What are the skills needed to get the highest salary?

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg,
        job_posted_date
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst')AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills_dim.skills
FROM
    top_paying_jobs
INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

The table created from the above query is provided as [CSV file](/SQL_Project/Result_Tables/Table_2.csv).

### Which Data and Business analysis skills are the most in-demand?

```sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS job_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
    job_work_from_home = TRUE
GROUP BY skills
ORDER BY job_count DESC
LIMIT 5;
```

The table created from the above query is provided as [CSV file](/SQL_Project/Result_Tables/Table_3.csv).

### What are the salaries for the most in-demand jobs?

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
```

The table created from the above query is provided as [CSV file](/SQL_Project/Result_Tables/Table_4.csv).

### What are the most optimal skills for Data and Business analysts?

```sql
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS job_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
),

average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.job_count,
    average_salary.avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    skills_demand.job_count > 10
ORDER BY
    average_salary.avg_salary DESC,
    skills_demand.job_count DESC
LIMIT 25;WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS job_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
),

average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst') AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.job_count,
    average_salary.avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    skills_demand.job_count > 10
ORDER BY
    average_salary.avg_salary DESC,
    skills_demand.job_count DESC
LIMIT 25;
```

The table created from the above query is provided as [CSV file](/SQL_Project/Result_Tables/Table_5.csv).
An alternate method for writing the above query, without the use of CTEs is provided in the following [SQL file](/SQL_Project/Topic_5.sql).

## Learning Outcome

Via this mini-project, the following SQL queries were identified, essential for filtering data and creating tables which can be further analyzed.

|SQL Commands|Application|
|---|---|
|SELECT and WHERE|Retrieve relevant columns and filter records.|
|ORDER BY|Sort results for easier comparison.|
|GROUP BY|Group records by skills, companies, or other attributes.|
|Aggregation function (SUM, COUNT, etc.)|Count postings and summarize numerical values.|
|JOIN|Combine multiple tables for better insight on data|
|Primary and Foreign keys|Establish relationships and maintain referential integrity.|
|||

## Conclusion

From the analysis, several general insights emerged:

- Top-Paying Data Analyst Jobs: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
- Skills for Top-Paying Jobs: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
- Most In-Demand Skills: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job-seekers.
- Skills with Higher Salaries: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
- Optimal Skills for Job Market Value: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

This SQL analysis demonstrates how structured employment data can be explored through relational database queries. By connecting job postings with company and skill information, the project provides a practical foundation for investigating job requirements and compensation patterns in data-related professions.

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.
