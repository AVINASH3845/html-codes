CREATE TABLE A2P2_Departments (
    DepartmentID    NUMBER(10) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    DepartmentName  NVARCHAR2(50) NOT NULL,
    DepartmentDesc  NVARCHAR2(100) DEFAULT 'Dept. Description to be determined' NOT NULL 
);

CREATE TABLE A2P2_Employees (
    EmployeeID          NUMBER(10) GENERATED ALWAYS AS IDENTITY,
    DepartmentID        NUMBER(10),
    ManagerEmployeeID   NUMBER(10),
    FirstName           NVARCHAR2(50),
    LastName            NVARCHAR2(50),
    Salary              NUMBER(18,2),
    CommissionBonus     NUMBER(18,2),
    FileFolder          NVARCHAR2(256) DEFAULT 'ToBeBuilt',
    CONSTRAINT PK_Ass2Employees_ID PRIMARY KEY (EmployeeID),
    CONSTRAINT FK_Ass2Employee_Department FOREIGN KEY (DepartmentID) REFERENCES A2P2_Departments ( DepartmentID ),
    CONSTRAINT FK_Ass2Employee_Manager FOREIGN KEY (ManagerEmployeeID) REFERENCES A2P2_Employees ( EmployeeID ),
    CONSTRAINT CK_Ass2EmployeeSalary CHECK ( Salary >= 0 ),
    CONSTRAINT CK_Ass2EmployeeCommission CHECK ( CommissionBonus >= 0 )
);



INSERT INTO A2P2_Departments ( DepartmentName, DepartmentDesc )
VALUES ( 'Management', 'Executive Management' );
INSERT INTO A2P2_Departments ( DepartmentName, DepartmentDesc )
VALUES ( 'HR', 'Human Resources' );
INSERT INTO A2P2_Departments ( DepartmentName, DepartmentDesc )
VALUES ( 'DatabaseMgmt', 'Database Management');
INSERT INTO A2P2_Departments ( DepartmentName, DepartmentDesc )
VALUES ( 'Support', 'Product Support' );
INSERT INTO A2P2_Departments ( DepartmentName, DepartmentDesc )
VALUES ( 'Software', 'Software Sales' );
INSERT INTO A2P2_Departments ( DepartmentName, DepartmentDesc )
VALUES ( 'Peripheral', 'Peripheral Sales' );


INSERT INTO A2P2_Employees ( DepartmentID, ManagerEmployeeID, FirstName, LastName, Salary, CommissionBonus, FileFolder )
VALUES ( 1, NULL, 'Sarah', 'Campbell', 76000, NULL, 'SarahCampbell' );
INSERT INTO A2P2_Employees ( DepartmentID, ManagerEmployeeID, FirstName, LastName, Salary, CommissionBonus, FileFolder )
VALUES ( 3, 1, 'James', 'Donoghue',     66000 , NULL, 'JamesDonoghue');
INSERT INTO A2P2_Employees ( DepartmentID, ManagerEmployeeID, FirstName, LastName, Salary, CommissionBonus, FileFolder )
VALUES ( 1, 1, 'Hank', 'Brady',        74000 , NULL, 'HankBrady');
INSERT INTO A2P2_Employees ( DepartmentID, ManagerEmployeeID, FirstName, LastName, Salary, CommissionBonus, FileFolder )
VALUES ( 2, 1, 'Samantha', 'Jones',    71000, NULL , 'SamanthaJones');
INSERT INTO A2P2_Employees ( DepartmentID, ManagerEmployeeID, FirstName, LastName, Salary, CommissionBonus, FileFolder )
VALUES ( 3, 4, 'Fred', 'Judd',         42000, 4000, 'FredJudd');
INSERT INTO A2P2_Employees ( DepartmentID, ManagerEmployeeID, FirstName, LastName, Salary, CommissionBonus, FileFolder )
VALUES ( 3, NULL, 'Hannah', 'Grant',   65000, 3000 ,  'HannahGrant');
INSERT INTO A2P2_Employees ( DepartmentID, ManagerEmployeeID, FirstName, LastName, Salary, CommissionBonus, FileFolder )
VALUES ( 3, 4, 'Dhruv', 'Patel',       64000, 2000 ,  'DhruvPatel');
INSERT INTO A2P2_Employees ( DepartmentID, ManagerEmployeeID, FirstName, LastName, Salary, CommissionBonus, FileFolder )
VALUES ( 4, 3, 'Ash', 'Mansfield',     52000, 5000 ,  'AshMansfield');


CREATE OR REPLACE FUNCTION A2P2_GetEmployeeID (FName IN NVARCHAR2, LName IN NVARCHAR2 )
RETURN NUMBER
IS
   EmpID NUMBER(10);
BEGIN
    SELECT EmployeeID INTO EmpID 
    FROM A2P2_Employees
    WHERE FirstName = FName AND LastName = LName;

    RETURN EmpID;
END;


/* REQUIREMENT 1*/--a stored procedure to insert into table Departments--

CREATE OR REPLACE PROCEDURE A2P2_InsertDepartment (
  p_DepartmentName  NVARCHAR2,
  p_DepartmentDesc  NVARCHAR2
) AS
BEGIN
  INSERT INTO A2P2_Departments (DepartmentName, DepartmentDesc)
  VALUES (p_DepartmentName, p_DepartmentDesc);
END;
/

BEGIN
  A2P2_InsertDepartment('SQA', 'Software Quality Assurance');
  A2P2_InsertDepartment('Engineering', 'Systems Design and Development');
  A2P2_InsertDepartment('TechSupport', 'Technical Support');
END;
/

/* REQUIREMENT 2*/-- scalar function to get an Department ID by name--
CREATE OR REPLACE FUNCTION A2P2_GetDepartmentID(
  p_DepartmentName  NVARCHAR2
) RETURN NUMBER
AS
  v_DepartmentID  NUMBER;
BEGIN
  SELECT DepartmentID INTO v_DepartmentID
  FROM A2P2_Departments
  WHERE DepartmentName = p_DepartmentName;
  RETURN v_DepartmentID;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN NULL;
END;
/



/* REQUIREMENT 3*/ --stored procedure that will insert a record into table employees--

CREATE OR REPLACE PROCEDURE A2P2_InsertEmployee(
  p_DepartmentName  NVARCHAR2,
  p_EmployeeFirstName  NVARCHAR2,
  p_EmployeeLastName  NVARCHAR2,
  p_Salary  NUMBER := 45000,
  p_FileFolder  NVARCHAR2,
  p_ManagerFirstName  NVARCHAR2,
  p_ManagerLastName  NVARCHAR2,
  p_CommissionBonus  NUMBER := 1500
) AS
  v_DepartmentID  NUMBER;
  v_ManagerEmployeeID  NUMBER;
BEGIN
  -- Get Department ID
  v_DepartmentID := A2P2_GetDepartmentID(p_DepartmentName);
  IF v_DepartmentID IS NULL THEN
    -- Insert new department
    A2P2_InsertDepartment(p_DepartmentName, '');
    v_DepartmentID := A2P2_GetDepartmentID(p_DepartmentName);
  END IF;
  
  -- Get Manager Employee ID
  v_ManagerEmployeeID := A2P2_GetEmployeeID(p_ManagerFirstName, p_ManagerLastName);
  IF v_ManagerEmployeeID IS NULL THEN
    -- Insert new manager
    A2P2_InsertEmployee(
      'DatabaseMgmt', 
      p_ManagerFirstName, 
      p_ManagerLastName, 
      45000, 
      p_ManagerFirstName || p_ManagerLastName, 
      NULL, 
      NULL, 
      1500
    );
    v_ManagerEmployeeID := A2P2_GetEmployeeID(p_ManagerFirstName, p_ManagerLastName);
  END IF;
  
  -- Insert new employees
  A2P2_InsertEmployee(
    'DatabaseMgmt', 
    'Avinash', 
    'Nuthalapati', 
    8943845, 
    'AvinashNuthalapati', 
    'Osam', 
    'Ali', 
    1500
  );
  
  A2P2_InsertEmployee(
    'DatabaseMgmt', 
    'Shamsh', 
    'Tabrez Shaikh', 
    8956767, 
    'ShamshTabrezShaikh', 
    'Osam', 
    'Ali', 
    1500
  );
  
  A2P2_InsertEmployee(
    'DatabaseMgmt', 
    'YourFirstName', 
    'YourLastName', 
    8943845, 
    'YourFirstNameYourLastName', 
    'Osam', 
    'Ali', 
    1500
  );
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END;
/


/* REQUIREMENT 4*/-- Function to return employees with salary greater than a specified value
CREATE OR REPLACE FUNCTION GetEmployeesBySalary (
    p_Salary NUMBER
) RETURN SYS_REFCURSOR
IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT EmployeeID, FirstName, LastName
        FROM A2P2_Employees
        WHERE Salary > p_Salary;

    RETURN v_cursor;
END;
/

-- PL/SQL block to fetch and display employees based on salary
DECLARE
    v_emp_cursor SYS_REFCURSOR;
    v_emp_id A2P2_Employees.EmployeeID%TYPE;
    v_emp_firstname A2P2_Employees.FirstName%TYPE;
    v_emp_lastname A2P2_Employees.LastName%TYPE;
BEGIN
    v_emp_cursor := GetEmployeesBySalary(45000);

    LOOP
        FETCH v_emp_cursor INTO v_emp_id, v_emp_firstname, v_emp_lastname;
        EXIT WHEN v_emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_emp_id || ', Name: ' || v_emp_firstname || ' ' || v_emp_lastname);
    END LOOP;

    CLOSE v_emp_cursor;
END;
/




/* REQUIREMENT 5*/-- window function that will rank employees by department--
WITH EmployeeRankings AS (
  SELECT
    E.FirstName,
    E.LastName,
    D.DepartmentName,
    E.CommissionBonus,
    LAG(E.CommissionBonus, 1, 0) OVER (
      PARTITION BY D.DepartmentID
      ORDER BY E.CommissionBonus DESC
    ) AS CommissionAbove,
    LAG(E.FirstName, 1, '') OVER (
      PARTITION BY D.DepartmentID
      ORDER BY E.CommissionBonus DESC
    ) AS NameAbove,
    AVG(E.CommissionBonus) OVER (
      PARTITION BY D.DepartmentID
    ) AS AvgCommission,
    E.Salary + E.CommissionBonus AS TotalCompensation,
    RANK() OVER (
      PARTITION BY D.DepartmentID
      ORDER BY E.CommissionBonus DESC
    ) AS CommissionRank
  FROM
    A2P2_Employees E
  INNER JOIN
    A2P2_Departments D ON E.DepartmentID = D.DepartmentID
)
SELECT
  *
FROM
  EmployeeRankings;


/* REQUIREMENT 6*/ --Recursive query to get employees by their manager--

WITH EmployeeHierarchy (EmployeeID, EmployeeFirstName, EmployeeLastName, DepartmentID, FileFolder, ManagerEmployeeID, ManagerFirstName, ManagerLastName, FilePath) AS (
    SELECT 
        e.EmployeeID,
        e.FirstName AS EmployeeFirstName,
        e.LastName AS EmployeeLastName,
        e.DepartmentID,
        e.FileFolder,
        e.ManagerEmployeeID,
        CAST(NULL AS NVARCHAR2(50)) AS ManagerFirstName,
        CAST(NULL AS NVARCHAR2(50)) AS ManagerLastName,
        e.FileFolder AS FilePath
    FROM 
        A2P2_Employees e
    WHERE 
        e.ManagerEmployeeID IS NULL
    
    UNION ALL
    
    SELECT
        e.EmployeeID,
        e.FirstName AS EmployeeFirstName,
        e.LastName AS EmployeeLastName,
        e.DepartmentID,
        e.FileFolder,
        e.ManagerEmployeeID,
        m.EmployeeFirstName AS ManagerFirstName,
        m.EmployeeLastName AS ManagerLastName,
        m.FilePath || '\' || e.FileFolder AS FilePath
    FROM 
        A2P2_Employees e
    JOIN 
        EmployeeHierarchy m ON e.ManagerEmployeeID = m.EmployeeID
)
SELECT 
    EmployeeFirstName,
    EmployeeLastName,
    DepartmentID,
    FileFolder,
    ManagerFirstName,
    ManagerLastName,
    FilePath
FROM 
    EmployeeHierarchy;

