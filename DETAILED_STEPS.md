Comprehensive Technical Walkthrough — SQL & Python ETL Pipeline

This document provides the full technical steps used to transform the raw transactional dataset (`sql_test_raw`) into the final pivot output (`sql_test-expected`).  
It complements the main `README.md` by providing detailed, reproducible steps for engineers and reviewers.

---

## 📑 Table of Contents
- 🔍 Overview  
- 📂 Dataset Schema  
- 🗂️ SQL Transformation Pipeline  
- 🐍 Python Transformation Pipeline  
- 📊 Output Comparison  
- ✔️ Validation & Quality Checks  

---

## 🔍 Overview
Both SQL and Python pipelines deliver the same output:

### **Raw Input**
- month  
- category  
- product  
- sales_qty  
- sales_amt  
- sales_cost  

### **Final Output**
For each product × category × month:
- profit  
- sales_qty_contribution  
- sales_amt_contribution  
- sales_cost_contribution  
- profit_contribution  

Pivoted across **Jan–Aug 2025**.

---

## 📂 Dataset Schema

### Raw table: `sql_test_raw`

| Column      | Type        |
|-------------|-------------|
| month       | VARCHAR     |
| category    | VARCHAR     |
| product     | VARCHAR     |
| sales_qty   | INT         |
| sales_amt   | DECIMAL     |
| sales_cost  | DECIMAL     |

---

# 🗂️ SQL Transformation Pipeline

### 🧱 1. Database Initialization
```sql
CREATE DATABASE mrdiy_test;
USE mrdiy_test;
```

### 📌 2. Ensure a Clean Environment
```sql
DROP TABLE IF EXISTS sql_test_raw;
```

### 🏗️ 3. Create Table Schema
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

### 📥 4. Insert Raw Data
(Refer to full insert statements in `Data Transformation (SQL).sql`.)

### 👁️ 5. Validate Raw Data
```sql
SELECT * FROM sql_test_raw;
```

### ⚠️ 6. Disable Safe Update Mode
```sql
SET SQL_SAFE_UPDATES = 0;
```

### ➕ 7. Add Profit Column
```sql
ALTER TABLE sql_test_raw ADD COLUMN profit DECIMAL(10,2);

UPDATE sql_test_raw
SET profit = sales_amt - sales_cost;
```

### 📐 8. Add Contribution Metric Columns
```sql
ALTER TABLE sql_test_raw
ADD sales_qty_contribution DECIMAL(10,4),
ADD sales_amt_contribution DECIMAL(10,4),
ADD sales_cost_contribution DECIMAL(10,4),
ADD profit_contribution DECIMAL(10,4);
```

### 📊 9. Compute Contribution Metrics
(Computed within each `month, category` group.)
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

### 🔄 10. Generate Pivot-Style Output
Each month (Jan–Aug) produces:
- `<Month>_sales_qty_contribution`
- `<Month>_sales_amt_contribution`
- `<Month>_sales_cost_contribution`
- `<Month>_profit_contribution`

Full logic is implemented in `Data Transformation (SQL).sql`.

### ✔️ 11. Re-enable Safe Update Mode
```sql
SET SQL_SAFE_UPDATES = 1;
```

---

# 🐍 Python Transformation Pipeline

### 🧱 1. Environment Setup
```bash
pip install pandas openpyxl jupyter
```

### 📥 2. Load Raw Data
```python
import pandas as pd

df = pd.read_excel("excel_sample_data_de.xlsx")
```

### 🧮 3. Compute Profit
```python
df["profit"] = df["sales_amt"] - df["sales_cost"]
```

### 🔢 4. Compute Contribution Metrics
```python
group_cols = ["month", "category"]

df["sales_qty_contribution"]  = df["sales_qty"]  / df.groupby(group_cols)["sales_qty"].transform("sum")
df["sales_amt_contribution"]  = df["sales_amt"]  / df.groupby(group_cols)["sales_amt"].transform("sum")
df["sales_cost_contribution"] = df["sales_cost"] / df.groupby(group_cols)["sales_cost"].transform("sum")
df["profit_contribution"]     = df["profit"]     / df.groupby(group_cols)["profit"].transform("sum")
```

### 📊 5. Pivot Transformation
```python
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
```

### Flatten Columns
```python
pivot.columns = [
    f"{month}_{metric}"
    for metric, month in pivot.columns
]
pivot.reset_index(inplace=True)
```

### 📁 6. Save Output
```python
pivot.to_excel("sql_test-expected (Python).xlsx", index=False)
```

---

# 📊 Output Comparison

| Process | Output File | Format |
|--------|-------------|--------|
| SQL    | sql_test-expected.csv | Decimal values |
| Python | sql_test-expected (Python).xlsx | Decimal values |

Both outputs match:
- identical values  
- identical structure  
- Excel shows `%` formatting, but underlying decimals align  

---

# ✔️ Validation & Quality Checks

### 1. Row Count Consistency
- Input rows = Output rows  
- No duplicates  
- No missing rows  

### 2. Contribution Metrics Validation  
For each `(month, category)` group:

- sum(sales_qty_contribution) = 1  
- sum(sales_amt_contribution) = 1  
- sum(sales_cost_contribution) = 1  
- sum(profit_contribution) = 1  

### 3. Profit Calculation Check
profit = sales_amt − sales_cost

### 4. Pivot Column Check
Pivot includes **all months Jan–Aug**.

### 5. SQL ↔ Python Parity
- Matching column names  
- Matching ordering  
- Matching values (float precision considered)  

---
