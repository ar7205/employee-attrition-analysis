-- ============================================
-- Employee Attrition Analysis - Overview
-- ============================================

-- Overall employee attrition.
SELECT
    attrition,
    COUNT(*) AS employees,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM employees
GROUP BY attrition
ORDER BY employees DESC;

-- Distinct marital status values.
SELECT DISTINCT marital_status
FROM employees;

-- Distinct overtime values.
SELECT DISTINCT overtime
FROM employees;

-- Distinct business travel categories.
SELECT DISTINCT business_travel
FROM employees;
