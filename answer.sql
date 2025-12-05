/* Q1: Count of purchases per month (excluding refunds)*/

SELECT 
    DATE_FORMAT(purchase_time, '%Y-%m') AS purchase_month,
    COUNT(*) AS total_purchases
FROM transactions
WHERE refund_item IS NULL
GROUP BY DATE_FORMAT(purchase_time, '%Y-%m')
ORDER BY purchase_month;