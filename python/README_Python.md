# 2. Python Data Transformation

### 📘 Objective
Transform the raw dataset (`sql_test-raw`) into the final pivot table (`sql_output-expected.xlsx`),  
matching the format of the **sql_test-expected** sheet.

Metrics calculated:
1. **Profit** = `sales_amt – sales_cost`
2. **Sales Qty Contribution by Category** = `sales_qty / total monthly sales_qty (by category)`
3. **Sales Amt Contribution by Category** = `sales_amt / total monthly sales_amt (by category)`
4. **Sales Cost Contribution by Category** = `sales_amt / total monthly sales_cost (by category)`
5. **Profit Contribution by Category** = `profit / total monthly profit (by category)`

---

### 🧱 Setup Instructions

1. Open **Jupyter Notebook** (via Anaconda, VS Code, or terminal).  
2. Ensure **Python 3.10+** is installed.  
3. Install dependencies using the following command
   *(run this in your **terminal**, not inside Jupyter)*:
   ```bash
   pip install pandas openpyxl jupyter
4. Place the file (`excel_sample_data_de.xlsx`) in the same working directory as your notebook.
5. Open the notebook file named (`Data Transformation (Python).ipynb`)

---

### ▶️ How to Run in Jupyter

1. Launch Jupyter Notebook from your environment.
2. Open Data Transformation (Python).ipynb.
3. Run all cells sequentially:
  Click Run All, or
  Press Shift + Enter for each cell.

The final file sql_output-expected (Python).xlsx will be generated in the same folder.

**Note on metrics**
In the Excel reference file, contribution metrics are displayed as percentages (e.g., 45%).
This script outputs them as decimal values (e.g., 0.45) for accurate numeric representation.
Both formats are equivalent which only the display differs.

