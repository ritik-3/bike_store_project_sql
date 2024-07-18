use bike_store;

# 1. Which products are the top 5 bestsellers?
SELECT p.product_name, 
AVG(oi.list_price) AS avg_list_price, 
SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 5;

#-----------------------------------------------------

# 2. What are the top 3 stores in terms of sales revenue?
SELECT s.store_name, 
SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN stores s ON o.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_revenue DESC
LIMIT 3;

#-----------------------------------------------------

# 3. Which categories of products are the most popular?
SELECT c.category_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_quantity DESC;

#-----------------------------------------------------

# 4. Who are the top 5 customers in terms of total purchase value?
SELECT c.first_name, c.last_name, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_purchase_value
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_purchase_value DESC
LIMIT 5;

#----------------------------------------------------

# 5. Which staff sold the most products?
SELECT s.staff_id, s.first_name AS "Staff First Name", s.last_name AS "Staff Last Name", SUM(oi.quantity) AS "Total Products Sold"
FROM staffs s
INNER JOIN orders o ON s.staff_id = o.staff_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY SUM(oi.quantity) DESC
LIMIT 5;

#----------------------------------------------------

# 6. What are the most common bike categories purchased by customers in a specific city?
SELECT c.city AS "City", cat.category_name AS "Category", COUNT(oi.product_id) AS "Total Bikes Sold"
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
WHERE c.city = 'campbell' -- replace here to find result from differnt city
GROUP BY c.city, cat.category_name
ORDER BY COUNT(oi.product_id) DESC;

#------------------------------------------------

# 7. Dividing customers into three types according to their purchase quantity as Platinum, Gold, and Silver.
WITH CustomerPurchase AS (SELECT c.customer_id, c.first_name, c.last_name, SUM(oi.quantity) AS total_quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN  order_items oi ON o.order_id = oi.order_id
GROUP BY  c.customer_id, c.first_name, c.last_name
)
SELECT  customer_id, first_name, last_name, total_quantity,
    CASE
        WHEN total_quantity >= 15 THEN 'Platinum'
        WHEN total_quantity BETWEEN 10 AND 14 THEN 'Gold'
        WHEN total_quantity BETWEEN 3 AND 9 THEN 'Silver'
        ELSE 'Not Frequent'
    END AS customer_type
FROM  CustomerPurchase
ORDER BY  total_quantity DESC;

#------------------------------------------------

# 8. What are the monthly sales trends for the given year?
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS monthly_sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE YEAR(order_date) = 2016
GROUP BY month
ORDER BY month;









