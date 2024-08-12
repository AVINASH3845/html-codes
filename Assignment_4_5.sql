----- CREATE WWI TABLES ---------
CREATE TABLE "PEOPLE" (	
    "PERSONID" NUMBER(10,0), 
	"FULLNAME" NVARCHAR2(50) NOT NULL, 
	"PREFERREDNAME" NVARCHAR2(50) NOT NULL, 
	"ISPERMITTEDTOLOGON" NUMBER(1,0) NOT NULL, 
	"LOGONNAME" NVARCHAR2(50), 
	"ISEXTERNALLOGONPROVIDER" NUMBER(1,0) NOT NULL , 
	"ISSYSTEMUSER" NUMBER(1,0) NOT NULL , 
	"ISEMPLOYEE" NUMBER(1,0) NOT NULL , 
	"ISSALESPERSON" NUMBER(1,0) NOT NULL , 
	"USERPREFERENCES" NVARCHAR2(400), 
	"PHONENUMBER" NVARCHAR2(20), 
	"FAXNUMBER" NVARCHAR2(20), 
	"EMAILADDRESS" NVARCHAR2(256), 
	 CONSTRAINT "PK_PEOPLE_ID" PRIMARY KEY ("PERSONID")
);

CREATE TABLE Countries(
	CountryID NUMBER (10) NOT NULL,
	CountryName NVARCHAR2(60) NOT NULL,
	FormalName NVARCHAR2(60) NOT NULL,
	IsoAlpha3Code NVARCHAR2(3) NULL,
	IsoNumericCode NUMBER (10) NULL,
	CountryType NVARCHAR2(20) NULL,
	LatestRecordedPopulation NUMBER(12) NULL,
	Continent NVARCHAR2(30) NOT NULL,
	Region NVARCHAR2(30) NOT NULL,
	Subregion NVARCHAR2(30) NOT NULL,
    CONSTRAINT PK_Countries_ID PRIMARY KEY (CountryID), 
    CONSTRAINT UQ_Countries_CountryName UNIQUE(CountryName)
);
--SELECT * FROM Countries;


CREATE TABLE StateProvinces(
	StateProvinceID NUMBER(10),
	StateProvinceCode nvarchar2(5) NOT NULL,
	StateProvinceName nvarchar2(50) NOT NULL,
	CountryID NUMBER(10) NOT NULL,
	SalesTerritory nvarchar2(50) NOT NULL,
	LatestRecordedPopulation NUMBER(12) NULL,
 	CONSTRAINT PK_StateProvinces_ID PRIMARY KEY (StateProvinceID),
	CONSTRAINT FK_StateProvinces_CountryID_Countries FOREIGN KEY(CountryID) REFERENCES Countries (CountryID)
);


CREATE TABLE Cities(
	CityID NUMBER(10),
	CityName nvarchar2(50) NOT NULL,
	StateProvinceID NUMBER(10) NOT NULL,
	LatestRecordedPopulation NUMBER(12) NULL,
 CONSTRAINT PK_Cities_ID PRIMARY KEY (CityID), 
 CONSTRAINT FK_Cities_StateProvinceID_StateProvinces FOREIGN KEY(StateProvinceID) REFERENCES StateProvinces (StateProvinceID)
);
--SELECT * FROM Cities;

CREATE TABLE CustomerCategories(
	CustomerCategoryID NUMBER(10),
	CustomerCategoryName nvarchar2(50) NOT NULL,
    CONSTRAINT PK_CustomerCategories_ID PRIMARY KEY (CustomerCategoryID),
    CONSTRAINT UQ_CustomerCategories_CustomerCategoryName UNIQUE (CustomerCategoryName)
);
--SELECT * FROM CustomerCategories;


CREATE TABLE DeliveryMethods(
	DeliveryMethodID NUMBER(10),
	DeliveryMethodName nvarchar2(50) NOT NULL,
    CONSTRAINT PK_DeliveryMethods PRIMARY KEY (DeliveryMethodID),
    CONSTRAINT UQ_DeliveryMethods_DeliveryMethodName UNIQUE (DeliveryMethodName)
);
--SELECT * FROM DeliveryMethods;

CREATE TABLE Customers(
	CustomerID NUMBER(10) NOT NULL,
	CustomerName nvarchar2(100) NOT NULL,
	BillToCustomerID NUMBER(10) NOT NULL,
	CustomerCategoryID NUMBER(10) NOT NULL,
	PrimaryContactPersonID NUMBER(10) NOT NULL,
	DeliveryMethodID NUMBER(10) NOT NULL,
	DeliveryCityID NUMBER(10) NOT NULL,
	PostalCityID NUMBER(10) NOT NULL,
	CreditLimit NUMBER(18, 2) NULL,
	AccountOpenedDate date NOT NULL,
	StandardDiscountPercentage NUMBER(18, 3) NOT NULL,
	IsStatementSent NUMBER(1) NOT NULL,
	IsOnCreditHold NUMBER(1) NOT NULL,
	PaymentDays NUMBER(10) NOT NULL,
	PhoneNumber nvarchar2(20) NOT NULL,
	FaxNumber nvarchar2(20) NOT NULL,
	WebsiteURL nvarchar2(256) NOT NULL,
	DeliveryAddressLine1 nvarchar2(60) NOT NULL,
	DeliveryAddressLine2 nvarchar2(60) NULL,
	DeliveryPostalCode nvarchar2(10) NOT NULL,
	PostalAddressLine1 nvarchar2(60) NOT NULL,
	PostalAddressLine2 nvarchar2(60) NULL,
	PostalPostalCode nvarchar2(10) NOT NULL,
 	CONSTRAINT PK_Sales_Customers_ID PRIMARY KEY (CustomerID),
	CONSTRAINT FK_Customers_PrimaryContactPersonID_People FOREIGN KEY(PrimaryContactPersonID) REFERENCES People (PersonID)
);
--SELECT * FROM customers;

CREATE TABLE Colors(
	ColorID NUMBER(10),
	ColorName nvarchar2(20) NOT NULL,
    CONSTRAINT PK_Colors_ID PRIMARY KEY (ColorID),
    CONSTRAINT UQ_Colors_ColorName UNIQUE (ColorName)
);
--TRUNCATE TABLE Colors;
--SELECT * FROM Colors;

CREATE TABLE SupplierCategories(
	SupplierCategoryID NUMBER(10),
	SupplierCategoryName nvarchar2(50) NOT NULL,
    CONSTRAINT PK_SupplierCategories_ID PRIMARY KEY (SupplierCategoryID),
    CONSTRAINT UQ_SupplierCategories_SupplierCategoryName UNIQUE (SupplierCategoryName)
);
--SELECT * FROM SupplierCategories;

--DROP TABLE Suppliers;
CREATE TABLE Suppliers(
	SupplierID NUMBER(10) NOT NULL,
	SupplierName nvarchar2(100) NOT NULL,
	SupplierCategoryID NUMBER(10) NOT NULL,
	PrimaryContactPersonID NUMBER(10) NOT NULL,
	DeliveryCityID NUMBER(10) NOT NULL,
	PostalCityID NUMBER(10) NOT NULL,
	SupplierReference nvarchar2(20) NULL,
	BankAccountName nvarchar2(50) NULL,
	BankAccountBranch nvarchar2(50) NULL,
	BankAccountCode nvarchar2(20) NULL,
	BankAccountNumber nvarchar2(20) NULL,
	BankInternationalCode nvarchar2(20) NULL,
	PaymentDays NUMBER(10) NOT NULL,
	InternalComments nvarchar2(300) NULL,
	PhoneNumber nvarchar2(20) NOT NULL,
	FaxNumber nvarchar2(20) NOT NULL,
	WebsiteURL nvarchar2(256) NOT NULL,
	DeliveryAddressLine1 nvarchar2(60) NOT NULL,
	DeliveryAddressLine2 nvarchar2(60) NULL,
	DeliveryPostalCode nvarchar2(10) NOT NULL,
	PostalAddressLine1 nvarchar2(60) NOT NULL,
	PostalAddressLine2 nvarchar2(60) NULL,
	PostalPostalCode nvarchar2(10) NOT NULL,
	CONSTRAINT PK_Suppliers_ID PRIMARY KEY (SupplierID),
	CONSTRAINT UQ_Suppliers_SupplierName UNIQUE (SupplierName),
	CONSTRAINT FK_Suppliers_PrimaryContactPersonID_People FOREIGN KEY(PrimaryContactPersonID) REFERENCES People (PersonID),
	CONSTRAINT FK_Suppliers_DeliveryCityID_Cities FOREIGN KEY(DeliveryCityID) REFERENCES Cities (CityID),
	CONSTRAINT FK_Suppliers_PostalCityID_Cities FOREIGN KEY(PostalCityID) REFERENCES Cities (CityID),
	CONSTRAINT FK_Suppliers_SupplierCategoryID_SupplierCategories FOREIGN KEY(SupplierCategoryID) REFERENCES SupplierCategories (SupplierCategoryID)
);
--SELECT * FROM suppliers;


CREATE TABLE StockItems(
	StockItemID NUMBER(10),
	StockItemName nvarchar2(100) NOT NULL,
	SupplierID NUMBER(10) NOT NULL,
	ColorID NUMBER(10) NULL,
	Brand nvarchar2(50) NULL,
	ItemSize nvarchar2(20) NULL,
	LeadTimeDays NUMBER(10) NOT NULL,
	QuantityPerOuter NUMBER(10) NOT NULL,
	IsChillerStock NUMBER(1) NOT NULL,
	Barcode nvarchar2(50) NULL,
	TaxRate NUMBER(18, 3) NOT NULL,
	UnitPrice NUMBER(18, 2) NOT NULL,
	RecommendedRetailPrice NUMBER(18, 2) NULL,
	TypicalWeightPerUnit NUMBER(18, 3) NOT NULL,
	MarketingComments nvarchar2(300) NULL,
	InternalComments nvarchar2(300) NULL,
	CustomFields nvarchar2(300) NULL,
	Tags nvarchar2(200) NULL,
	SearchDetails nvarchar2(200) NULL,
	CONSTRAINT PK_StockItems PRIMARY KEY (StockItemID),
	CONSTRAINT UQ_StockItems_StockItemName UNIQUE (StockItemName),
	CONSTRAINT FK_StockItems_ColorID_Colors FOREIGN KEY(ColorID) REFERENCES Colors (ColorID),
	CONSTRAINT FK_StockItems_SupplierID_Suppliers FOREIGN KEY(SupplierID) REFERENCES Suppliers (SupplierID)
);

CREATE TABLE Orders(
	OrderID NUMBER(10),
	CustomerID NUMBER(10) NOT NULL,
	SalespersonPersonID NUMBER(10) NOT NULL,
	ContactPersonID NUMBER(10) NOT NULL,
	OrderDate date NOT NULL,
	ExpectedDeliveryDate date NOT NULL,
	CustomerPurchaseOrderNumber nvarchar2(20) NULL,
	IsUndersupplyBackordered NUMBER(1) NOT NULL,
	PickingCompletedWhen Date NULL,
	LastEditedBy NUMBER(10) NOT NULL,
	LastEditedWhen Date NOT NULL,
	CONSTRAINT PK_Orders_ID PRIMARY KEY (OrderID),
	CONSTRAINT FK_Orders_CustomerID_Customers FOREIGN KEY(CustomerID) REFERENCES Customers (CustomerID),
	CONSTRAINT FK_Orders_SalespersonPersonID_People FOREIGN KEY(SalespersonPersonID) REFERENCES People (PersonID),
	CONSTRAINT FK_Orders_ContactPersonID_People FOREIGN KEY(ContactPersonID) REFERENCES People (PersonID),
	CONSTRAINT FK_Orders_People FOREIGN KEY(LastEditedBy) REFERENCES People (PersonID)
);
--SELECT * FROM orders WHERE orderdate = '2013-01-01';


--DROP TABLE OrderLines;
CREATE TABLE OrderLines(
	OrderLineID NUMBER(10) NOT NULL,
	OrderID NUMBER(10) NOT NULL,
	StockItemID NUMBER(10) NOT NULL,
	Description nvarchar2(100) NOT NULL,
	Quantity NUMBER(4) NOT NULL,
	UnitPrice NUMBER(18, 2) NULL,
	TaxRate NUMBER(18, 3) NOT NULL,
	PickedQuantity NUMBER(4) NOT NULL,
	PickingCompletedWhen Date NULL,
	CONSTRAINT PK_OrderLines_ID PRIMARY KEY (OrderLineID),
	CONSTRAINT FK_OrderLines_Orders FOREIGN KEY(OrderID) REFERENCES Orders (OrderID),
	CONSTRAINT FK_OrderLines_StockItemID_StockItems FOREIGN KEY(StockItemID) REFERENCES StockItems (StockItemID)
);
--TRUNCATE TABLE OrderLines;
SELECT * FROM OrderLines;

DROP TABLE OrderLines;
DROP TABLE Orders;
DROP TABLE StockItems;
DROP TABLE Suppliers;
DROP TABLE SupplierCategories;
DROP TABLE Colors;
DROP TABLE Customers;
DROP TABLE DeliveryMethods;
DROP TABLE CustomerCategories;
DROP TABLE Cities;
DROP TABLE StateProvinces;
DROP TABLE Countries;
DROP TABLE PEOPLE;
DROP TABLE PackageTypes;

CREATE TABLE "PEOPLE" (
    "PERSONID" NUMBER(10,0), 
    "FULLNAME" NVARCHAR2(50) NOT NULL, 
    "PREFERREDNAME" NVARCHAR2(50) NOT NULL, 
    "ISPERMITTEDTOLOGON" NUMBER(1,0) NOT NULL, 
    "LOGONNAME" NVARCHAR2(50), 
    "ISEXTERNALLOGONPROVIDER" NUMBER(1,0) NOT NULL, 
    "ISSYSTEMUSER" NUMBER(1,0) NOT NULL, 
    "ISEMPLOYEE" NUMBER(1,0) NOT NULL, 
    "ISSALESPERSON" NUMBER(1,0) NOT NULL, 
    "USERPREFERENCES" NVARCHAR2(400), 
    "PHONENUMBER" NVARCHAR2(20), 
    "FAXNUMBER" NVARCHAR2(20), 
    "EMAILADDRESS" NVARCHAR2(256), 
    CONSTRAINT "PK_PEOPLE_ID" PRIMARY KEY ("PERSONID")
);

CREATE TABLE Countries (
    CountryID NUMBER(10) NOT NULL,
    CountryName NVARCHAR2(60) NOT NULL,
    FormalName NVARCHAR2(60) NOT NULL,
    IsoAlpha3Code NVARCHAR2(3),
    IsoNumericCode NUMBER(10),
    CountryType NVARCHAR2(20),
    LatestRecordedPopulation NUMBER(12),
    Continent NVARCHAR2(30) NOT NULL,
    Region NVARCHAR2(30) NOT NULL,
    Subregion NVARCHAR2(30) NOT NULL,
    CONSTRAINT PK_Countries_ID PRIMARY KEY (CountryID), 
    CONSTRAINT UQ_Countries_CountryName UNIQUE (CountryName)
);

CREATE TABLE StateProvinces (
    StateProvinceID NUMBER(10),
    StateProvinceCode NVARCHAR2(5) NOT NULL,
    StateProvinceName NVARCHAR2(50) NOT NULL,
    CountryID NUMBER(10) NOT NULL,
    SalesTerritory NVARCHAR2(50) NOT NULL,
    LatestRecordedPopulation NUMBER(12),
    CONSTRAINT PK_StateProvinces_ID PRIMARY KEY (StateProvinceID),
    CONSTRAINT FK_StateProvinces_CountryID_Countries FOREIGN KEY (CountryID) REFERENCES Countries (CountryID)
);

CREATE TABLE Cities (
    CityID NUMBER(10),
    CityName NVARCHAR2(50) NOT NULL,
    StateProvinceID NUMBER(10) NOT NULL,
    LatestRecordedPopulation NUMBER(12),
    CONSTRAINT PK_Cities_ID PRIMARY KEY (CityID), 
    CONSTRAINT FK_Cities_StateProvinceID_StateProvinces FOREIGN KEY (StateProvinceID) REFERENCES StateProvinces (StateProvinceID)
);

CREATE TABLE CustomerCategories (
    CustomerCategoryID NUMBER(10),
    CustomerCategoryName NVARCHAR2(50) NOT NULL,
    CONSTRAINT PK_CustomerCategories_ID PRIMARY KEY (CustomerCategoryID),
    CONSTRAINT UQ_CustomerCategories_CustomerCategoryName UNIQUE (CustomerCategoryName)
);

CREATE TABLE DeliveryMethods (
    DeliveryMethodID NUMBER(10),
    DeliveryMethodName NVARCHAR2(50) NOT NULL,
    CONSTRAINT PK_DeliveryMethods PRIMARY KEY (DeliveryMethodID),
    CONSTRAINT UQ_DeliveryMethods_DeliveryMethodName UNIQUE (DeliveryMethodName)
);

CREATE TABLE Customers (
    CustomerID NUMBER(10) NOT NULL,
    CustomerName NVARCHAR2(100) NOT NULL,
    BillToCustomerID NUMBER(10) NOT NULL,
    CustomerCategoryID NUMBER(10) NOT NULL,
    PrimaryContactPersonID NUMBER(10) NOT NULL,
    DeliveryMethodID NUMBER(10) NOT NULL,
    DeliveryCityID NUMBER(10) NOT NULL,
    PostalCityID NUMBER(10) NOT NULL,
    CreditLimit NUMBER(18,2),
    AccountOpenedDate DATE NOT NULL,
    StandardDiscountPercentage NUMBER(18,3) NOT NULL,
    IsStatementSent NUMBER(1) NOT NULL,
    IsOnCreditHold NUMBER(1) NOT NULL,
    PaymentDays NUMBER(10) NOT NULL,
    PhoneNumber NVARCHAR2(20) NOT NULL,
    FaxNumber NVARCHAR2(20) NOT NULL,
    WebsiteURL NVARCHAR2(256) NOT NULL,
    DeliveryAddressLine1 NVARCHAR2(60) NOT NULL,
    DeliveryAddressLine2 NVARCHAR2(60),
    DeliveryPostalCode NVARCHAR2(10) NOT NULL,
    PostalAddressLine1 NVARCHAR2(60) NOT NULL,
    PostalAddressLine2 NVARCHAR2(60),
    PostalPostalCode NVARCHAR2(10) NOT NULL,
    CONSTRAINT PK_Sales_Customers_ID PRIMARY KEY (CustomerID),
    CONSTRAINT FK_Customers_PrimaryContactPersonID_People FOREIGN KEY (PrimaryContactPersonID) REFERENCES PEOPLE (PERSONID)
);

CREATE TABLE Colors (
    ColorID NUMBER(10),
    ColorName NVARCHAR2(20) NOT NULL,
    CONSTRAINT PK_Colors_ID PRIMARY KEY (ColorID),
    CONSTRAINT UQ_Colors_ColorName UNIQUE (ColorName)
);

CREATE TABLE SupplierCategories (
    SupplierCategoryID NUMBER(10),
    SupplierCategoryName NVARCHAR2(50) NOT NULL,
    CONSTRAINT PK_SupplierCategories_ID PRIMARY KEY (SupplierCategoryID),
    CONSTRAINT UQ_SupplierCategories_SupplierCategoryName UNIQUE (SupplierCategoryName)
);

CREATE TABLE Suppliers (
    SupplierID NUMBER(10) NOT NULL,
    SupplierName NVARCHAR2(100) NOT NULL,
    SupplierCategoryID NUMBER(10) NOT NULL,
    PrimaryContactPersonID NUMBER(10) NOT NULL,
    DeliveryCityID NUMBER(10) NOT NULL,
    PostalCityID NUMBER(10) NOT NULL,
    SupplierReference NVARCHAR2(20),
    BankAccountName NVARCHAR2(50),
    BankAccountBranch NVARCHAR2(50),
    BankAccountCode NVARCHAR2(20),
    BankAccountNumber NVARCHAR2(20),
    BankInternationalCode NVARCHAR2(20),
    PaymentDays NUMBER(10) NOT NULL,
    InternalComments NVARCHAR2(300),
    PhoneNumber NVARCHAR2(20) NOT NULL,
    FaxNumber NVARCHAR2(20) NOT NULL,
    WebsiteURL NVARCHAR2(256) NOT NULL,
    DeliveryAddressLine1 NVARCHAR2(60) NOT NULL,
    DeliveryAddressLine2 NVARCHAR2(60),
    DeliveryPostalCode NVARCHAR2(10) NOT NULL,
    PostalAddressLine1 NVARCHAR2(60) NOT NULL,
    PostalAddressLine2 NVARCHAR2(60),
    PostalPostalCode NVARCHAR2(10) NOT NULL,
    CONSTRAINT PK_Suppliers_ID PRIMARY KEY (SupplierID),
    CONSTRAINT UQ_Suppliers_SupplierName UNIQUE (SupplierName),
    CONSTRAINT FK_Suppliers_PrimaryContactPersonID_People FOREIGN KEY (PrimaryContactPersonID) REFERENCES PEOPLE (PERSONID),
    CONSTRAINT FK_Suppliers_DeliveryCityID_Cities FOREIGN KEY (DeliveryCityID) REFERENCES Cities (CityID),
    CONSTRAINT FK_Suppliers_PostalCityID_Cities FOREIGN KEY (PostalCityID) REFERENCES Cities (CityID),
    CONSTRAINT FK_Suppliers_SupplierCategoryID_SupplierCategories FOREIGN KEY (SupplierCategoryID) REFERENCES SupplierCategories (SupplierCategoryID)
);

CREATE TABLE StockItems (
    StockItemID NUMBER(10),
    StockItemName NVARCHAR2(100) NOT NULL,
    SupplierID NUMBER(10) NOT NULL,
    ColorID NUMBER(10),
    Brand NVARCHAR2(50),
    ItemSize NVARCHAR2(20),
    LeadTimeDays NUMBER(10) NOT NULL,
    QuantityPerOuter NUMBER(10) NOT NULL,
    IsChillerStock NUMBER(1) NOT NULL,
    Barcode NVARCHAR2(50),
    TaxRate NUMBER(18,3) NOT NULL,
    UnitPrice NUMBER(18,2) NOT NULL,
    RecommendedRetailPrice NUMBER(18,2),
    TypicalWeightPerUnit NUMBER(18,3) NOT NULL,
    MarketingComments NVARCHAR2(300),
    InternalComments NVARCHAR2(300),
    CustomFields NVARCHAR2(300),
    Tags NVARCHAR2(200),
    SearchDetails NVARCHAR2(200),
    CONSTRAINT PK_StockItems PRIMARY KEY (StockItemID),
    CONSTRAINT UQ_StockItems_StockItemName UNIQUE (StockItemName),
    CONSTRAINT FK_StockItems_ColorID_Colors FOREIGN KEY (ColorID) REFERENCES Colors (ColorID),
    CONSTRAINT FK_StockItems_SupplierID_Suppliers FOREIGN KEY (SupplierID) REFERENCES Suppliers (SupplierID)
);

CREATE TABLE Orders (
    OrderID NUMBER(10),
    CustomerID NUMBER(10) NOT NULL,
    SalespersonPersonID NUMBER(10) NOT NULL,
    ContactPersonID NUMBER(10) NOT NULL,
    OrderDate DATE NOT NULL,
    ExpectedDeliveryDate DATE NOT NULL,
    CustomerPurchaseOrderNumber NVARCHAR2(20),
    IsUndersupplyBackordered NUMBER(1) NOT NULL,
    PickingCompletedWhen DATE,
    LastEditedBy NUMBER(10) NOT NULL,
    LastEditedWhen DATE NOT NULL,
    CONSTRAINT PK_Sales_Orders PRIMARY KEY (OrderID),
    CONSTRAINT FK_Orders_ContactPersonID_People FOREIGN KEY (ContactPersonID) REFERENCES PEOPLE (PERSONID),
    CONSTRAINT FK_Orders_CustomerID_Customers FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID),
    CONSTRAINT FK_Orders_SalespersonPersonID_People FOREIGN KEY (SalespersonPersonID) REFERENCES PEOPLE (PERSONID)
);

CREATE TABLE OrderLines (
    OrderLineID NUMBER(10),
    OrderID NUMBER(10) NOT NULL,
    StockItemID NUMBER(10) NOT NULL,
    Description NVARCHAR2(100) NOT NULL,
    PackageTypeID NUMBER(10) NOT NULL,
    Quantity NUMBER(10) NOT NULL,
    UnitPrice NUMBER(18,2) NOT NULL,
    TaxRate NUMBER(18,3) NOT NULL,
    PickedQuantity NUMBER(10) NOT NULL,
    PickingCompletedWhen DATE,
    LastEditedBy NUMBER(10) NOT NULL,
    LastEditedWhen DATE NOT NULL,
    CONSTRAINT PK_Sales_OrderLines PRIMARY KEY (OrderLineID),
    CONSTRAINT FK_OrderLines_OrderID_Orders FOREIGN KEY (OrderID) REFERENCES Orders (OrderID),
    CONSTRAINT FK_OrderLines_StockItemID_StockItems FOREIGN KEY (StockItemID) REFERENCES StockItems (StockItemID)
);

CREATE TABLE PackageTypes (
    PackageTypeID NUMBER(10),
    PackageTypeName NVARCHAR2(50) NOT NULL,
    CONSTRAINT PK_Sales_PackageTypes PRIMARY KEY (PackageTypeID),
    CONSTRAINT UQ_Sales_PackageTypes_PackageTypeName UNIQUE (PackageTypeName)
);

-- Requirement 1: Adding/Updating Dimensional Model tables including PKs, FKs, and Indexes
-- DimEmployees Table
CREATE TABLE DimEmployees (
    EmployeeID NUMBER(10) PRIMARY KEY,
    FullName NVARCHAR2(100) NOT NULL,
    JobTitle NVARCHAR2(50) NOT NULL,
    Department NVARCHAR2(50) NOT NULL,
    HireDate DATE NOT NULL
);

-- Adding PickerEmployeeID to FactOrders table
ALTER TABLE FactOrders ADD (
    PickerEmployeeID NUMBER(10)
);

ALTER TABLE FactOrders ADD CONSTRAINT FK_FactOrders_PickerEmployeeID 
FOREIGN KEY (PickerEmployeeID) REFERENCES DimEmployees (EmployeeID);

-- Creating indexes for optimized querying
CREATE INDEX idx_factorders_pickeremployeeid ON FactOrders(PickerEmployeeID);


-- DimSupplier Table (Assuming it follows SCD Type 2)
CREATE TABLE DimSupplier (
    SupplierID NUMBER(10) PRIMARY KEY,
    SupplierName NVARCHAR2(100) NOT NULL,
    CategoryName NVARCHAR2(50),
    EffectiveDate DATE NOT NULL,
    ExpirationDate DATE
);

-- Example of how a supplier might change categories, triggering SCD Type 2 behavior
-- Index for DimSupplier
CREATE INDEX idx_dimsupplier_supplierid ON DimSupplier(SupplierID);

--/Requirement 2: Date Dimension & Stored Procedure/--
-- Date Dimension Table
CREATE TABLE DateDimension (
    DateKey NUMBER PRIMARY KEY,
    DateValue DATE,
    Day INT,
    Month INT,
    Year INT,
    DayName VARCHAR2(10),
    MonthName VARCHAR2(20),
    YearName VARCHAR2(10)
);


-- Stored Procedure to Load Date Dimension Table
CREATE OR REPLACE PROCEDURE LoadDateDimension(p_start_date IN DATE, p_end_date IN DATE) AS
BEGIN
    FOR d IN (SELECT p_start_date + LEVEL - 1 AS DateValue
              FROM dual
              CONNECT BY LEVEL <= (p_end_date - p_start_date + 1)) LOOP
        INSERT INTO DateDimension (DateKey, DateValue, Day, Month, Year, DayName, MonthName, YearName)
        VALUES (
            TO_NUMBER(TO_CHAR(d.DateValue, 'YYYYMMDD')),
            d.DateValue,
            TO_NUMBER(TO_CHAR(d.DateValue, 'DD')),
            TO_NUMBER(TO_CHAR(d.DateValue, 'MM')),
            TO_NUMBER(TO_CHAR(d.DateValue, 'YYYY')),
            TO_CHAR(d.DateValue, 'Day'),
            TO_CHAR(d.DateValue, 'Month'),
            TO_CHAR(d.DateValue, 'YYYY')
        );
    END LOOP;
    COMMIT;
END;
/

--/Requirement 3: Compelling Warehouse Query/--
CREATE TABLE DimCustomers (
    CustomerKey NUMBER PRIMARY KEY,
    CustomerID VARCHAR2(50),
    CustomerName VARCHAR2(100),
    CustomerCategory VARCHAR2(50),
    City VARCHAR2(100),
    StateProvince VARCHAR2(100),
    Country VARCHAR2(100),
    DateAdded DATE
);
CREATE TABLE DimProducts (
    ProductKey NUMBER PRIMARY KEY,
    ProductID VARCHAR2(50),
    ProductName VARCHAR2(100),
    Brand VARCHAR2(50),
    Color VARCHAR2(50),
    Price NUMBER
);

CREATE TABLE DimSalespeople (
    SalespersonKey NUMBER PRIMARY KEY,
    SalespersonID VARCHAR2(50),
    SalespersonName VARCHAR2(100),
    SalespersonEmail VARCHAR2(100)
);
-- Creating the DimCities table
CREATE TABLE DimCities (
    CityKey NUMBER PRIMARY KEY,
    CityName VARCHAR2(100),
    StateProvince VARCHAR2(100),
    Country VARCHAR2(100)
);
-- Creating the FactOrders table
CREATE TABLE FactOrders (
    OrderKey NUMBER PRIMARY KEY,
    CustomerKey NUMBER,
    ProductKey NUMBER,
    SalespersonKey NUMBER,
    CityKey NUMBER,
    DateKey NUMBER,
    Quantity NUMBER,
    TotalAmount NUMBER(10,2),
    SupplierKey NUMBER,
    PickingStaffKey NUMBER,
    PickerEmployeeID NUMBER,  -- Ensure this matches with EmployeeID in DimEmployees
    FOREIGN KEY (CustomerKey) REFERENCES DimCustomers(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES DimProducts(ProductKey),
    FOREIGN KEY (SalespersonKey) REFERENCES DimSalespeople(SalespersonKey),
    FOREIGN KEY (CityKey) REFERENCES DimCities(CityKey),
    FOREIGN KEY (DateKey) REFERENCES DimDate(DateID),
    FOREIGN KEY (SupplierKey) REFERENCES DimSupplier(SupplierKey),
    FOREIGN KEY (PickingStaffKey) REFERENCES DimEmployees(EmployeeKey)  -- Correct reference
);

-- Requirement 3: Compelling Warehouse Query

SELECT 
    c.CustomerName,
    c.City,
    sp.SalespersonName,
    p.ProductName,
    s.SupplierName,
    e.EmployeeName AS PickingStaff,
    o.OrderDate
FROM 
    FactOrders o
JOIN DimCustomers c ON o.CustomerKey = c.CustomerKey
JOIN DimProducts p ON o.ProductKey = p.ProductKey
JOIN DimSalespeople sp ON o.SalespersonKey = sp.SalespersonKey
JOIN DimSupplier s ON o.SupplierKey = s.SupplierKey
JOIN DimEmployees e ON o.PickingStaffKey = e.EmployeeKey
JOIN DimDate d ON o.DateKey = d.DateID
WHERE 
    o.OrderDate BETWEEN TO_DATE('2013-01-01', 'YYYY-MM-DD') AND TO_DATE('2013-01-04', 'YYYY-MM-DD');
    
    
    ---/Requirement 4: Extracts/---
    -- Stage Tables
CREATE TABLE StageCustomers AS SELECT * FROM Customers WHERE 1=0;
CREATE TABLE StageProducts AS SELECT * FROM StockItems WHERE 1=0;
CREATE TABLE StageSalespeople AS SELECT * FROM People WHERE IsSalesperson = 1 AND 1=0;
CREATE TABLE StageOrders AS SELECT * FROM Orders WHERE 1=0;
CREATE TABLE StageSuppliers AS SELECT * FROM Suppliers WHERE 1=0;

-- Extract Customers
CREATE OR REPLACE PROCEDURE ExtractCustomers AS
BEGIN
    INSERT INTO StageCustomers
    SELECT c.CustomerID, c.CustomerName, cat.CustomerCategoryName, ci.CityName, sp.StateProvinceName, co.CountryName
    FROM Customers c
    JOIN CustomerCategories cat ON c.CustomerCategoryID = cat.CustomerCategoryID
    JOIN Cities ci ON c.DeliveryCityID = ci.CityID
    JOIN StateProvinces sp ON ci.StateProvinceID = sp.StateProvinceID
    JOIN Countries co ON sp.CountryID = co.CountryID;
END;

--/Requirement 5: Transforms/-
-- PreLoad Staging Tables
CREATE TABLE PreLoadDimCustomers AS SELECT * FROM DimCustomers WHERE 1=0;
CREATE TABLE PreLoadDimProducts AS SELECT * FROM DimProducts WHERE 1=0;
CREATE TABLE PreLoadDimSalespeople AS SELECT * FROM DimSalespeople WHERE 1=0;
CREATE TABLE PreLoadDimSuppliers AS SELECT * FROM DimSupplier WHERE 1=0;

-- Transform Customers
CREATE OR REPLACE PROCEDURE ExtractCustomers AS
BEGIN
    INSERT INTO Staging_Customers (CustomerKey, CustomerID, CustomerName, CustomerCategory, City, StateProvince, Country)
    SELECT 
        c.CustomerID, -- Assuming CustomerID is unique and used as the key
        c.CustomerID,
        c.CustomerName,
        cc.CategoryName, -- Use the correct column name
        ci.CityName,
        sp.StateProvinceName,
        co.CountryName
    FROM 
        Customers c
    JOIN 
        CustomerCategories cc ON c.CustomerCategoryID = cc.CustomerCategoryID
    JOIN 
        Cities ci ON c.CityID = ci.CityID
    JOIN 
        StateProvinces sp ON ci.StateProvinceID = sp.StateProvinceID
    JOIN 
        Countries co ON sp.CountryID = co.CountryID;
END;
/

DESC Customers;

--/Requirement 6: Create ETL Loads/--

-- ETL Load for Customers
CREATE OR REPLACE PROCEDURE LoadCustomers AS
BEGIN
    INSERT INTO DimCustomers
    SELECT * FROM PreLoadDimCustomers;
END;

--/Requirement 7: Load Rest of Data to DWH and Query/--
-- Execute Extract, Transform, and Load Procedures
BEGIN
    ExtractCustomers;
    TransformCustomers;
    LoadCustomers;

    -- Repeat for other entities: Products, Salespeople, Orders, Suppliers
END;

-- Running the compelling query
SELECT 
    c.CustomerName,
    c.City,
    sp.FullName AS Salesperson,
    p.ProductName,
    s.SupplierName,
    e.FullName AS PickingStaff,
    o.OrderDate
FROM 
    FactOrders o
JOIN DimCustomers c ON o.CustomerID = c.CustomerID
JOIN DimProducts p ON o.ProductID = p.ProductID
JOIN DimSalespeople sp ON o.SalespersonID = sp.SalespersonID
JOIN DimSupplier s ON o.SupplierID = s.SupplierID
JOIN DimEmployees e ON o.PickerEmployeeID = e.EmployeeID
JOIN DimDate d ON o.OrderDate = d.DateID
WHERE 
    o.OrderDate BETWEEN TO_DATE('2013-01-01', 'YYYY-MM-DD') AND TO_DATE('2013-01-04', 'YYYY-MM-DD');
