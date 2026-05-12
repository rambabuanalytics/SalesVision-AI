CREATE DATABASE sales_project;
USE sales_project;
# DATA CHECK--------
SELECT * FROM customers_dirty_2019_2025;
SELECT * FROM orders_dirty_2019_2025;
SELECT * FROM products_dirty_2019_2025;

# DUPLICATES CHECK
SELECT customer_id, COUNT(*)
FROM customers_dirty_2019_2025
GROUP BY customer_id
HAVING COUNT(*) > 1;

# MISSING VALUES CHECK
SELECT *
FROM customers_dirty_2019_2025
WHERE age IS NULL OR city IS NULL;

# SPELLING CHECK
SELECT DISTINCT city
FROM customers_dirty_2019_2025;

# ORDRS__TABLE
# MISSING VALUES CHECK
SELECT *
FROM orders_dirty_2019_2025
WHERE qty IS NULL OR price IS NULL;

# INVALID DATA
SELECT *
FROM orders_dirty_2019_2025
WHERE qty <= 0;

# PRODUCT_TABLE
# DUPLICATES CHECK
SELECT product_id, COUNT(*)
FROM products_dirty_2019_2025
GROUP BY product_id
HAVING COUNT(*) > 1;

# MISSING VALUES CHECK
SELECT *
FROM products_dirty_2019_2025
WHERE category IS NULL 
   OR cost_price IS NULL 
   OR brand IS NULL;
   
# SPELLING CHECK
SELECT DISTINCT category
FROM products_dirty_2019_2025;

# INVALID PRICE CHECK
SELECT *
FROM products_dirty_2019_2025
WHERE cost_price <= 0;

# PRODUCTS FIX ("correct the data")
UPDATE products_dirty_2019_2025
SET category = 'ELECTRONICS'
WHERE category = 'ELETRONICS'; 
SET SQL_SAFE_UPDATES = 0;

# CUSTOMERS FIX (NULL + NaN)
UPDATE customers_dirty_2019_2025
SET city = 'Unknown'
WHERE city = 'NaN' OR city IS NULL;
UPDATE customers_dirty_2019_2025
SET name = 'Unknown'
WHERE name IS NULL;

# Missing name identify
SELECT *
FROM customers_dirty_2019_2025
WHERE name IS NULL;

# Fill missing names
UPDATE customers_dirty_2019_2025
SET name = CONCAT('Customer_', customer_id)
WHERE name IS NULL OR name = '';

# ORDERS FIX (INVALID DATE ❌)
DELETE FROM orders_dirty_2019_2025
WHERE order_date = 'INVALID_DATE';

# CLEAN TABLE
#  customer:

CREATE TABLE customers_clean_sql AS
SELECT *
FROM customers_dirty_2019_2025;


# Orders:
CREATE TABLE orders_clean_sql AS
SELECT *
FROM orders_dirty_2019_2025
WHERE qty > 0;

# Products:
CREATE TABLE products_clean_sql AS
SELECT *
FROM products_dirty_2019_2025;

# FINAL CHECK
SELECT * FROM customers_clean_sql;
SELECT * FROM orders_clean_sql;
SELECT * FROM products_clean_sql;
