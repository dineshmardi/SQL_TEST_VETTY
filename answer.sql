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

