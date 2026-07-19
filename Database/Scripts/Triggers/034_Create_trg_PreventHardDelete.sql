USE E2MS;
GO

CREATE OR ALTER TRIGGER dbo.trg_PreventHardDelete
ON dbo.Employee
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    THROW 50007,
          'Hard delete is not allowed. Please use dbo.sp_DeleteEmployee for soft delete.',
          1;
END;
GO   