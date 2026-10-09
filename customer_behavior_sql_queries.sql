USE customer_behavior;
select count(*) from customer;

-- Q1. What is the total revenue by gender?
SELECT gender, SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY gender;

-- Q2. Who spent more than average despite using discount?
SELECT customer_id, purchase_amount
FROM customer
WHERE discount_applied = 'Yes' 
AND purchase_amount > (SELECT AVG(purchase_amount) FROM customer);

-- Q3. Which 5 products have the highest average rating?
SELECT item_purchased, ROUND(AVG(review_rating),2) AS avg_rating
FROM customer
GROUP BY item_purchased
ORDER BY avg_rating DESC
LIMIT 5;

-- Q4. Average purchase for Standard vs Express shipping?
SELECT shipping_type, ROUND(AVG(purchase_amount),2) AS avg_amount
FROM customer
WHERE shipping_type IN ('Standard','Express')
GROUP BY shipping_type;

-- Q5. Subscribed vs Non-Subscribed customers analysis
SELECT subscription_status, COUNT(*) AS total_customers,
       ROUND(AVG(purchase_amount),2) AS avg_spend,
       SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY subscription_status;

-- Q6. Which 5 products have highest % of purchases with discount?
SELECT item_purchased,
       ROUND(100.0 * SUM(CASE WHEN discount_applied='Yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;

-- Q7. Segment customers into New, Returning, Loyal
WITH customer_type AS (
  SELECT customer_id, previous_purchases,
  CASE
    WHEN previous_purchases = 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN 'Returning'
    ELSE 'Loyal'
  END AS customer_segment
  FROM customer
)
SELECT customer_segment, COUNT(*) AS "Number of Customers"
FROM customer_type
GROUP BY customer_segment;

-- Q8. Top 3 most purchased products within each category
WITH item_counts AS (
  SELECT category, item_purchased,
         COUNT(customer_id) AS total_orders,
         ROW_NUMBER() OVER (PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
  FROM customer
  GROUP BY category, item_purchased
)
SELECT item_rank, category, item_purchased, total_orders
FROM item_counts
WHERE item_rank <= 3;

-- Q9. Are repeat buyers (>5 purchases) likely to subscribe?
SELECT subscription_status, COUNT(customer_id) AS repeat_buyers
FROM customer
WHERE previous_purchases > 5
GROUP BY subscription_status;

-- Q10. Revenue contribution of each age group (FIXED)
SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 50 THEN '36-50'
    ELSE '51+'
  END AS age_group,
  SUM(purchase_amount) AS total_revenue
FROM customer
GROUP BY age_group
ORDER BY total_revenue DESC;