USE E2MS;
GO

CREATE OR ALTER FUNCTION dbo.fn_GetEmployeeAge
(
    @EmployeeId INT
)
RETURNS INT
AS
BEGIN   

    DECLARE @DateOfBirth DATE;
    DECLARE @Age INT;

    SELECT
        @DateOfBirth = DateOfBirth
    FROM dbo.Employee
    WHERE EmployeeId = @EmployeeId;

    IF @DateOfBirth IS NULL
    BEGIN
        RETURN NULL;
    END;

    SET @Age =
        DATEDIFF
        (
            YEAR,
            @DateOfBirth,
            GETDATE()
        );

    IF
    (
        DATEADD
        (
            YEAR,
            @Age,
            @DateOfBirth
        ) > CAST(GETDATE() AS DATE)
    )
    BEGIN
        SET @Age = @Age - 1;
    END;

    RETURN @Age;

END;
GO