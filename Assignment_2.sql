-- REQUIREMENT 1
CREATE TABLE Dim_Customers (
    CustomerKey INT PRIMARY KEY,
    CustomerID INT,
    CustomerName VARCHAR(255),
    CustomerCategoryName VARCHAR(255),
    CityName VARCHAR(255),
    StateProvinceName VARCHAR(255),
    CountryName VARCHAR(255)
);

CREATE TABLE Dim_Products (
    ProductKey INT PRIMARY KEY,
    ProductID INT,
    ProductName VARCHAR(255),
    Color VARCHAR(255)
);

CREATE TABLE Dim_Salespeople (
    SalespersonKey INT PRIMARY KEY,
    SalespersonID INT,
    SalespersonName VARCHAR(255)
);

CREATE TABLE Dim_Suppliers (
    SupplierKey INT PRIMARY KEY,
    SupplierID INT,
    SupplierName VARCHAR(255),
    SupplierCategoryName VARCHAR(255)
);

CREATE TABLE Fact_Orders (
    OrderKey INT PRIMARY KEY,
    OrderID INT,
    CustomerKey INT,
    SalespersonKey INT,
    ProductKey INT,
    OrderDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2)
);
-- Inserting into Dim_Customers
INSERT INTO Dim_Customers (CustomerKey, CustomerID, CustomerName, CustomerCategoryName, CityName, StateProvinceName, CountryName)
VALUES (4, 4, 'John Doe', 'Individual', 'New York', 'New York', 'USA');
INSERT INTO Dim_Customers (CustomerKey, CustomerID, CustomerName, CustomerCategoryName, CityName, StateProvinceName, CountryName)
VALUES (5, 5, 'Jane Smith', 'Individual', 'Los Angeles', 'California', 'USA');
INSERT INTO Dim_Customers (CustomerKey, CustomerID, CustomerName, CustomerCategoryName, CityName, StateProvinceName, CountryName)
VALUES (6, 6, 'Bob Brown', 'Corporate', 'Chicago', 'Illinois', 'USA');

-- Inserting into Fact_Orders
INSERT INTO Fact_Orders (OrderKey, OrderID, CustomerKey, SalespersonKey, ProductKey, OrderDate, Quantity, TotalAmount)
VALUES (1, 1, 4, 1, 1, TO_DATE('2022-01-01', 'YYYY-MM-DD'), 10, 100.00);
INSERT INTO Fact_Orders (OrderKey, OrderID, CustomerKey, SalespersonKey, ProductKey, OrderDate, Quantity, TotalAmount)
VALUES (2, 2, 5, 2, 2, TO_DATE('2022-01-15', 'YYYY-MM-DD'), 20, 200.00);
INSERT INTO Fact_Orders (OrderKey, OrderID, CustomerKey, SalespersonKey, ProductKey, OrderDate, Quantity, TotalAmount)
VALUES (3, 3, 6, 3, 3, TO_DATE('2022-02-01', 'YYYY-MM-DD'), 30, 300.00);

-- Inserting into Dim_Products
INSERT INTO Dim_Products (ProductKey, ProductID, ProductName, Color)
VALUES (4, 1, 'Product A', 'Red');
INSERT INTO Dim_Products (ProductKey, ProductID, ProductName, Color)
VALUES (5, 2, 'Product B', 'Blue');
INSERT INTO Dim_Products (ProductKey, ProductID, ProductName, Color)
VALUES (6, 3, 'Product C', 'Green');

-- Inserting into Dim_Suppliers
INSERT INTO Dim_Suppliers (SupplierKey, SupplierID, SupplierName, SupplierCategoryName)
VALUES (4, 1, 'Supplier 1', 'Category 1');
INSERT INTO Dim_Suppliers (SupplierKey, SupplierID, SupplierName, SupplierCategoryName)
VALUES (5, 2, 'Supplier 2', 'Category 2');
INSERT INTO Dim_Suppliers (SupplierKey, SupplierID, SupplierName, SupplierCategoryName)
VALUES (6, 3, 'Supplier 3', 'Category 3');

-- Inserting into Dim_Salespeople
INSERT INTO Dim_Salespeople (SalespersonKey, SalespersonID, SalespersonName)
VALUES (4, 1, 'Salesperson 1');
INSERT INTO Dim_Salespeople (SalespersonKey, SalespersonID, SalespersonName)
VALUES (5, 2, 'Salesperson 2');
INSERT INTO Dim_Salespeople (SalespersonKey, SalespersonID, SalespersonName)
VALUES (6, 3, 'Salesperson 3');


-- REQUIREMENT 2
CREATE PROCEDURE Load_Date_Dimension AS
BEGIN
    FOR i IN 1..1825 LOOP
        INSERT INTO Dim_Date (DateValue, Year, Month, Day)
        VALUES (DATE '2012-01-01' + i, EXTRACT(YEAR FROM DATE '2012-01-01' + i), EXTRACT(MONTH FROM DATE '2012-01-01' + i), EXTRACT(DAY FROM DATE '2012-01-01' + i));
    END LOOP;
END;

-- REQUIREMENT 3
SELECT 
    c.CustomerName,
    ci.CityName,
    s.SalespersonName,
    p.ProductName,
    s.SupplierName,
    d.OrderDate,
    SUM(o.SalesAmount) AS TotalSales
FROM 
    Fact_Sales o
JOIN 
    Dim_Customers c ON o.CustomerKey = c.CustomerKey
JOIN 
    Dim_Cities ci ON c.CityKey = ci.CityKey
JOIN 
    Dim_Salespeople s ON o.SalespersonKey = s.SalespersonKey
JOIN 
    Dim_Products p ON o.ProductKey = p.ProductKey
JOIN 
    Dim_Suppliers s ON p.SupplierKey = s.SupplierKey
JOIN 
    Dim_Date d ON o.OrderDateKey = d.DateKey
WHERE 
    d.OrderDate BETWEEN DATE '2001-01-01' AND DATE '2024-12-31'
GROUP BY 
    c.CustomerName, ci.CityName, s.SalespersonName, p.ProductName, s.SupplierName, d.OrderDate
ORDER BY 
    TotalSales DESC;
-- REQUIREMENT 4
CREATE TABLE Stage_Customers (
    CustomerID INT,
    CustomerName VARCHAR(255),
    CustomerCategoryName VARCHAR(255),
    CityName VARCHAR(255),
    StateProvinceName VARCHAR(255),
    CountryName VARCHAR(255)
);

CREATE TABLE Stage_Products (
    ProductID INT,
    ProductName VARCHAR(255),
    Color VARCHAR(255)
);

CREATE TABLE Stage_Salespeople (
    SalespersonID INT,
    SalespersonName VARCHAR(255)
);

CREATE TABLE Stage_Suppliers (
    SupplierID INT,
    SupplierName VARCHAR(255),
    SupplierCategoryName VARCHAR(255)
);

CREATE TABLE Stage_Orders (
    OrderID INT,
    CustomerID INT,
    SalespersonID INT,
    OrderDate DATE,
    ProductID INT,
    Quantity INT
);

CREATE PROCEDURE Extract_Customers AS
BEGIN
    INSERT INTO Stage_Customers (CustomerID, CustomerName, CustomerCategoryName, CityName, StateProvinceName, CountryName)
    SELECT 
        c.CustomerID,
        c.CustomerName,
        cc.CustomerCategoryName,
        ct.CityName,
        sp.StateProvinceName,
        cn.CountryName
    FROM 
        WideWorldImporters.Sales.Customers c
    JOIN 
        WideWorldImporters.Sales.CustomerCategories cc ON c.CustomerCategoryID = cc.CustomerCategoryID
    JOIN 
        WideWorldImporters.Application.Cities ct ON c.DeliveryCityID = ct.CityID
    JOIN 
        WideWorldImporters.Application.StateProvinces sp ON ct.StateProvinceID = sp.StateProvinceID
    JOIN 
        WideWorldImporters.Application.Countries cn ON sp.CountryID = cn.CountryID;
    COMMIT;
END;

CREATE PROCEDURE Extract_Products AS
BEGIN
    INSERT INTO Stage_Products (ProductID, ProductName, Color)
    SELECT 
        si.StockItemID,
        si.StockItemName,
        c.ColorName
    FROM 
        WideWorldImporters.Warehouse.StockItems si
    JOIN 
        WideWorldImporters.Warehouse.Colors c ON si.ColorID = c.ColorID;
    COMMIT;
END;

CREATE PROCEDURE Extract_Salespeople AS
BEGIN
    INSERT INTO Stage_Salespeople (SalespersonID, SalespersonName)
    SELECT 
        p.PersonID,
        p.FullName
    FROM 
        WideWorldImporters.Application.People p
    WHERE 
        p.IsSalesperson = 1;
    COMMIT;
END;

CREATE PROCEDURE Extract_Suppliers AS
BEGIN
    INSERT INTO Stage_Suppliers (SupplierID, SupplierName, SupplierCategoryName)
    SELECT 
        s.SupplierID,
        s.SupplierName,
        sc.SupplierCategoryName
    FROM 
        WideWorldImporters.Purchasing.Suppliers s
    JOIN 
        WideWorldImporters.Purchasing.SupplierCategories sc ON s.SupplierCategoryID = sc.SupplierCategoryID;
    COMMIT;
END;

CREATE PROCEDURE Extract_Orders (OrderDate DATE) AS
BEGIN
    INSERT INTO Stage_Orders (OrderID, CustomerID, SalespersonID, OrderDate, ProductID, Quantity)
    SELECT 
        o.OrderID,
        o.CustomerID,
        o.SalespersonPersonID,
        o.OrderDate,
        ol.StockItemID,
        ol.Quantity
    FROM 
        WideWorldImporters.Sales.Orders o
    JOIN 
        WideWorldImporters.Sales.OrderLines ol ON o.OrderID = ol.OrderID
    WHERE 
        o.OrderDate = OrderDate;
    COMMIT;
END;

-- REQUIREMENT 5
CREATE TABLE PreLoad_Customers (
    CustomerKey INT,
    CustomerID INT,
    CustomerName VARCHAR(255),
    CustomerCategoryName VARCHAR(255),
    CityName VARCHAR(255),
    StateProvinceName VARCHAR(255),
    CountryName VARCHAR(255)
);

CREATE TABLE PreLoad_Products (
    ProductKey INT,
    ProductID INT,
    ProductName VARCHAR(255),
    Color VARCHAR(255)
);

CREATE TABLE PreLoad_Salespeople (
    SalespersonKey INT,
    SalespersonID INT,
    SalespersonName VARCHAR(255)
);

CREATE TABLE PreLoad_Suppliers (
    SupplierKey INT,
    SupplierID INT,
    SupplierName VARCHAR(255),
    SupplierCategoryName VARCHAR(255)
);

CREATE PROCEDURE Transform_Customers AS
BEGIN
    MERGE INTO Dim_Customers dc
    USING PreLoad_Customers pc
    ON (dc.CustomerID = pc.CustomerID)
    WHEN MATCHED THEN
        UPDATE SET dc.CustomerName = pc.CustomerName, dc.CustomerCategoryName = pc.CustomerCategoryName, dc.CityName = pc.CityName, dc.StateProvinceName = pc.StateProvinceName, dc.CountryName = pc.CountryName
    WHEN NOT MATCHED THEN
        INSERT (CustomerKey, CustomerID, CustomerName, CustomerCategoryName, CityName, StateProvinceName, CountryName)
        VALUES (pc.CustomerKey, pc.CustomerID, pc.CustomerName, pc.CustomerCategoryName, pc.CityName, pc.StateProvinceName, pc.CountryName);
    COMMIT;
END;

CREATE PROCEDURE Transform_Products AS
BEGIN
    MERGE INTO Dim_Products dp
    USING PreLoad_Products pp
    ON (dp.ProductID = pp.ProductID)
    WHEN MATCHED THEN
        UPDATE SET dp.ProductName = pp.ProductName, dp.Color = pp.Color
    WHEN NOT MATCHED THEN
        INSERT (ProductKey, ProductID, ProductName, Color)
        VALUES (pp.ProductKey, pp.ProductID, pp.ProductName, pp.Color);
    COMMIT;
END;

CREATE PROCEDURE Transform_Salespeople AS
BEGIN
    MERGE INTO Dim_Salespeople ds
    USING PreLoad_Salespeople ps
    ON (ds.SalespersonID = ps.SalespersonID)
    WHEN MATCHED THEN
        UPDATE SET ds.SalespersonName = ps.SalespersonName
    WHEN NOT MATCHED THEN
        INSERT (SalespersonKey, SalespersonID, SalespersonName)
        VALUES (ps.SalespersonKey, ps.SalespersonID, ps.SalespersonName);
    COMMIT;
END;

CREATE PROCEDURE Transform_Suppliers AS
BEGIN
    MERGE INTO Dim_Suppliers ds
    USING PreLoad_Suppliers ps
    ON (ds.SupplierID = ps.SupplierID)
    WHEN MATCHED THEN
        UPDATE SET ds.SupplierName = ps.SupplierName, ds.SupplierCategoryName = ps.SupplierCategoryName
    WHEN NOT MATCHED THEN
        INSERT (SupplierKey, SupplierID, SupplierName, SupplierCategoryName)
        VALUES (ps.SupplierKey, ps.SupplierID, ps.SupplierName, ps.SupplierCategoryName);
    COMMIT;
END;

-- REQUIREMENT 6
CREATE PROCEDURE Load_Dim_Customers AS
BEGIN
    EXEC Transform_Customers;
    COMMIT;
END;


CREATE PROCEDURE Load_Dim_Products AS
BEGIN
    EXEC Transform_Products;
    COMMIT;
END;

CREATE PROCEDURE Load_Dim_Salespeople AS
BEGIN
    EXEC Transform_Salespeople;
    COMMIT;
END;

CREATE PROCEDURE Load_Dim_Suppliers AS
BEGIN
    EXEC Transform_Suppliers;
    COMMIT;
END;

CREATE PROCEDURE Load_Fact_Orders AS
BEGIN
    INSERT INTO Fact_Orders (OrderKey, OrderID, CustomerKey, SalespersonKey, ProductKey, OrderDate, Quantity, TotalAmount)
    SELECT 
        o.OrderID,
        o.OrderID,
        c.CustomerKey,
        sp.SalespersonKey,
        p.ProductKey,
        o.OrderDate,
        ol.Quantity,
        ol.Quantity * ol.UnitPrice AS TotalAmount
    FROM 
        Stage_Orders o
    JOIN 
        Dim_Customers c ON o.CustomerID = c.CustomerID
    JOIN 
        Dim_Salespeople sp ON o.SalespersonID = sp.SalespersonID
    JOIN 
        Dim_Products p ON o.ProductID = p.ProductID
    JOIN 
        WideWorldImporters.Sales.OrderLines ol ON o.OrderID = ol.OrderID;
    COMMIT;
END;

-- REQUIREMENT 7
EXEC Load_Dim_Customers;
EXEC Load_Dim_Products;
EXEC Load_Dim_Salespeople;
EXEC Load_Dim_Suppliers;
EXEC Load_Fact_Orders;

SELECT 
    c.CustomerName,
    ct.CityName,
    sp.SalespersonName,
    p.ProductName,
    s.SupplierName,
    o.OrderDate
FROM 
    Fact_Orders o
JOIN 
    Dim_Customers c ON o.CustomerKey = c.CustomerKey
JOIN 
    Dim_Cities ct ON c.CityKey = ct.CityKey
JOIN 
    Dim_Salespeople sp ON o.SalespersonKey = sp.SalespersonKey
JOIN 
    Dim_Products p ON o.ProductKey = p.ProductKey
JOIN 
    Dim_Suppliers s ON p.SupplierKey = s.SupplierKey
WHERE 
    o.OrderDate BETWEEN '2013-01-01' AND '2013-01-04';