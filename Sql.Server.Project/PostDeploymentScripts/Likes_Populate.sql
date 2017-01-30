SET IDENTITY_INSERT [dbo].[Likes] ON;

MERGE [dbo].[Likes] C
USING (VALUES
	(1, '2016-05-12', 1, '0720510a-3cfd-43a3-b232-435e3472f0a9'),
	(2, '2016-05-12', 2, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(3, '2016-05-12', 3, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(4, '2016-05-12', 4, '0720510a-3cfd-43a3-b232-435e3472f0a9'),
	(5, '2016-05-12', 5, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(6, '2016-05-12', 6, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(7, '2016-05-12', 7, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(8, '2016-05-12', 8, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(9, '2016-05-12', 9, 'b292a04d-9c7d-4d60-b194-cc3896901c9d'),
	(10, '2016-05-12', 10, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(11, '2016-05-12', 11, '0720510a-3cfd-43a3-b232-435e3472f0a9'),
	(12, '2016-05-12', 12, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(13, '2016-05-12', 13, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(14, '2016-05-12', 14, 'b292a04d-9c7d-4d60-b194-cc3896901c9d'),
	(15, '2016-05-12', 15, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(16, '2016-05-12', 16, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(17, '2016-05-12', 17, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(18, '2016-05-12', 18, 'b292a04d-9c7d-4d60-b194-cc3896901c9d'),
	(19, '2016-05-12', 19, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(20, '2016-05-12', 20, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(21, '2016-05-12', 21, '0720510a-3cfd-43a3-b232-435e3472f0a9'),
	(22, '2016-05-12', 22, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(23, '2016-05-12', 23, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(24, '2016-05-12', 24, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(25, '2016-05-12', 25, 'b292a04d-9c7d-4d60-b194-cc3896901c9d'),
	(26, '2016-05-12', 26, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(27, '2016-05-12', 27, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(28, '2016-05-12', 28, '0720510a-3cfd-43a3-b232-435e3472f0a9'),
	(29, '2016-05-12', 29, 'd813919f-ba33-44a0-b2e3-4619d70792bf'),
	(30, '2016-05-12', 30, 'b292a04d-9c7d-4d60-b194-cc3896901c9d'))
	
	as S (Id, Time, LikedEvent_Id, Liker_Id) 
	ON C.Id = S.Id

	WHEN MATCHED AND (
		C.Time <> S.Time
		OR C.LikedEvent_Id <> S.LikedEvent_Id
		OR C.Liker_Id <> S.Liker_Id) 
	THEN UPDATE SET 
	    C.Time = S.Time,
		C.LikedEvent_Id = S.LikedEvent_Id, 
		C.Liker_Id = S.Liker_Id

	WHEN NOT MATCHED BY TARGET
	THEN INSERT (Id, Time, LikedEvent_Id, Liker_Id)
		VALUES (S.Id, S.Time, S.LikedEvent_Id, S.Liker_Id)
	;
	-- WHEN NOT MATCHED BY SOURCE
	--	THEN DELETE; 

SET IDENTITY_INSERT [dbo].[Likes] OFF;