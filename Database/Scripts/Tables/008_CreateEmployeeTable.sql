/*
=========================================================
 Script Name : 008_CreateEmployeeTable.sql
 Description : Creates Employee table.
 Author      : Mohit Yadav
 Created On  : 12-Jul-2026
=========================================================
*/

USE E2MS;
GO

SET NOCOUNT ON;
GO

IF OBJECT_ID('dbo.Employee', 'U') IS NULL
BEGIN

    CREATE TABLE dbo.Employee
    (
        -------------------------------------------------
        -- Primary Key
        -------------------------------------------------

        EmployeeId INT IDENTITY(1,1) NOT NULL,

        -------------------------------------------------
        -- Personal Information
        -------------------------------------------------

        FirstName NVARCHAR(50) NOT NULL,

        LastName NVARCHAR(50) NULL,

        DateOfBirth DATE NOT NULL,

        GenderId INT NOT NULL,

        -------------------------------------------------
        -- Contact Information
        -------------------------------------------------

        Email NVARCHAR(255) NOT NULL,

        PhoneNumber NVARCHAR(15) NOT NULL,

        AddressLine1 NVARCHAR(200) NOT NULL,

        AddressLine2 NVARCHAR(200) NULL,

        City NVARCHAR(100) NOT NULL,

        State NVARCHAR(100) NOT NULL,

        Country NVARCHAR(100) NOT NULL,

        PinCode NVARCHAR(6) NOT NULL,

        -------------------------------------------------
        -- Employment Information
        -------------------------------------------------

        DepartmentId INT NOT NULL,

        RoleId INT NOT NULL,

        ManagerId INT NULL,

        HireDate DATE NOT NULL,

        Salary DECIMAL(18,2) NOT NULL,

        TotalExperience DECIMAL(4,1) NOT NULL,

        -------------------------------------------------
        -- Audit Columns
        -------------------------------------------------

        IsActive BIT NOT NULL
            CONSTRAINT DF_Employee_IsActive
            DEFAULT (1),

        CreatedDate DATETIME2 NOT NULL
            CONSTRAINT DF_Employee_CreatedDate
            DEFAULT (SYSDATETIME()),

        ModifiedDate DATETIME2 NULL,

        -------------------------------------------------
        -- Primary Key
        -------------------------------------------------

        CONSTRAINT PK_Employee
            PRIMARY KEY CLUSTERED (EmployeeId),

        -------------------------------------------------
        -- Unique Constraints
        -------------------------------------------------

        CONSTRAINT UQ_Employee_Email
            UNIQUE (Email),

        CONSTRAINT UQ_Employee_PhoneNumber
            UNIQUE (PhoneNumber),

        -------------------------------------------------
        -- Check Constraints
        -------------------------------------------------

        CONSTRAINT CK_Employee_Salary
            CHECK (Salary >= 0),

        CONSTRAINT CK_Employee_TotalExperience
            CHECK (TotalExperience >= 0),

        CONSTRAINT CK_Employee_DateOfBirth
            CHECK (DateOfBirth < CAST(GETDATE() AS DATE)),

        CONSTRAINT CK_Employee_HireDate
            CHECK
            (
                HireDate >= DateOfBirth
                AND HireDate <= CAST(GETDATE() AS DATE)
            ),

        CONSTRAINT CK_Employee_PinCode
            CHECK
            (
                LEN(PinCode) = 6
                AND PinCode NOT LIKE '%[^0-9]%'
            ),

        -------------------------------------------------
        -- Foreign Keys
        -------------------------------------------------

        CONSTRAINT FK_Employee_Gender
            FOREIGN KEY (GenderId)
            REFERENCES dbo.Gender(GenderId),

        CONSTRAINT FK_Employee_Department
            FOREIGN KEY (DepartmentId)
            REFERENCES dbo.Department(DepartmentId),

        CONSTRAINT FK_Employee_Role
            FOREIGN KEY (RoleId)
            REFERENCES dbo.Role(RoleId),

        CONSTRAINT FK_Employee_Manager
            FOREIGN KEY (ManagerId)
            REFERENCES dbo.Employee(EmployeeId)
            ON DELETE SET NULL

    );

END
GO

SET NOCOUNT OFF;
GO