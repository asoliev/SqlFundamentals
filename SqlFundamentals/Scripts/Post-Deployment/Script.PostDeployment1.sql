/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
BEGIN TRANSACTION

    INSERT INTO [Person] ([FirstName], [LastName])
                    VALUES ('James', 'Belbut');

    INSERT INTO [Address] ([Street], [City], [State], [ZipCode])
                   VALUES ('Phoenix', 'Larne',  'USA', '95003');

    INSERT INTO [Employee] ([AddressId], [PersonId], [CompanyName], [Position], [EmployeeName])
    VALUES (IDENT_CURRENT('Address'), IDENT_CURRENT('Person'), 'Apple', 'Top', 'User');

    INSERT INTO [Company] ([Name], [AddressId])
                   VALUES ('Apple', IDENT_CURRENT('Address'));

COMMIT;