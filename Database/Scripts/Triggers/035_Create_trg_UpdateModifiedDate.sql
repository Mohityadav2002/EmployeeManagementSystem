USE E2MS;
GO

CREATE OR ALTER TRIGGER dbo.trg_UpdateModifiedDate
ON dbo.Employee
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    UPDATE e
    SET ModifiedDate = SYSDATETIME()
    FROM dbo.Employee e
    INNER JOIN inserted i
        ON e.EmployeeId = i.EmployeeId;
END;
GO