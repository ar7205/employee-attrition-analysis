# Employee Attrition & Retention Analysis

> SQL-driven workforce analytics using PostgreSQL to identify employee attrition patterns, high-risk segments, and potential retention opportunities.

---

## Project Overview

Employee attrition is an important workforce challenge because frequent employee turnover can increase recruitment costs, training requirements, and productivity losses.

This project analyzes the **IBM HR Analytics Employee Attrition & Performance dataset** using PostgreSQL to understand which employee characteristics and working conditions are associated with higher observed attrition.

The analysis moves from basic data validation to descriptive analysis, driver analysis, multi-dimensional segmentation, and business recommendations.

The dataset contains **1,470 employee records** covering employee demographics, compensation, job characteristics, satisfaction, tenure, overtime, business travel, and attrition.

---

## Project Highlights

- Analyzed **1,470 employee records** using PostgreSQL.
- Identified a **30.53% observed attrition rate** among employees working overtime.
- Found a **50.96% observed attrition rate** among employees with 0–2 years of tenure who worked overtime.
- Identified **Sales Representatives working overtime** as a high-attrition group with a **66.67% observed attrition rate**.
- Developed a rule-based multi-factor segmentation that identified a group with **71.11% observed attrition**.
- Used CTEs, conditional aggregation, `CASE`, `NTILE()`, `RANK()`, and window functions to move from descriptive analysis to employee segmentation.

---

## Business Problem

The objective is to answer a practical HR analytics question:

**"Which types of employees show higher observed attrition, and what characteristics are associated with employee turnover?"**

Instead of looking only at overall attrition, the analysis examines multiple dimensions and combinations of factors to identify employee groups that may require greater retention attention.

---

## Objectives

The project aims to:

- Establish the overall employee attrition rate.
- Validate the quality and completeness of the dataset.
- Compare attrition across departments and job roles.
- Analyze the relationship between overtime and attrition.
- Examine the impact of business travel patterns.
- Analyze attrition across employee tenure groups.
- Compare attrition across salary quartiles.
- Investigate job satisfaction and promotion-related patterns.
- Analyze combinations of multiple employee risk factors.
- Identify employee segments with elevated observed attrition.
- Translate the findings into practical HR recommendations.

---

## Dataset

### IBM HR Analytics Employee Attrition & Performance

The dataset contains **1,470 employee records** and **35 attributes**.

Important fields used in this analysis include:

| Category | Examples |
|---|---|
| Employee Information | Employee Number, Age, Gender |
| Work Conditions | Overtime, Business Travel, Standard Hours |
| Job Information | Department, Job Role, Job Level |
| Compensation | Monthly Income, Salary Hike, Stock Option Level |
| Satisfaction | Job Satisfaction, Environment Satisfaction, Relationship Satisfaction |
| Career History | Years at Company, Years in Current Role, Years Since Last Promotion |
| Target | Attrition |

The raw dataset is **not included in this repository**.

---

## Technology Stack

- **PostgreSQL** — database and analytical engine
- **SQL** — data analysis and segmentation
- **pgAdmin 4** — database management and query execution
- **Git** — version control
- **GitHub** — project hosting and documentation

---

# Analysis Workflow

The analysis was structured into four stages.

### 1. Data Quality & Validation

Before analyzing the data, basic quality checks were performed to verify:

- Record count
- Missing values
- Duplicate employee numbers
- Distinct categorical values
- Table structure and column consistency

The dataset contained **1,470 records** and the selected data-quality checks returned no missing values for the tested fields and no duplicate employee numbers.

---

### 2. Descriptive Analysis

Initial analysis established the workforce composition and overall attrition level.

Key areas included:

- Overall attrition
- Department distribution
- Job role distribution
- Marital status
- Overtime
- Business travel

The overall observed attrition rate was:

**16.12%**

with:

- **1,233 employees retained**
- **237 employees leaving**

---

### 3. Attrition Driver Analysis

The project then examined individual factors associated with employee attrition.

Factors analyzed include:

- Overtime
- Business travel
- Department
- Job role
- Job satisfaction
- Salary level
- Tenure
- Promotion gap

Rather than focusing only on employee counts, the analysis calculates **attrition rates within each group**, allowing different-sized employee groups to be compared more fairly.

---

### 4. Multi-Factor Segmentation

The final stage combines multiple characteristics to identify employee segments with elevated observed attrition.

SQL techniques such as:

- `CASE`
- CTE
- Conditional aggregation
- `FILTER`
- Window functions
- `NTILE()`
- `RANK()`
- `GROUP BY`
- `HAVING`
- `PARTITION BY`

were used to create and analyze these segments.

---

# Key Findings

## 1. Overall Attrition

Out of 1,470 employees:

| Attrition | Employees | Rate |
|---|---:|---:|
| No | 1,233 | 83.88% |
| Yes | 237 | 16.12% |

The overall observed attrition rate is **16.12%**.

---

## 2. Overtime Shows a Strong Association with Attrition

| Overtime | Employees | Left | Attrition Rate |
|---|---:|---:|---:|
| Yes | 416 | 127 | **30.53%** |
| No | 1,054 | 110 | **10.44%** |

Employees working overtime had an observed attrition rate nearly three times that of employees who did not work overtime.

This suggests that workload and overtime should be investigated as potential retention concerns.

---

## 3. Business Travel

| Business Travel | Employees | Left | Attrition Rate |
|---|---:|---:|---:|
| Travel Frequently | 277 | 69 | **24.91%** |
| Travel Rarely | 1,043 | 156 | **14.96%** |
| Non-Travel | 150 | 12 | **8.00%** |

Frequent travelers showed the highest observed attrition among the three travel categories.

---

## 4. Department-Level Attrition

| Department | Employees | Left | Attrition Rate |
|---|---:|---:|---:|
| Sales | 446 | 92 | **20.63%** |
| Human Resources | 63 | 12 | **19.05%** |
| Research & Development | 961 | 133 | **13.84%** |

Sales had the highest observed attrition rate among the three departments analyzed.

---

## 5. Job Role + Overtime

Combining job role with overtime revealed stronger differences than looking at either factor independently.

The highest observed attrition group was:

**Sales Representative + Overtime → 66.67%**

Other notable groups included:

- Laboratory Technician + Overtime → 50.00%
- Human Resources + Overtime → 38.46%
- Research Scientist + Overtime → 34.02%
- Sales Executive + Overtime → 32.98%

This demonstrates why multi-dimensional analysis can reveal patterns that simple grouping may miss.

---

## 6. Tenure + Overtime

Employees with shorter tenure and overtime exposure showed particularly high observed attrition.

| Tenure | Overtime | Employees | Left | Attrition Rate |
|---|---|---:|---:|---:|
| 0–2 Years | Yes | 104 | 53 | **50.96%** |
| 3–5 Years | Yes | 127 | 36 | **28.35%** |
| 6+ Years | Yes | 185 | 38 | **20.54%** |

The **0–2 year + overtime** group had an observed attrition rate of **50.96%**.

This suggests that early-tenure employees exposed to overtime may represent an important group for further investigation.

---

## 7. Salary Quartiles

Employees were divided into four salary groups using `NTILE(4)`.

| Salary Quartile | Employees | Left | Attrition Rate | Avg. Income |
|---|---:|---:|---:|---:|
| Q1 | 368 | 108 | **29.35%** | 2,353 |
| Q2 | 368 | 52 | **14.13%** | 3,964 |
| Q3 | 367 | 39 | **10.63%** | 6,191 |
| Q4 | 367 | 38 | **10.35%** | 13,522 |

The lowest salary quartile had the highest observed attrition rate.

---

# High-Risk Employee Segmentation

The final analysis combines multiple employee characteristics to create rule-based risk segments.

The resulting groups were:

| Risk Group | Employees | Left | Attrition Rate |
|---|---:|---:|---:|
| **High Risk** | 45 | 32 | **71.11%** |
| Elevated Risk | 184 | 55 | **29.89%** |
| Lower Risk | 1,241 | 150 | **12.09%** |

The high-risk segment had an observed attrition rate of **71.11%**.

This demonstrates how combining multiple employee characteristics can reveal concentrated attrition patterns that may not be visible when analyzing individual variables independently.

> **Important:** These risk groups are rule-based analytical segments, not predictions generated by a machine-learning model.

---

# Business Insights

The analysis suggests several areas that HR teams could investigate further:

### 1. Overtime and Workload

Overtime is consistently associated with higher observed attrition.

HR teams could investigate:

- Workload distribution
- Staffing levels
- Overtime frequency
- Burnout indicators
- Work-life balance

### 2. Early-Tenure Retention

Employees within their first two years show considerably higher attrition, particularly when overtime is involved.

Possible actions include:

- Structured onboarding
- Early-career mentoring
- Regular manager check-ins
- Workload monitoring during the first two years

### 3. Sales & Customer-Facing Roles

Sales Representatives show particularly high observed attrition, especially among employees working overtime.

This group could be examined for:

- Workload
- Compensation
- Performance pressure
- Career progression
- Managerial support

### 4. Compensation

The lowest salary quartile has considerably higher observed attrition than the highest quartile.

This supports further investigation into:

- Compensation competitiveness
- Salary progression
- Promotion opportunities
- Internal pay equity

### 5. Business Travel

Frequent business travel is associated with higher observed attrition.

Organizations could investigate whether travel requirements contribute to:

- Work-life balance challenges
- Employee fatigue
- Job dissatisfaction
- Increased turnover risk

---

# SQL Skills Demonstrated

This project demonstrates practical SQL analytics techniques including:

### Aggregation

```sql
COUNT()
SUM()
AVG()
ROUND()