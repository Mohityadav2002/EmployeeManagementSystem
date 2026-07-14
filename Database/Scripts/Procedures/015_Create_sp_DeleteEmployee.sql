/*
=========================================================
 Script Name : 015_Create_sp_DeleteEmployee.sql
 Description : Performs soft delete for an employee.
 Author      : Mohit Yadav
 Created On  : 14-Jul-2026
=========================================================

Business Rules

1. Employee must exist.
2. Employee must be active.
3. Employee cannot be deleted if assigned as Manager
   to any active employee.
4. Perform soft delete only.
5. Update ModifiedDate.
6. Use transaction.
7. Use TRY...CATCH.

=========================================================
*/

USE E2MS;
GO

SET ANSI_NULLS ON;
GO  

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.sp_DeleteEmployee

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
        THROW 50201,
              'Employee does not exist.',
              1;
    END;

    IF @IsActive = 0
    BEGIN
        THROW 50202,
              'Employee is already inactive.',
              1;
    END;

    ---------------------------------------------------------
    -- Validate Reporting Employees
    ---------------------------------------------------------

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Employee
        WHERE ManagerId = @EmployeeId
          AND IsActive = 1
    )
    BEGIN
        THROW 50203,
              'Employee cannot be deleted because active employees are reporting to this manager.',
              1;
    END;
        BEGIN TRY

        BEGIN TRANSACTION;

        ---------------------------------------------------------
        -- Soft Delete Employee
        ---------------------------------------------------------

        UPDATE dbo.Employee
        SET
            IsActive = 0,
            ModifiedDate = SYSUTCDATETIME()
        WHERE EmployeeId = @EmployeeId;

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH;

END;
GO