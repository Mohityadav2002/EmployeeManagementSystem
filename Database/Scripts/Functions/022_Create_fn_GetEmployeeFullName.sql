USE E2MS;
GO

CREATE OR ALTER FUNCTION dbo.fn_GetEmployeeFullName
(
    @EmployeeId INT
)
RETURNS NVARCHAR(101)
AS
BEGIN

    DECLARE @FullName NVARCHAR(101);

    SELECT
        @FullName =
           LTRIM(RTRIM(CONCAT(FirstName, ' ', ISNULL(LastName, ''))))
    FROM dbo.Employee
    WHERE EmployeeId = @EmployeeId;

    RETURN @FullName;

END;
GO   