USE E2MS;
GO

CREATE TABLE dbo.EmployeeAuditLog
(
    AuditId BIGINT IDENTITY(1,1)
        CONSTRAINT PK_EmployeeAuditLog PRIMARY KEY,

    EmployeeId INT NOT NULL,

    EmployeeCode NVARCHAR(20) NOT NULL,

    ColumnName NVARCHAR(100) NOT NULL,

    OldValue NVARCHAR(MAX) NULL,

    NewValue NVARCHAR(MAX) NULL,

    ActionType NVARCHAR(10) NOT NULL
        CONSTRAINT CK_EmployeeAuditLog_ActionType
        CHECK (ActionType IN ('INSERT','UPDATE','DELETE')),

    ActionDate DATETIME2 NOT NULL
        CONSTRAINT DF_EmployeeAuditLog_ActionDate
        DEFAULT SYSDATETIME(),

    ActionBy NVARCHAR(100) NOT NULL
        CONSTRAINT DF_EmployeeAuditLog_ActionBy
        DEFAULT SUSER_SNAME()
);
GO