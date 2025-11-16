# ETL Data Pipeline — SQL & Python Transformations

This project showcases an end-to-end **ETL data transformation pipeline** built using **SQL** and **Python**, converting a raw retail transaction dataset into an analytical, metric-driven reporting table.

Both implementations independently process the raw dataset and generate identical outputs validated against a benchmark reference.

---

## 🚀 Project Overview

The goal of this project is to:

- Extract and clean raw retail transaction data  
- Compute key business metrics (profit, contribution ratios, etc.)  
- Aggregate results into a pivot-style analytical structure  
- Produce consistent outputs using both SQL and Python pipelines  

This project demonstrates practical data engineering skills including:

- ETL workflow design  
- SQL transformation logic  
- Python (pandas) data manipulation  
- Pivot table generation  
- Data validation across multiple pipelines  

---

## 🗂️ Dataset Description

**Source file:** `excel_sample_data_de.xlsx`  
**Sheet:** `sql_test-raw`

| Column | Description |
|--------|-------------|
| `month` | Transaction month (Excel date) |
| `product` | Product name |
| `store_code` | Store identifier |
| `category` | Product category |
| `sales_qty` | Quantity sold |
| `sales_amt` | Sales revenue |
| `sales_cost` | Cost of goods sold |

---

## 🔢 Transformation Metrics

| Metric | Formula |
|--------|---------|
| **Profit** | `sales_amt - sales_cost` |
| **Sales Qty Contribution** | `sales_qty / total monthly sales_qty (category)` |
| **Sales Amt Contribution** | `sales_amt / total monthly sales_amt (category)` |
| **Sales Cost Contribution** | `sales_cost / total monthly sales_cost (category)` |
| **Profit Contribution** | `profit / total monthly profit (category)` |

These metrics support category-level performance analysis and comparison across months.

---

## 🛢️ SQL Pipeline

- Built using **MySQL**
- Includes:
  - Schema & table creation  
  - Data ingestion  
  - Metric computation  
  - Pivot-style transformation  
- Final output exported as `sql_test-expected (SQL).csv`.

📄 Detailed guide: [`sql/README_SQL.md`](sql/README_SQL.md)

---

## 🐍 Python Pipeline

- Implemented in **Jupyter Notebook** using `pandas`
- Performs:
  - Data cleaning  
  - Metric calculations  
  - Multi-level pivot table generation  
- Final output exported as `sql_test-expected (Python).xlsx`.

📄 Detailed guide: [`python/README_Python.md`](python/README_Python.md)

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

## ✔️ Output Consistency

Both SQL and Python pipelines produce **numerically identical results**.

Differences appear only in layout:

| Pipeline | Output Format |
|---------|----------------|
| SQL | Flattened columns (e.g. `Jan_25_sales_qty_contribution`) |
| Python | Multi-index pivot (month grouped above metrics) |

Contribution values are stored as decimals (e.g., `0.45` = 45%) for precision and interoperability.

---

## 👤 Author

**Zack Chong Zhao Cheng**  
**Email:** chongzhaocheng06@gmail.com  
**LinkedIn:** [linkedin.com/in/chong-z-38b102131](https://linkedin.com/in/chong-z-38b102131)

