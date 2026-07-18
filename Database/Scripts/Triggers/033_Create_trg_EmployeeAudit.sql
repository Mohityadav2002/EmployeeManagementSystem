USE E2MS;
GO

CREATE OR ALTER TRIGGER dbo.trg_EmployeeAudit
ON dbo.Employee
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    ----------------------------------------------------
    -- INSERT
    ----------------------------------------------------
    IF EXISTS (SELECT 1 FROM inserted)
       AND NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN

        INSERT INTO dbo.EmployeeAuditLog
        (
            EmployeeId,
            EmployeeCode,
            ColumnName,
            OldValue,
            NewValue,
            ActionType
        )
        SELECT
            EmployeeId,
            EmployeeCode,
            'NEW RECORD',
            NULL,
            'Employee Created',
            'INSERT'
        FROM inserted;

    END

    ----------------------------------------------------
    -- DELETE
    ----------------------------------------------------
    IF EXISTS (SELECT 1 FROM deleted)
       AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN

        INSERT INTO dbo.EmployeeAuditLog
        (
            EmployeeId,
            EmployeeCode,
            ColumnName,
            OldValue,
            NewValue,
            ActionType
        )
        SELECT
            EmployeeId,
            EmployeeCode,
            'RECORD',
            'Employee Deleted',
            NULL,
            'DELETE'
        FROM deleted;

    END

    ----------------------------------------------------
    -- UPDATE
    ----------------------------------------------------
    IF EXISTS (SELECT 1 FROM inserted)
       AND EXISTS (SELECT 1 FROM deleted)
    BEGIN

        ---------------- Salary ----------------

        INSERT INTO dbo.EmployeeAuditLog
        (
            EmployeeId,
            EmployeeCode,
            ColumnName,
            OldValue,
            NewValue,
            ActionType
        )
        SELECT
            i.EmployeeId,
            i.EmployeeCode,
            'Salary',
            CAST(d.Salary AS NVARCHAR(MAX)),
            CAST(i.Salary AS NVARCHAR(MAX)),
            'UPDATE'
        FROM inserted i
        INNER JOIN deleted d
            ON i.EmployeeId=d.EmployeeId
        WHERE ISNULL(i.Salary,0)<>ISNULL(d.Salary,0);

        ---------------- Department ----------------

        INSERT INTO dbo.EmployeeAuditLog
        (
            EmployeeId,
            EmployeeCode,
            ColumnName,
            OldValue,
            NewValue,
            ActionType
        )
        SELECT
            i.EmployeeId,
            i.EmployeeCode,
            'DepartmentId',
            CAST(d.DepartmentId AS NVARCHAR(MAX)),
            CAST(i.DepartmentId AS NVARCHAR(MAX)),
            'UPDATE'
        FROM inserted i
        INNER JOIN deleted d
            ON i.EmployeeId=d.EmployeeId
        WHERE ISNULL(i.DepartmentId,0)<>ISNULL(d.DepartmentId,0);

        ---------------- Role ----------------

        INSERT INTO dbo.EmployeeAuditLog
        (
            EmployeeId,
            EmployeeCode,
            ColumnName,
            OldValue,
            NewValue,
            ActionType
        )
        SELECT
            i.EmployeeId,
            i.EmployeeCode,
            'RoleId',
            CAST(d.RoleId AS NVARCHAR(MAX)),
            CAST(i.RoleId AS NVARCHAR(MAX)),
            'UPDATE'
        FROM inserted i
        INNER JOIN deleted d
            ON i.EmployeeId=d.EmployeeId
        WHERE ISNULL(i.RoleId,0)<>ISNULL(d.RoleId,0);

        ---------------- Email ----------------

        INSERT INTO dbo.EmployeeAuditLog
        (
            EmployeeId,
            EmployeeCode,
            ColumnName,
            OldValue,
            NewValue,
            ActionType
        )
        SELECT
            i.EmployeeId,
            i.EmployeeCode,
            'Email',
            d.Email,
            i.Email,
            'UPDATE'
        FROM inserted i
        INNER JOIN deleted d
            ON i.EmployeeId=d.EmployeeId
        WHERE ISNULL(i.Email,'')<>ISNULL(d.Email,'');

        ---------------- Phone ----------------

        INSERT INTO dbo.EmployeeAuditLog
        (
            EmployeeId,
            EmployeeCode,
            ColumnName,
            OldValue,
            NewValue,
            ActionType
        )
        SELECT
            i.EmployeeId,
            i.EmployeeCode,
            'PhoneNumber',
            d.PhoneNumber,
            i.PhoneNumber,
            'UPDATE'
        FROM inserted i
        INNER JOIN deleted d
            ON i.EmployeeId=d.EmployeeId
        WHERE ISNULL(i.PhoneNumber,'')<>ISNULL(d.PhoneNumber,'');

        ---------------- IsActive ----------------

        INSERT INTO dbo.EmployeeAuditLog
        (
            EmployeeId,
            EmployeeCode,
            ColumnName,
            OldValue,
            NewValue,
            ActionType
        )
        SELECT
            i.EmployeeId,
            i.EmployeeCode,
            'IsActive',
            CAST(d.IsActive AS NVARCHAR(MAX)),
            CAST(i.IsActive AS NVARCHAR(MAX)),
            'UPDATE'
        FROM inserted i
        INNER JOIN deleted d
            ON i.EmployeeId=d.EmployeeId
        WHERE ISNULL(i.IsActive,0)<>ISNULL(d.IsActive,0);

    END

END;
GO