SELECT c.category_name, b.brand_name, 
SUM(oi.quantity) AS total_quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN brands b ON p.brand_id = b.brand_id
GROUP BY c.category_name, b.brand_name
ORDER BY total_quantity DESC;


use bike_store;

#2. What are the purchasing patterns of high-value customers and how can they be incentivized to increase their purchase frequency?
#Objective: To analyze the purchasing behavior of high-value customers (e.g., Platinum customers) and develop targeted incentives or loyalty programs to encourage more frequent purchases.
WITH HighValueCustomers AS (
    SELECT c.customer_id,c.first_name,c.last_name,
		SUM(oi.quantity * oi.list_price) AS total_spent,
        COUNT(DISTINCT o.order_id) AS total_orders
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.first_name, c.last_name
    HAVING SUM(oi.quantity * oi.list_price) > 20000  -- Define high-value threshold
),
CustomerOrderLags AS (
    SELECT o.customer_id,o.order_date,
		LAG(o.order_date) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS previous_order_date
    FROM orders o
)
SELECT hvc.customer_id,hvc.first_name, hvc.last_name, hvc.total_spent, hvc.total_orders,
    AVG(oi.quantity * oi.list_price) AS avg_order_value,
    AVG(DATEDIFF(o.order_date, col.previous_order_date)) AS avg_days_between_orders
FROM HighValueCustomers hvc
JOIN orders o ON hvc.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN CustomerOrderLags col ON hvc.customer_id = col.customer_id AND o.order_date = col.order_date
GROUP BY hvc.customer_id, hvc.first_name, hvc.last_name, hvc.total_spent, hvc.total_orders
ORDER BY hvc.total_spent DESC;


SELECT YEAR(o.order_date) AS year,
    MONTH(o.order_date) AS month,
    SUM(oi.quantity * oi.list_price) AS total_revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE YEAR(o.order_date) IN (2016, 2017)
GROUP BY YEAR(o.order_date), MONTH(o.order_date)
ORDER BY year, month;
    
select * from orders;
