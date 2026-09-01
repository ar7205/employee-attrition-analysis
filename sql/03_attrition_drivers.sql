-- ============================================
-- Overtime vs Employee Attrition
-- ============================================

SELECT
    overtime,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY overtime
ORDER BY attrition_rate DESC;

-- ============================================

-- Business Travel vs Employee Attrition
-- Compare attrition rates across travel frequency categories.

SELECT
    business_travel,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY business_travel
ORDER BY attrition_rate DESC;

-- ============================================

-- Department vs Employee Attrition
-- Compare attrition rates across departments.

SELECT
    department,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY department
ORDER BY attrition_rate DESC;

-- ============================================

-- Job Role vs Employee Attrition
-- Identify job roles with elevated attrition rates.

SELECT
    job_role,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY job_role
HAVING COUNT(*) >= 30
ORDER BY attrition_rate DESC;
