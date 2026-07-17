USE E2MS;
GO

CREATE OR ALTER VIEW dbo.vw_EmployeeDetails
AS

SELECT

    ---------------------------------------------------------
    -- Employee Information
    ---------------------------------------------------------

    E.EmployeeId,
    E.FirstName,
    E.LastName,

    CONCAT(E.FirstName, ' ', ISNULL(E.LastName, '')) AS FullName,

    ---------------------------------------------------------
    -- Gender
    ---------------------------------------------------------

    G.GenderCode,
    G.GenderName,

    ---------------------------------------------------------
    -- Department
    ---------------------------------------------------------

    D.DepartmentCode,
    D.DepartmentName,

    ---------------------------------------------------------
    -- Role
    ---------------------------------------------------------

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
    -- Address
    ---------------------------------------------------------

    E.AddressLine1,
    E.AddressLine2,
    E.City,
    E.State,
    E.Country,
    E.PinCode,

    ---------------------------------------------------------
    -- Employment
    ---------------------------------------------------------

    E.DateOfBirth,
    E.HireDate,
    E.Salary,
    E.TotalExperience,

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