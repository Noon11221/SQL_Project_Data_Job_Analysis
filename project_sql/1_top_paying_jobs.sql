
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

/*
Key Insights – Top Paying Data Analyst Jobs

Top-paying roles extend beyond traditional “Data Analyst” titles
The highest salaries are associated with senior and leadership positions such as Director of Analytics, Associate Director, and Principal Data Analyst, indicating that compensation increases significantly with responsibility and scope.

Remote and flexible roles dominate the highest salary tier
All top-paying positions are listed as Anywhere, Remote, or Hybrid, suggesting that geographic flexibility is strongly correlated with higher pay in the data analytics market.

Strategic and business-facing analytics roles command premium pay
Job titles related to marketing analytics, performance analysis, and data insights imply that roles closely tied to business decision-making tend to offer higher compensation.

High salaries are concentrated in large or data-driven organizations
Companies such as Meta, AT&T, Pinterest, and SmartAsset appear among the top-paying employers, highlighting that mature, data-centric organizations are willing to invest heavily in analytics talent.

Exceptional salaries reflect role seniority rather than volume of postings
The highest salary ($650K) is a clear outlier, reinforcing that extreme compensation is driven by niche, high-impact roles rather than typical analyst positions.
*/