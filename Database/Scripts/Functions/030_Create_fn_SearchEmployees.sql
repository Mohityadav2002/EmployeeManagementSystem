USE E2MS;
GO

CREATE OR ALTER FUNCTION dbo.fn_SearchEmployees
(
    @SearchText NVARCHAR(100)
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
        GenderName,
        DepartmentName,
        RoleName,
        ManagerName,
        Email,
        PhoneNumber,
        HireDate,
        Age,
        Experience,
        Salary,
        IsActive
    FROM dbo.vw_EmployeeDetails
    WHERE
            EmployeeCode LIKE '%' + @SearchText + '%'
        OR  FullName LIKE '%' + @SearchText + '%'
        OR  Email LIKE '%' + @SearchText + '%'
        OR  PhoneNumber LIKE '%' + @SearchText + '%'
        OR  DepartmentName LIKE '%' + @SearchText + '%'
        OR  RoleName LIKE '%' + @SearchText + '%'
);
GO