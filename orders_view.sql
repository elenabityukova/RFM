CREATE OR REPLACE VIEW analysis.orders AS
SELECT o.order_id,
       ol.dttm AS "order_ts",
       o.user_id,
       o.bonus_payment,
       o.payment,
       o."cost",
       o.bonus_grant,
       ol.status_id AS "status"
FROM production.orders o
LEFT JOIN production.orderstatuslog ol ON ol.order_id = o.order_id
AND ol.dttm =
  (SELECT max(ol2.dttm)
   FROM production.orderstatuslog ol2
   WHERE ol2.order_id = o.order_id);
