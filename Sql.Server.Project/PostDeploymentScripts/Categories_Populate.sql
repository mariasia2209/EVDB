SET IDENTITY_INSERT [dbo].[Categories] ON;

MERGE [dbo].[Categories] C
USING (VALUES
	(1, 'Sport'),
	(2, 'Nightlife'),
	(3, 'Family'),
	(4, 'Politics'),
	(5, 'Health'),
	(6, 'Tech'),
	(7, 'Science'),
	(8, 'Arts'),
	(9, 'Travel'))
	
	as S (Id, Name) 
	ON C.Id = S.Id
	
	WHEN MATCHED AND (
		C.Name <> S.Name) 
	THEN UPDATE SET 
	    C.Name = S.Name

	WHEN NOT MATCHED BY TARGET
	THEN INSERT (Id, Name)
		VALUES (S.Id, S.Name)
	;
	-- WHEN NOT MATCHED BY SOURCE
	--	THEN DELETE; 

SET IDENTITY_INSERT [dbo].[Categories] OFF;