Show tables;

SELECT * FROM customers;

#Total number of customers :- 1445
SELECT COUNT(*) AS total_rows FROM customers ;

#########################################

#Number of customers form each state 
SELECT 
    COUNT(*) as customers_by_state,
    state 
FROM
    customers
GROUP BY state;

#-----------------------------------------

SELECT 
    customer_id, first_name, Last_name, state
FROM
    customers
ORDER BY state;

#-----------------------------------------

SELECT 
    *
FROM
    customers
WHERE
    state IN ('CA' , 'TX')
ORDER BY 
	state;


##########################################

#Extract those customers who has not filled their phone number 
SELECT 
    customer_id, first_name, last_name, email
FROM
    customers
WHERE
    phone IS NULL
ORDER BY 
	customer_id;

#######################################

SELECT 
    *
FROM
    products;
    
#------------------------------------

SELECT 
    product_id, product_name
FROM
    products
WHERE
    product_name LIKE 'r%';
    
#-----------------------------------

SELECT 
    product_id, product_name
FROM
    products
WHERE
    product_name LIKE '%6'; 
    
#####################################

SELECT 
    *
FROM
    order_items;
    
#-------------------------------------

#What is the most expensive product?

SELECT 
    MAX(list_price)
FROM 
	order_items;
    
#----------------------------------------
#what is the avefage price of all the products.
SELECT 
	AVG(discount) as avg_discount
FROM 
	order_items;
    
#-----------------------------------------

#what is the total items sold -7071

SELECT 
    SUM(quantity) AS total_items_ordered
FROM 
    order_items;
    
#----------------------------------------

#What is the most sold item and the total value of its sale
SELECT
    product_id,
    SUM(quantity) AS total_sold,
    ROUND(SUM(list_price * (1 - discount) * quantity),2) AS total_price_w_discount
FROM
    order_items
GROUP BY
    product_id
ORDER BY
    total_sold DESC;
    
#------------------------------------

#Extract all the products which have final price more than 20,000/-
SELECT 
    order_id,
    ROUND(SUM(quantity * list_price * (1 - discount)), 2) final_sale_price
FROM 
    order_items
GROUP BY
    1
HAVING
    final_sale_price > 20000
ORDER BY
    2 DESC;
    
###############################################

SELECT 
    *
FROM
    orders;
    
#---------------------------------------------

SELECT 
    *,
    CASE WHEN shipped_date > required_date THEN 1
         ELSE 0
         END AS 'shipped_late'
FROM 
    orders
order by
	shipped_late desc;

#--------------------------------------------------

#Count how many orders are late 

SELECT
    COUNT(CASE WHEN shipped_late = 1 THEN 1 ELSE NULL END) AS late,
    COUNT(CASE WHEN shipped_late = 0 THEN 1 ELSE NULL END) AS not_late
FROM (
    SELECT 
        *,
        CASE WHEN shipped_date > required_date THEN 1
             ELSE 0
        END AS 'shipped_late'
    FROM 
        orders
) AS subquery;
    