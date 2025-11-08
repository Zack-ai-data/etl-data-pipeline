# MR D.I.Y. Junior Data Engineer Assessment
**Candidate:** Chong Zhao Cheng (Zack)  
**Company:** MR D.I.Y. Trading Sdn Bhd  
**Section 2:** Technical Knowledge – Data Transformation using SQL & Python

---

## Overview
This repository includes work for the **SQL** and **Python** technical tests, along with their respective scripts, documentation and outputs.
Both scripts independently transform the raw dataset (`sql_test-raw`) into the expected output format (`sql_test-expected`),  
calculating the required business metrics and presenting them in a structured table.

---

## Objective

Transform the raw dataset (`sql_test-raw` in **excel_sample_data_de.xlsx**) into the expected pivot table format (`sql_test-expected`),  
by performing all metric calculations and transformations using **SQL** and **Python** independently.

---

## 🗂️ Dataset Description

**Input file:** `excel_sample_data_de.xlsx`  
**Sheet:** `sql_test-raw`

| Column Name | Description |
|--------------|-------------|
| `month` | Transaction month (in Excel date format displayed as `Jan-25`) |
| `product` | Product name |
| `store_code` | Store identifier |
| `category` | Product category (e.g. Beverage, Snack, Dairy) |
| `sales_qty` | Quantity sold |
| `sales_amt` | Total sales amount |
| `sales_cost` | Total cost of sales |

---

## Key Transformation Metrics

| Metric | Formula | Description |
|--------|----------|-------------|
| **Profit** | `sales_amt - sales_cost` | Calculates profit per product |
| **Sales Qty Contribution by Category** | `sales_qty / total monthly sales_qty (by category)` | Product’s quantity contribution |
| **Sales Amt Contribution by Category** | `sales_amt / total monthly sales_amt (by category)` | Product’s revenue contribution |
| **Sales Cost Contribution by Category** | `sales_cost / total monthly sales_cost (by category)` | Product’s cost contribution |
| **Profit Contribution by Category** | `profit / total monthly profit (by category)` | Product’s profit share |

---

## Python Transformation

- Implemented in **Jupyter Notebook** (`python/mrdiy_python_transformation.ipynb`).
- Uses **pandas** for data manipulation and pivoting.
- Exports the final result as `sql_test-expected (Python).xlsx`.

**NOTE:** Refer to [README_Python.md](python/README_Python.md) for detailed setup and execution steps.

---

## SQL Transformation

- Implemented using **MySQL**.
- Script includes:
  - Database & table creation  
  - Data insertion  
  - Metric computation  
  - Pivot-style aggregation by month and metric  
- Final output exported as `sql_test-expected (SQL).csv`.

**NOTE:** Refer to [README_SQL.md](sql/README_SQL.md) for detailed setup and execution steps.

---

## ⚠️ Notes & Clarifications on Metrics

Although the assessment requirements mention four metrics
(profit, sales qty contribution, sales amt contribution, profit contribution),
the reference file sql_test-expected also includes sales cost contribution by category.
Both SQL and Python implementations include this metric for completeness.

> The original assessment brief listed four required metrics:
> 1. Profit  
> 2. Sales Qty Contribution by Category  
> 3. Sales Amt Contribution by Category  
> 4. Profit Contribution by Category  
>
> However, the provided reference output (`sql_test-expected` in *excel_sample_data_de.xlsx*) also included  
> **Sales Cost Contribution by Category**.
>
> To ensure alignment with the expected results, **both SQL and Python transformations include this additional metric**.  
> This was done intentionally for consistency and completeness.

---

## ⚠️ Output Format Note

> The pivoted outputs from SQL and Python contain **the same values and column order as the expected Excel output**,  
> but may differ slightly in **visual structure** due to platform limitations:
>
> - **SQL Output:** Flattened column names such as `Jan_25_sales_qty_contribution_by_category`  
> - **Python Output:** Multi-level pivot table (month on top of metrics), as shown in `sql_test-expected (Python).xlsx`  
>
> Specifically, Due to differences between SQL and Excel pivot formatting:
> 
> The SQL output presents month-specific columns such as Jan_25_sales_qty_contribution_by_category, Feb_25_…, etc.
> The Python output mirrors the Excel pivot layout with month headers (Jan-25, Feb-25, …) grouped over the four metrics.
> 
> Both formats maintain the **same calculations and metric accuracy** as the provided `sql_test-expected` reference.
> Hence, all calculated values are identical and verified and only the table layout differs.

---

## Submission Details

- **Excel Section:** Completed directly in the provided Excel file  
- **Technical Section (SQL & Python):** Hosted in this GitHub repository  
- **Aptitude Section:** Completed in the provided Word document  

For any clarification, please refer to this repository or contact me directly.

---

**Author:** Zack Chong Zhao Cheng

**Date Submitted:** 9th November 2025

**Email:** chongzhaocheng06@gmail.com

**Eduaction:** Bachelor of Science (Hons) Statistical Data Modelling — Sunway University

**Contact:** *[`LinkedIn Profile`](http://linkedin.com/in/chong-z-38b102131)* 
