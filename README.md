# # Data Analyst Job Market Analysis
*Exploring salary trends, skill demand, and optimal career skills in data analytics*

---

## Introduction
This project analyzes the Data Analyst job market to understand how **salary levels, skill demand, and skill specialization** interact. Using job posting data, the analysis answers five key questions related to top-paying roles, in-demand skills, salary-driving skills, and the optimal skills that balance both demand and compensation.

The goal is to provide **data-driven insights** that help aspiring and current Data Analysts make informed decisions about skill development and career progression.

Check SQL queries out here: [project_sql folder](/project_sql/)

---

## Background
The demand for Data Analysts continues to grow, but compensation varies widely depending on **role seniority, technical depth, and the technologies used**. While some skills are highly demanded, others—though less common—command significantly higher salaries.

This project bridges that gap by analyzing:
- Which Data Analyst roles pay the most
- Which skills are most demanded
- Which skills drive higher salaries
- Which skills optimally combine **high demand and high pay**

---

## Tools Used
- **SQL (PostgreSQL)** – data querying, joins, aggregations, and filtering  
- **VS Code** – SQL development and analysis  
- **Git & GitHub** – version control and project documentation  
- **CSV datasets** – structured job posting data  

---

## The Analysis

### 1. Top Paying Data Analyst Jobs
The highest-paying roles extend beyond traditional “Data Analyst” titles and are concentrated in **senior and leadership positions** such as Director of Analytics, Associate Director, and Principal Data Analyst. These roles offer significantly higher compensation due to their broader scope, strategic influence, and decision-making responsibility.

Remote and flexible work arrangements dominate the top salary tier, indicating a strong correlation between geographic flexibility and higher pay. Additionally, many of these roles are business-facing, particularly in areas such as marketing analytics and performance analysis, where insights directly impact strategic outcomes. High salaries are largely concentrated in large, data-driven organizations, reinforcing the link between analytics maturity and compensation.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    cd.name AS company_name
FROM 
    job_postings_fact
LEFT JOIN 
    company_dim as cd
ON job_postings_fact.company_id = cd.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL 
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
```
---

### 2. Skills Required for Top-Paying Data Analyst Jobs
Top-paying Data Analyst roles require a **balanced and advanced skill set**. SQL remains the foundational skill for extracting and transforming data, while Python acts as a key differentiator by enabling automation and complex analytics.

Data visualization tools such as Tableau and Excel remain essential for communicating insights effectively. In addition, experience with cloud-based platforms like Snowflake and Azure is strongly associated with higher compensation. The presence of specialized and engineering-oriented tools further suggests that higher-paying roles often involve production-level data environments and greater technical responsibility.
```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        cd.name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN 
        company_dim as cd
    ON job_postings_fact.company_id = cd.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL 
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills as skill_name
FROM
    top_paying_jobs
INNER JOIN 
    skills_job_dim
ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;
```
---

### 3. Most In-Demand Data Analyst Skills
SQL is the most in-demand skill by a wide margin, confirming its role as the core requirement across Data Analyst positions. Excel ranks second, demonstrating that traditional spreadsheet-based analysis remains highly relevant in business contexts.

Python is also in strong demand, though slightly behind Excel, indicating that programming skills often complement rather than replace core querying and reporting tasks. Visualization tools such as Tableau and Power BI are widely required, reflecting the importance of communicating data insights effectively. Overall, the most demanded skills emphasize **practicality and immediate business value** rather than specialization.
```sql
SELECT 
    skills,
    COUNT(*) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.job_work_from_home = true
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```
---

### 4. Top Skills Based on Salary
Salary-driven skill analysis reveals that **big data and distributed computing tools** such as PySpark and Databricks command the highest average salaries. This indicates that Data Analysts working with large-scale data systems are rewarded more than those focused on traditional analytics.

High-paying roles increasingly overlap with data engineering and MLOps responsibilities, as reflected by tools such as Kubernetes, Airflow, Jenkins, GitLab, and Linux. Machine learning–related skills also correlate with higher compensation, even when the role is not explicitly a Data Scientist position. Cloud-native platforms and niche technologies further contribute to higher salaries, showing that depth and specialization matter more than widespread adoption.
```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    2 DESC
LIMIT 25;
```
---

### 5. Optimal Skills: High Demand and High Pay
The optimal skills for Data Analysts lie at the intersection of **strong market demand and high salary potential**. Big data tools such as PySpark and Databricks lead this category, highlighting the value of scalable data processing expertise.

Top salaries increasingly require skills beyond traditional analytics, including data engineering, MLOps, and production system tools. Machine learning–related skills further enhance earning potential, while version control and collaboration tools such as GitLab and Bitbucket signal seniority and system-level responsibility. Overall, compensation is driven by **skill depth and technical complexity**, not by popularity alone.
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

```
---

## What I Learned
- SQL is indispensable across all Data Analyst roles, regardless of salary level.  
- Higher compensation is strongly associated with seniority, system ownership, and production-level responsibilities.  
- Big data, cloud platforms, and MLOps tools significantly increase earning potential.  
- The most demanded skills are not always the highest paying, highlighting the importance of strategic skill development.  

---

## Conclusion
The Data Analyst job market rewards professionals who move beyond foundational analytics into **scalable data systems, cloud platforms, and advanced technical workflows**. While SQL, Excel, and visualization tools remain essential for employability, the highest salaries are driven by specialized skills in big data, machine learning, and data infrastructure. This analysis demonstrates that a balanced combination of **high-demand fundamentals and high-impact advanced skills** is key to long-term career growth and financial success in data analytics.

