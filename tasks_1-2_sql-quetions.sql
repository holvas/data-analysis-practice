/* Task 1. Your business has launched a new feature in the app. How can you tell if users are actually using it? 
Or: the product has been around for a year, but you don't know if people visit every day or once a month. How many users are active right now? Do they come back regularly? */
Google Sheets (DATASET):
https://docs.google.com/spreadsheets/d/1dh3orZAT8H3je5roVI_A1KLPQrp1H2APn92CW9hLmD0/edit?usp=sharing


/* Task 2  The client wants to understand:
- How users are distributed across cities
- Which orders are the largest in terms of volume
- Which payment methods are the most popular
- Which customers are the most active
- How fast is delivery
The task as an analyst is to write SQL queries to retrieve this information from the database, analyze the data structure, and get answers to the client's business questions. */
--- Q1 ---
/* Analysis of user geographical distribution Display the number of unique users for each city. Sort the results in descending order by number of users */
SELECT
    user_city,
    COUNT(DISTINCT user_name) AS users_count
FROM public.users_sql_project
GROUP BY user_city
ORDER BY users_count DESC;

--- Q2 ---
/* Search for the largest order Find the order ID with the largest quantity of goods. Display this ID as the result. */
SELECT order_id
FROM public.order_items_sql_project
GROUP BY order_id
ORDER BY SUM(quantity) DESC
LIMIT 1;

--- Q3 ---
/* Analysis of payment methods Select unrefused orders where the payment method is “Card” or “Bank transfer.” Calculate the total number of such orders. */
SELECT COUNT(*) AS orders_count 
FROM payments_sql_project
WHERE payment_status IS NOT NULL
AND payment_status NOT LIKE 'Відхилено' 
AND payment_method IN ('Картка', 'Банківський переказ');

--- Q4 ---
/* Identifying the most active customers Find customers who have placed 5 or more orders. Output a table containing the user ID and number of orders, sorted by number of orders in descending order. */
SELECT user_id,
COUNT(*) AS orders_count
FROM orders_sql_project
GROUP BY user_id
HAVING COUNT(*) >= 5
ORDER BY orders_count DESC;

--- Q5 ---
/* Analyzing brand popularity Count the total number of products and the total number of orders for products of the ‘DigitalUA’ brand (you can track the product_id of this brand's products in 
the corresponding table and specify the selected product_id in the filter command). */
SELECT
   SUM(quantity) AS total_quantity,
   COUNT(DISTINCT order_id) AS unique_orders
FROM order_items_sql_project
WHERE product_id IN (11, 23);

--- Q6 ---
/* Tracking delivery status For each order, display the tracking number and delivery date, replacing missing delivery dates with the text “in progress”. */
SELECT
    tracking_number,
    COALESCE(delivery_date::text, 'в роботі') AS delivery_date
FROM shipments_sql_project;

--- Q7 ---
/* Creating age categories Create age categories for customers and count how many customers are in each category: < 25 - “young” 25–44 - “middle age” ≥ 45 - “older age” */
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
/* Loyalty program analysis For each city, count how many different types of loyalty_status customers have. Display only those cities where there are at least 3 different 
loyalty statuses, and sort them by status in ascending order. */
SELECT
 user_city,
 COUNT(DISTINCT loyalty_status) AS loyalty_status_count
FROM users_sql_project
GROUP BY user_city
HAVING COUNT(DISTINCT loyalty_status) >= 3
ORDER BY loyalty_status_count ASC;

--- Q9 ---
/* Filtering users by domain Get a list of users whose email addresses are on the gmail.com domain and display all available rows and columns with data on the screen. */
SELECT *
FROM users_sql_project
WHERE user_email LIKE '%@gmail.com';

--- Q10 ---
/* Calculating average delivery time For orders that have both iShipment_date and Delivery_date, calculate the number of delivery days and display the average delivery time 
for each courier. Sort the results in ascending order by average delivery time. */
SELECT courier,
 AVG(delivery_date - shipment_date) AS avg_delivery_time
FROM shipments_sql_project
WHERE shipment_date IS NOT NULL
 AND delivery_date IS NOT NULL
GROUP BY courier
ORDER BY avg_delivery_time ASC;

