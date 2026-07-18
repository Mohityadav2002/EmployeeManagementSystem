USE E2MS;
GO

CREATE OR ALTER FUNCTION dbo.fn_GetEmployeesByRole
(
    @RoleId INT
)
RETURNS TABLE
AS
RETURN  
(
    SELECT
        EmployeeId,
        EmployeeCode,
        FirstName,
        LastName,
        FullName,
        GenderId,
        GenderCode,
        GenderName,
        DepartmentId,
        DepartmentCode,
        DepartmentName,
        RoleId,
        RoleCode,
        RoleName,
        ManagerId,
        ManagerName,
        Email,
        PhoneNumber,
        HireDate,
        Age,
        Experience,
        Salary,
        AddressLine1,
        AddressLine2,
        City,
        State,
        Country,
        PinCode,
        IsActive,
        CreatedDate
    FROM dbo.vw_EmployeeDetails
    WHERE RoleId = @RoleId
);
GO