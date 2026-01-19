/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and
  helps identify the most financially rewarding skills to acquire or improve
*/



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


/*
Key Trends in Top-Paying Data Analyst Skills

Big Data & Distributed Computing Drive the Highest Salaries
Skills such as PySpark and Databricks sit at the top of the salary range, indicating that Data Analysts who work with large-scale, distributed data systems are rewarded significantly more than those focused solely on traditional analytics.

Data Analysts Are Moving Closer to Engineering and MLOps
Tools like Kubernetes, Airflow, Jenkins, GitLab, Bitbucket, and Linux suggest that top-paying roles increasingly expect analysts to operate within production environments, pipelines, and CI/CD workflows rather than isolated analysis tasks.

Machine Learning Capability Increases Earning Potential
The presence of DataRobot, scikit-learn, NumPy, and Pandas shows that analysts who can build, deploy, or support machine learning models tend to earn higher salaries, even if their primary role is not “Data Scientist.”

Cloud and Platform Expertise Is Strongly Valued
Skills such as GCP, Databricks, and Kubernetes highlight that familiarity with cloud-native data platforms is a strong indicator of higher compensation, reflecting the industry shift toward scalable, cloud-based analytics infrastructure.

Specialized and Niche Tools Command Premium Pay
Technologies like Couchbase, Elasticsearch, Twilio, and MicroStrategy appear less frequently but offer high average salaries, suggesting that niche expertise can significantly boost earning potential when demand outpaces supply.

High Pay Reflects Role Seniority, Not Just Skill Popularity
Many top-paying skills are not the most common ones, indicating that salary is driven more by depth of expertise and system-level responsibility than by widely used tools alone.

*/; 


