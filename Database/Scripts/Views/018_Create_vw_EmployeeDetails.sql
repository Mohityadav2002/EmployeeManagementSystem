USE E2MS;
GO

CREATE OR ALTER VIEW dbo.vw_EmployeeDetails
AS

SELECT

    ---------------------------------------------------------
    -- Employee Information
    ---------------------------------------------------------

    E.EmployeeId,
    E.EmployeeCode,
    E.FirstName,
    E.LastName,

    dbo.fn_GetEmployeeFullName(E.EmployeeId) AS FullName,
    ---------------------------------------------------------
    -- Gender
    ---------------------------------------------------------
    E.GenderId,
    G.GenderCode,
    G.GenderName,

    ---------------------------------------------------------
    -- Department
    ---------------------------------------------------------
    
    E.DepartmentId,
    D.DepartmentCode,
    D.DepartmentName,

    ---------------------------------------------------------
    -- Role
    ---------------------------------------------------------
    E.RoleId,
    R.RoleCode,
    R.RoleName,

    ---------------------------------------------------------
    -- Manager
    ---------------------------------------------------------

    M.EmployeeId AS ManagerId,

    CONCAT
    (
        M.FirstName,
        ' ',
        ISNULL(M.LastName,'')
    ) AS ManagerName,

    ---------------------------------------------------------
    -- Contact
    ---------------------------------------------------------

    E.Email,
    E.PhoneNumber,


   ---------------------------------------------------------
    -- Employment
    ---------------------------------------------------------

    E.DateOfBirth,
    E.HireDate,
    dbo.fn_GetEmployeeAge(E.EmployeeId) AS Age,
    dbo.fn_GetEmployeeExperience(E.EmployeeId) AS Experience,
    E.Salary,
    E.TotalExperience,
    ---------------------------------------------------------
    -- Address
    ---------------------------------------------------------

    E.AddressLine1,
    E.AddressLine2,
    E.City,
    E.State,
    E.Country,
    E.PinCode,

    ---------------------------------------------------------
    -- Status
    ---------------------------------------------------------

    E.IsActive,
    E.CreatedDate

    FROM dbo.Employee AS E

INNER JOIN dbo.Gender AS G
    ON E.GenderId = G.GenderId

INNER JOIN dbo.Department AS D
    ON E.DepartmentId = D.DepartmentId

INNER JOIN dbo.Role AS R
    ON E.RoleId = R.RoleId

LEFT JOIN dbo.Employee AS M
    ON E.ManagerId = M.EmployeeId;

GO 