SELECT *
FROM customers;
#--------------------------
SELECT *
FROM orders;
    
################################################
#Joining customer table and order table to find out "Order ID" and "OrderDate"
SELECT 
    customer_id,
    last_name,
    first_name,
    state,
    order_id,
    order_date
FROM
    customers
        JOIN
    orders USING (customer_id);
    
#--------------------------------------

# Create a detaild result table containing customer, order and product details.
SELECT 
    c.first_name,
    c.last_name,
    p.product_name,
    oi.quantity,
    oi.list_price,
    oi.discount
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id
ORDER BY 
    c.last_name, c.first_name, p.product_name;

#-----------------------------------------------

# For each sale in the database, list the customer's full name and the full name of the staff member who processed the order.
SELECT 
    c.first_name AS 'Customer First Name',
    c.last_name AS 'Customer Last Name',
    s.first_name AS 'Staff First Name',
    s.last_name AS 'Staff Last Name'
FROM
    customers c
		JOIN
    orders o ON c.customer_id = o.customer_id
		JOIN
    staffs s ON o.staff_id = s.staff_id;
    
#--------------------------------------------------

# Which products are the top 5 bestsellers?
SELECT 
    p.product_name, SUM(oi.quantity) AS total_quantity
FROM
    order_items oi
        JOIN
    products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 5;

#---------------------------------------------------

# What are the top 5 stores in terms of sales revenue?
SELECT 
    s.store_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_revenue
FROM
    order_items oi
        JOIN
    orders o ON oi.order_id = o.order_id
        JOIN
    stores s ON o.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_revenue DESC
LIMIT 5;

#----------------------------------------------------

# Which staff sold the most products?
SELECT s.staff_id, s.first_name AS "Staff First Name", s.last_name AS "Staff Last Name", SUM(oi.quantity) AS "Total Products Sold"
FROM staffs s
INNER JOIN orders o ON s.staff_id = o.staff_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.staff_id, s.first_name, s.last_name
ORDER BY SUM(oi.quantity) DESC
LIMIT 5;

#-----------------------------------------------------

# Which categories of products are the most popular?
SELECT c.category_name, SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_quantity DESC;

#-----------------------------------------------------

# Who are the top 5 customers in terms of total purchase value?
SELECT c.first_name, c.last_name, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_purchase_value
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_purchase_value DESC
LIMIT 5;

#------------------------------------------------

# What are the monthly sales trends for the current year?
##############################################################
############## NOT WORKING FOR SOME REASON ###################
##############################################################

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS monthly_sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE YEAR(order_date) = YEAR(CURDATE())
GROUP BY month
ORDER BY month;

#------------------------------------------

# Find all customers who have placed more than a certain number of orders.
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS order_count
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    COUNT(o.order_id) > 2
ORDER BY 
    order_count DESC;

#----------------------------------------------

#What are the most common bike categories purchased by customers in a specific city?
SELECT c.city AS "City", cat.category_name AS "Category", COUNT(oi.product_id) AS "Total Bikes Sold"
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
WHERE c.city = 'campbell' -- replace here to find result from differnt city
GROUP BY c.city, cat.category_name
ORDER BY COUNT(oi.product_id) DESC;

#--------------------------------------

SELECT s.first_name AS "Staff First Name", s.last_name AS "Staff Last Name", 
       ROUND(AVG(oi.quantity * oi.list_price * (1 - oi.discount/100)),2) AS "Average Revenue"
FROM staffs s
JOIN orders o ON s.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.staff_id, s.first_name, s.last_name;