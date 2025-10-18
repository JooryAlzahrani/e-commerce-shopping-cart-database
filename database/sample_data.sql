USE ShoppingCartDB;

INSERT INTO Customer (FirstName, LastName, PhoneNumber, Email)
VALUES  
('Hassan', 'Alamri', '0561234567', 'hassan@gmail.com'),  
('Aisha', 'Almutairi', '0544875620', 'aisha@gmail.com'),  
('Lama', 'Alshammari', '0561478554', 'lama@gmail.com'),  
('Fahad', 'Alqahtani', '0571477851', 'fahad@gmail.com'),  
('Salem', 'Alharbi', '0562547813', 'salem@gmail.com');

INSERT INTO Product (ProductName, ProductDescription, Price, StockQuantity, ProductStatus)
VALUES
('Laptop', 'High-performance laptop with 16GB RAM', 1200.99, 10, 'Almost Done'),
('Smartphone', 'Latest model smartphone with 5G', 699.49, 62, 'Available'),
('Desk', 'Ergonomic wooden desk', 150.00, 112, 'Available'),
('Chair', 'Comfortable office chair', 85.99, 0, 'Unavailable'),
('Book', 'Database fundamentals guide', 12.49, 84, 'Available');

INSERT INTO Cart (CustomerID, Quantity, ProductID, AddedDate)
VALUES  
(1, 1, 1, '2022-12-01'),  
(2, 1, 2, '2023-01-03'),  
(3, 2, 3, '2024-03-04'),  
(4, 1, 4, '2024-06-04'),  
(5, 3, 5, '2025-01-12');

INSERT INTO Payment (PaymentMethod, AmountPaid, PaymentDate, PaymentStatus)
VALUES
('Upon Receipt', 1200.99, '2025-01-07', 'Paid'),
('Apple Pay', 699.49, '2025-01-01', 'Canceled'),
('Credit Card', 150.00, '2025-01-01', 'Paid'),
('Upon Receipt', 85.99, '2025-01-01', 'Paid'),
('Apple Pay', 12.49, '2025-01-01', 'Paid');

INSERT INTO Orders (OrderDate, OrderStatus, CustomerID, CartID, PaymentID, DeliveryDate)  
VALUES 
('2024-12-30', 'Delivered', 1, 1, 1, '2025-01-05'),  
('2025-01-01', 'Canceled', 2, 2, 2, NULL),  
('2025-01-01', 'Shipped', 3, 3, 3, NULL),  
('2025-01-07', 'Delivered', 4, 4, 4, '2025-01-10'), 
('2025-01-14', 'Being Prepared', 5, 5, 5, NULL);
