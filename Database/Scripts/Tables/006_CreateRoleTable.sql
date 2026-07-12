/*
=========================================================
 Script Name : 006_CreateRoleTable.sql
 Description : Creates Role master table.
 Author      : Mohit Yadav
 Created On  : 12-Jul-2026
=========================================================
*/

USE E2MS;
GO

IF OBJECT_ID('dbo.Role', 'U') IS NULL
BEGIN

    CREATE TABLE dbo.Role
    (
        RoleId INT IDENTITY(1,1) NOT NULL,

        RoleCode NVARCHAR(10) NOT NULL,

        RoleName NVARCHAR(100) NOT NULL,

        IsActive BIT NOT NULL
            CONSTRAINT DF_Role_IsActive DEFAULT (1),

        CreatedDate DATETIME2 NOT NULL
            CONSTRAINT DF_Role_CreatedDate DEFAULT (SYSDATETIME()),

        ModifiedDate DATETIME2 NULL,

        CONSTRAINT PK_Role
            PRIMARY KEY CLUSTERED (RoleId),

        CONSTRAINT UQ_Role_RoleCode
            UNIQUE (RoleCode),

        CONSTRAINT UQ_Role_RoleName
            UNIQUE (RoleName)
    );

END
GO