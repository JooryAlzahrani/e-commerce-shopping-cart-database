# Shopping Cart Database

A comprehensive relational database system designed for an e-commerce shopping cart application. Built with MySQL, this project demonstrates core database concepts including schema design, relationships, constraints, and data integrity.

## Overview

This project implements a complete shopping cart database system that manages customers, products, shopping carts, payments, and orders. It's ideal for learning relational database design and SQL fundamentals.

## Features

- **Customer Management**: Store and manage customer information with unique identifiers
- **Product Catalog**: Maintain product inventory with pricing and availability status
- **Shopping Cart**: Track products added to customer carts with quantities
- **Payment Processing**: Handle multiple payment methods and payment status tracking
- **Order Management**: Complete order lifecycle from creation to delivery
- **Data Integrity**: Enforced through primary keys, foreign keys, and constraints
- **Audit Trails**: Automatic timestamp tracking for record creation and updates

## Database Schema

### Tables

**Customer**
- Stores customer information (name, phone, email)
- Auto-incrementing primary key
- Timestamps for record tracking

**Product**
- Contains product details (name, description, price, stock)
- Price and stock validation checks
- Inventory status tracking (Available, Unavailable, Almost Done)

**Cart**
- Links customers to products with quantities
- Many-to-many relationship through customer and product
- Tracks when items were added

**Payment**
- Records payment transactions
- Supports multiple payment methods
- Tracks payment status (Paid, Canceled, Awaiting Payment, Refunded)

**Orders**
- Main transaction table linking customers, carts, and payments
- Order lifecycle management
- Delivery date tracking

## Requirements

- MySQL 5.7 or higher
- SQL client (MySQL Workbench, DBeaver, or command line)

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/shopping-cart-database.git
cd shopping-cart-database
```

2. Open your MySQL client and execute:
```bash
source DBproject.sql
```

Or manually copy and paste the SQL script into your MySQL client.

3. Verify installation:
```sql
USE ShoppingCartDB;
SELECT * FROM Customer;
```

## Usage

### View All Products
```sql
SELECT * FROM Product;
```

### Get Customer Orders
```sql
SELECT 
    o.OrderID,
    c.FirstName,
    c.LastName,
    p.ProductName,
    o.OrderStatus
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Cart cart ON o.CartID = cart.CartID
JOIN Product p ON cart.ProductID = p.ProductID;
```

### Calculate Revenue by Payment Method
```sql
SELECT PaymentMethod, SUM(AmountPaid) AS TotalRevenue
FROM Payment
GROUP BY PaymentMethod;
```

### Track Inventory
```sql
SELECT ProductName, StockQuantity, ProductStatus
FROM Product
ORDER BY StockQuantity ASC;
```

## Data Constraints

- **Price Validation**: All prices must be greater than 0
- **Stock Validation**: Stock quantities cannot be negative
- **Email Uniqueness**: Each customer must have a unique email
- **Phone Uniqueness**: Each customer must have a unique phone number
- **Referential Integrity**: Foreign key constraints prevent orphaned records
- **Status Enums**: Predefined status values ensure data consistency

## Sample Data

The database includes 5 sample customers, 5 products, and 5 orders for testing and demonstration purposes.

## Contributing

Feel free to fork this project and submit pull requests for any improvements.

## License

This project is open source and available under the MIT License.

## Author

Created as a Fundamentals of Databases course project.
