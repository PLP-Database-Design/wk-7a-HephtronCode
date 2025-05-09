-- Question 1: Achieving 1NF (First Normal Form)
-- Transform the ProductDetail table into 1NF by ensuring each row represents a single product for an order.

-- Original Table: ProductDetail
-- | OrderID | CustomerName  | Products                        |
-- |---------|---------------|---------------------------------|
-- | 101     | John Doe      | Laptop, Mouse                   |
-- | 102     | Jane Smith    | Tablet, Keyboard, Mouse         |
-- | 103     | Emily Clark   | Phone                           |

-- Transformed Table in 1NF:
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Insert transformed data into the 1NF table
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Query to verify the transformation
SELECT * FROM ProductDetail_1NF;

-- Question 2: Achieving 2NF (Second Normal Form)
-- Transform the OrderDetails table into 2NF by removing partial dependencies.

-- Original Table: OrderDetails
-- | OrderID | CustomerName  | Product      | Quantity |
-- |---------|---------------|--------------|----------|
-- | 101     | John Doe      | Laptop       | 2        |
-- | 101     | John Doe      | Mouse        | 1        |
-- | 102     | Jane Smith    | Tablet       | 3        |
-- | 102     | Jane Smith    | Keyboard     | 1        |
-- | 102     | Jane Smith    | Mouse        | 2        |
-- | 103     | Emily Clark   | Phone        | 1        |

-- Step 1: Create a separate table for Customer details to remove partial dependency
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert unique customer data
INSERT INTO Customers (CustomerName)
VALUES
    ('John Doe'),
    ('Jane Smith'),
    ('Emily Clark');

-- Step 2: Create a new OrderDetails table without the CustomerName column
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert data into the new OrderDetails table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity, CustomerID)
VALUES
    (101, 'Laptop', 2, 1), -- John Doe
    (101, 'Mouse', 1, 1),  -- John Doe
    (102, 'Tablet', 3, 2), -- Jane Smith
    (102, 'Keyboard', 1, 2), -- Jane Smith
    (102, 'Mouse', 2, 2), -- Jane Smith
    (103, 'Phone', 1, 3); -- Emily Clark

-- Query to verify the transformation
SELECT * FROM OrderDetails_2NF;
SELECT * FROM Customers;