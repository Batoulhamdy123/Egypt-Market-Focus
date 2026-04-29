SELECT Country, AVG(Avg_Salary_Usd) AS Average_Salary
FROM country_trends
GROUP BY Country
ORDER BY Average_Salary DESC;

--
SELECT Year, AVG(Avg_Salary_Usd) AS Average_Salary
FROM country_trends
GROUP BY Year
ORDER BY Year;
--
SELECT 
    CASE 
        WHEN Remote_Percentage > 70 THEN 'Remote'
        WHEN Remote_Percentage BETWEEN 30 AND 70 THEN 'Hybrid'
        ELSE 'On-site'
    END AS Work_Mode,
    AVG(Avg_Salary_Usd) AS Average_Salary
FROM country_trends
GROUP BY 
    CASE 
        WHEN Remote_Percentage > 70 THEN 'Remote'
        WHEN Remote_Percentage BETWEEN 30 AND 70 THEN 'Hybrid'
        ELSE 'On-site'
    END;
    --
    SELECT Top_Skill, COUNT(*) AS Skill_Demand_Count
FROM country_trends
GROUP BY Top_Skill
ORDER BY Skill_Demand_Count DESC;
--
SELECT Country, Top_Skill, COUNT(*) AS Skill_Count
FROM country_trends
GROUP BY Country, Top_Skill
ORDER BY Country, Skill_Count DESC;
--
SELECT Country, Year, SUM(Total_Ai_Jobs) AS Total_Jobs_Volume
FROM country_trends
GROUP BY Country, Year
ORDER BY Total_Jobs_Volume DESC
--
SELECT 
    Remote_Percentage, 
    COUNT(*) AS Number_of_Jobs,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(10,2)) AS Percentage_of_Total
FROM country_trends
GROUP BY Remote_Percentage
ORDER BY Remote_Percentage DESC;
GO
--
SELECT 
    Year, 
    AVG(Remote_Percentage) AS Avg_Remote_Rate,
    COUNT(*) AS Total_Jobs
FROM country_trends
GROUP BY Year
ORDER BY Year;
GO
--
SELECT 
    CASE 
        WHEN Remote_Percentage > 70 THEN 'Remote'
        WHEN Remote_Percentage BETWEEN 30 AND 70 THEN 'Hybrid'
        ELSE 'On-site'
    END AS Work_Mode_Preference,
    COUNT(*) AS Total_Positions,
    AVG(Avg_Salary_Usd) AS Avg_Salary_Per_Mode
FROM country_trends
GROUP BY 
    CASE 
        WHEN Remote_Percentage > 70 THEN 'Remote'
        WHEN Remote_Percentage BETWEEN 30 AND 70 THEN 'Hybrid'
        ELSE 'On-site'
    END
ORDER BY Total_Positions DESC;
GO
--
SELECT 
    Country, 
    COUNT(*) AS Remote_Jobs_Count,
    AVG(Avg_Salary_Usd) AS Average_Remote_Salary
FROM country_trends
WHERE Remote_Percentage > 70 -- 
GROUP BY Country
ORDER BY Remote_Jobs_Count DESC;
GO
--

SELECT 
    MIN(Avg_Salary_Usd) AS Minimum_Salary, 
    MAX(Avg_Salary_Usd) AS Maximum_Salary 
FROM country_trends;
--


















