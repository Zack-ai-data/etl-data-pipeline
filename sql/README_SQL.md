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
3. Ensure MySQL server is running (recommended version **8.0+**).  
4. Execute the script **sequentially** to create tables, insert data, and generate the transformed output.

---

### ▶️ Step-by-Step Execution

| Step | Description |
|------|-------------|
| 1️⃣ | Create database `mrdiy_test` |
| 2️⃣ | Drop existing `sql_test_raw` table (clean start) |
| 3️⃣ | Recreate table structure |
| 4️⃣ | Insert sample data (Jan–Aug 2025) |
| 5️⃣ | Verify raw dataset |
| 6️⃣ | Disable safe updates (`Error 1175`) |
| 7️⃣ | Add `profit` column |
| 8️⃣ | Compute `profit = sales_amt - sales_cost` |
| 9️⃣ | Add 4 contribution metric columns |
| 🔟 | Compute contribution ratios per month & category |
| 1️⃣1️⃣ | Preview final transformed table |
| 1️⃣2️⃣ | Generate pivot-style output (Jan–Aug metrics per product/category) |
| 1️⃣3️⃣ | Re-enable Safe Update Mode |

---

### 💾 Output Description

The final SQL query produces a wide pivot-style dataset with contribution metrics for every  
**product × category × month** combination.

Example output column pattern:

```
Jan_25_sales_qty_contribution_by_category  
Jan_25_sales_amt_contribution_by_category  
Jan_25_sales_cost_contribution_by_category  
Jan_25_profit_contribution_by_category  
...
(repeated for Feb–Aug)
```

For each month, metrics are grouped in this order:

1. Sales Qty Contribution  
2. Sales Amt Contribution  
3. Sales Cost Contribution  
4. Profit Contribution  

---

### ⚙️ Execution & Export Notes

- Export table in Workbench:  
  `Query > Export Results > CSV File (.csv)`
- If you encounter **Error 1175**, the script already includes:
  ```sql
  SET SQL_SAFE_UPDATES = 0;
  ...
  SET SQL_SAFE_UPDATES = 1;
  ```
- All numeric outputs are rounded to **2 decimal places** for consistency with Excel results.

---

### 📊 Note on Metric Display Format

Excel reference output (`sql_test-expected`) shows contributions as **percentages** (e.g., **45%**).  
SQL output uses **decimal values** (e.g., **0.45**) to preserve numeric precision.  

Both formats represent the **same values**.
