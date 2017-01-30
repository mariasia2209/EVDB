
MERGE [dbo].[UserGroups] C
USING (VALUES
	('d813919f-ba33-44a0-b2e3-4619d70792bf',1),
	('0720510a-3cfd-43a3-b232-435e3472f0a9',1),
	('b292a04d-9c7d-4d60-b194-cc3896901c9d',1),
	('2b0ed59e-570c-42ba-8d83-b140c52c4cc8',2),
	('2fff00a2-fbc6-48db-bce4-dbfd94479247',2))
	
	as S (User_Id, Group_Id) 
	ON C.User_Id = S.User_Id
	
	WHEN MATCHED AND (
		C.User_Id <> S.User_Id) 
	THEN UPDATE SET 
	    C.User_Id = S.User_Id

	WHEN NOT MATCHED BY TARGET
	THEN INSERT (User_Id, Group_Id)
		VALUES (S.User_Id, S.Group_Id)
	;
	-- WHEN NOT MATCHED BY SOURCE
	--	THEN DELETE; 

