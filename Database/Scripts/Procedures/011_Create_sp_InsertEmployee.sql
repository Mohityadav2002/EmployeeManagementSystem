/*
=========================================================
 Script Name : 011_Create_sp_InsertEmployee.sql
 Description : Creates stored procedure to insert a new
               employee into Employee table.
 Author      : Mohit Yadav
 Created On  : 12-Jul-2026
=========================================================
*/

USE E2MS;
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE OR ALTER PROCEDURE dbo.sp_InsertEmployee

    @FirstName         NVARCHAR(50),

    @LastName          NVARCHAR(50) = NULL,

    @DateOfBirth       DATE,

    @GenderId          INT,

    @Email             NVARCHAR(255),

    @PhoneNumber       NVARCHAR(10),

    @AddressLine1      NVARCHAR(200),

    @AddressLine2      NVARCHAR(200) = NULL,

    @City              NVARCHAR(100),

    @State             NVARCHAR(100),

    @Country           NVARCHAR(100),

    @PinCode           NVARCHAR(6),

    @DepartmentId      INT,

    @RoleId            INT,

    @ManagerId         INT = NULL,

    @HireDate          DATE,

    @Salary            DECIMAL(18,2),

    @TotalExperience   DECIMAL(4,1)

AS
BEGIN

    SET NOCOUNT ON;

     ---------------------------------------------------------
    -- Validate First Name
    ---------------------------------------------------------

    IF LTRIM(RTRIM(@FirstName)) = ''
    BEGIN
        THROW 50001, 'First Name cannot be empty.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Date Of Birth
    ---------------------------------------------------------

    IF @DateOfBirth >= CAST(GETDATE() AS DATE)
    BEGIN
        THROW 50002, 'Date of Birth must be less than current date.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Hire Date
    ---------------------------------------------------------

    IF @HireDate > CAST(GETDATE() AS DATE)
    BEGIN
        THROW 50003, 'Hire Date cannot be a future date.', 1;
    END;

    IF @HireDate < @DateOfBirth
    BEGIN
        THROW 50004, 'Hire Date cannot be earlier than Date of Birth.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Salary
    ---------------------------------------------------------

    IF @Salary < 0
    BEGIN
        THROW 50005, 'Salary cannot be negative.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Experience
    ---------------------------------------------------------

    IF @TotalExperience < 0
    BEGIN
        THROW 50006, 'Total Experience cannot be negative.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Duplicate Email
    ---------------------------------------------------------

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Employee
        WHERE Email = @Email
    )
    BEGIN
        THROW 50007, 'Email already exists.', 1;
    END;

    ---------------------------------------------------------
    -- Validate Duplicate Phone Number
    ---------------------------------------------------------

    IF EXISTS
    (
        SELECT 1
        FROM dbo.Employee
        WHERE PhoneNumber = @PhoneNumber
    )
    BEGIN
        THROW 50008, 'Phone Number already exists.', 1;
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
        THROW 50009, 'Invalid Gender.', 1;
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
        THROW 50010, 'Invalid Department.', 1;
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
        THROW 50011, 'Invalid Role.', 1;
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
    )
    BEGIN
        THROW 50012, 'Invalid Manager.', 1;
    END;

        ---------------------------------------------------------
    -- Insert Employee
    ---------------------------------------------------------

    BEGIN TRY

        BEGIN TRANSACTION;

        INSERT INTO dbo.Employee
        (
            FirstName,
            LastName,
            DateOfBirth,
            GenderId,
            Email,
            PhoneNumber,
            AddressLine1,
            AddressLine2,
            City,
            State,
            Country,
            PinCode,
            DepartmentId,
            RoleId,
            ManagerId,
            HireDate,
            Salary,
            TotalExperience,
            IsActive,
            CreatedDate,
            ModifiedDate
        )
        VALUES
        (
            @FirstName,
            @LastName,
            @DateOfBirth,
            @GenderId,
            @Email,
            @PhoneNumber,
            @AddressLine1,
            @AddressLine2,
            @City,
            @State,
            @Country,
            @PinCode,
            @DepartmentId,
            @RoleId,
            @ManagerId,
            @HireDate,
            @Salary,
            @TotalExperience,
            1,
            SYSDATETIME(),
            NULL
        );

        DECLARE @EmployeeId INT;

        SET @EmployeeId = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        ---------------------------------------------------------
        -- Return Newly Created Employee Id
        ---------------------------------------------------------

        SELECT
            @EmployeeId AS EmployeeId,
            'Employee created successfully.' AS Message;


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

-- @ManagerId : Pass NULL for top-level employees
-- @TotalExperience : Total years of experience
