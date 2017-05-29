CREATE DATABASE [PreviewDemoDB]
GO


USE [PreviewDemoDB]
GO

CREATE SCHEMA [HumanResources]
GO
CREATE SCHEMA [Person]
GO
CREATE TYPE [dbo].[Flag] FROM [bit] NOT NULL
GO
CREATE TYPE [dbo].[Name] FROM [nvarchar](50) NULL
GO
CREATE TYPE [dbo].[NameStyle] FROM [bit] NOT NULL
GO
CREATE TYPE [dbo].[Phone] FROM [nvarchar](25) NULL
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HumanResources].[Department]
(
	[DepartmentID] [smallint] IDENTITY(1,1) NOT NULL,
	[Name] [dbo].[Name] NOT NULL,
	[GroupName] [dbo].[Name] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HumanResources].[Employee]
(
	[BusinessEntityID] [int] NOT NULL,
	[OrganizationNode] [hierarchyid] NULL,
	[OrganizationLevel]  AS ([OrganizationNode].[GetLevel]()),
	[JobTitle] [nvarchar](50) NOT NULL,
	[HireDate] [date] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HumanResources].[EmployeeDepartmentHistory]
(
	[BusinessEntityID] [int] NOT NULL,
	[DepartmentID] [smallint] NOT NULL,
	[ShiftID] [tinyint] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[EmailAddress]
(
	[BusinessEntityID] [int] NOT NULL,
	[EmailAddressID] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[Person]
(
	[BusinessEntityID] [int] NOT NULL,
	[FirstName] [dbo].[Name] NOT NULL,
	[LastName] [dbo].[Name] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Person].[PersonPhone]
(
	[BusinessEntityID] [int] NOT NULL,
	[PhoneNumber] [dbo].[Phone] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  View [HumanResources].[vEmployee]    Script Date: 5/26/2017 9:57:33 PM ******/
CREATE VIEW [HumanResources].[vEmployee]
AS
	SELECT e.[BusinessEntityID]
	, e.[OrganizationNode]
	, e.[OrganizationLevel]
    , p.[FirstName]
    , p.[LastName]
    , e.[JobTitle]  
    , pp.[PhoneNumber]
    , ea.[EmailAddress]
	, d.[DepartmentID]
	, d.[GroupName]
	, d.[Name] as DepartmentName
	FROM [HumanResources].[Employee] e INNER JOIN [Person].[Person] p ON p.[BusinessEntityID] = e.[BusinessEntityID] LEFT OUTER JOIN [Person].[PersonPhone] pp ON pp.BusinessEntityID = p.[BusinessEntityID] LEFT OUTER JOIN [Person].[EmailAddress] ea ON p.[BusinessEntityID] = ea.[BusinessEntityID] INNER JOIN [HumanResources].[EmployeeDepartmentHistory] edh ON e.[BusinessEntityID] = edh.[BusinessEntityID] INNER JOIN [HumanResources].[Department] d ON edh.[DepartmentID] = d.[DepartmentID]
	WHERE edh.EndDate IS NULL

GO
SET IDENTITY_INSERT [HumanResources].[Department] ON
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(1, N'Engineering', N'Research and Development')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(2, N'Tool Design', N'Research and Development')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(3, N'Sales', N'Sales and Marketing')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(4, N'Marketing', N'Sales and Marketing')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(5, N'Purchasing', N'Inventory Management')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(6, N'Research and Development', N'Research and Development')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(7, N'Production', N'Manufacturing')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(8, N'Production Control', N'Manufacturing')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(9, N'Human Resources', N'Executive General and Administration')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(10, N'Finance', N'Executive General and Administration')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(11, N'Information Services', N'Executive General and Administration')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(12, N'Document Control', N'Quality Assurance')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(13, N'Quality Assurance', N'Quality Assurance')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(14, N'Facilities and Maintenance', N'Executive General and Administration')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(15, N'Shipping and Receiving', N'Inventory Management')
INSERT [HumanResources].[Department]
	([DepartmentID], [Name], [GroupName])
VALUES
	(16, N'Executive', N'Executive General and Administration')
SET IDENTITY_INSERT [HumanResources].[Department] OFF
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(1, 0x, N'Chief Executive Officer', CAST(N'2009-01-14' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(2, 0x58, N'Vice President of Engineering', CAST(N'2008-01-31' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(3, 0x5AC0, N'Engineering Manager', CAST(N'2007-11-11' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(4, 0x5AD6, N'Senior Tool Designer', CAST(N'2007-12-05' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(5, 0x5ADA, N'Design Engineer', CAST(N'2008-01-06' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(6, 0x5ADE, N'Design Engineer', CAST(N'2008-01-24' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(7, 0x5AE1, N'Research and Development Manager', CAST(N'2009-02-08' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(8, 0x5AE158, N'Research and Development Engineer', CAST(N'2008-12-29' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(9, 0x5AE168, N'Research and Development Engineer', CAST(N'2009-01-16' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(10, 0x5AE178, N'Research and Development Manager', CAST(N'2009-05-03' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(11, 0x5AE3, N'Senior Tool Designer', CAST(N'2010-12-05' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(12, 0x5AE358, N'Tool Designer', CAST(N'2007-12-11' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(13, 0x5AE368, N'Tool Designer', CAST(N'2010-12-23' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(14, 0x5AE5, N'Senior Design Engineer', CAST(N'2010-12-30' AS Date))
INSERT [HumanResources].[Employee]
	([BusinessEntityID], [OrganizationNode], [JobTitle], [HireDate])
VALUES
	(15, 0x5AE7, N'Design Engineer', CAST(N'2011-01-18' AS Date))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(1, 16, 1, CAST(N'2009-01-14' AS Date), NULL, CAST(N'2009-01-13T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(2, 1, 1, CAST(N'2008-01-31' AS Date), NULL, CAST(N'2008-01-30T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(3, 1, 1, CAST(N'2007-11-11' AS Date), NULL, CAST(N'2007-11-10T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(4, 1, 1, CAST(N'2007-12-05' AS Date), CAST(N'2010-05-30' AS Date), CAST(N'2010-05-28T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(4, 2, 1, CAST(N'2010-05-31' AS Date), NULL, CAST(N'2010-05-30T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(5, 1, 1, CAST(N'2008-01-06' AS Date), NULL, CAST(N'2008-01-05T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(6, 1, 1, CAST(N'2008-01-24' AS Date), NULL, CAST(N'2008-01-23T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(7, 6, 1, CAST(N'2009-02-08' AS Date), NULL, CAST(N'2009-02-07T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(8, 6, 1, CAST(N'2008-12-29' AS Date), NULL, CAST(N'2008-12-28T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(9, 6, 1, CAST(N'2009-01-16' AS Date), NULL, CAST(N'2009-01-15T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(10, 6, 1, CAST(N'2009-05-03' AS Date), NULL, CAST(N'2009-05-02T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(11, 2, 1, CAST(N'2010-12-05' AS Date), NULL, CAST(N'2010-12-04T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(12, 2, 1, CAST(N'2007-12-11' AS Date), NULL, CAST(N'2007-12-10T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(13, 2, 1, CAST(N'2010-12-23' AS Date), NULL, CAST(N'2010-12-22T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(14, 1, 1, CAST(N'2010-12-30' AS Date), NULL, CAST(N'2010-12-29T00:00:00.000' AS DateTime))
INSERT [HumanResources].[EmployeeDepartmentHistory]
	([BusinessEntityID], [DepartmentID], [ShiftID], [StartDate], [EndDate], [ModifiedDate])
VALUES
	(15, 1, 1, CAST(N'2011-01-18' AS Date), NULL, CAST(N'2011-01-17T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [Person].[EmailAddress] ON
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(1, 1, N'ken0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(2, 2, N'terri0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(3, 3, N'roberto0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(4, 4, N'rob0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(5, 5, N'gail0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(6, 6, N'jossef0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(7, 7, N'dylan0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(8, 8, N'diane1@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(9, 9, N'gigi0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(10, 10, N'michael6@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(11, 11, N'ovidiu0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(12, 12, N'thierry0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(13, 13, N'janice0@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(14, 14, N'michael8@adventure-works.com')
INSERT [Person].[EmailAddress]
	([BusinessEntityID], [EmailAddressID], [EmailAddress])
VALUES
	(15, 15, N'sharon0@adventure-works.com')
SET IDENTITY_INSERT [Person].[EmailAddress] OFF
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(1, N'Ken', N'Sánchez')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(2, N'Terri', N'Duffy')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(3, N'Roberto', N'Tamburello')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(4, N'Rob', N'Walters')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(5, N'Gail', N'Erickson')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(6, N'Jossef', N'Goldberg')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(7, N'Dylan', N'Miller')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(8, N'Diane', N'Margheim')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(9, N'Gigi', N'Matthew')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(10, N'Michael', N'Raheem')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(11, N'Ovidiu', N'Cracium')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(12, N'Thierry', N'D''Hers')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(13, N'Janice', N'Galvin')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(14, N'Michael', N'Sullivan')
INSERT [Person].[Person]
	([BusinessEntityID], [FirstName], [LastName])
VALUES
	(15, N'Sharon', N'Salavaria')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(1, N'697-555-0142')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(2, N'819-555-0175')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(3, N'212-555-0187')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(4, N'612-555-0100')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(5, N'849-555-0139')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(6, N'122-555-0189')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(7, N'181-555-0156')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(8, N'815-555-0138')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(9, N'185-555-0186')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(10, N'330-555-2568')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(11, N'719-555-0181')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(12, N'168-555-0183')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(13, N'473-555-0117')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(14, N'465-555-0156')
INSERT [Person].[PersonPhone]
	([BusinessEntityID], [PhoneNumber])
VALUES
	(15, N'970-555-0138')
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [HumanResources].[uspGetDirectManager]
	@BusinessEntityID int
AS
SELECT m.[BusinessEntityID]
	, m.[OrganizationNode]
	, m.[OrganizationLevel]
    , m.[FirstName]
    , m.[LastName]
    , m.[JobTitle]  
    , m.[PhoneNumber]
    , m.[EmailAddress]
	, m.[DepartmentID]
	, m.[GroupName]
	, m.[DepartmentName]
FROM [HumanResources].[vEmployee] m INNER JOIN [HumanResources].[vEmployee] e ON m.[OrganizationNode] = e.[OrganizationNode].GetAncestor(1)
where e.BusinessEntityID = @BusinessEntityID
RETURN 0

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [HumanResources].[uspGetDirectReports]
	@BusinessEntityID int
AS
DECLARE @hid hierarchyid
SET @hid = (SELECT Top (1)
	m.[OrganizationNode]
from [HumanResources].[vEmployee] m
where m.[BusinessEntityID] = @BusinessEntityID)
SELECT e.[BusinessEntityID]
	, e.[OrganizationNode]
	, e.[OrganizationLevel]
    , e.[FirstName]
    , e.[LastName]
    , e.[JobTitle]  
    , e.[PhoneNumber]
    , e.[EmailAddress]
	, e.[DepartmentID]
	, e.[GroupName]
	, e.[DepartmentName]
FROM [HumanResources].[vEmployee] e
WHERE e.[OrganizationNode].GetAncestor(1) = @hid
RETURN 0

GO
ALTER DATABASE [PreviewDemoDB] SET  READ_WRITE 
GO

SELECT name, state_desc FROM sys.databases;
GO

SELECT * FROM HumanResources.vEmployee;
GO