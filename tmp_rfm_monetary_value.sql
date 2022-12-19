TRUNCATE analysis.tmp_rfm_monetary_value;

INSERT INTO analysis.tmp_rfm_monetary_value
WITH order_closed AS(
SELECT u.id,
	   max(o.order_ts) AS orders_closed_last_date,
       count(o.order_ts) AS orders_closed_cnt,
	   sum(o.payment) AS orders_closed_sum
FROM analysis.users u
JOIN analysis.orders o ON o.user_id = u.id
JOIN analysis.orderstatuses os ON o.status = os.id
WHERE os."key" = 'Closed'
  AND o.order_ts >= '01.01.2022'::timestamp
GROUP BY u.id
),

ds AS(
SELECT u.id AS user_id,
       coalesce(oc.orders_closed_last_date, '01.01.2022'::timestamp) AS orders_closed_last_date,
       coalesce(oc.orders_closed_cnt, 0) AS orders_closed_cnt,
       coalesce(oc.orders_closed_sum, 0) AS orders_closed_sum
FROM analysis.users u
LEFT JOIN order_closed oc ON oc.id = u.id
)

SELECT user_id,
ntile(5) OVER(ORDER BY orders_closed_sum) as "monetary_value"
FROM ds;
