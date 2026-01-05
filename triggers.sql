CREATE TRIGGER tr_prevent_order_delete
ON orders
INSTEAD OF DELETE
AS
IF EXISTS (SELECT 1 FROM order_details od JOIN deleted d ON od.order_id = d.order_id)
BEGIN
    RAISERROR ('Cannot delete orders with order details.', 16, 1);
    ROLLBACK TRANSACTION;
END;