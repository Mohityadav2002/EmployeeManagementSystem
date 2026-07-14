/*
=========================================================
 Script Name : 014_Create_sp_GetAllEmployees.sql
 Description : Returns all active employees with related
               lookup information.
 Author      : Mohit Yadav
 Created On  : 14-Jul-2026
=========================================================

Business Rules

1. Return only active employees.
2. Return lookup names along with IDs.
3. Return Manager Name if assigned.
4. Do not return confidential information like Salary.
5. Sort employees by First Name and Last Name.
=========================================================
*/

USE E2MS;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.sp_GetAllEmployees

AS
BEGIN

    SET NOCOUNT ON;

        BEGIN TRY

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

        WHERE E.IsActive = 1

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