# Introduction

A set of SQL projects that help provide an insight into the job market based on the data provided, and how they can be filtered to provide more substantial information to be used for analyzing the job market.

## Code Source

The SQL data was generated and provided by an online source, [Luke Burossa](https://drive.google.com/drive/folders/1moeWYoUtUklJO6NJdWo9OV8zWjRn0rjN).
The data covers job opportunities across data-related professions, including Data Analysis, Business Analysis, and Data Science. This project concentrates primarily on Data Analyst and Business Analyst positions.
The database is organized into related tables containing information about companies, job postings, skills, and the association between job postings and skills.

### Technology Stack

- **SQL:** Data querying and analysis.
- **PostgreSQL:** Relational database management.
- **pgAdmin**: Database administration and query execution.

### Data Structure

The project uses the following tables:

|Table|Purpose|
|---|---|
|job_postings_fact|Contains job-posting details, including role, location, work arrangements, dates, and salary-related fields.|
|company_dim|Stores company-related information.|
|skills_dim|Stores skill names and skill classifications.|
|skills_job_dim|Connects job postings with their associated skills.|

The relationships between these tables allow job opportunities to be analyzed alongside company information, skill requirements, and compensation data.

## Purpose

The main aim of the project(s) is to conduct a study on the data provided and categorize the data based on the skills and the wage in the market, while also displaying the ability to categorize data using SQL queries and generating the appropriate tables of data to conduct further studies on.
