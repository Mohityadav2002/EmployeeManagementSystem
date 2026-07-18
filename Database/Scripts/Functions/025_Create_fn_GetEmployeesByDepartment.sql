USE E2MS;
GO

CREATE OR ALTER FUNCTION dbo.fn_GetEmployeesByDepartment
(
    @DepartmentId INT
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
        GenderName,
        DepartmentName,
        RoleName,
        ManagerName,
        Salary,
        TotalExperience,
        IsActive
    FROM dbo.vw_EmployeeDetails
    WHERE DepartmentId = @DepartmentId
);
GO