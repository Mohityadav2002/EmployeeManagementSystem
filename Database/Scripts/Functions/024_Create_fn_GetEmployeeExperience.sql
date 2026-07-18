USE E2MS;
GO

CREATE OR ALTER FUNCTION dbo.fn_GetEmployeeExperience
(
    @EmployeeId INT
)
RETURNS NVARCHAR(30)
AS    
BEGIN

    DECLARE @HireDate DATE;
    DECLARE @Today DATE = CAST(GETDATE() AS DATE);

    DECLARE @Years INT;
    DECLARE @Months INT;

    DECLARE @Experience NVARCHAR(30);

    SELECT
        @HireDate = HireDate
    FROM dbo.Employee
    WHERE EmployeeId = @EmployeeId;

    IF @HireDate IS NULL
    BEGIN
        RETURN NULL;
    END;

    SET @Years =
        DATEDIFF(YEAR, @HireDate, @Today);

    IF DATEADD(YEAR, @Years, @HireDate) > @Today
    BEGIN
        SET @Years = @Years - 1;
    END;

    SET @Months =
        DATEDIFF
        (
            MONTH,
            DATEADD(YEAR, @Years, @HireDate),
            @Today
        );

    IF DAY(@Today) < DAY(@HireDate)
    BEGIN
        SET @Months = @Months - 1;
    END;

   SET @Experience =
    CONCAT
    (
        @Years,
        ' ',
        CASE
            WHEN @Years = 1 THEN 'Year'
            ELSE 'Years'
        END,
        ' ',
        @Months,
        ' ',
        CASE
            WHEN @Months = 1 THEN 'Month'
            ELSE 'Months'
        END
    );
    
    RETURN @Experience;

END;
GO