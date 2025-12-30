Google Sheets (DATASET):
https://docs.google.com/spreadsheets/d/1dh3orZAT8H3je5roVI_A1KLPQrp1H2APn92CW9hLmD0/edit?usp=sharing

--- Q1 ---
SELECT
    user_city,
    COUNT(DISTINCT user_name) AS users_count
FROM public.users_sql_project
GROUP BY user_city
ORDER BY users_count DESC;

--- Q2 ---
SELECT order_id
FROM public.order_items_sql_project
GROUP BY order_id
ORDER BY SUM(quantity) DESC
LIMIT 1;

--- Q3 ---
SELECT COUNT(*) AS orders_count 
FROM payments_sql_project
WHERE payment_status IS NOT NULL
AND payment_status NOT LIKE 'Відхилено' 
AND payment_method IN ('Картка', 'Банківський переказ');

--- Q4 ---
SELECT user_id,
COUNT(*) AS orders_count
FROM orders_sql_project
GROUP BY user_id
HAVING COUNT(*) >= 5
ORDER BY orders_count DESC;

--- Q5 ---
SELECT
   SUM(quantity) AS total_quantity,
   COUNT(DISTINCT order_id) AS unique_orders
FROM order_items_sql_project
WHERE product_id IN (11, 23);

--- Q6 ---
SELECT
    tracking_number,
    COALESCE(delivery_date::text, 'в роботі') AS delivery_date
FROM shipments_sql_project;

--- Q7 ---
SELECT
 CASE
   WHEN user_age < 25 THEN 'молоді'
   WHEN user_age BETWEEN 25 AND 44 THEN 'середній вік'
   ELSE 'старший вік'
 END AS age_category,
 COUNT(*) AS users_count
FROM users_sql_project
GROUP BY
 CASE
   WHEN user_age < 25 THEN 'молоді'
   WHEN user_age BETWEEN 25 AND 44 THEN 'середній вік'
   ELSE 'старший вік'
 END
ORDER BY users_count DESC;

--- Q8 ---
SELECT
 user_city,
 COUNT(DISTINCT loyalty_status) AS loyalty_status_count
FROM users_sql_project
GROUP BY user_city
HAVING COUNT(DISTINCT loyalty_status) >= 3
ORDER BY loyalty_status_count ASC;

--- Q9 ---
SELECT *
FROM users_sql_project
WHERE user_email LIKE '%@gmail.com';

--- Q10 ---
SELECT courier,
 AVG(delivery_date - shipment_date) AS avg_delivery_time
FROM shipments_sql_project
WHERE shipment_date IS NOT NULL
 AND delivery_date IS NOT NULL
GROUP BY courier
ORDER BY avg_delivery_time ASC;
