/*
The total number of data and business analyst remote jobs for the top 5 required skills.
*/

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