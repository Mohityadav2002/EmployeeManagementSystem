USE E2MS;
GO

CREATE OR ALTER VIEW dbo.vw_DepartmentSummary
AS

SELECT

    D.DepartmentId,
    D.DepartmentCode,
    D.DepartmentName,

    COUNT(E.EmployeeId) AS TotalEmployees,

   COALESCE(
    SUM(CASE WHEN E.IsActive = 1 THEN 1 ELSE 0 END),
    0
) AS ActiveEmployees

, 
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

FROM dbo.Department AS D

LEFT JOIN dbo.Employee AS E
    ON D.DepartmentId = E.DepartmentId

WHERE D.IsActive = 1

GROUP BY

    D.DepartmentId,
    D.DepartmentCode,
    D.DepartmentName;
GO