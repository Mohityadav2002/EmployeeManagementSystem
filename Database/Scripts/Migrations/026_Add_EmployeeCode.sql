USE E2MS;
GO

-- Part-2 : Add Column

IF COL_LENGTH('dbo.Employee', 'EmployeeCode') IS NULL
BEGIN
    ALTER TABLE dbo.Employee
    ADD EmployeeCode NVARCHAR(20) NULL;
END;
GO

-- Part-3 : Populate Existing Data

UPDATE dbo.Employee
SET EmployeeCode = 'EMP' + RIGHT('000000' + CAST(EmployeeId AS VARCHAR(6)), 6)
WHERE EmployeeCode IS NULL;
GO

ALTER TABLE dbo.Employee
ALTER COLUMN EmployeeCode NVARCHAR(20) NOT NULL;
GO

ALTER TABLE dbo.Employee
ADD CONSTRAINT UQ_Employee_EmployeeCode
UNIQUE (EmployeeCode);
GO