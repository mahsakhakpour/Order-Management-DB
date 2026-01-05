CREATE VIEW vw_order_cost AS
SELECT
    o.order_id,
    o.order_date,
    c.name AS customer_name,
    od.quantity * p.unit_price AS order_cost
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN order_details od ON od.order_id = o.order_id
JOIN products p ON p.product_id = od.product_id;