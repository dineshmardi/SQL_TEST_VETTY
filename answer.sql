/* Q1: Count of purchases per month (excluding refunds)*/

SELECT 
    DATE_FORMAT(purchase_time, '%Y-%m') AS purchase_month,
    COUNT(*) AS total_purchases
FROM transactions
WHERE refund_item IS NULL
GROUP BY DATE_FORMAT(purchase_time, '%Y-%m')
ORDER BY purchase_month;


/*Q2: Number of stores receiving at least 5 orders in Oct 2020 */

SELECT 
    store_id,
    COUNT(*) AS order_count
FROM transactions
WHERE purchase_time BETWEEN '2020-10-01' AND '2020-10-31 23:59:59'
GROUP BY store_id
HAVING COUNT(*) >= 5;


/*  Q3: Shortest interval (in minutes) from purchase to refund*/
/* Consider only refunded transactions (refund_time IS NOT NULL).*/
SELECT 
    store_id,
    MIN(TIMESTAMPDIFF(MINUTE, purchase_time, refund_time)) 
        AS shortest_refund_interval_minutes
FROM transactions
WHERE refund_time IS NOT NULL
GROUP BY store_id;

/* Q4: Gross transaction value of each store's first order */
SELECT 
    t.store_id,
    t.gross_transaction_value
FROM transactions t
JOIN (
    SELECT 
        store_id,
        MIN(purchase_time) AS first_order_time
    FROM transactions   /*Select the gross_transaction_value for that first purchase.*/
    GROUP BY store_id
) f ON t.store_id = f.store_id 
   AND t.purchase_time = f.first_order_time;



/* Q5: Most popular item ordered in buyers' first purchases*/

WITH first_orders AS (
    SELECT 
        buyer_id,
        MIN(purchase_time) AS first_time
    FROM transactions
    GROUP BY buyer_id
)
SELECT 
    i.item_name,
    COUNT(*) AS times_ordered /*Count and return the most frequently ordered item.*/
FROM transactions t
JOIN first_orders f 
      ON t.buyer_id = f.buyer_id AND t.purchase_time = f.first_time
JOIN items i 
      ON t.item_id = i.item_id
GROUP BY i.item_name
ORDER BY times_ordered DESC
LIMIT 1;