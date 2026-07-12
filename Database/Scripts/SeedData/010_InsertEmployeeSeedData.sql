/*
=========================================================
 Script Name : 010_InsertEmployeeSeedData.sql
 Description : Inserts demo Employee data using MERGE.
               This script is idempotent and can be
               executed multiple times safely.
 Author      : Mohit Yadav
 Created On  : 12-Jul-2026
=========================================================
*/

USE E2MS;
GO

SET NOCOUNT ON;
GO

---------------------------------------------------------
-- Employee Seed Data
---------------------------------------------------------

DECLARE @EmployeeSeed TABLE
(
    FirstName          NVARCHAR(50)   NOT NULL,
    LastName           NVARCHAR(50)       NULL,

    DateOfBirth        DATE           NOT NULL,

    GenderCode         NVARCHAR(1)    NOT NULL,

    Email              NVARCHAR(255)  NOT NULL,

    ManagerEmail       NVARCHAR(255)      NULL,

    PhoneNumber        NVARCHAR(10)   NOT NULL,

    AddressLine1       NVARCHAR(200)  NOT NULL,

    AddressLine2       NVARCHAR(200)      NULL,

    City               NVARCHAR(100)  NOT NULL,

    State              NVARCHAR(100)  NOT NULL,

    Country            NVARCHAR(100)  NOT NULL,

    PinCode            NVARCHAR(6)    NOT NULL,

    DepartmentCode     NVARCHAR(10)   NOT NULL,

    RoleCode           NVARCHAR(20)   NOT NULL,

    HireDate           DATE           NOT NULL,

    Salary             DECIMAL(18,2)  NOT NULL,

    TotalExperience    DECIMAL(4,1)   NOT NULL
);

---------------------------------------------------------
-- Insert Employee Seed Data
---------------------------------------------------------

INSERT INTO @EmployeeSeed
(
    FirstName,
    LastName,
    DateOfBirth,
    GenderCode,
    Email,
    ManagerEmail,
    PhoneNumber,
    AddressLine1,
    AddressLine2,
    City,
    State,
    Country,
    PinCode,
    DepartmentCode,
    RoleCode,
    HireDate,
    Salary,
    TotalExperience
)
VALUES

---------------------------------------------------------
-- System Administrator
---------------------------------------------------------

(
    'System',
    'Administrator',
    '1988-05-15',
    'M',
    'admin@e2ms.com',
    NULL,
    '9876543210',
    'Corporate Office',
    NULL,
    'Noida',
    'Uttar Pradesh',
    'India',
    '201301',
    'OPS',
    'ADMIN',
    '2015-01-05',
    250000.00,
    12.0
),

---------------------------------------------------------
-- Project Manager
---------------------------------------------------------

(
    'Rahul',
    'Sharma',
    '1990-02-18',
    'M',
    'rahul.sharma@e2ms.com',
    'admin@e2ms.com',
    '9876543211',
    'Sector 62',
    NULL,
    'Noida',
    'Uttar Pradesh',
    'India',
    '201301',
    'DEV',
    'PM',
    '2017-06-10',
    180000.00,
    10.0
),

---------------------------------------------------------
-- Team Lead
---------------------------------------------------------

(
    'Amit',
    'Verma',
    '1993-08-22',
    'M',
    'amit.verma@e2ms.com',
    'rahul.sharma@e2ms.com',
    '9876543212',
    'Sector 63',
    NULL,
    'Noida',
    'Uttar Pradesh',
    'India',
    '201301',
    'DEV',
    'TL',
    '2019-03-15',
    120000.00,
    7.0
),

---------------------------------------------------------
-- Software Engineer
---------------------------------------------------------

(
    'Mohit',
    'Yadav',
    '2002-04-10',
    'M',
    'mohit.yadav@e2ms.com',
    'amit.verma@e2ms.com',
    '9876543213',
    'Knowledge Park',
    NULL,
    'Greater Noida',
    'Uttar Pradesh',
    'India',
    '201310',
    'DEV',
    'SE',
    '2024-01-08',
    45000.00,
    1.5
),

---------------------------------------------------------
-- Software Engineer
---------------------------------------------------------

(
    'Ankit',
    'Kumar',
    '1998-11-05',
    'M',
    'ankit.kumar@e2ms.com',
    'amit.verma@e2ms.com',
    '9876543214',
    'Sector 18',
    NULL,
    'Noida',
    'Uttar Pradesh',
    'India',
    '201301',
    'DEV',
    'SE',
    '2023-02-20',
    55000.00,
    2.0
),

---------------------------------------------------------
-- QA Engineer
---------------------------------------------------------

(
    'Neha',
    'Singh',
    '1996-09-14',
    'F',
    'neha.singh@e2ms.com',
    'rahul.sharma@e2ms.com',
    '9876543215',
    'Sector 75',
    NULL,
    'Noida',
    'Uttar Pradesh',
    'India',
    '201301',
    'QA',
    'QA',
    '2022-07-11',
    70000.00,
    4.0
),

---------------------------------------------------------
-- HR Executive
---------------------------------------------------------

(
    'Priya',
    'Gupta',
    '1994-01-20',
    'F',
    'priya.gupta@e2ms.com',
    'admin@e2ms.com',
    '9876543216',
    'Sector 50',
    NULL,
    'Noida',
    'Uttar Pradesh',
    'India',
    '201301',
    'HR',
    'HR',
    '2021-05-18',
    80000.00,
    5.0
);

---------------------------------------------------------
-- Merge Employee Seed Data
---------------------------------------------------------

MERGE dbo.Employee AS TARGET

USING
(
    SELECT
        ES.FirstName,
        ES.LastName,
        ES.DateOfBirth,
        G.GenderId,
        ES.Email,
        ES.ManagerEmail,
        ES.PhoneNumber,
        ES.AddressLine1,
        ES.AddressLine2,
        ES.City,
        ES.State,
        ES.Country,
        ES.PinCode,
        D.DepartmentId,
        R.RoleId,
        ES.HireDate,
        ES.Salary,
        ES.TotalExperience
    FROM @EmployeeSeed ES

    INNER JOIN dbo.Gender G
        ON G.GenderCode = ES.GenderCode

    INNER JOIN dbo.Department D
        ON D.DepartmentCode = ES.DepartmentCode

    INNER JOIN dbo.Role R
        ON R.RoleCode = ES.RoleCode

) AS SOURCE

ON TARGET.Email = SOURCE.Email

---------------------------------------------------------
-- Update Existing Employee
---------------------------------------------------------

WHEN MATCHED THEN

UPDATE SET

    TARGET.FirstName         = SOURCE.FirstName,
    TARGET.LastName          = SOURCE.LastName,
    TARGET.DateOfBirth       = SOURCE.DateOfBirth,
    TARGET.GenderId          = SOURCE.GenderId,
    TARGET.PhoneNumber       = SOURCE.PhoneNumber,
    TARGET.AddressLine1      = SOURCE.AddressLine1,
    TARGET.AddressLine2      = SOURCE.AddressLine2,
    TARGET.City              = SOURCE.City,
    TARGET.State             = SOURCE.State,
    TARGET.Country           = SOURCE.Country,
    TARGET.PinCode           = SOURCE.PinCode,
    TARGET.DepartmentId      = SOURCE.DepartmentId,
    TARGET.RoleId            = SOURCE.RoleId,
    TARGET.HireDate          = SOURCE.HireDate,
    TARGET.Salary            = SOURCE.Salary,
    TARGET.TotalExperience   = SOURCE.TotalExperience,
    TARGET.ModifiedDate      = SYSDATETIME()

---------------------------------------------------------
-- Insert New Employee
---------------------------------------------------------

WHEN NOT MATCHED BY TARGET THEN

INSERT
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
    CreatedDate
)

VALUES
(
    SOURCE.FirstName,
    SOURCE.LastName,
    SOURCE.DateOfBirth,
    SOURCE.GenderId,
    SOURCE.Email,
    SOURCE.PhoneNumber,
    SOURCE.AddressLine1,
    SOURCE.AddressLine2,
    SOURCE.City,
    SOURCE.State,
    SOURCE.Country,
    SOURCE.PinCode,
    SOURCE.DepartmentId,
    SOURCE.RoleId,
    NULL,
    SOURCE.HireDate,
    SOURCE.Salary,
    SOURCE.TotalExperience,
    1,
    SYSDATETIME()
);

---------------------------------------------------------
-- Update Manager Hierarchy
---------------------------------------------------------

UPDATE E
SET E.ManagerId = M.EmployeeId
FROM dbo.Employee E
INNER JOIN @EmployeeSeed ES
    ON ES.Email = E.Email
LEFT JOIN dbo.Employee M
    ON M.Email = ES.ManagerEmail;

---------------------------------------------------------
-- Verification
---------------------------------------------------------

SELECT
    E.EmployeeId,
    E.FirstName,
    E.LastName,
    E.Email,
    D.DepartmentName,
    R.RoleName,
    G.GenderName,
    ManagerName =
        CASE
            WHEN M.EmployeeId IS NULL THEN NULL
            ELSE CONCAT(M.FirstName, ' ', M.LastName)
        END,
    E.Salary,
    E.TotalExperience,
    E.IsActive
FROM dbo.Employee E
INNER JOIN dbo.Department D
    ON E.DepartmentId = D.DepartmentId
INNER JOIN dbo.Role R
    ON E.RoleId = R.RoleId
INNER JOIN dbo.Gender G
    ON E.GenderId = G.GenderId
LEFT JOIN dbo.Employee M
    ON E.ManagerId = M.EmployeeId
ORDER BY E.EmployeeId;

SET NOCOUNT OFF;
GO  