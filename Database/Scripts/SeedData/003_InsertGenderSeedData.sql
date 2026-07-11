/*
=========================================================
 Script Name : 003_InsertGenderSeedData.sql
 Description : Inserts default seed data into Gender table.
 Author      : Mohit Yadav
 Created On  : 11-Jul-2026
=========================================================
*/

USE E2MS;
GO

SET NOCOUNT ON;
GO

-- Insert Male
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Gender
    WHERE GenderCode = 'M'
)
BEGIN
    INSERT INTO dbo.Gender
    (
        GenderCode,
        GenderName
    )
    VALUES
    (
        'M',
        'Male'
    );
END
GO

-- Insert Female
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Gender
    WHERE GenderCode = 'F'
)
BEGIN
    INSERT INTO dbo.Gender
    (
        GenderCode,
        GenderName
    )
    VALUES
    (
        'F',
        'Female'
    );
END
GO

-- Insert Other
IF NOT EXISTS
(
    SELECT 1
    FROM dbo.Gender
    WHERE GenderCode = 'O'
)
BEGIN
    INSERT INTO dbo.Gender
    (
        GenderCode,
        GenderName
    )
    VALUES
    (
        'O',
        'Other'
    );
END
GO

SET NOCOUNT OFF;
GO