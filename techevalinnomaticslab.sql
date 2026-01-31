use techeval;
SELECT 
    city,
    SUM(total_amount) AS total_revenue
FROM final
WHERE membership = 'Gold'
GROUP BY city
ORDER BY total_revenue DESC;

SELECT 
    cuisine,
    AVG(total_amount) AS avg_order_value
FROM final
GROUP BY cuisine
ORDER BY avg_order_value DESC;
SELECT 
    COUNT(*) AS user_count
FROM (
    SELECT 
        user_id
    FROM final

    GROUP BY user_id
    HAVING SUM(total_amount) > 1000
) AS high_value_users;
SELECT 
    rating_range,
    SUM(total_amount) AS total_revenue
FROM (
    SELECT
        total_amount,
        CASE
            WHEN rating >= 3 AND rating < 3.5 THEN '3 to 3.5'
            WHEN rating >= 3.6 AND rating < 4 THEN '3.6 to 4'
            WHEN rating >= 4.1 AND rating < 4.5 THEN '4.1 to 4.5'
            WHEN rating >= 4.6 AND rating < 5 THEN '4.6 to 5'
            ELSE '<3&>5'
        END AS rating_range
    FROM final
) AS rated_orders
GROUP BY rating_range
ORDER BY total_revenue DESC;
SELECT 
    city,
    AVG(total_amount) AS avg_order_value
FROM final
WHERE membership = 'Gold'
GROUP BY city
ORDER BY avg_order_value DESC;
SELECT 
    cuisine,
    COUNT(DISTINCT restaurant_id) AS restaurant_count,
    SUM(total_amount) AS total_revenue
FROM final
GROUP BY cuisine
ORDER BY restaurant_count ASC, total_revenue DESC;
SELECT 
    ROUND(
        (SUM(membership = 'Gold') * 100.0) / COUNT(*)
    ) AS gold_order_percentage
FROM final;
SELECT 
    restaurant_id,
    restaurant_name_x AS restaurant_name,
    AVG(total_amount) AS avg_order_value,
    COUNT(order_id) AS total_orders
FROM final
WHERE restaurant_name_x IN (
    'Grand Cafe punjabi',
    'Grand Restaurant South Indian',
    'Ruchi Mess Multicuisine',
    'Ruchi Foods Chinese'
)
GROUP BY restaurant_id, restaurant_name_x
HAVING COUNT(order_id) < 20
ORDER BY avg_order_value DESC;
SELECT 
    membership,
    cuisine,
    SUM(total_amount) AS total_revenue
FROM final
WHERE (membership = 'Gold' AND cuisine = 'Indian')
   OR (membership = 'Gold' AND cuisine = 'Italian')
   OR (membership = 'Regular' AND cuisine = 'Indian')
   OR (membership = 'Regular' AND cuisine = 'Chinese')
GROUP BY membership, cuisine
ORDER BY total_revenue DESC;
SELECT 
    quarter,
    SUM(total_amount) AS total_revenue
FROM (
    SELECT
        total_amount,
        CASE
            WHEN MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) BETWEEN 1 AND 3
                THEN 'Q1 (Jan–Mar)'
            WHEN MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) BETWEEN 4 AND 6
                THEN 'Q2 (Apr–Jun)'
            WHEN MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) BETWEEN 7 AND 9
                THEN 'Q3 (Jul–Sep)'
            ELSE 'Q4 (Oct–Dec)'
        END AS quarter
    FROM final
) AS quarterly_orders
GROUP BY quarter
ORDER BY total_revenue DESC;
SELECT 
    COUNT(order_id) AS total_gold_orders
FROM final
WHERE membership = 'Gold';
SELECT 
    ROUND(SUM(total_amount)) AS total_revenue_hyderabad
FROM final
WHERE city = 'Hyderabad';
SELECT 
    COUNT(DISTINCT user_id) AS distinct_users_with_orders
FROM final;
SELECT 
    ROUND(AVG(total_amount), 2) AS avg_order_value_gold
FROM final
WHERE membership = 'Gold';
SELECT 
    COUNT(order_id) AS total_orders_high_rating
FROM final
WHERE rating >= 4.5;
SELECT 
    COUNT(order_id) AS total_orders
FROM final
WHERE membership = 'Gold'
  AND city = (
      SELECT city
      FROM final
      WHERE membership = 'Gold'
      GROUP BY city
      ORDER BY SUM(total_amount) DESC
      LIMIT 1
  );