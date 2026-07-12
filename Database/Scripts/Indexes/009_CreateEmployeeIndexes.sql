/*
=========================================================
 Script Name : 009_CreateEmployeeIndexes.sql
 Description : Creates nonclustered indexes on Employee table.
 Author      : Mohit Yadav
 Created On  : 12-Jul-2026
=========================================================
*/

USE E2MS;
GO

SET NOCOUNT ON;
GO

----------------------------------------------------------
-- DepartmentId Index
----------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Employee_DepartmentId'
      AND object_id = OBJECT_ID('dbo.Employee')
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_Employee_DepartmentId
    ON dbo.Employee (DepartmentId);

END
GO

----------------------------------------------------------
-- RoleId Index
----------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Employee_RoleId'
      AND object_id = OBJECT_ID('dbo.Employee')
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_Employee_RoleId
    ON dbo.Employee (RoleId);

END
GO

----------------------------------------------------------
-- ManagerId Index
----------------------------------------------------------

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Employee_ManagerId'
      AND object_id = OBJECT_ID('dbo.Employee')
)
BEGIN

    CREATE NONCLUSTERED INDEX IX_Employee_ManagerId
    ON dbo.Employee (ManagerId);

END
GO

SET NOCOUNT OFF;
GO