USE E2MS;
GO

CREATE OR ALTER VIEW dbo.vw_RoleSummary
AS

SELECT

    ---------------------------------------------------------
    -- Role Information
    ---------------------------------------------------------

    R.RoleId,
    R.RoleCode,
    R.RoleName,

    ---------------------------------------------------------
    -- Employee Summary
    ---------------------------------------------------------

    COUNT(E.EmployeeId) AS TotalEmployees,

    COALESCE
    (
        SUM
        (
            CASE
                WHEN E.IsActive = 1 THEN 1
                ELSE 0
            END
        ),
        0
    ) AS ActiveEmployees,

    COALESCE
    (
        SUM
        (
            CASE
                WHEN E.IsActive = 0 THEN 1
                ELSE 0
            END
        ),
        0
    ) AS InactiveEmployees

FROM dbo.Role AS R

LEFT JOIN dbo.Employee AS E
    ON R.RoleId = E.RoleId

WHERE R.IsActive = 1

GROUP BY

    R.RoleId,
    R.RoleCode,
    R.RoleName;
GO