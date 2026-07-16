/*
=========================================================
 Script Name : 010_InsertEmployeeSeedData.sql
 Description : Inserts demo Employee data using MERGE.
               This script is idempotent and can be
               executed multiple times safely.
 Author      : Mohit Yadav
 Created On  : 12-Jul-2026
=========================================================
*/

USE E2MS;
GO

SET NOCOUNT ON;
GO

---------------------------------------------------------
-- Employee Seed Data
---------------------------------------------------------


DECLARE @EmployeeSeed TABLE
(
    FirstName          NVARCHAR(50),
    LastName           NVARCHAR(50),

    GenderCode         NVARCHAR(1),

    DepartmentCode     NVARCHAR(10),

    RoleCode           NVARCHAR(20),

    ManagerEmail       NVARCHAR(100) NULL,

    Email              NVARCHAR(100),

    PhoneNumber        NVARCHAR(15),

    DateOfBirth        DATE,

    HireDate           DATE,

    Salary             DECIMAL(10,2),

    TotalExperience    DECIMAL(4,1),

    AddressLine1       NVARCHAR(200),

    AddressLine2       NVARCHAR(200) NULL,

    City               NVARCHAR(100),

    State              NVARCHAR(100),

    Country            NVARCHAR(100),

    PinCode            NVARCHAR(10)
);
---------------------------------------------------------
-- Insert Employee Seed Data
---------------------------------------------------------

INSERT INTO @EmployeeSeed
(
    FirstName,
    LastName,
    GenderCode,
    DepartmentCode,
    RoleCode,
    ManagerEmail,
    Email,
    PhoneNumber,
    DateOfBirth,
    HireDate,
    Salary,
    TotalExperience,
    AddressLine1,
    AddressLine2,
    City,
    State,
    Country,
    PinCode
)
VALUES

(
    'Raj', 'Mehta', 'M', 'IT', 'ADMIN',
    NULL,
    'raj.mehta@e2ms.com',
    '9876543201',
    '1980-04-15',
    '2010-01-15',
    3000000,
    20.0,
    'MG Road',
    'Block A',
    'Bangalore',
    'Karnataka',
    'India',
    '560001'
),

(
    'Amit', 'Sharma', 'M', 'DEV', 'PM',
    'raj.mehta@e2ms.com',
    'amit.sharma@e2ms.com',
    '9876543202',
    '1985-08-10',
    '2014-03-20',
    2200000,
    15.0,
    'Sector 62',
    'Tower A',
    'Noida',
    'Uttar Pradesh',
    'India',
    '201309'
),

(
    'Neha', 'Singh', 'F', 'QA', 'PM',
    'raj.mehta@e2ms.com',
    'neha.singh@e2ms.com',
    '9876543203',
    '1987-01-25',
    '2015-07-10',
    2100000,
    13.0,
    'Hinjewadi',
    'Phase 1',
    'Pune',
    'Maharashtra',
    'India',
    '411057'
),

(
    'Vikram', 'Joshi', 'M', 'IT', 'PM',
    'raj.mehta@e2ms.com',
    'vikram.joshi@e2ms.com',
    '9876543204',
    '1984-11-18',
    '2013-05-12',
    2300000,
    16.0,
    'Electronic City',
    'Phase 2',
    'Bangalore',
    'Karnataka',
    'India',
    '560100'
),

(
    'Rohit', 'Gupta', 'M', 'DEV', 'TL',
    'amit.sharma@e2ms.com',
    'rohit.gupta@e2ms.com',
    '9876543205',
    '1990-06-12',
    '2017-02-15',
    1700000,
    9.0,
    'Sector 63',
    'Block B',
    'Noida',
    'Uttar Pradesh',
    'India',
    '201301'
),

(
    'Priya', 'Verma', 'F', 'DEV', 'TL',
    'amit.sharma@e2ms.com',
    'priya.verma@e2ms.com',
    '9876543206',
    '1991-03-22',
    '2018-01-08',
    1600000,
    8.0,
    'Laxmi Nagar',
    'Block C',
    'Delhi',
    'Delhi',
    'India',
    '110092'
),

(
    'Ankit', 'Mishra', 'M', 'QA', 'TL',
    'neha.singh@e2ms.com',
    'ankit.mishra@e2ms.com',
    '9876543207',
    '1990-09-14',
    '2017-08-21',
    1650000,
    9.0,
    'Baner',
    'Phase 2',
    'Pune',
    'Maharashtra',
    'India',
    '411045'
),

(
    'Sneha', 'Kapoor', 'F', 'QA', 'TL',
    'neha.singh@e2ms.com',
    'sneha.kapoor@e2ms.com',
    '9876543208',
    '1992-02-17',
    '2018-11-05',
    1600000,
    8.0,
    'Powai',
    'Lake View',
    'Mumbai',
    'Maharashtra',
    'India',
    '400076'
),

(
    'Karan', 'Malhotra', 'M', 'IT', 'TL',
    'vikram.joshi@e2ms.com',
    'karan.malhotra@e2ms.com',
    '9876543209',
    '1991-12-08',
    '2018-06-18',
    1650000,
    8.0,
    'Whitefield',
    'Phase 1',
    'Bangalore',
    'Karnataka',
    'India',
    '560066'
),

(
    'Pooja', 'Sinha', 'F', 'IT', 'TL',
    'vikram.joshi@e2ms.com',
    'pooja.sinha@e2ms.com',
    '9876543310',
    '1992-05-28',
    '2019-01-14',
    1550000,
    7.0,
    'Gachibowli',
    'Tower A',
    'Hyderabad',
    'Telangana',
    'India',
    '500032'
)

,
(
    'Mohit', 'Yadav', 'M', 'DEV', 'SE',
    'rohit.gupta@e2ms.com',
    'mohit.yadav@e2ms.com',
    '9876543311',
    '2000-05-18',
    '2024-06-15',
    650000,
    2.0,
    'Sector 62',
    'Block A',
    'Noida',
    'Uttar Pradesh',
    'India',
    '201309'
),

(
    'Rahul', 'Kumar', 'M', 'DEV', 'SE',
    'rohit.gupta@e2ms.com',
    'rahul.kumar@e2ms.com',
    '9876543312',
    '1999-09-10',
    '2023-07-01',
    700000,
    3.0,
    'Sector 63',
    'Block B',
    'Noida',
    'Uttar Pradesh',
    'India',
    '201301'
),

(
    'Abhishek', 'Singh', 'M', 'DEV', 'SE',
    'rohit.gupta@e2ms.com',
    'abhishek.singh@e2ms.com',
    '9876543313',
    '1998-02-21',
    '2022-08-18',
    800000,
    4.0,
    'Indirapuram',
    'Ahinsa Khand',
    'Ghaziabad',
    'Uttar Pradesh',
    'India',
    '201014'
),

(
    'Vivek', 'Patel', 'M', 'DEV', 'SE',
    'rohit.gupta@e2ms.com',
    'vivek.patel@e2ms.com',
    '9876543314',
    '1997-12-12',
    '2021-03-10',
    900000,
    5.0,
    'Sector 18',
    'Near Metro',
    'Noida',
    'Uttar Pradesh',
    'India',
    '201301'
),

(
    'Saurabh', 'Gupta', 'M', 'DEV', 'SE',
    'priya.verma@e2ms.com',
    'saurabh.gupta@e2ms.com',
    '9876543315',
    '1999-07-11',
    '2023-01-16',
    720000,
    3.0,
    'Laxmi Nagar',
    'Block C',
    'Delhi',
    'Delhi',
    'India',
    '110092'
),

(
    'Ashish', 'Yadav', 'M', 'DEV', 'SE',
    'priya.verma@e2ms.com',
    'ashish.yadav@e2ms.com',
    '9876543316',
    '1998-11-25',
    '2022-09-12',
    850000,
    4.0,
    'Dwarka',
    'Sector 10',
    'Delhi',
    'Delhi',
    'India',
    '110075'
),

(
    'Deepak', 'Sharma', 'M', 'DEV', 'SE',
    'priya.verma@e2ms.com',
    'deepak.sharma@e2ms.com',
    '9876543317',
    '1997-03-14',
    '2021-04-19',
    950000,
    5.0,
    'Rohini',
    'Sector 8',
    'Delhi',
    'Delhi',
    'India',
    '110085'
),

(
    'Nitin', 'Verma', 'M', 'DEV', 'SE',
    'priya.verma@e2ms.com',
    'nitin.verma@e2ms.com',
    '9876543318',
    '1996-10-08',
    '2020-02-24',
    1050000,
    6.0,
    'Janakpuri',
    'Block D',
    'Delhi',
    'Delhi',
    'India',
    '110058'
),

(
    'Manish', 'Gupta', 'M', 'DEV', 'SE',
    'karan.malhotra@e2ms.com',
    'manish.gupta@e2ms.com',
    '9876543319',
    '1998-06-17',
    '2022-06-20',
    850000,
    4.0,
    'Whitefield',
    'Phase 1',
    'Bangalore',
    'Karnataka',
    'India',
    '560066'
),

(
    'Gaurav', 'Singh', 'M', 'DEV', 'SE',
    'karan.malhotra@e2ms.com',
    'gaurav.singh@e2ms.com',
    '9876543320',
    '1997-01-28',
    '2021-05-10',
    950000,
    5.0,
    'Electronic City',
    'Phase 2',
    'Bangalore',
    'Karnataka',
    'India',
    '560100'
) , 
---------------------------------------------------------
-- Software Engineers (11-20)
---------------------------------------------------------


(
    'Rakesh', 'Kumar', 'M', 'DEV', 'SE',
    'karan.malhotra@e2ms.com',
    'rakesh.kumar@e2ms.com',
    '9876543221',
    '1996-04-09',
    '2020-08-14',
    1100000,
    6.0,
    'Marathahalli',
    'Ring Road',
    'Bangalore',
    'Karnataka',
    'India',
    '560037'
),

(
    'Aditya', 'Sharma', 'M', 'DEV', 'SE',
    'karan.malhotra@e2ms.com',
    'aditya.sharma@e2ms.com',
    '9876543222',
    '1995-09-22',
    '2019-10-07',
    1200000,
    7.0,
    'HSR Layout',
    'Sector 2',
    'Bangalore',
    'Karnataka',
    'India',
    '560102'
),

(
    'Shubham', 'Mishra', 'M', 'DEV', 'SE',
    'pooja.sinha@e2ms.com',
    'shubham.mishra@e2ms.com',
    '9876543223',
    '1999-01-16',
    '2023-04-11',
    720000,
    3.0,
    'Gachibowli',
    'Tower A',
    'Hyderabad',
    'Telangana',
    'India',
    '500032'
),

(
    'Akash', 'Yadav', 'M', 'DEV', 'SE',
    'pooja.sinha@e2ms.com',
    'akash.yadav@e2ms.com',
    '9876543224',
    '1998-07-29',
    '2022-03-21',
    820000,
    4.0,
    'Madhapur',
    'Hi-Tech City',
    'Hyderabad',
    'Telangana',
    'India',
    '500081'
),

(
    'Shivam', 'Singh', 'M', 'DEV', 'SE',
    'pooja.sinha@e2ms.com',
    'shivam.singh@e2ms.com',
    '9876543225',
    '1997-02-18',
    '2021-07-05',
    930000,
    5.0,
    'Kondapur',
    'Block C',
    'Hyderabad',
    'Telangana',
    'India',
    '500084'
),

(
    'Arjun', 'Verma', 'M', 'DEV', 'SE',
    'pooja.sinha@e2ms.com',
    'arjun.verma@e2ms.com',
    '9876543226',
    '1996-12-04',
    '2020-11-16',
    1100000,
    6.0,
    'Kukatpally',
    'Phase 3',
    'Hyderabad',
    'Telangana',
    'India',
    '500072'
),

(
    'Harsh', 'Gupta', 'M', 'DEV', 'SE',
    'amit.sharma@e2ms.com',
    'harsh.gupta@e2ms.com',
    '9876543227',
    '1999-08-13',
    '2023-02-08',
    700000,
    3.0,
    'Civil Lines',
    'Ward 5',
    'Jaipur',
    'Rajasthan',
    'India',
    '302006'
),

(
    'Kunal', 'Singh', 'M', 'DEV', 'SE',
    'amit.sharma@e2ms.com',
    'kunal.singh@e2ms.com',
    '9876543228',
    '1998-05-20',
    '2022-05-30',
    820000,
    4.0,
    'Vaishali Nagar',
    'Block A',
    'Jaipur',
    'Rajasthan',
    'India',
    '302021'
),

(
    'Ayush', 'Mishra', 'M', 'DEV', 'SE',
    'vikram.joshi@e2ms.com',
    'ayush.mishra@e2ms.com',
    '9876543229',
    '1999-04-02',
    '2023-06-12',
    730000,
    3.0,
    'Aliganj',
    'Sector B',
    'Lucknow',
    'Uttar Pradesh',
    'India',
    '226024'
),

(
    'Varun', 'Sharma', 'M', 'DEV', 'SE',
    'vikram.joshi@e2ms.com',
    'varun.sharma@e2ms.com',
    '9876543230',
    '1997-10-15',
    '2021-09-27',
    920000,
    5.0,
    'Gomti Nagar',
    'Extension',
    'Lucknow',
    'Uttar Pradesh',
    'India',
    '226010'
) , 
---------------------------------------------------------
-- QA Engineers
---------------------------------------------------------


(
    'Komal', 'Sharma', 'F', 'QA', 'QA',
    'ankit.mishra@e2ms.com',
    'komal.sharma@e2ms.com',
    '9876543231',
    '1999-02-14',
    '2023-04-01',
    650000,
    3.0,
    'Kothrud',
    'Block A',
    'Pune',
    'Maharashtra',
    'India',
    '411038'
),

(
    'Riya', 'Gupta', 'F', 'QA', 'QA',
    'ankit.mishra@e2ms.com',
    'riya.gupta@e2ms.com',
    '9876543232',
    '1998-06-20',
    '2022-07-15',
    720000,
    4.0,
    'Baner',
    'Phase 2',
    'Pune',
    'Maharashtra',
    'India',
    '411045'
),

(
    'Swati', 'Singh', 'F', 'QA', 'QA',
    'ankit.mishra@e2ms.com',
    'swati.singh@e2ms.com',
    '9876543233',
    '1997-09-10',
    '2021-03-12',
    800000,
    5.0,
    'Wakad',
    'Tower B',
    'Pune',
    'Maharashtra',
    'India',
    '411057'
),

(
    'Nisha', 'Verma', 'F', 'QA', 'QA',
    'ankit.mishra@e2ms.com',
    'nisha.verma@e2ms.com',
    '9876543234',
    '1996-12-05',
    '2020-08-24',
    900000,
    6.0,
    'Hinjewadi',
    'Phase 1',
    'Pune',
    'Maharashtra',
    'India',
    '411057'
),

(
    'Aditi', 'Yadav', 'F', 'QA', 'QA',
    'sneha.kapoor@e2ms.com',
    'aditi.yadav@e2ms.com',
    '9876543235',
    '1999-08-18',
    '2023-05-19',
    650000,
    3.0,
    'Andheri East',
    'Block C',
    'Mumbai',
    'Maharashtra',
    'India',
    '400069'
),

(
    'Pooja', 'Gupta', 'F', 'QA', 'QA',
    'sneha.kapoor@e2ms.com',
    'pooja.gupta@e2ms.com',
    '9876543236',
    '1998-01-29',
    '2022-06-10',
    730000,
    4.0,
    'Powai',
    'Lake View',
    'Mumbai',
    'Maharashtra',
    'India',
    '400076'
),

(
    'Simran', 'Kaur', 'F', 'QA', 'QA',
    'sneha.kapoor@e2ms.com',
    'simran.kaur@e2ms.com',
    '9876543237',
    '1997-04-08',
    '2021-09-20',
    820000,
    5.0,
    'Thane West',
    'Block D',
    'Mumbai',
    'Maharashtra',
    'India',
    '400601'
),

(
    'Meenal', 'Singh', 'F', 'QA', 'QA',
    'sneha.kapoor@e2ms.com',
    'meenal.singh@e2ms.com',
    '9876543238',
    '1996-11-11',
    '2020-10-14',
    910000,
    6.0,
    'Navi Mumbai',
    'Sector 12',
    'Mumbai',
    'Maharashtra',
    'India',
    '400706'
),

(
    'Anjali', 'Sharma', 'F', 'QA', 'QA',
    'neha.singh@e2ms.com',
    'anjali.sharma@e2ms.com',
    '9876543239',
    '1998-05-25',
    '2022-04-18',
    720000,
    4.0,
    'Sector 21',
    'Block A',
    'Gurgaon',
    'Haryana',
    'India',
    '122016'
),

(
    'Kavita', 'Verma', 'F', 'QA', 'QA',
    'neha.singh@e2ms.com',
    'kavita.verma@e2ms.com',
    '9876543240',
    '1997-07-14',
    '2021-01-08',
    820000,
    5.0,
    'DLF Phase 2',
    'Tower C',
    'Gurgaon',
    'Haryana',
    'India',
    '122002'
),

(
    'Ritika', 'Gupta', 'F', 'QA', 'QA',
    'neha.singh@e2ms.com',
    'ritika.gupta@e2ms.com',
    '9876543241',
    '1999-03-19',
    '2023-08-07',
    650000,
    3.0,
    'Sector 56',
    'Block E',
    'Gurgaon',
    'Haryana',
    'India',
    '122011'
),

(
    'Sonia', 'Mishra', 'F', 'QA', 'QA',
    'neha.singh@e2ms.com',
    'sonia.mishra@e2ms.com',
    '9876543242',
    '1996-02-03',
    '2020-12-15',
    920000,
    6.0,
    'Golf Course Road',
    'Tower A',
    'Gurgaon',
    'Haryana',
    'India',
    '122003'
) , 
---------------------------------------------------------
-- HR Team
---------------------------------------------------------


(
    'Sunita', 'Sharma', 'F', 'HR', 'HR',
    'raj.mehta@e2ms.com',
    'sunita.sharma@e2ms.com',
    '9876543243',
    '1988-06-10',
    '2016-05-16',
    1100000,
    10.0,
    'MG Road',
    'Block A',
    'Bangalore',
    'Karnataka',
    'India',
    '560001'
),

(
    'Reena', 'Gupta', 'F', 'HR', 'HR',
    'sunita.sharma@e2ms.com',
    'reena.gupta@e2ms.com',
    '9876543244',
    '1994-04-08',
    '2019-02-11',
    850000,
    7.0,
    'Whitefield',
    'Phase 2',
    'Bangalore',
    'Karnataka',
    'India',
    '560066'
),

(
    'Sapna', 'Singh', 'F', 'HR', 'HR',
    'sunita.sharma@e2ms.com',
    'sapna.singh@e2ms.com',
    '9876543245',
    '1995-09-27',
    '2020-03-18',
    780000,
    6.0,
    'Electronic City',
    'Phase 1',
    'Bangalore',
    'Karnataka',
    'India',
    '560100'
),

(
    'Alka', 'Verma', 'F', 'HR', 'HR',
    'sunita.sharma@e2ms.com',
    'alka.verma@e2ms.com',
    '9876543246',
    '1993-12-21',
    '2018-08-13',
    900000,
    8.0,
    'Koramangala',
    'Block B',
    'Bangalore',
    'Karnataka',
    'India',
    '560034'
),

(
    'Divya', 'Mishra', 'F', 'HR', 'HR',
    'sunita.sharma@e2ms.com',
    'divya.mishra@e2ms.com',
    '9876543247',
    '1996-10-15',
    '2021-04-19',
    720000,
    5.0,
    'Indiranagar',
    'Sector C',
    'Bangalore',
    'Karnataka',
    'India',
    '560038'
),

(
    'Preeti', 'Sharma', 'F', 'HR', 'HR',
    'sunita.sharma@e2ms.com',
    'preeti.sharma@e2ms.com',
    '9876543248',
    '1994-01-18',
    '2019-06-24',
    830000,
    7.0,
    'JP Nagar',
    'Phase 5',
    'Bangalore',
    'Karnataka',
    'India',
    '560078'
),

(
    'Jyoti', 'Gupta', 'F', 'HR', 'HR',
    'sunita.sharma@e2ms.com',
    'jyoti.gupta@e2ms.com',
    '9876543249',
    '1995-07-06',
    '2020-07-30',
    760000,
    6.0,
    'Yelahanka',
    'Block D',
    'Bangalore',
    'Karnataka',
    'India',
    '560064'
),

(
    'Monika', 'Singh', 'F', 'HR', 'HR',
    'sunita.sharma@e2ms.com',
    'monika.singh@e2ms.com',
    '9876543250',
    '1993-03-28',
    '2018-10-09',
    910000,
    8.0,
    'Hebbal',
    'Tower E',
    'Bangalore',
    'Karnataka',
    'India',
    '560024'
);

---------------------------------------------------------
-- Merge Employee Seed Data
---------------------------------------------------------

MERGE dbo.Employee AS TARGET

USING
(
    SELECT
        ES.FirstName,
        ES.LastName,
        ES.DateOfBirth,
        G.GenderId,
        ES.Email,
        ES.ManagerEmail,
        ES.PhoneNumber,
        ES.AddressLine1,
        ES.AddressLine2,
        ES.City,
        ES.State,
        ES.Country,
        ES.PinCode,
        D.DepartmentId,
        R.RoleId,
        ES.HireDate,
        ES.Salary,
        ES.TotalExperience
    FROM @EmployeeSeed ES

    INNER JOIN dbo.Gender G
        ON G.GenderCode = ES.GenderCode

    INNER JOIN dbo.Department D
        ON D.DepartmentCode = ES.DepartmentCode

    INNER JOIN dbo.Role R
        ON R.RoleCode = ES.RoleCode

) AS SOURCE

ON TARGET.Email = SOURCE.Email

---------------------------------------------------------
-- Update Existing Employee
---------------------------------------------------------

WHEN MATCHED THEN

UPDATE SET

    TARGET.FirstName         = SOURCE.FirstName,
    TARGET.LastName          = SOURCE.LastName,
    TARGET.DateOfBirth       = SOURCE.DateOfBirth,
    TARGET.GenderId          = SOURCE.GenderId,
    TARGET.PhoneNumber       = SOURCE.PhoneNumber,
    TARGET.AddressLine1      = SOURCE.AddressLine1,
    TARGET.AddressLine2      = SOURCE.AddressLine2,
    TARGET.City              = SOURCE.City,
    TARGET.State             = SOURCE.State,
    TARGET.Country           = SOURCE.Country,
    TARGET.PinCode           = SOURCE.PinCode,
    TARGET.DepartmentId      = SOURCE.DepartmentId,
    TARGET.RoleId            = SOURCE.RoleId,
    TARGET.HireDate          = SOURCE.HireDate,
    TARGET.Salary            = SOURCE.Salary,
    TARGET.TotalExperience   = SOURCE.TotalExperience,
    TARGET.ModifiedDate      = SYSDATETIME()

---------------------------------------------------------
-- Insert New Employee
---------------------------------------------------------

WHEN NOT MATCHED BY TARGET THEN

INSERT
(
    FirstName,
    LastName,
    DateOfBirth,
    GenderId,
    Email,
    PhoneNumber,
    AddressLine1,
    AddressLine2,
    City,
    State,
    Country,
    PinCode,
    DepartmentId,
    RoleId,
    ManagerId,
    HireDate,
    Salary,
    TotalExperience,
    IsActive,
    CreatedDate
)

VALUES
(
    SOURCE.FirstName,
    SOURCE.LastName,
    SOURCE.DateOfBirth,
    SOURCE.GenderId,
    SOURCE.Email,
    SOURCE.PhoneNumber,
    SOURCE.AddressLine1,
    SOURCE.AddressLine2,
    SOURCE.City,
    SOURCE.State,
    SOURCE.Country,
    SOURCE.PinCode,
    SOURCE.DepartmentId,
    SOURCE.RoleId,
    NULL,
    SOURCE.HireDate,
    SOURCE.Salary,
    SOURCE.TotalExperience,
    1,
    SYSDATETIME()
);

---------------------------------------------------------
-- Update Manager Hierarchy
---------------------------------------------------------

UPDATE E
SET E.ManagerId = M.EmployeeId
FROM dbo.Employee E
INNER JOIN @EmployeeSeed ES
    ON ES.Email = E.Email
LEFT JOIN dbo.Employee M
    ON M.Email = ES.ManagerEmail;

---------------------------------------------------------
-- Verification
---------------------------------------------------------

SELECT
    E.EmployeeId,
    E.FirstName,
    E.LastName,
    E.Email,
    D.DepartmentName,
    R.RoleName,
    G.GenderName,
    ManagerName =
        CASE
            WHEN M.EmployeeId IS NULL THEN NULL
            ELSE CONCAT(M.FirstName, ' ', M.LastName)
        END,
    E.Salary,
    E.TotalExperience,
    E.IsActive
FROM dbo.Employee E
INNER JOIN dbo.Department D
    ON E.DepartmentId = D.DepartmentId
INNER JOIN dbo.Role R
    ON E.RoleId = R.RoleId
INNER JOIN dbo.Gender G
    ON E.GenderId = G.GenderId
LEFT JOIN dbo.Employee M
    ON E.ManagerId = M.EmployeeId
ORDER BY E.EmployeeId;

SET NOCOUNT OFF;
GO  