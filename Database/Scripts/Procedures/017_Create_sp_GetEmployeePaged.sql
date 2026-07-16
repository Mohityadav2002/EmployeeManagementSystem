/*
=========================================================
 Script Name : 017_Create_sp_GetEmployeePaged.sql
 Description : Returns active employees using
               pagination, search and optional filters.
 Author      : Mohit Yadav
 Created On  : 15-Jul-2026
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

4. Support server-side pagination.

5. Return total record count.

6. Return lookup IDs, Codes and Names.

7. Return Manager Name if assigned.

8. Do not return confidential information like Salary.

9. Sort employees by:
   - FirstName
   - LastName
   - EmployeeId

10. PageNumber must be greater than zero.

11. PageSize must be greater than zero.

=========================================================
*/

USE E2MS;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetEmployeePaged

    @PageNumber INT = 1,
    @PageSize INT = 10,
    @SearchText NVARCHAR(100) = NULL,
    @GenderId INT = NULL,
    @DepartmentId INT = NULL,
    @RoleId INT = NULL

AS
BEGIN

    SET NOCOUNT ON;
        BEGIN TRY

        ---------------------------------------------------------
        -- Validate Pagination Parameters
        ---------------------------------------------------------

        IF @PageNumber <= 0
        BEGIN
            THROW 50301,
                  'PageNumber must be greater than zero.',
                  1;
        END;

        IF @PageSize <= 0
        BEGIN
            THROW 50302,
                  'PageSize must be greater than zero.',
                  1;
        END;

         IF @PageSize > 100
    BEGIN
        THROW 50303,
              'PageSize cannot be greater than 100.',
              1;
    END;


        ---------------------------------------------------------
        -- Trim Search Text
        ---------------------------------------------------------

        SET @SearchText = LTRIM(RTRIM(@SearchText));

        IF @SearchText = ''
        BEGIN
            SET @SearchText = NULL;
        END;



                ---------------------------------------------------------
        -- Get Paged Employees
        ---------------------------------------------------------

        SELECT

            COUNT(*) OVER() AS TotalRecordCount,

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
                ) LIKE '%' + @SearchText + '%'

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
            E.EmployeeId

        OFFSET (@PageNumber - 1) * @PageSize ROWS

        FETCH NEXT @PageSize ROWS ONLY;

            END TRY

    BEGIN CATCH

        THROW;

    END CATCH;

END;
GO
