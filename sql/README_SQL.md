# 1. SQL Data Transformation

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

1. Open **MySQL Workbench** or any MySQL-compatible SQL client.  
2. Copy and paste all code from **[Data Transformation (SQL).sql](Data%20Transformation%20(SQL).sql)**.  
3. Ensure MySQL server is running (preferably version **8.0+**).  
4. Execute the script **sequentially** to create tables, load data, and perform transformations.

---

### ▶️ Step-by-Step Execution

| Step | Description |
|------|--------------|
| 1️⃣ | Create database `mrdiy_test` |
| 2️⃣ | Drop existing `sql_test_raw` table (clean start) |
| 3️⃣ | Recreate table structure |
| 4️⃣ | Insert test data (Jan–Aug 2025) |
| 5️⃣ | Verify raw data |
| 6️⃣ | Disable safe updates (`Error 1175` prevention) |
| 7️⃣ | Add `profit` column |
| 8️⃣ | Calculate `profit = sales_amt - sales_cost` |
| 9️⃣ | Add 4 contribution metric columns |
| 🔟 | Compute contribution ratios per month & category |
| 1️⃣1️⃣ | Preview final table |
| 1️⃣2️⃣ | Generate pivot table output (Jan–Aug metrics by product & category) |
| 1️⃣3️⃣ | Re-enable safe update mode |

---

### 💾 Output Description

The final query output displays each **product–category** combination with month-wise contribution metrics.

**Example column pattern:**

Jan_25_sales_qty_contribution_by_category
Jan_25_sales_amt_contribution_by_category
Jan_25_sales_cost_contribution_by_category
Jan_25_profit_contribution_by_category
... up to Aug_25

Each month is expanded horizontally, grouping the four metrics in order:
**(Sales Qty Contribution → Sales Amt Contribution → Sales Cost Contribution → Profit Contribution).**

---

### ⚙️ Execution & Export Notes

- You may export the result table from **MySQL Workbench** using:  
  `Query > Export Results > CSV File (.csv)`
- If you encounter **Error Code 1175**, it is caused by MySQL’s Safe Update Mode.  
  The script includes the required commands to toggle it:
  ```sql
  SET SQL_SAFE_UPDATES = 0;
  ...
  SET SQL_SAFE_UPDATES = 1;

All numeric results are rounded to 2 decimal places for consistency with Excel output.

---

### 📊 Note on Metric Display Format

In the reference Excel file (`sql_test-expected`), contribution metrics are displayed as percentages (e.g., **45%**).  
In the SQL output, these same values are represented in decimal form (e.g., **0.45**) to maintain numeric precision during calculations and aggregations.  
Both formats represent the same underlying values where only the display format differs.
