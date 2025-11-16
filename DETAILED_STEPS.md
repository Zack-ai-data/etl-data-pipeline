Comprehensive Technical Walkthrough — SQL & Python ETL Pipeline

This document provides the full technical steps used to transform the raw transactional dataset (`sql_test-raw`) into the final pivot table (`sql_test-expected`).  
It complements the main `README.md` by offering deeper technical clarity for engineers, reviewers, and anyone reproducing the ETL pipeline.

---

## 📑 Table of Contents
- 🔍 Overview  
- 📂 Dataset Schema  
- 🗂️ SQL Transformation Pipeline  
  - Database setup  
  - Table creation  
  - Data insertion  
  - Feature engineering  
  - Contribution metric calculations  
  - Pivot output  
- 🐍 Python Transformation Pipeline  
  - Environment setup  
  - Data loading  
  - Preprocessing  
  - Feature engineering  
  - Contribution metric calculations  
  - Pivot output  
- 📊 Output Comparison  
- ✔️ Validation & Quality Checks  

---

## 🔍 Overview

Both SQL and Python workflows accomplish the same transformation:

### **Input (Raw Table)**  
Transaction-level data:  
- `month`  
- `category`  
- `product`  
- `sales_qty`  
- `sales_amt`  
- `sales_cost`  

### **Output (Pivot Table)**  
For each **month × product × category**, compute:

- Profit  
- Sales Qty Contribution  
- Sales Amt Contribution  
- Sales Cost Contribution  
- Profit Contribution  

Repeated for **Jan–Aug 2025**.

---

## 📂 Dataset Schema

### **Raw dataset (`sql_test_raw`)**

| Column      | Type        | Example  |
|-------------|-------------|----------|
| month       | VARCHAR     | Jan-25   |
| category    | VARCHAR     | Hardware |
| product     | VARCHAR     | Hammer   |
| sales_qty   | INT         | 120      |
| sales_amt   | DECIMAL     | 5800     |
| sales_cost  | DECIMAL     | 4200     |

---

## 🗂️ SQL Transformation Pipeline

### 🧱 1. Database Initialization
```sql
CREATE DATABASE mrdiy_test;
USE mrdiy_test;
```

### 📌 2. Ensure a clean environment
```sql
DROP TABLE IF EXISTS sql_test_raw;
```

### 🏗️ 3. Create table schema
```sql
CREATE TABLE sql_test_raw (
    month VARCHAR(10),
    category VARCHAR(50),
    product VARCHAR(100),
    sales_qty INT,
    sales_amt DECIMAL(10,2),
    sales_cost DECIMAL(10,2)
);
```

### 📥 4. Insert sample data

Data includes months Jan–Aug 2025.
(Refer to Data Transformation (SQL).sql for full insert script.)

### 👁️ 5. Validate raw dataset
```sql
SELECT * FROM sql_test_raw;
```

### ⚠️ 6. Handle Safe Update Mode

MySQL Workbench may block UPDATE operations without WHERE clauses.
```sql
SET SQL_SAFE_UPDATES = 0;
```

### ➕ 7. Add computed column: profit
```sql
ALTER TABLE sql_test_raw ADD COLUMN profit DECIMAL(10,2);
UPDATE sql_test_raw
SET profit = sales_amt - sales_cost;
```

### 📐 8. Add contribution metric columns
```sql
ALTER TABLE sql_test_raw
ADD sales_qty_contribution DECIMAL(10,4),
ADD sales_amt_contribution DECIMAL(10,4),
ADD sales_cost_contribution DECIMAL(10,4),
ADD profit_contribution DECIMAL(10,4);
```

### 📊 9. Compute contribution metrics

The contribution metrics are calculated within each (month, category) group.

Example:
```sql
UPDATE sql_test_raw r
JOIN (
    SELECT month, category,
           SUM(sales_qty) AS total_qty,
           SUM(sales_amt) AS total_amt,
           SUM(sales_cost) AS total_cost,
           SUM(profit) AS total_profit
    FROM sql_test_raw
    GROUP BY month, category
) t
ON r.month = t.month AND r.category = t.category
SET
    r.sales_qty_contribution  = r.sales_qty  / t.total_qty,
    r.sales_amt_contribution  = r.sales_amt  / t.total_amt,
    r.sales_cost_contribution = r.sales_cost / t.total_cost,
    r.profit_contribution     = r.profit     / t.total_profit;
```

### 🔄 10. Generate pivot-style output

For each month (Jan–Aug), produce:

<Month>_sales_qty_contribution_by_category
<Month>_sales_amt_contribution_by_category
<Month>_sales_cost_contribution_by_category
<Month>_profit_contribution_by_category


This section is fully implemented in the SQL script file:
Data Transformation (SQL).sql

### ✔️ 11. Re-enable Safe Updates
```sql
SET SQL_SAFE_UPDATES = 1;
```

🐍 Python Transformation Pipeline
🧱 1. Environment Setup

Install required packages:

pip install pandas openpyxl jupyter

📥 2. Load raw data
import pandas as pd

df = pd.read_excel("excel_sample_data_de.xlsx")

🧮 3. Compute profit
df["profit"] = df["sales_amt"] - df["sales_cost"]

🔢 4. Calculate contribution metrics

Group by (month, category):

group_cols = ["month", "category"]

df["sales_qty_contribution"] = df["sales_qty"] / df.groupby(group_cols)["sales_qty"].transform("sum")
df["sales_amt_contribution"] = df["sales_amt"] / df.groupby(group_cols)["sales_amt"].transform("sum")
df["sales_cost_contribution"] = df["sales_cost"] / df.groupby(group_cols)["sales_cost"].transform("sum")
df["profit_contribution"] = df["profit"] / df.groupby(group_cols)["profit"].transform("sum")

📊 5. Pivot transformation
pivot = df.pivot_table(
    index=["category", "product"],
    columns="month",
    values=[
        "sales_qty_contribution",
        "sales_amt_contribution",
        "sales_cost_contribution",
        "profit_contribution",
    ]
)


Flatten columns:

pivot.columns = [
    f"{month}_{metric}"
    for metric, month in pivot.columns
]
pivot.reset_index(inplace=True)

📁 6. Save final output
pivot.to_excel("sql_test-expected (Python).xlsx", index=False)

📊 Output Comparison
Process	File Generated	Format
SQL	sql_test-expected.csv	Decimal values
Python	sql_test-expected (Python).xlsx	Decimal values

Both outputs match structurally.
Excel reference uses percentage formatting but reflects same numeric values.

✔️ Validation & Quality Checks
1. Row count consistency

Raw input rows = Output rows

No duplicates introduced

No rows lost

2. Contribution metrics sum to 1

Within each (month, category) group:

SUM(sales_qty_contribution) = 1  
SUM(sales_amt_contribution) = 1  
SUM(sales_cost_contribution) = 1  
SUM(profit_contribution) = 1  

3. Profit formula check
profit = sales_amt - sales_cost

4. Pivot column completeness

All months Jan–Aug appear in:

<metric>_<Month>

5. Cross-framework parity

SQL output vs Python output:

column names match

row ordering consistent

values identical (decimal precision allowed)
