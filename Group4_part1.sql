---- Assignment 2 Part 1 Initial Database -------------------
/*
DROP TABLE A2P1_Departments CASCADE CONSTRAINTS;
DROP TABLE A2P1_PhoneTypes CASCADE CONSTRAINTS;
DROP TABLE A2P1_Employees CASCADE CONSTRAINTS;
DROP TABLE A2P1_EmployeePhoneNumbers CASCADE CONSTRAINTS;
DROP TABLE A2P1_BenefitTypes CASCADE CONSTRAINTS;
DROP TABLE A2P1_EmployeeBenefits CASCADE CONSTRAINTS;
DROP TABLE A2P1_Providers CASCADE CONSTRAINTS;
DROP TABLE A2P1_Claims CASCADE CONSTRAINTS;
*/

CREATE TABLE A2P1_Departments(
	DepartmentID 	NUMBER(10) GENERATED ALWAYS AS IDENTITY,
	DepartmentName 	NVARCHAR2(150) NOT NULL,
	StreetAddress 	NVARCHAR2(100) NOT NULL,
	City 			NVARCHAR2(60) NOT NULL,
	Province 		NVARCHAR2(50) NOT NULL,
	PostalCode 		CHAR(6) NOT NULL,
	MaxWorkstations NUMBER(10) NOT NULL,
	CONSTRAINT PK_Department PRIMARY KEY (DepartmentID)
);

CREATE TABLE A2P1_PhoneTypes(
	PhoneTypeID NUMBER(10) GENERATED ALWAYS AS IDENTITY,
	PhoneType NVARCHAR2(50) NOT NULL,
	CONSTRAINT PK_PhoneTypes PRIMARY KEY (PhoneTypeID)
);
  
CREATE TABLE A2P1_Employees(
	EmployeeID NUMBER(10) GENERATED ALWAYS AS IDENTITY,
	FirstName NVARCHAR2(50) NOT NULL,
	MiddleName NVARCHAR2(50) NULL,
	LastName NVARCHAR2(50) NOT NULL,
	DateofBirth DATE NOT NULL,
	SIN char(9) NOT NULL,
	DefaultDepartmentID  NUMBER(10) NOT NULL,
    CurrentDepartmentID  NUMBER(10) NOT NULL,
	ReportsToEmployeeID NUMBER(10) NULL, 
	StreetAddress NVARCHAR2(100) NULL,
	City NVARCHAR2(60) NULL,
	Province NVARCHAR2(50) NULL,
	PostalCode CHAR(6) NULL,
	StartDate  DATE NOT NULL,
	BaseSalary NUMBER(18, 2) NOT NULL,
-- 	BonusPercent NUMBER(3, 2) NOT NULL -- Best not to Store, as this Can be calculated from Employee data
	CONSTRAINT PK_Employee PRIMARY KEY (EmployeeID),
	CONSTRAINT FK_Employee_Department_Default FOREIGN KEY (DefaultDepartmentID) REFERENCES A2P1_Departments ( DepartmentID ),
	CONSTRAINT FK_Employee_Department_Current FOREIGN KEY (CurrentDepartmentID) REFERENCES A2P1_Departments ( DepartmentID ),
	CONSTRAINT FK_Employee_ReportsTo FOREIGN KEY (ReportsToEmployeeID) REFERENCES A2P1_Employees ( EmployeeID )
);

CREATE TABLE A2P1_EmployeePhoneNumbers(
	EmployeePhoneNumberID NUMBER(10) GENERATED ALWAYS AS IDENTITY,
	EmployeeID NUMBER(10) NOT NULL, 
	PhoneTypeID NUMBER(10) NOT NULL, 
	PhoneNumber NVARCHAR2(14) NULL,
	CONSTRAINT PK_EmployeePhoneNumbers PRIMARY KEY (EmployeePhoneNumberID),
	CONSTRAINT FK_EmployeePhoneNumbers_Employee FOREIGN KEY(EmployeeID) REFERENCES A2P1_Employees ( EmployeeID ),
	CONSTRAINT FK_EmployeePhoneNumbers_PhoneTypes FOREIGN KEY(PhoneTypeID) REFERENCES A2P1_PhoneTypes (PhoneTypeID )
); 

CREATE TABLE A2P1_BenefitTypes(
	BenefitTypeID NUMBER(10) GENERATED ALWAYS AS IDENTITY, 
	BenefitType NVARCHAR2(100) NOT NULL,
	BenefitCompanyName NVARCHAR2(100) NOT NULL,
    PolicyNumber INT NULL,
	CONSTRAINT PK_BenefitTypes PRIMARY KEY (BenefitTypeID)
);

CREATE TABLE A2P1_EmployeeBenefits(
	EmployeeBenefitID NUMBER(10) GENERATED ALWAYS AS IDENTITY, 
	EmployeeId NUMBER(10) NOT NULL, 
	BenefitTypeID NUMBER(10) NOT NULL, 
    StartDate DATE NULL,
	CONSTRAINT PK_EmployeeBenefits PRIMARY KEY(EmployeeBenefitID), 
	CONSTRAINT FK_Employee FOREIGN KEY (EmployeeId) REFERENCES A2P1_Employees ( EmployeeID ),
	CONSTRAINT FK_Employee_BenefitTypes FOREIGN KEY (BenefitTypeID) REFERENCES A2P1_BenefitTypes ( BenefitTypeID )
);

CREATE TABLE A2P1_Providers (
	ProviderID NUMBER(10) GENERATED ALWAYS AS IDENTITY, 
	ProviderName  NVARCHAR2(50) NOT NULL,
	ProviderAddress NVARCHAR2(60) NOT NULL,
	ProviderCity NVARCHAR2(50) NOT NULL,
	CONSTRAINT PK_Providers PRIMARY KEY (ProviderID) 
);

CREATE TABLE A2P1_Claims(
	ClaimID NUMBER(10) GENERATED ALWAYS AS IDENTITY, 
	ProviderID NUMBER(10) NOT NULL, 
	ClaimAmount NUMBER(18, 2) NOT NULL,
	ServiceDate DATE NOT NULL,
	EmployeeBenefitID INT NULL, 
	ClaimDate DATE NOT NULL,
	CONSTRAINT PK_Claims PRIMARY KEY (ClaimID), 
	CONSTRAINT FK_Provider FOREIGN KEY (ProviderID) REFERENCES A2P1_Providers ( ProviderID ),
	CONSTRAINT FK_Claims_EmployeeBenefits FOREIGN KEY (EmployeeBenefitID) REFERENCES A2P1_EmployeeBenefits ( EmployeeBenefitID )
);




CREATE UNIQUE INDEX UK_SIN ON A2P1_Employees (SIN);

CREATE INDEX IX_DepartmentName ON A2P1_Departments (DepartmentName);

CREATE INDEX IX_PolicyNumber ON A2P1_BenefitTypes (PolicyNumber);

CREATE INDEX IX_EmployeeID ON A2P1_EmployeePhoneNumbers (EmployeeID);

CREATE INDEX IX_BenefitTypeID ON A2P1_EmployeeBenefits (BenefitTypeID);

CREATE INDEX IX_ProviderID ON A2P1_Claims (ProviderID);

CREATE INDEX IX_ServiceDate ON A2P1_Claims (ServiceDate);

CREATE INDEX IX_ClaimDate ON A2P1_Claims (ClaimDate);


CREATE TRIGGER TR_MaxWorkstations
BEFORE INSERT OR UPDATE ON A2P1_Departments
FOR EACH ROW
BEGIN
IF :NEW.MaxWorkstations < 0 THEN
RAISE_APPLICATION_ERROR(-20001, 'MaxWorkstations must be greater than or equal to 0');
END IF;
END TR_MaxWorkstations;
/


