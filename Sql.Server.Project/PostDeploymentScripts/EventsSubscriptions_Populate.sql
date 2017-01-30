SET IDENTITY_INSERT [dbo].[EventSubscriptions] ON;

MERGE [dbo].[EventSubscriptions] U
USING (VALUES
	(1, '2016-05-12', 1, '0720510a-3cfd-43a3-b232-435e3472f0a9', 0, 1),
	(2, '2016-05-12', 2, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(3, '2016-05-12', 3, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(4, '2016-05-12', 4, '0720510a-3cfd-43a3-b232-435e3472f0a9', 0, 1),
	(5, '2016-05-12', 5, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(6, '2016-05-12', 6, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(7, '2016-05-12', 7, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(8, '2016-05-12', 8, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(9, '2016-05-12', 9, 'b292a04d-9c7d-4d60-b194-cc3896901c9d', 0, 1),
	(10, '2016-05-12', 10, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(11, '2016-05-12', 11, '0720510a-3cfd-43a3-b232-435e3472f0a9', 0, 1),
	(12, '2016-05-12', 12, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(13, '2016-05-12', 13, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(14, '2016-05-12', 14, 'b292a04d-9c7d-4d60-b194-cc3896901c9d', 0, 1),
	(15, '2016-05-12', 15, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(16, '2016-05-12', 16, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(17, '2016-05-12', 17, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(18, '2016-05-12', 18, 'b292a04d-9c7d-4d60-b194-cc3896901c9d', 0, 1),
	(19, '2016-05-12', 19, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(20, '2016-05-12', 20, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(21, '2016-05-12', 21, '0720510a-3cfd-43a3-b232-435e3472f0a9', 0, 1),
	(22, '2016-05-12', 22, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(23, '2016-05-12', 23, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(24, '2016-05-12', 24, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(25, '2016-05-12', 25, 'b292a04d-9c7d-4d60-b194-cc3896901c9d', 0, 1),
	(26, '2016-05-12', 26, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(27, '2016-05-12', 27, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(28, '2016-05-12', 28, '0720510a-3cfd-43a3-b232-435e3472f0a9', 0, 1),
	(29, '2016-05-12', 29, 'd813919f-ba33-44a0-b2e3-4619d70792bf', 0, 1),
	(30, '2016-05-12', 30, 'b292a04d-9c7d-4d60-b194-cc3896901c9d', 0, 1))
	
	as S (Id, Time, Event_Id, Subscriber_Id, Suspended, Type) 
	ON U.Id = S.Id

	WHEN MATCHED AND (
		U.Time <> S.Time
		OR U.Event_Id <> S.Event_Id
		OR U.Subscriber_Id <> S.Subscriber_Id
		OR U.Suspended <> S.Suspended
		OR U.Type <> S.Type) 
	THEN UPDATE SET 
	    U.Time = S.Time,
		U.Event_Id = S.Event_Id,
		U.Subscriber_Id = S.Subscriber_Id,
		U.Suspended = S.Suspended,
		U.Type = S.Type

	WHEN NOT MATCHED BY TARGET
	THEN INSERT (Id, Time, Event_Id, Subscriber_Id, Suspended, Type)
		VALUES (S.Id, S.Time, S.Event_Id, S.Subscriber_Id, S.Suspended, S.Type)
	;
	-- WHEN NOT MATCHED BY SOURCE
	--	THEN DELETE; 

SET IDENTITY_INSERT [dbo].[EventSubscriptions] OFF;