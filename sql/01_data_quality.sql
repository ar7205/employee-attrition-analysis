-- ============================================
-- Employee Attrition Analysis - Data Quality
-- ============================================

-- Check total number of employee records.
SELECT COUNT(*) AS total_employees
FROM employees;

-- Check for missing values in key analysis columns.
SELECT
    COUNT(*) FILTER (WHERE age IS NULL) AS missing_age,
    COUNT(*) FILTER (WHERE attrition IS NULL) AS missing_attrition,
    COUNT(*) FILTER (WHERE department IS NULL) AS missing_department,
    COUNT(*) FILTER (WHERE job_role IS NULL) AS missing_job_role,
    COUNT(*) FILTER (WHERE monthly_income IS NULL) AS missing_income,
    COUNT(*) FILTER (WHERE overtime IS NULL) AS missing_overtime,
    COUNT(*) FILTER (WHERE job_satisfaction IS NULL) AS missing_satisfaction
FROM employees;

-- Check for duplicate employee numbers.
SELECT
    employee_number,
    COUNT(*) AS occurrences
FROM employees
GROUP BY employee_number
HAVING COUNT(*) > 1;
