USE E2MS;
GO

CREATE OR ALTER FUNCTION dbo.fn_GetManagerHierarchy
(
    @ManagerId INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        EmployeeId,
        EmployeeCode,
        FullName,
        DepartmentName,
        RoleName,
        Email,
        PhoneNumber,
        HireDate,
        Experience,
        IsActive
    FROM dbo.vw_EmployeeDetails
    WHERE ManagerId = @ManagerId
);
GO