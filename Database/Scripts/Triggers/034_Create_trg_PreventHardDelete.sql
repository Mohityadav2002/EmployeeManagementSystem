USE E2MS;
GO

CREATE OR ALTER TRIGGER dbo.trg_PreventHardDelete
ON dbo.Employee
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    THROW 50001,
    'Hard Delete is not allowed. Use sp_DeleteEmployee (Soft Delete) instead.',
    1;
END;
GO