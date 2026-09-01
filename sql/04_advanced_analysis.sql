-- Job Role and Overtime vs Employee Attrition
-- Examine whether overtime is associated with higher attrition within job roles.

SELECT
    job_role,
    overtime,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY job_role, overtime
HAVING COUNT(*) >= 10
ORDER BY attrition_rate DESC;

-- ============================================

-- Employee Tenure vs Attrition
-- Compare attrition rates across employee tenure segments.

WITH employee_segments AS (
    SELECT
        employee_number,
        years_at_company,
        attrition,
        CASE
            WHEN years_at_company <= 2 THEN '0-2 Years'
            WHEN years_at_company <= 5 THEN '3-5 Years'
            ELSE '6+ Years'
        END AS tenure_group
    FROM employees
)

SELECT
    tenure_group,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_segments
GROUP BY tenure_group
ORDER BY
    CASE tenure_group
        WHEN '0-2 Years' THEN 1
        WHEN '3-5 Years' THEN 2
        ELSE 3
    END;

-- ============================================

-- Tenure and Overtime vs Employee Attrition
-- Identify employee segments with elevated attrition based on tenure and overtime.

WITH employee_segments AS (
    SELECT
        employee_number,
        attrition,
        overtime,
        CASE
            WHEN years_at_company <= 2 THEN '0-2 Years'
            WHEN years_at_company <= 5 THEN '3-5 Years'
            ELSE '6+ Years'
        END AS tenure_group
    FROM employees
)

SELECT
    tenure_group,
    overtime,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_segments
GROUP BY tenure_group, overtime
HAVING COUNT(*) >= 10
ORDER BY attrition_rate DESC;

-- ============================================

-- Salary Quartile vs Employee Attrition
-- Compare attrition rates across employee income levels.

WITH salary_groups AS (
    SELECT
        employee_number,
        monthly_income,
        attrition,
        NTILE(4) OVER (
            ORDER BY monthly_income
        ) AS salary_quartile
    FROM employees
)

SELECT
    salary_quartile,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate,
    ROUND(AVG(monthly_income), 0) AS average_income
FROM salary_groups
GROUP BY salary_quartile
ORDER BY salary_quartile;

-- ============================================

-- Job Satisfaction vs Employee Attrition
-- Compare attrition rates across job satisfaction levels.

SELECT
    job_satisfaction,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM employees
GROUP BY job_satisfaction
ORDER BY job_satisfaction;

-- ============================================

-- Promotion Gap vs Employee Attrition
-- Compare attrition rates across time since last promotion.

WITH promotion_groups AS (
    SELECT
        employee_number,
        attrition,
        years_since_last_promotion,
        CASE
            WHEN years_since_last_promotion <= 1 THEN '0-1 Years'
            WHEN years_since_last_promotion <= 3 THEN '2-3 Years'
            ELSE '4+ Years'
        END AS promotion_gap
    FROM employees
)

SELECT
    promotion_gap,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM promotion_groups
GROUP BY promotion_gap
ORDER BY
    CASE promotion_gap
        WHEN '0-1 Years' THEN 1
        WHEN '2-3 Years' THEN 2
        ELSE 3
    END;

-- ============================================

-- High-Risk Employee Segment Analysis
-- Identify attrition rates for employees combining key risk factors.

WITH employee_segments AS (
    SELECT
        employee_number,
        attrition,
        overtime,
        years_at_company,
        monthly_income,

        CASE
            WHEN years_at_company <= 2 THEN '0-2 Years'
            WHEN years_at_company <= 5 THEN '3-5 Years'
            ELSE '6+ Years'
        END AS tenure_group,

        NTILE(4) OVER (
            ORDER BY monthly_income
        ) AS salary_quartile

    FROM employees
),

risk_segments AS (
    SELECT
        *,
        CASE
            WHEN tenure_group = '0-2 Years'
                 AND overtime = 'Yes'
                 AND salary_quartile = 1
                THEN 'High Risk'

            WHEN tenure_group = '0-2 Years'
                 AND (overtime = 'Yes' OR salary_quartile = 1)
                THEN 'Elevated Risk'

            ELSE 'Lower Risk'
        END AS risk_group

    FROM employee_segments
)

SELECT
    risk_group,
    COUNT(*) AS total_employees,
    COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
        2
    ) AS attrition_rate
FROM risk_segments
GROUP BY risk_group
ORDER BY attrition_rate DESC;

-- ============================================

-- Rank Job Roles Within Each Department by Attrition
-- Identify the highest-attrition roles within each department.

WITH role_attrition AS (
    SELECT
        department,
        job_role,
        COUNT(*) AS total_employees,
        COUNT(*) FILTER (WHERE attrition = 'Yes') AS employees_left,
        ROUND(
            100.0 * COUNT(*) FILTER (WHERE attrition = 'Yes') / COUNT(*),
            2
        ) AS attrition_rate
    FROM employees
    GROUP BY department, job_role
    HAVING COUNT(*) >= 10
),

ranked_roles AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY department
            ORDER BY attrition_rate DESC
        ) AS role_rank
    FROM role_attrition
)

SELECT
    department,
    job_role,
    total_employees,
    employees_left,
    attrition_rate,
    role_rank
FROM ranked_roles
WHERE role_rank <= 3
ORDER BY department, role_rank;
