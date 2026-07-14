/*
=========================================================
 Script Name : 016_Create_sp_SearchEmployees.sql
 Description : Searches active employees using optional
               search text and lookup filters.
 Author      : Mohit Yadav
 Created On  : 14-Jul-2026
=========================================================

Business Rules

1. Return only active employees.

2. Support partial search on:
   - First Name
   - Last Name
   - Email
   - Phone Number
   - City
   - Department Code
   - Department Name
   - Role Code
   - Role Name

3. Support optional filters:
   - Gender
   - Department
   - Role

4. Return lookup IDs, Codes and Names.

5. Ignore NULL filter parameters.

6. Return Manager Name if assigned.

7. Do not return confidential information like Salary.

8. Sort employees by:
   - FirstName
   - LastName
   - EmployeeId

=========================================================
*/

USE E2MS;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.sp_SearchEmployees
    @SearchText NVARCHAR(100) = NULL,
    @GenderId INT = NULL,
    @DepartmentId INT = NULL,
    @RoleId INT = NULL
AS
BEGIN

    SET NOCOUNT ON;

        BEGIN TRY

        ---------------------------------------------------------
        -- Trim Search Text
        ---------------------------------------------------------

        SET @SearchText = LTRIM(RTRIM(@SearchText));
        IF @SearchText = ''
        SET @SearchText = NULL;

        ---------------------------------------------------------
        -- Search Employees
        ---------------------------------------------------------

        SELECT

            E.EmployeeId,

            E.FirstName,

            E.LastName,

            E.GenderId,
            G.GenderName,

            E.Email,

            E.PhoneNumber,

            E.DepartmentId,
            D.DepartmentCode,
            D.DepartmentName,

            E.RoleId,
            R.RoleCode,
            R.RoleName,

            E.ManagerId,

            CASE
                WHEN E.ManagerId IS NULL
                    THEN NULL
                ELSE CONCAT
                (
                    M.FirstName,
                    ' ',
                    ISNULL(M.LastName, '')
                )
            END AS ManagerName,

            E.City,

            E.State,

            E.Country,

            E.HireDate,

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

        WHERE

            E.IsActive = 1

            AND
            (
                @SearchText IS NULL

                OR E.FirstName LIKE '%' + @SearchText + '%'
                OR E.LastName LIKE '%' + @SearchText + '%'
                OR CONCAT
            (
                     E.FirstName,
                            ' ',
                       ISNULL(E.LastName, '')
            )             LIKE '%' + @SearchText + '%'
                OR E.Email LIKE '%' + @SearchText + '%'
                OR E.PhoneNumber LIKE '%' + @SearchText + '%'
                OR E.City LIKE '%' + @SearchText + '%'
                OR D.DepartmentCode LIKE '%' + @SearchText + '%'
                OR D.DepartmentName LIKE '%' + @SearchText + '%'
                OR R.RoleCode LIKE '%' + @SearchText + '%'
                OR R.RoleName LIKE '%' + @SearchText + '%'
            )

            AND
            (
                @GenderId IS NULL
                OR E.GenderId = @GenderId
            )

            AND
            (
                @DepartmentId IS NULL
                OR E.DepartmentId = @DepartmentId
            )

            AND
            (
                @RoleId IS NULL
                OR E.RoleId = @RoleId
            )

        ORDER BY

            E.FirstName,
            E.LastName,
            E.EmployeeId;

                END TRY

    BEGIN CATCH

        THROW;

    END CATCH;

END;
GO   
