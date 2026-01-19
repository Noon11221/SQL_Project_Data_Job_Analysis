/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
  offering strategic insights for career development in data analysis
*/


WITH skills_demand as (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills, 
        COUNT(*) as demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_postings_fact.job_work_from_home = true
    GROUP BY skills_dim.skill_id

) ,average_salary AS(
SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY
    skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary USING(skill_id)
WHERE
    demand_count > 10
ORDER BY avg_salary DESC

LIMIT 25;


-- Rewriting above query more concisely
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

/*
Highest-paying Data Analyst roles favor big data and distributed systems, with PySpark and Databricks leading salary rankings, reflecting the value of working with large-scale data environments.

Top salaries increasingly require skills beyond traditional analytics, including data engineering and MLOps tools such as Airflow, Kubernetes, Jenkins, and Linux.

Machine learning–related skills correlate with higher compensation, indicating that analysts who can support or apply ML workflows earn more.

Version control and collaboration tools (GitLab, Bitbucket) appear frequently, signaling that higher pay is associated with seniority and production-level responsibility.

Salary is driven by skill depth rather than popularity, as many high-paying skills are specialized and less common.
*/ 