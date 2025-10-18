# Shopping Cart Database Documentation

## Overview

The Shopping Cart Database is a relational database system designed to manage e-commerce operations. It handles customer information, product inventory, shopping carts, payment transactions, and order management. The database follows normalization principles and enforces data integrity through constraints and relationships.

## Database Entities

### Customer

**Description:** Stores customer information for the e-commerce platform.

**Attributes:**
- `CustomerID` (INT, Primary Key, Auto-Increment) - Unique customer identifier
- `FirstName` (VARCHAR(50), Not Null) - Customer's first name
- `LastName` (VARCHAR(50), Not Null) - Customer's last name
- `PhoneNumber` (VARCHAR(20), Not Null, Unique) - Customer's contact phone number
- `Email` (VARCHAR(100), Not Null, Unique) - Customer's email address
- `CreatedDate` (TIMESTAMP) - Date and time when customer record was created
- `UpdatedDate` (TIMESTAMP) - Date and time when customer record was last updated

**Constraints:**
- Primary Key: CustomerID
- Unique: PhoneNumber, Email
- Cascade Delete: Deletes all associated carts and orders

---

### Product

**Description:** Contains product information and inventory details for the catalog.

**Attributes:**
- `ProductID` (INT, Primary Key, Auto-Increment) - Unique product identifier
- `ProductName` (VARCHAR(255), Not Null) - Name of the product
- `ProductDescription` (TEXT) - Detailed description of the product
- `Price` (DECIMAL(10,2), Not Null) - Product price (must be greater than 0)
- `StockQuantity` (INT, Not Null, Default: 0) - Quantity in inventory (must be >= 0)
- `ProductStatus` (VARCHAR(20), Not Null, Default: 'Available') - Product availability status
- `CreatedDate` (TIMESTAMP) - Date and time when product was added
- `UpdatedDate` (TIMESTAMP) - Date and time when product was last updated

**Valid Status Values:** 'Available', 'Unavailable', 'Almost Done'

**Constraints:**
- Primary Key: ProductID
- Check: Price > 0
- Check: StockQuantity >= 0
- Check: ProductStatus IN ('Available', 'Unavailable', 'Almost Done')

---

### Cart

**Description:** Represents items added to customer shopping carts.

**Attributes:**
- `CartID` (INT, Primary Key, Auto-Increment) - Unique cart item identifier
- `CustomerID` (INT, Not Null, Foreign Key) - References Customer table
- `Quantity` (INT, Not Null, Default: 1) - Quantity of product in cart (must be > 0)
- `ProductID` (INT, Not Null, Foreign Key) - References Product table
- `AddedDate` (TIMESTAMP) - Date and time when item was added to cart

**Constraints:**
- Primary Key: CartID
- Foreign Key: CustomerID → Customer(CustomerID) with Cascade Delete
- Foreign Key: ProductID → Product(ProductID) with Cascade Delete
- Check: Quantity > 0

---

### Payment

**Description:** Records payment transactions for orders.

**Attributes:**
- `PaymentID` (INT, Primary Key, Auto-Increment) - Unique payment identifier
- `PaymentMethod` (VARCHAR(50), Not Null) - Method used for payment
- `AmountPaid` (DECIMAL(10,2), Not Null) - Amount paid (must be greater than 0)
- `PaymentDate` (TIMESTAMP) - Date and time of payment transaction
- `PaymentStatus` (VARCHAR(20), Not Null, Default: 'Awaiting Payment') - Status of payment

**Valid Payment Methods:** 'Upon Receipt', 'Credit Card', 'Debit Card', 'Apple Pay', 'PayPal'

**Valid Payment Statuses:** 'Paid', 'Canceled', 'Awaiting Payment', 'Refunded'

**Constraints:**
- Primary Key: PaymentID
- Check: PaymentMethod IN ('Upon Receipt', 'Credit Card', 'Debit Card', 'Apple Pay', 'PayPal')
- Check: AmountPaid > 0
- Check: PaymentStatus IN ('Paid', 'Canceled', 'Awaiting Payment', 'Refunded')

---

### Orders

**Description:** Main transaction table that links customers, carts, and payments to create orders.

**Attributes:**
- `OrderID` (INT, Primary Key, Auto-Increment) - Unique order identifier
- `OrderDate` (TIMESTAMP) - Date and time when order was created
- `OrderStatus` (VARCHAR(20), Not Null, Default: 'Awaiting Payment') - Current order status
- `CustomerID` (INT, Not Null, Foreign Key) - References Customer table
- `CartID` (INT, Not Null, Foreign Key) - References Cart table
- `PaymentID` (INT, Not Null, Foreign Key) - References Payment table
- `DeliveryDate` (TIMESTAMP, Nullable) - Date and time when order was delivered

**Valid Order Statuses:** 'Awaiting Payment', 'Being Prepared', 'Shipped', 'Delivered', 'Canceled', 'Refunded'

**Constraints:**
- Primary Key: OrderID
- Foreign Key: CustomerID → Customer(CustomerID) with Cascade Delete
- Foreign Key: CartID → Cart(CartID) with Cascade Delete
- Foreign Key: PaymentID → Payment(PaymentID) with Cascade Delete
- Check: OrderStatus IN ('Awaiting Payment', 'Being Prepared', 'Shipped', 'Delivered', 'Canceled', 'Refunded')

---

## Relationships

### Customer → Cart (One-to-Many)
- One customer can have multiple items in their cart
- Relationship: `Customer.CustomerID` → `Cart.CustomerID`
- Delete Behavior: Cascade (deleting a customer deletes all their cart items)

### Customer → Orders (One-to-Many)
- One customer can place multiple orders
- Relationship: `Customer.CustomerID` → `Orders.CustomerID`
- Delete Behavior: Cascade (deleting a customer deletes all their orders)

### Product → Cart (One-to-Many)
- One product can appear in multiple shopping carts
- Relationship: `Product.ProductID` → `Cart.ProductID`
- Delete Behavior: Cascade (deleting a product removes it from all carts)

### Cart → Orders (One-to-Many)
- One cart can be associated with one order
- Relationship: `Cart.CartID` → `Orders.CartID`
- Delete Behavior: Cascade (deleting a cart deletes the associated order)

### Payment → Orders (One-to-Many)
- One payment can be associated with one order
- Relationship: `Payment.PaymentID` → `Orders.PaymentID`
- Delete Behavior: Cascade (deleting a payment deletes the associated order)

---

## Database Design Principles

### Normalization
The database follows Third Normal Form (3NF) principles:
- Each table has a single primary key
- All non-key attributes depend on the primary key
- No transitive dependencies exist between attributes

### Data Integrity
- **Referential Integrity:** Foreign key constraints ensure data consistency
- **Entity Integrity:** Primary keys ensure each record is unique
- **Domain Integrity:** Check constraints ensure valid data values
- **Uniqueness:** Unique constraints on email and phone number prevent duplicates

### Cascade Deletes
All foreign key relationships use `ON DELETE CASCADE` to maintain referential integrity when records are deleted.

### Audit Trails
CreatedDate and UpdatedDate timestamps on Customer and Product tables track record changes.

---

## Sample Data

The database includes sample data for testing and demonstration:
- 5 Customers
- 5 Products
- 5 Cart Items
- 5 Payments
- 5 Orders

Sample data can be loaded using the separate `DBproject_sample_data.sql` file.

---

## Key Features

✓ Customer account management with unique contact information
✓ Product inventory tracking with status management
✓ Shopping cart functionality with item quantities
✓ Multiple payment method support
✓ Order lifecycle management from creation to delivery
✓ Complete audit trail with timestamps
✓ Data validation through check constraints
✓ Referential integrity with cascade deletes
✓ Automatic primary key generation with auto-increment
