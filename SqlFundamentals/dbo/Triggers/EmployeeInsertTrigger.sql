CREATE TRIGGER [EmployeeInsertTrigger]
	ON [dbo].[Employee]
	FOR INSERT
	AS
	BEGIN
		--SET NOCOUNT ON
		BEGIN TRAN
			INSERT INTO [Company] ([Name], [AddressId])
			SELECT CompanyName, AddressId FROM inserted; --virtual table INSERTED
		COMMIT;
	END
