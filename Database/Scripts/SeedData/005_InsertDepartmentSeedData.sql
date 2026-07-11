/*
=========================================================
 Script Name : 005_InsertDepartmentSeedData.sql
 Description : Inserts default seed data into Department table.
 Author      : Mohit Yadav
 Created On  : 12-Jul-2026
=========================================================
*/

USE E2MS;
GO

SET NOCOUNT ON;
GO

-- Insert Human Resources
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Department
    WHERE DepartmentCode = 'HR'
)
BEGIN
    INSERT INTO dbo.Department
    (
        DepartmentCode,
        DepartmentName,
        DepartmentEmail
    )
    VALUES
    (
        'HR',
        'Human Resources',
        'hr@e2ms.com'
    );
END
GO

-- Insert Information Technology
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Department
    WHERE DepartmentCode = 'IT'
)
BEGIN
    INSERT INTO dbo.Department
    (
        DepartmentCode,
        DepartmentName,
        DepartmentEmail
    )
    VALUES
    (
        'IT',
        'Information Technology',
        'it@e2ms.com'
    );
END
GO

-- Insert Finance
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Department
    WHERE DepartmentCode = 'FIN'
)
BEGIN
    INSERT INTO dbo.Department
    (
        DepartmentCode,
        DepartmentName,
        DepartmentEmail
    )
    VALUES
    (
        'FIN',
        'Finance',
        'finance@e2ms.com'
    );
END
GO

-- Insert Quality Assurance
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Department
    WHERE DepartmentCode = 'QA'
)
BEGIN
    INSERT INTO dbo.Department
    (
        DepartmentCode,
        DepartmentName,
        DepartmentEmail
    )
    VALUES
    (
        'QA',
        'Quality Assurance',
        'qa@e2ms.com'
    );
END
GO

-- Insert Software Development
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Department
    WHERE DepartmentCode = 'DEV'
)
BEGIN
    INSERT INTO dbo.Department
    (
        DepartmentCode,
        DepartmentName,
        DepartmentEmail
    )
    VALUES
    (
        'DEV',
        'Software Development',
        'dev@e2ms.com'
    );
END
GO

-- Insert Operations
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Department
    WHERE DepartmentCode = 'OPS'
)
BEGIN
    INSERT INTO dbo.Department
    (
        DepartmentCode,
        DepartmentName,
        DepartmentEmail
    )
    VALUES
    (
        'OPS',
        'Operations',
        'ops@e2ms.com'
    );
END
GO

SET NOCOUNT OFF;
GO