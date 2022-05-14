CREATE TABLE [dbo].[Employee]
(
	[Id] INT IDENTITY NOT NULL PRIMARY KEY,
	[AddressId] INT NOT NULL REFERENCES [dbo].[Address] (Id),
	[PersonId] INT NOT NULL REFERENCES [dbo].[Person] (Id),
	[CompanyName] NVARCHAR(20) NOT NULL,
	[Position] NVARCHAR(30) NULL,
	[EmployeeName] NVARCHAR(100) NULL
)