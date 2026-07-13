/*
=========================================================
 Script Name : 012_Create_sp_UpdateEmployee.sql
 Description : Creates stored procedure to update an
               existing employee.
 Author      : Mohit Yadav
 Created On  : 13-Jul-2026
=========================================================
*/

USE E2MS;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.sp_UpdateEmployee

    @EmployeeId         INT,

    @FirstName          NVARCHAR(50),

    @LastName           NVARCHAR(50) = NULL,

    @DateOfBirth        DATE,

    @GenderId           INT,

    @Email              NVARCHAR(255),

    @PhoneNumber        NVARCHAR(10),

    @AddressLine1       NVARCHAR(200),

    @AddressLine2       NVARCHAR(200) = NULL,

    @City               NVARCHAR(100),

    @State              NVARCHAR(100),

    @Country            NVARCHAR(100),

    @PinCode            NVARCHAR(6),

    @DepartmentId       INT,

    @RoleId             INT,

    @ManagerId          INT = NULL,

    @HireDate           DATE,

    @Salary             DECIMAL(18,2),

    @TotalExperience    DECIMAL(4,1)

AS
BEGIN

    SET NOCOUNT ON;
        ---------------------------------------------------------
    -- Validate Employee Exists
    ---------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Employee
        WHERE EmployeeId = @EmployeeId
    )
    BEGIN
        THROW 50051, 'Employee does not exist.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Employee Is Active
    ---------------------------------------------------------

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Employee
        WHERE EmployeeId = @EmployeeId
          AND IsActive = 0
    )
    BEGIN
        THROW 50052, 'Employee is inactive.', 1;
    END;

    ---------------------------------------------------------
    -- Validate First Name
    ---------------------------------------------------------

    IF LTRIM(RTRIM(@FirstName)) = ''
    BEGIN
        THROW 50053, 'First Name cannot be empty.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Date Of Birth
    ---------------------------------------------------------

    IF @DateOfBirth >= CAST(GETDATE() AS DATE)
    BEGIN
        THROW 50054, 'Date of Birth must be less than current date.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Hire Date
    ---------------------------------------------------------

    IF @HireDate > CAST(GETDATE() AS DATE)
    BEGIN
        THROW 50055, 'Hire Date cannot be a future date.', 1;
    END;

    IF @HireDate < @DateOfBirth
    BEGIN
        THROW 50056, 'Hire Date cannot be earlier than Date of Birth.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Salary
    ---------------------------------------------------------

    IF @Salary < 0
    BEGIN
        THROW 50057, 'Salary cannot be negative.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Experience
    ---------------------------------------------------------

    IF @TotalExperience < 0
    BEGIN
        THROW 50058, 'Total Experience cannot be negative.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Duplicate Email
    ---------------------------------------------------------

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Employee
        WHERE Email = @Email
          AND EmployeeId <> @EmployeeId
    )
    BEGIN
        THROW 50059, 'Email already exists.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Duplicate Phone Number
    ---------------------------------------------------------

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Employee
        WHERE PhoneNumber = @PhoneNumber
          AND EmployeeId <> @EmployeeId
    )
    BEGIN
        THROW 50060, 'Phone Number already exists.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Gender
    ---------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Gender
        WHERE GenderId = @GenderId
    )
    BEGIN
        THROW 50061, 'Invalid Gender.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Department
    ---------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Department
        WHERE DepartmentId = @DepartmentId
    )
    BEGIN
        THROW 50062, 'Invalid Department.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Role
    ---------------------------------------------------------

    IF NOT EXISTS
    (
        SELECT 1
        FROM dbo.Role
        WHERE RoleId = @RoleId
    )
    BEGIN
        THROW 50063, 'Invalid Role.', 1;
    END;

---------------------------------------------------------
-- Validate Self Reporting
---------------------------------------------------------

IF @ManagerId = @EmployeeId
BEGIN
    THROW 50065,
          'Employee cannot be their own manager.',
          1;
END;

---------------------------------------------------------
-- Validate Manager
---------------------------------------------------------

IF @ManagerId IS NOT NULL
   AND NOT EXISTS
(
    SELECT 1
    FROM dbo.Employee
    WHERE EmployeeId = @ManagerId
      AND IsActive = 1
)
BEGIN
    THROW 50064,
          'Invalid Manager.',
          1;
END;

        ---------------------------------------------------------
    -- Update Employee
    ---------------------------------------------------------

    BEGIN TRY

        BEGIN TRANSACTION;

        UPDATE dbo.Employee
        SET
            FirstName = @FirstName,
            LastName = @LastName,
            DateOfBirth = @DateOfBirth,
            GenderId = @GenderId,
            Email = @Email,
            PhoneNumber = @PhoneNumber,
            AddressLine1 = @AddressLine1,
            AddressLine2 = @AddressLine2,
            City = @City,
            State = @State,
            Country = @Country,
            PinCode = @PinCode,
            DepartmentId = @DepartmentId,
            RoleId = @RoleId,
            ManagerId = @ManagerId,
            HireDate = @HireDate,
            Salary = @Salary,
            TotalExperience = @TotalExperience,
            ModifiedDate = SYSDATETIME()
        WHERE EmployeeId = @EmployeeId;

        COMMIT TRANSACTION;

        ---------------------------------------------------------
        -- Return Success Message
        ---------------------------------------------------------

        SELECT
            @EmployeeId AS EmployeeId,
            'Employee updated successfully.' AS Message;


                END TRY

    BEGIN CATCH

        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;

        THROW;  

    END CATCH;

END;
GO
