SELECT 
    Country AS [الدولة], 
    AVG(Avg_Salary_Usd) AS [متوسط الراتب]
FROM country_trends
GROUP BY Country;
--
SELECT 
    Country AS [الدولة], 
    AVG(Avg_Salary_Usd) AS [متوسط الراتب],
    MIN(Avg_Salary_Usd) AS [أقل راتب],
    MAX(Avg_Salary_Usd) AS [أعلى راتب],
    COUNT(*) AS [عدد الوظائف المتاحة]
FROM country_trends
GROUP BY Country
ORDER BY [متوسط الراتب] DESC;
--
SELECT 
    Top_Skill AS [المهارة],
    COUNT(*) AS [عدد الوظائف],
    AVG(Avg_Salary_Usd) AS [متوسط الراتب]
FROM country_trends
GROUP BY Top_Skill
ORDER BY [عدد الوظائف] DESC;
--
SELECT 
    Remote_Percentage AS [نسبة العمل عن بعد],
    AVG(Avg_Salary_Usd) AS [متوسط الراتب],
    COUNT(*) AS [عدد الوظائف]
FROM country_trends
GROUP BY Remote_Percentage
ORDER BY Remote_Percentage DESC;
--
SELECT 
    Top_Skill AS [المهارة],
    AVG(Avg_Salary_Usd) AS [متوسط الراتب],
    SUM(Total_Ai_Jobs) AS [إجمالي الوظائف]
FROM country_trends
GROUP BY Top_Skill
ORDER BY [إجمالي الوظائف] DESC;
