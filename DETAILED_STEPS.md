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
