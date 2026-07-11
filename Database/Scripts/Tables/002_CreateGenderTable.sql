/*
=========================================================
 Script Name : 002_CreateGenderTable.sql
 Description : Creates Gender lookup table.
 Author      : Mohit Yadav
 Created On  : 11-Jul-2026
=========================================================
*/

USE E2MS;
GO

IF OBJECT_ID('dbo.Gender', 'U') IS NULL
BEGIN

    CREATE TABLE dbo.Gender
    (
        GenderId INT IDENTITY(1,1) NOT NULL,

        GenderCode NVARCHAR(1) NOT NULL,

        GenderName NVARCHAR(20) NOT NULL,

        IsActive BIT NOT NULL
            CONSTRAINT DF_Gender_IsActive DEFAULT (1),

        CreatedDate DATETIME2 NOT NULL
            CONSTRAINT DF_Gender_CreatedDate DEFAULT (SYSDATETIME()),

        ModifiedDate DATETIME2 NULL
        CONSTRAINT DF_Gender_ModifiedDate DEFAULT (SYSDATETIME()),

        CONSTRAINT PK_Gender
            PRIMARY KEY CLUSTERED (GenderId),

        CONSTRAINT UQ_Gender_GenderCode
            UNIQUE (GenderCode),

        CONSTRAINT UQ_Gender_GenderName
            UNIQUE (GenderName),

        CONSTRAINT CK_Gender_GenderCode
            CHECK (GenderCode IN ('M', 'F', 'O'))
    );

END
GO