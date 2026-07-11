/*
=========================================================
 Script Name : 004_CreateDepartmentTable.sql
 Description : Creates Department master table.
 Author      : Mohit Yadav
 Created On  : 11-Jul-2026
=========================================================
*/

USE E2MS;
GO

IF OBJECT_ID('dbo.Department', 'U') IS NULL
BEGIN

    CREATE TABLE dbo.Department
    (
        DepartmentId INT IDENTITY(1,1) NOT NULL,

        DepartmentCode NVARCHAR(10) NOT NULL,

        DepartmentName NVARCHAR(100) NOT NULL,

        DepartmentEmail NVARCHAR(100) NULL,

        CONSTRAINT UQ_Department_DepartmentEmail
            UNIQUE (DepartmentEmail)

        IsActive BIT NOT NULL
            CONSTRAINT DF_Department_IsActive DEFAULT (1),

        CreatedDate DATETIME2 NOT NULL
            CONSTRAINT DF_Department_CreatedDate DEFAULT (SYSDATETIME()),

        ModifiedDate DATETIME2 NULL,

        CONSTRAINT PK_Department
            PRIMARY KEY CLUSTERED (DepartmentId),

        CONSTRAINT UQ_Department_DepartmentCode
            UNIQUE (DepartmentCode),

        CONSTRAINT UQ_Department_DepartmentName
            UNIQUE (DepartmentName)
    );

END
GO  