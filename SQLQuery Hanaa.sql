CREATE DATABASE AI_Job_Market_Analysis
GO

--SHow Data Tables
SELECT TOP 5 * FROM jobs_ai;
SELECT TOP 5 * FROM skills_demand;
SELECT TOP 5 * FROM country_trends;
SELECT TOP 5 * FROM job_title_mapping;

USE AI_Job_Market_Analysis;
GO
--#check unmatched items

SELECT COUNT(*) AS Unmatched_Ids
FROM skills_demand s
LEFT JOIN jobs_ai j
ON TRIM(s.Job_Id) = TRIM(j.Job_Id)
WHERE j.Job_Id IS NULL;
-- there are Jobs IDS unmatched
--#I will use new table to use only the matched Ids 
--#checking new table

USE AI_Job_Market_Analysis;
GO

SELECT COUNT(*) AS Unmatched_Ids
FROM clean_skills_demand s
LEFT JOIN jobs_ai j
ON TRIM(s.Job_Id) = TRIM(j.Job_Id)
WHERE j.Job_Id IS NULL;

USE AI_Job_Market_Analysis;
GO

--#cleaning jobs_ai&create newtable(clean_jobs_ai)
SELECT
    TRIM(Job_Id) AS Job_Id,
    TRIM(Job_Title) AS Job_Title,
    TRIM(Company_Type) AS Company_Type,
    TRIM(Industry) AS Industry,
    TRIM(Country) AS Country,
    TRIM(City) AS City,
    TRIM(Job_Type) AS Job_Type,
    TRIM(Experience_Level) AS Experience_Level,
    Experience_Level_Order,
    Min_Experience_Years,
    Salary_Min_Usd,
    Salary_Max_Usd,
    Average_Salary_Usd,
    TRIM(Employment_Type) AS Employment_Type,
    Posted_Year,
    TRIM(Company_Size) AS Company_Size,
    TRIM(Country_Year_Key) AS Country_Year_Key
INTO clean_jobs_ai
FROM jobs_ai;

--#cleaningcountry_trendstable

SELECT
    TRIM(country) AS Country,
    year AS Posted_Year,
    total_ai_jobs AS Total_AI_Jobs,
    avg_salary_usd AS Avg_Salary_Usd,
    remote_percentage AS Remote_Percentage,
    TRIM(top_skill) AS Top_Skill,
    TRIM(Country_Year_Key) AS Country_Year_Key
INTO clean_country_trends
FROM country_trends;

--# Check for all cleaned tables


CREATE VIEW vw_jobs_ai AS
SELECT *
FROM clean_jobs_ai;
GO

CREATE VIEW vw_skills_demand AS
SELECT *
FROM clean_skills_demand;
GO

CREATE VIEW vw_country_trends AS
SELECT *
FROM clean_country_trends;
GO

--#Watch&checkviewtables

SELECT TOP 5 * FROM vw_jobs_ai;
SELECT TOP 5 * FROM vw_skills_demand;
SELECT TOP 5 * FROM vw_country_trends;

-- Relations
--every job do more than one skill
vw_jobs_ai[Job_Id] → vw_skills_demand[Job_Id]
One to Many

--Skills in All countries had been done with one job
vw_jobs_ai[Country_Year_Key] → vw_country_trends[Country_Year_Key]
Many to One
 
--#THE Begining of analysis

--#(1)#queryforanalyzing(alltotaljobs)

SELECT COUNT(DISTINCT Job_Id) AS Total_Jobs
FROM vw_jobs_ai;


--#(2)AVGSALARY

SELECT ROUND(AVG(Average_Salary_Usd), 0) AS Average_Salary
FROM vw_jobs_ai;

--#(3)TopCountries

SELECT Country, COUNT(*) AS Total_Jobs
FROM vw_jobs_ai
GROUP BY Country
ORDER BY Total_Jobs DESC;

--#(4)TopSkills

SELECT Skill, COUNT(*) AS Skill_Demand
FROM vw_skills_demand
GROUP BY Skill
ORDER BY Skill_Demand DESC;

