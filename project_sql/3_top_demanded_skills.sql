/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst
- Focus on all job postings
- Why? Retrieves the top 5 skills with the highest demand in the job market,
  providing insights into the most valuable skills for job seekers
*/;





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

/*
Key Insights – Most In-Demand Data Analyst Skills

SQL is the dominant foundational skill
SQL has the highest demand by a significant margin, confirming its role as the core requirement for Data Analyst positions across industries.

Spreadsheet proficiency remains highly relevant
Excel ranks second, indicating that traditional data analysis and reporting tools continue to be widely used alongside more advanced technologies.

Programming skills are critical but secondary to SQL
Python appears slightly behind Excel in demand, suggesting that while programming is important, it is often complementary to core querying and reporting tasks.

Data visualization tools are essential for business communication
Tableau and Power BI together show strong demand, highlighting the importance of translating data into actionable insights for stakeholders.

Demand favors practicality over specialization
The most in-demand skills are broadly applicable tools, reflecting employers’ preference for analysts who can immediately support day-to-day business analytics.
*/