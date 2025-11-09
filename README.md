# MR D.I.Y. Junior Data Engineer Assessment
**Candidate:** Chong Zhao Cheng (Zack)  
**Company:** MR D.I.Y. Trading Sdn Bhd  
**Section 2:** Technical Knowledge – Data Transformation using SQL & Python

---

## Overview & Objective
This repository contains the deliverables for the SQL and Python technical assessment.
Both implementations independently transform the raw dataset (`sql_test-raw`) into the final expected output (`sql_test-expected`),
calculating the required business metrics and presenting them in a structured pivot-style format.

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

## SQL Transformation

- Implemented using **MySQL** (`sql/Data Transformation (SQL).sql`).
- Script includes:
  - Database & table creation  
  - Data insertion  
  - Metric computation  
  - Pivot-style aggregation by month and metric  
- Final output exported as `sql_test-expected (SQL).csv`.

**NOTE:** Refer to [README_SQL.md](sql/README_SQL.md) for detailed setup and execution steps.

---

## Python Transformation

- Implemented in **Jupyter Notebook** (`python/Data Transformation (Python).ipynb`).
- Uses **pandas** for data manipulation and pivoting.
- Exports the final result as `sql_test-expected (Python).xlsx`.

**NOTE:** Refer to [README_Python.md](python/README_Python.md) for detailed setup and execution steps.

---

## 📁 Repository Structure

```
mrdiy-junior-data-engineer-assessment/
│
├── 📁 data/
│   └── Section_2_Instructions.md                 # Original Section 2 Instructions from word file provided
|   └── excel_sample_data_de.xlsx                 # Original dataset provided
│
├── 📁 sql/
│   ├── Data Transformation (SQL).sql             # SQL script with table creation & transformation
│   ├── sql_test-expected (SQL).csv               # Final output from SQL query (exported)
│   └── README_SQL.md                             # SQL setup & execution userguide
│
├── 📁 python/
│   ├── Data Transformation (Python).ipynb        # Python Jupyter Notebook transformation
│   ├── sql_test-expected (Python).xlsx           # Final output from Python pivot table
│   └── README_Python.md                          # Python setup & execution user guide
│
└── README.md                                     # Main overview file 
└── LICENSE                                       # MIT License
```

---

## ⚙️ Clarifications on Metrics

Although the assessment requirements listed four metrics
(profit, sales qty contribution by category, sales amt contribution by category, profit contribution by category),
the provided reference output (`sql_test-expected` in *excel_sample_data_de.xlsx*) also included **Sales Cost Contribution by Category**.
Therefore, both SQL and Python implementations include this additional metric for completeness and alignment with the expected output.

> The original assessment brief listed four required metrics:
> 1. Profit  
> 2. Sales Qty Contribution by Category  
> 3. Sales Amt Contribution by Category  
> 4. Profit Contribution by Category  
>
> To ensure consistency with the expected Excel reference and maintain calculation integrity, an additional metric was implemented:
> 
> 5. Profit Contribution by Category

✅ This ensures all transformation outputs (SQL and Python) fully match the provided reference file and maintain consistency across all methods.

---

## 🧾 Output Format Note

Both SQL and Python outputs contain the same values and correct metric order,
but differ slightly in table layout due to the formatting behavior of each platform.

| Implementation | Output Format | Example |
|--------|----------|-------------|
| SQL | Flattened columns | Jan_25_sales_qty_contribution_by_category, Feb_25_... |
| Python | Multi-level pivot (month grouped above metrics) | Jan-25 → [sales_qty, sales_amt, sales_cost, profit] |

✅ All calculated values have been verified identical to the reference (`sql_test-expected`).
Only the visual structure differs — the underlying logic and results remain consistent.

> Percentage Display Clarification
> In the provided Excel reference (`sql_test-expected`), contribution metrics are displayed as percentages (e.g., 45%).
> In both SQL and Python outputs, these values are represented in decimal form (e.g., 0.45).
> The numerical values are equivalent which only the formatting differs.

✅ This approach preserves numeric precision during computation and ensures accurate comparisons across systems.

---

## 📤 Submission Details

- **Excel Section:** Completed directly in the provided Excel file  
- **Technical Section (SQL & Python):** Hosted in this GitHub repository  
- **Aptitude Section:** Completed in the provided Word document  

For clarification or review, please refer to this repository or contact me directly.

---

## 👤 Author Information

Name: Zack Chong Zhao Cheng
Email: chongzhaocheng06@gmail.com
Education: B.Sc. (Hons) Statistical Data Modelling — Sunway University
Date Submitted: 9th November 2025
LinkedIn: *[`LinkedIn Profile`](http://linkedin.com/in/chong-z-38b102131)* 
