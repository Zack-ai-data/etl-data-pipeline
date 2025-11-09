-- Create a database for this test (if not already exists)
CREATE DATABASE IF NOT EXISTS mrdiy_test;
USE mrdiy_test;

-- Drop existing table to ensure a clean setup
DROP TABLE IF EXISTS sql_test_raw;

-- Create table to store sql_test-raw excel sheet's data
CREATE TABLE sql_test_raw (
  month DATE,
  product VARCHAR(50),
  store_code VARCHAR(50),
  category VARCHAR(50),
  sales_qty INT,
  sales_amt INT,
  sales_cost INT
);

-- Insert sql_test-raw excel sheet's data into table
INSERT INTO sql_test_raw (month, product, store_code, category, sales_qty, sales_amt, sales_cost) 
VALUES
('2025-01-25','ProdA','S001','Beverage',120,600,360),
('2025-01-25','ProdB','S001','Beverage',140,700,420),
('2025-01-25','ProdC','S002','Snack',180,720,450),
('2025-01-25','ProdD','S003','Snack',150,600,370),
('2025-01-25','ProdE','S004','Dairy',200,1000,650),
('2025-01-25','ProdF','S005','Dairy',100,500,320),

('2025-02-25','ProdA','S001','Beverage',130,650,390),
('2025-02-25','ProdB','S002','Beverage',120,600,360),
('2025-02-25','ProdC','S003','Snack',170,680,420),
('2025-02-25','ProdD','S004','Snack',160,640,400),
('2025-02-25','ProdE','S005','Dairy',190,950,600),
('2025-02-25','ProdF','S006','Dairy',110,550,350),

('2025-03-25','ProdA','S001','Beverage',140,700,420),
('2025-03-25','ProdB','S002','Beverage',150,750,450),
('2025-03-25','ProdC','S003','Snack',200,800,500),
('2025-03-25','ProdD','S004','Snack',170,680,410),
('2025-03-25','ProdE','S005','Dairy',210,1050,670),
('2025-03-25','ProdF','S006','Dairy',120,600,360),

('2025-04-25','ProdA','S002','Beverage',160,800,480),
('2025-04-25','ProdB','S003','Beverage',130,650,390),
('2025-04-25','ProdC','S004','Snack',190,760,460),
('2025-04-25','ProdD','S005','Snack',180,720,440),
('2025-04-25','ProdE','S006','Dairy',220,1100,700),
('2025-04-25','ProdF','S007','Dairy',130,650,400),

('2025-05-25','ProdA','S001','Beverage',150,750,450),
('2025-05-25','ProdB','S002','Beverage',160,800,480),
('2025-05-25','ProdC','S003','Snack',210,840,520),
('2025-05-25','ProdD','S004','Snack',190,760,460),
('2025-05-25','ProdE','S005','Dairy',230,1150,720),
('2025-05-25','ProdF','S006','Dairy',140,700,430),

('2025-06-25','ProdA','S002','Beverage',170,850,510),
('2025-06-25','ProdB','S003','Beverage',140,700,420),
('2025-06-25','ProdC','S004','Snack',200,800,480),
('2025-06-25','ProdD','S005','Snack',180,720,430),
('2025-06-25','ProdE','S006','Dairy',220,1100,680),
('2025-06-25','ProdF','S007','Dairy',130,650,390),

('2025-07-25','ProdA','S001','Beverage',160,800,480),
('2025-07-25','ProdB','S002','Beverage',150,750,450),
('2025-07-25','ProdC','S003','Snack',210,840,500),
('2025-07-25','ProdD','S004','Snack',190,760,460),
('2025-07-25','ProdE','S005','Dairy',240,1200,750),
('2025-07-25','ProdF','S006','Dairy',150,750,450),

('2025-08-25','ProdA','S001','Beverage',170,850,510),
('2025-08-25','ProdB','S002','Beverage',160,800,480),
('2025-08-25','ProdC','S003','Snack',220,880,530),
('2025-08-25','ProdD','S004','Snack',200,800,470),
('2025-08-25','ProdE','S005','Dairy',250,1250,780),
('2025-08-25','ProdF','S006','Dairy',140,700,420);

SELECT * FROM sql_test_raw;

-- Disable Safe Update Mode (to avoid Error 1175)
SET SQL_SAFE_UPDATES = 0;

-- Add profit column
ALTER TABLE sql_test_raw ADD COLUMN profit INT;

-- Update and calculate profit values using formulation requested
UPDATE sql_test_raw
SET profit = sales_amt - sales_cost;

SELECT * FROM sql_test_raw;

-- Add 4 new metric columns for calculations required if they don’t already exist
ALTER TABLE sql_test_raw
ADD COLUMN sales_qty_contribution_by_category DECIMAL(10,4),
ADD COLUMN sales_amt_contribution_by_category DECIMAL(10,4),
ADD COLUMN sales_cost_contribution_by_category DECIMAL(10,4),
ADD COLUMN profit_contribution_by_category DECIMAL(10,4);

-- Update calculated metric columns using Left Join to merge main table with aggregated totals per (month, category) to calculate contribution ratios for each metric
UPDATE sql_test_raw a
LEFT JOIN (
    SELECT 
        month, category,
        SUM(sales_qty) AS total_qty,
        SUM(sales_amt) AS total_amt,
        SUM(sales_cost) AS total_cost,
        SUM(profit) AS total_profit
    FROM sql_test_raw
    GROUP BY month, category
) b
ON a.month = b.month AND a.category = b.category
SET 
    a.sales_qty_contribution_by_category = ROUND(a.sales_qty / b.total_qty, 4),
    a.sales_amt_contribution_by_category = ROUND(a.sales_amt / b.total_amt, 4),
    a.sales_cost_contribution_by_category = ROUND(a.sales_cost / b.total_cost, 4),
    a.profit_contribution_by_category = ROUND(a.profit / b.total_profit, 4);

-- Preview transformed data
SELECT * FROM sql_test_raw;

-- Create pivoted output similar to the expected Excel sheet
-- Using SUM() + CASE WHEN to aggregate contribution values by month
-- Produces a month-based wide table grouped by product and category
SELECT 
    product,
    category,

    -- January
    SUM(CASE WHEN MONTH(month) = 1 THEN ROUND(sales_qty_contribution_by_category, 2) END) AS Jan_25_sales_qty_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 1 THEN ROUND(sales_amt_contribution_by_category, 2) END) AS Jan_25_sales_amt_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 1 THEN ROUND(sales_cost_contribution_by_category, 2) END) AS Jan_25_sales_cost_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 1 THEN ROUND(profit_contribution_by_category, 2) END) AS Jan_25_profit_contribution_by_category,

    -- February
    SUM(CASE WHEN MONTH(month) = 2 THEN ROUND(sales_qty_contribution_by_category, 2) END) AS Feb_25_sales_qty_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 2 THEN ROUND(sales_amt_contribution_by_category, 2) END) AS Feb_25_sales_amt_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 2 THEN ROUND(sales_cost_contribution_by_category, 2) END) AS Feb_25_sales_cost_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 2 THEN ROUND(profit_contribution_by_category, 2) END) AS Feb_25_profit_contribution_by_category,

    -- March
    SUM(CASE WHEN MONTH(month) = 3 THEN ROUND(sales_qty_contribution_by_category, 2) END) AS Mar_25_sales_qty_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 3 THEN ROUND(sales_amt_contribution_by_category, 2) END) AS Mar_25_sales_amt_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 3 THEN ROUND(sales_cost_contribution_by_category, 2) END) AS Mar_25_sales_cost_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 3 THEN ROUND(profit_contribution_by_category, 2) END) AS Mar_25_profit_contribution_by_category,

    -- April
    SUM(CASE WHEN MONTH(month) = 4 THEN ROUND(sales_qty_contribution_by_category, 2) END) AS Apr_25_sales_qty_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 4 THEN ROUND(sales_amt_contribution_by_category, 2) END) AS Apr_25_sales_amt_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 4 THEN ROUND(sales_cost_contribution_by_category, 2) END) AS Apr_25_sales_cost_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 4 THEN ROUND(profit_contribution_by_category, 2) END) AS Apr_25_profit_contribution_by_category,

    -- May
    SUM(CASE WHEN MONTH(month) = 5 THEN ROUND(sales_qty_contribution_by_category, 2) END) AS May_25_sales_qty_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 5 THEN ROUND(sales_amt_contribution_by_category, 2) END) AS May_25_sales_amt_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 5 THEN ROUND(sales_cost_contribution_by_category, 2) END) AS May_25_sales_cost_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 5 THEN ROUND(profit_contribution_by_category, 2) END) AS May_25_profit_contribution_by_category,

    -- June
    SUM(CASE WHEN MONTH(month) = 6 THEN ROUND(sales_qty_contribution_by_category, 2) END) AS Jun_25_sales_qty_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 6 THEN ROUND(sales_amt_contribution_by_category, 2) END) AS Jun_25_sales_amt_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 6 THEN ROUND(sales_cost_contribution_by_category, 2) END) AS Jun_25_sales_cost_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 6 THEN ROUND(profit_contribution_by_category, 2) END) AS Jun_25_profit_contribution_by_category,

    -- July
    SUM(CASE WHEN MONTH(month) = 7 THEN ROUND(sales_qty_contribution_by_category, 2) END) AS Jul_25_sales_qty_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 7 THEN ROUND(sales_amt_contribution_by_category, 2) END) AS Jul_25_sales_amt_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 7 THEN ROUND(sales_cost_contribution_by_category, 2) END) AS Jul_25_sales_cost_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 7 THEN ROUND(profit_contribution_by_category, 2) END) AS Jul_25_profit_contribution_by_category,

    -- August
    SUM(CASE WHEN MONTH(month) = 8 THEN ROUND(sales_qty_contribution_by_category, 2) END) AS Aug_25_sales_qty_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 8 THEN ROUND(sales_amt_contribution_by_category, 2) END) AS Aug_25_sales_amt_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 8 THEN ROUND(sales_cost_contribution_by_category, 2) END) AS Aug_25_sales_cost_contribution_by_category,
    SUM(CASE WHEN MONTH(month) = 8 THEN ROUND(profit_contribution_by_category, 2) END) AS Aug_25_profit_contribution_by_category

FROM sql_test_raw
GROUP BY product, category
ORDER BY product, category;

-- Reset Safe Update Mode
SET SQL_SAFE_UPDATES = 1;