# Shopping Cart Database

A comprehensive relational database system designed for an e-commerce shopping cart application. Built with MySQL, this project demonstrates core database concepts including schema design, relationships, constraints, and data integrity.

## Overview

This project implements a complete shopping cart database system that manages customers, products, shopping carts, payments, and orders. The database follows normalization principles and enforces data integrity through primary keys, foreign keys, and check constraints. It's ideal for learning relational database design and SQL fundamentals.

## Features

- **Customer Management**: Store and manage customer information with unique identifiers
- **Product Catalog**: Maintain product inventory with pricing and availability status
- **Shopping Cart**: Track products added to customer carts with quantities
- **Payment Processing**: Handle multiple payment methods and payment status tracking
- **Order Management**: Complete order lifecycle from creation to delivery
- **Data Integrity**: Enforced through primary keys, foreign keys, and constraints
- **Audit Trails**: Automatic timestamp tracking for record creation and updates
- **Cascading Deletes**: Maintains referential integrity across related tables

## Database Schema

The database consists of 5 core entities with well-defined relationships:

### Tables

**Customer**
- Stores customer information (name, phone, email)
- Auto-incrementing primary key
- Timestamps for record creation and updates
- Unique constraints on phone and email

**Product**
- Contains product details (name, description, price, stock)
- Price and stock validation checks
- Inventory status tracking (Available, Unavailable, Almost Done)
- Automatic timestamp tracking

**Cart**
- Links customers to products with item quantities
- Tracks when items were added to cart
- Maintains relationship between Customer and Product tables

**Payment**
- Records payment transactions
- Supports multiple payment methods (Upon Receipt, Credit Card, Debit Card, Apple Pay, PayPal)
- Tracks payment status (Paid, Canceled, Awaiting Payment, Refunded)

**Orders**
- Main transaction table linking customers, carts, and payments
- Tracks order status throughout lifecycle (Awaiting Payment, Being Prepared, Shipped, Delivered, Canceled, Refunded)
- Records order and delivery dates

For detailed entity descriptions and relationship diagrams, see [DATABASE_DOCUMENTATION.md](docs/db_description.md) and [ERD](docs/erd.mermaid).

## Project Structure

```
shopping-cart-database/
│
├── README.md
├── database/
│   ├── schema.sql      # Schema only (for production)
│   ├── sample_data.sql       # Sample data for testing
│   └── test_queries.sql      # Test queries to validate data
│
└── docs/
    ├── erd.mermaid                     # Entity Relationship Diagram
    └── DATABASE_DOCUMENTATION.md       # Detailed database documentation
```

## Requirements

- MySQL 5.7 or higher
- SQL client (MySQL Workbench, DBeaver, or command line)

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/shopping-cart-database.git
cd shopping-cart-database
```

### Step 2: Create the Database Schema

Open your MySQL client and execute the empty schema file:

```bash
source database/DBproject_empty_schema.sql
```

Or manually copy and paste the SQL script into your MySQL client.

### Step 3: Load Sample Data (Optional)

To populate the database with sample data for testing:

```bash
source database/DBproject_sample_data.sql
```

### Step 4: Verify Installation

```sql
USE ShoppingCartDB;
SELECT * FROM Customer;
```

You should see 5 sample customers if you loaded the sample data.

## Testing

### Using Sample Data

After loading the sample data, you can test the database with the provided test queries file:

```bash
source database/DBproject_test_queries.sql
```

This will execute 11 different queries that demonstrate:
- Basic SELECT statements from all tables
- WHERE conditions and filtering
- GROUP BY aggregations and calculations
- JOINs across multiple tables
- Sorting and ordering
- COUNT and SUM functions

### Test Queries Included

The `DBproject_test_queries.sql` file includes:

1. View all customers
2. View all products
3. View all cart items
4. View all payments
5. View all orders
6. Find products priced over $75
7. Calculate total revenue by payment method
8. Find payment methods with revenue over $300
9. View all orders sorted by ID
10. View complete order details with customer and product information
11. Count orders per customer
12. Track inventory levels
13. View delivered orders with customer contact info
14. Generate payment statistics

## Usage Examples

### View All Products

```sql
SELECT * FROM Product;
```

### Get Customer Orders with Details

```sql
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
```

### Calculate Revenue by Payment Method

```sql
SELECT PaymentMethod, SUM(AmountPaid) AS TotalRevenue
FROM Payment
GROUP BY PaymentMethod;
```

### Track Inventory Levels

```sql
SELECT ProductName, StockQuantity, ProductStatus
FROM Product
ORDER BY StockQuantity ASC;
```

For more examples and queries, see `database/DBproject_test_queries.sql`.

## Data Constraints

- **Price Validation**: All prices must be greater than 0
- **Stock Validation**: Stock quantities cannot be negative
- **Quantity Validation**: Cart quantities must be greater than 0
- **Email Uniqueness**: Each customer must have a unique email
- **Phone Uniqueness**: Each customer must have a unique phone number
- **Referential Integrity**: Foreign key constraints prevent orphaned records
- **Status Enums**: Predefined status values ensure data consistency
- **Cascading Deletes**: Deleting a customer automatically removes their orders and cart items

## Sample Data

The `DBproject_sample_data.sql` file includes:
- 5 sample customers
- 5 sample products
- 5 sample cart items
- 5 sample payments
- 5 sample orders

This data is provided for testing and demonstration purposes only.

## Documentation

- **[DATABASE_DOCUMENTATION.md](docs/db_description.md)** - Comprehensive documentation including entity descriptions, attributes, constraints, and relationships
- **[ERD Diagram](docs/erd.mermaid)** - Visual entity relationship diagram showing database structure

## Contributing

Feel free to fork this project and submit pull requests for any improvements.

## License

This project is open source and available under the MIT License.

## Author

Joory Alzahrani
