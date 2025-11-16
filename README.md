# 🛠️ Data Engineering ETL: SQL + Python Transformation Project

Transforming raw transactional data into a structured, analysis-ready pivot table using  
**MySQL** and **Python (Pandas)** — replicating and automating the logic used in Excel.

---

## 📌 Table of Contents
- [🚀 Project Overview](#-project-overview)
- [🧰 Technologies Used](#-technologies-used)
- [📂 Dataset Description](#-dataset-description)
- [1. SQL Data Transformation](#1-sql-data-transformation)
- [2. Python Data Transformation](#2-python-data-transformation)
- [📊 Output Format](#-output-format)
- [📁 Project Structure](#-project-structure)
- [🔧 How to Reproduce](#-how-to-reproduce)
- [📢 Notes](#-notes)

---

## 🚀 Project Overview

This project performs a complete **ETL-style data transformation**, converting raw sales transactions into a pivot table with contribution metrics by:

- **Month**
- **Product**
- **Category**

Two separate implementations are provided:

1. **MySQL** — table creation, data loading, transformation & pivoting  
2. **Python (Pandas)** — replicating the same logic and exporting Excel output

This mirrors a real-world **Data Engineering & Analytics workflow**, suitable for portfolio demonstration.

---

## 🧰 Technologies Used

![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?logo=pandas&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?logo=jupyter&logoColor=white)

---

## 📂 Dataset Description

The raw dataset contains transaction-level information:

| Column        | Description |
|---------------|-------------|
| month         | Year–month (Jan–Aug 2025) |
| category      | Product category |
| product       | Product description |
| sales_qty     | Units sold |
| sales_amt     | Total sales amount |
| sales_cost    | Cost of goods sold |

---

# 1. SQL Data Transformation

<details>
<summary><strong>Click to expand SQL section</strong></summary>

### 📘 Objective  
Transform the `sql_test-raw` dataset into a pivot-style table (`sql_test-expected`)  
with calculated contribution metrics per month and category.

Metrics calculated:

1. **Profit** = `sales_amt – sales_cost`  
2. **Sales Qty Contribution by Category** = `sales_qty / SUM(sales_qty) by (month, category)`  
3. **Sales Amt Contribution by Category** = `sales_amt / SUM(sales_amt) by (month, category)`  
4. **Sales Cost Contribution by Category** = `sales_cost / SUM(sales_cost) by (month, category)`  
5. **Profit Contribution by Category** = `profit / SUM(profit) by (month, category)`  

---

### 🧱 Setup Instructions

1. Open MySQL Workbench (or any compatible SQL client)  
2. Load **Data Transformation (SQL).sql**  
3. Run sequentially to:
   - Create tables  
   - Insert test data  
   - Compute metrics  
   - Generate pivot table  

---

### ▶️ Step-by-Step Execution

| Step | Description |
|------|-------------|
| 1️⃣ | Create database `mrdiy_test` |
| 2️⃣ | Drop existing `sql_test_raw` (cleanup) |
| 3️⃣ | Recreate table structure |
| 4️⃣ | Insert sample data |
| 5️⃣ | Validate raw data |
| 6️⃣ | Disable Safe Update Mode |
| 7️⃣ | Add profit column |
| 8️⃣ | Compute profit |
| 9️⃣ | Add 4 contribution metric columns |
| 🔟 | Calculate contribution metrics |
| 1️⃣1️⃣ | Preview final transformed table |
| 1️⃣2️⃣ | Generate pivot-style output |
| 1️⃣3️⃣ | Re-enable Safe Update Mode |

---

### 📊 SQL Output

Columns follow this pattern:

```
Jan_25_sales_qty_contribution_by_category  
Jan_25_sales_amt_contribution_by_category  
Jan_25_sales_cost_contribution_by_category  
Jan_25_profit_contribution_by_category  
...
(repeats Feb–Aug)
```

---

### ⚙️ Notes
- Export CSV from Workbench:  
  *Query → Export Results → CSV*
- Safe Update Mode handling is included in the SQL file.
- Values are rounded to **2 decimal places**.

</details>

---

# 2. Python Data Transformation

<details>
<summary><strong>Click to expand Python section</strong></summary>

### 📘 Objective  
Replicate the MySQL transformation using **Python + Pandas** and output  
`sql_output-expected (Python).xlsx`.

---

### 🧱 Setup Instructions

1. Install dependencies:

```bash
pip install pandas openpyxl jupyter
```

2. Place `excel_sample_data_de.xlsx` in the working directory  
3. Open the notebook:

```
Data Transformation (Python).ipynb
```

---

### ▶️ Running the Notebook

1. Launch Jupyter Notebook  
2. Open the `.ipynb` file  
3. Run all cells (Run All or Shift+Enter)  
4. Output file generated:

```
sql_output-expected (Python).xlsx
```

---

### 📊 Python Metric Format  
- Calculations use **decimal values** (0.45)  
- Excel example uses **percentage format** (45%)  

Both represent the same metrics — only display formatting differs.

</details>

---

## 📊 Output Format

The final transformed output contains:

- Wide pivot table  
- Data grouped by month  
- 4 metrics per month  
- Per product × category combination  

Perfect for:

✔️ BI dashboards  
✔️ Trend analysis  
✔️ Machine learning features  
✔️ Reporting automation  

---

## 📁 Project Structure

```
📦 etl-data-pipeline/
│
├── 📁 data/
│   └── Section_2_Instructions.md                 # Original Section 2 Instructions from word file provided
|   └── excel_sample_data_de.xlsx                 # Original dataset provided
│
├── 📁 sql/
│   ├── Data Transformation (SQL).sql             # SQL script with table creation & transformation
│   ├── sql_test-expected (SQL).csv               # Final output from SQL query (exported)
│   └── README_SQL.md                             # SQL setup & execution user guide
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

## 🔧 How to Reproduce

Clone the repo:

```bash
git clone https://github.com/<username>/data-engineering-etl.git
```

Follow either:

- SQL workflow  
- Python workflow  

Both produce the same output structure.
