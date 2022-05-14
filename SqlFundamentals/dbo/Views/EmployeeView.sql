CREATE VIEW [dbo].[EmployeeView] AS
	SELECT 
		ISNULL(epl.[EmployeeName], 
			CONCAT_WS(' ', prs.FirstName, prs.LastName)
		) EmployeeFullName,
		CONCAT_WS(', ',
			CONCAT_WS('_', adr.ZipCode, adr.[State]),
			CONCAT_WS('-', adr.City, adr.Street)
		) EmployeeFullAddress,
		CONCAT(
			epl.CompanyName,
			'(', epl.Position, ')'
		) EmployeeCompanyInfo
	FROM [Employee] epl
	INNER JOIN [Person] prs ON prs.Id = epl.PersonId
	INNER JOIN [Address] adr ON adr.Id = epl.AddressId
	ORDER BY epl.CompanyName, adr.City OFFSET 0 ROWS