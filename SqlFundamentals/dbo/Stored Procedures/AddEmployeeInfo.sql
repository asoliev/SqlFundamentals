/* At least one field (either EmployeeName  or FirstName or LastName) should be not be:
	1) NULL
	2) empty string
	3) contains only ‘space’ symbols */
CREATE PROCEDURE [dbo].[AddEmployeeInfo]
	@EmployeeName NVARCHAR(100) = NULL, --(optional) --nullable --[Employee]
	@FirstName NVARCHAR(50) = '', --(optional) --[Person]
	@LastName NVARCHAR(50) = '', --(optional) --[Person]
	@CompanyName NVARCHAR(20), --(required)! --[Company] -- len < 20
	@Position NVARCHAR(30) = NULL, --(optional) --nullable --[Employee]
	@Street NVARCHAR(50), --(required)! --[Address]
	@City NVARCHAR(20) = NULL, --(optional) --nullable --[Address]
	@State NVARCHAR(50) = NULL, --(optional) --nullable --[Address]
	@ZipCode NVARCHAR(50) = NULL --(optional) --nullable --[Address]
AS
	IF  @EmployeeName IS NULL
	AND @FirstName IS NULL
	AND @LastName IS NULL
		RAISERROR('EmployeeName and FirstName and LastName is NULL', 15, 1);
	ELSE IF @EmployeeName = ''
		AND @FirstName = ''
		AND @LastName = ''
		RAISERROR('EmployeeName, FirstName and LastName is EMPTY', 15, 2);
	ELSE IF TRIM(@EmployeeName) = ''
		AND TRIM(@FirstName) = ''
		AND TRIM(@LastName) = ''
		RAISERROR('EmployeeName, FirstName and LastName contains only ‘SPACE’ symbols', 15, 3);
	ELSE
	BEGIN
		BEGIN TRANSACTION
			INSERT INTO [Person] ([FirstName], [LastName])
			VALUES (@FirstName, @LastName);

			INSERT INTO [Address] ([Street], [City], [State], [ZipCode])
			VALUES (@Street, @City, @State, @ZipCode);

			INSERT INTO [Company] ([Name], [AddressId])
			VALUES (LEFT(@CompanyName, 20), IDENT_CURRENT('Address'));

			INSERT INTO [Employee] ([AddressId], [PersonId], [CompanyName], [Position], [EmployeeName])
			VALUES (IDENT_CURRENT('Address'), IDENT_CURRENT('Person'), LEFT(@CompanyName, 20), @Position, @EmployeeName);
		COMMIT;
	END
RETURN 0