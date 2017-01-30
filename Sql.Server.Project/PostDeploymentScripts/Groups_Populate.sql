SET IDENTITY_INSERT [dbo].[Groups] ON;

MERGE [dbo].[Groups] C
USING (VALUES
	(1, 'Admin','0720510a-3cfd-43a3-b232-435e3472f0a9',NULL,0,'Group for admins'),
	(2, 'User', 'd813919f-ba33-44a0-b2e3-4619d70792bf',NULL,0,'Group for users'))
		
	as S (Id, Name, Creator_Id, Photo, Suspended, About) 
	ON C.Id = S.Id

	WHEN MATCHED AND (
		C.Name <> S.Name
		OR C.Creator_Id <> S.Creator_Id
		OR C.Photo <> S.Photo
		OR C.Suspended <> S.Suspended
		OR C.About <> S.About) 
	THEN UPDATE SET 
	    C.Name = S.Name,
		C.Creator_Id = S.Creator_Id, 
		C.Photo = S.Photo, 
		C.Suspended = S.Suspended, 
		C.About = S.About

	WHEN NOT MATCHED BY TARGET
	THEN INSERT (Id, Name, Creator_Id, Photo, Suspended, About)
		VALUES (S.Id, S.Name, S.Creator_Id, S.Photo, S.Suspended, S.About)
	;
	-- WHEN NOT MATCHED BY SOURCE
	--	THEN DELETE; 

SET IDENTITY_INSERT [dbo].[Groups] OFF;