CREATE SCHEMA IF NOT EXISTS ShoppingCartDB;
USE ShoppingCartDB;


CREATE TABLE IF NOT EXISTS Customer(
    CustomerID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT Customer_PK PRIMARY KEY(CustomerID)
);


CREATE TABLE IF NOT EXISTS Product(
    ProductID INT NOT NULL AUTO_INCREMENT,
    ProductName VARCHAR(255) NOT NULL,
    ProductDescription TEXT,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    StockQuantity INT NOT NULL DEFAULT 0 CHECK (StockQuantity >= 0),
    ProductStatus VARCHAR(20) NOT NULL DEFAULT 'Available' 
        CHECK (ProductStatus IN('Available','Unavailable','Almost Done')),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT Product_PK PRIMARY KEY (ProductID)
);


CREATE TABLE IF NOT EXISTS Cart(
    CartID INT NOT NULL AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1 CHECK (Quantity > 0),
    ProductID INT NOT NULL,
    AddedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Cart_PK PRIMARY KEY (CartID),
    CONSTRAINT Cart_FK_Product FOREIGN KEY (ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE,
    CONSTRAINT Cart_FK_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS Payment(
    PaymentID INT NOT NULL AUTO_INCREMENT,
    PaymentMethod VARCHAR(50) NOT NULL 
        CHECK(PaymentMethod IN ('Upon Receipt', 'Credit Card', 'Debit Card', 'Apple Pay', 'PayPal')),
    AmountPaid DECIMAL(10,2) NOT NULL CHECK (AmountPaid > 0),
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PaymentStatus VARCHAR(20) NOT NULL DEFAULT 'Awaiting Payment' 
        CHECK (PaymentStatus IN ('Paid', 'Canceled', 'Awaiting Payment', 'Refunded')),
    CONSTRAINT Payment_PK PRIMARY KEY (PaymentID)
);


CREATE TABLE IF NOT EXISTS Orders(
    OrderID INT NOT NULL AUTO_INCREMENT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    OrderStatus VARCHAR(20) NOT NULL DEFAULT 'Awaiting Payment' 
        CHECK (OrderStatus IN ('Awaiting Payment', 'Being Prepared', 'Shipped', 'Delivered', 'Canceled', 'Refunded')),
    CustomerID INT NOT NULL,
    CartID INT NOT NULL,
    PaymentID INT NOT NULL,
     DeliveryDate TIMESTAMP NULL,
    CONSTRAINT Order_PK PRIMARY KEY (OrderID),
    CONSTRAINT Order_FK_Cart FOREIGN KEY (CartID) REFERENCES Cart(CartID) ON DELETE CASCADE,
    CONSTRAINT Order_FK_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    CONSTRAINT Order_FK_Payment FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID) ON DELETE CASCADE
);