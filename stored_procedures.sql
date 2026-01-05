CREATE PROCEDURE sp_customers_by_city
    @city VARCHAR(20)
AS
SELECT customer_id, name, address, phone
FROM customers
WHERE city = @city;
GO

CREATE PROCEDURE sp_orders_by_date
    @start_date DATE,
    @end_date DATE
AS
SELECT o.order_id, c.name AS customer_name, o.shipped_date
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.shipped_date BETWEEN @start_date AND @end_date;
GO