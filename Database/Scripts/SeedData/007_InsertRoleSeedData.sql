/*
=========================================================
 Script Name : 007_InsertRoleSeedData.sql
 Description : Inserts default seed data into Role table.
 Author      : Mohit Yadav
 Created On  : 12-Jul-2026
=========================================================
*/

USE E2MS;
GO

SET NOCOUNT ON;
GO

-- Insert Administrator
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Role
    WHERE RoleCode = 'ADMIN'
)
BEGIN
    INSERT INTO dbo.Role
    (
        RoleCode,
        RoleName
    )
    VALUES
    (
        'ADMIN',
        'Administrator'
    );
END
GO

-- Insert Project Manager
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Role
    WHERE RoleCode = 'PM'
)
BEGIN
    INSERT INTO dbo.Role
    (
        RoleCode,
        RoleName
    )
    VALUES
    (
        'PM',
        'Project Manager'
    );
END
GO

-- Insert Team Lead
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Role
    WHERE RoleCode = 'TL'
)
BEGIN
    INSERT INTO dbo.Role
    (
        RoleCode,
        RoleName
    )
    VALUES
    (
        'TL',
        'Team Lead'
    );
END
GO

-- Insert Software Engineer
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Role
    WHERE RoleCode = 'SE'
)
BEGIN
    INSERT INTO dbo.Role
    (
        RoleCode,
        RoleName
    )
    VALUES
    (
        'SE',
        'Software Engineer'
    );
END
GO

-- Insert QA Engineer
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Role
    WHERE RoleCode = 'QA'
)
BEGIN
    INSERT INTO dbo.Role
    (
        RoleCode,
        RoleName
    )
    VALUES
    (
        'QA',
        'QA Engineer'
    );
END
GO

-- Insert HR Executive
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Role
    WHERE RoleCode = 'HR'
)
BEGIN
    INSERT INTO dbo.Role
    (
        RoleCode,
        RoleName
    )
    VALUES
    (
        'HR',
        'HR Executive'
    );
END
GO

SET NOCOUNT OFF;
GO