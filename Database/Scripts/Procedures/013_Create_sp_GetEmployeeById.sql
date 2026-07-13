/*
=========================================================
 Script Name : 013_Create_sp_GetEmployeeById.sql
 Description : Returns employee details by EmployeeId.
 Author      : Mohit Yadav
 Created On  : 13-Jul-2026
=========================================================

Business Rules

1. Employee must exist.
2. Employee must be active.
3. Return employee details with related lookup data.
4. Return Manager Name if assigned.
=========================================================
*/

USE E2MS;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetEmployeeById

    @EmployeeId INT

AS
BEGIN

    SET NOCOUNT ON;
        ---------------------------------------------------------
    -- Validate Employee
    ---------------------------------------------------------

    DECLARE @IsActive BIT;

    SELECT
        @IsActive = IsActive
    FROM dbo.Employee
    WHERE EmployeeId = @EmployeeId;

    IF @IsActive IS NULL
    BEGIN
        THROW 50101,
              'Employee does not exist or is inactive.',
              1;
    END;

    IF @IsActive = 0
    BEGIN
        THROW 50102,
              'Employee does not exist or is inactive.',
              1;
    END;

    BEGIN TRY
-- =============================select query ======================================================
    SELECT

        E.EmployeeId,

        E.FirstName,

        E.LastName,

        E.DateOfBirth,

        E.GenderId,
        G.GenderName,

        E.Email,

        E.PhoneNumber,

        E.AddressLine1,
        E.AddressLine2,

        E.City,
        E.State,
        E.Country,
        E.PinCode,

        E.DepartmentId,
        D.DepartmentCode,
        D.DepartmentName,

        E.RoleId,
        R.RoleCode,
        R.RoleName,

        E.ManagerId,

    CASE
    WHEN M.EmployeeId IS NULL THEN NULL
    ELSE CONCAT
    (
        M.FirstName,
        ' ',
        ISNULL(M.LastName, '')
    )
    END AS ManagerName , 

        E.HireDate,

        E.Salary,

        E.TotalExperience,

        E.IsActive,

        E.CreatedDate,

        E.ModifiedDate

    FROM dbo.Employee AS E

    INNER JOIN dbo.Gender AS G
        ON E.GenderId = G.GenderId

    INNER JOIN dbo.Department AS D
        ON E.DepartmentId = D.DepartmentId

    INNER JOIN dbo.Role AS R
        ON E.RoleId = R.RoleId

    LEFT JOIN dbo.Employee AS M
        ON E.ManagerId = M.EmployeeId

    WHERE E.EmployeeId = @EmployeeId;
  
    END TRY

    BEGIN CATCH

        THROW;

    END CATCH;

END;
GO
