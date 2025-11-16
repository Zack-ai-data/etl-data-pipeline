# 2. Python Data Transformation

### 📘 Objective  
Transform the raw data (`sql_test-raw`) into the final pivot table (`sql_output-expected.xlsx`)  
matching the structure of the **sql_test-expected** Excel sheet.

Metrics calculated:

1. **Profit** = `sales_amt – sales_cost`  
2. **Sales Qty Contribution by Category** = `sales_qty / total monthly sales_qty (by category)`  
3. **Sales Amt Contribution by Category** = `sales_amt / total monthly sales_amt (by category)`  
4. **Sales Cost Contribution by Category** = `sales_cost / total monthly sales_cost (by category)`  
5. **Profit Contribution by Category** = `profit / total monthly profit (by category)`

---

### 🧱 Setup Instructions

1. Launch **Jupyter Notebook** (Anaconda / VS Code / terminal).  
2. Ensure **Python 3.10+** is installed.  
3. Install required packages:
   ```bash
   pip install pandas openpyxl jupyter
   ```
4. Place `excel_sample_data_de.xlsx` in the same directory as the notebook.  
5. Open **[Data Transformation (Python).ipynb](Data%20Transformation%20(Python).ipynb)**.

---

### ▶️ How to Run in Jupyter

1. Open the notebook file.  
2. Run all cells:
   - Click **Run All**, or  
   - Press **Shift + Enter** for each cell.  
3. The final output file:

```
sql_output-expected (Python).xlsx
```

will be generated in your working directory.

---

### 📊 Note on Metric Display Format

Excel output displays contributions as **percentages** (e.g., 45%).  
Python output uses **decimals** (e.g., 0.45) for calculation accuracy.  

Both formats reflect the same underlying metric — only the display style differs.
