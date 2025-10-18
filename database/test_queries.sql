USE ShoppingCartDB;

SELECT * FROM Customer;

SELECT * FROM Product;

SELECT * FROM Cart;

SELECT * FROM Payment;

SELECT * FROM Orders;

SELECT * FROM Product WHERE Price > 75;

SELECT PaymentMethod, SUM(AmountPaid) AS TotalAmount FROM Payment GROUP BY PaymentMethod;

SELECT PaymentMethod, SUM(AmountPaid) AS TotalAmount FROM Payment GROUP BY PaymentMethod HAVING SUM(AmountPaid) > 300;

SELECT * FROM Orders ORDER BY OrderID DESC;

SELECT 
    o.OrderID,
    c.FirstName,
    c.LastName,
    p.ProductName,
    p.Price,
    o.OrderStatus,
    o.OrderDate
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Cart cart ON o.CartID = cart.CartID
JOIN Product p ON cart.ProductID = p.ProductID
ORDER BY o.OrderDate DESC;

SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders FROM Orders o JOIN Customer c ON o.CustomerID = c.CustomerID GROUP BY c.CustomerID, c.FirstName, c.LastName;

SELECT p.ProductName, p.StockQuantity, p.ProductStatus FROM Product ORDER BY p.StockQuantity ASC;

SELECT o.OrderID, o.OrderDate, o.OrderStatus, c.FirstName, c.Email FROM Orders o JOIN Customer c ON o.CustomerID = c.CustomerID WHERE o.OrderStatus = 'Delivered';

SELECT pm.PaymentMethod, COUNT(p.PaymentID) AS TransactionCount, SUM(p.AmountPaid) AS TotalAmount FROM Payment p GROUP BY p.PaymentMethod;
