SET IDENTITY_INSERT [dbo].[Comments] ON;

MERGE [dbo].[Comments] U
USING (VALUES
	(1, '2016-11-12', 'Generations of Rothermere have pretty much got away with murder. Murdoch has the back door key to No 10 and has had every senior UK politician in his pocket for 30 years with the obvious recent exception of Corbyn.Fox News experts stated that Birmingham was one enormous no go area.', 0,'0720510a-3cfd-43a3-b232-435e3472f0a9', 6),
	(2, '2016-11-12', 'I cant honestly read any article in full on this site anymore, its just plain ridiculous now, Trump apparently not grasping the might of the role he is taking on. ', 0,'2fff00a2-fbc6-48db-bce4-dbfd94479247', 6),
	(3, '2016-10-09', 'Regarding the "quark-gluon" plasma "evidence", theoreticians predicted that it would behave like a weakly interacting gas. The RHIC observational evidence says this prediction was WRONG.', 0,'b292a04d-9c7d-4d60-b194-cc3896901c9d', 7),
	(4, '2016-11-10', 'The illustration comes from extremely small scale scattering experiments at a subatomic particle collider. Any comparison to Big Bang phenomena is a truly astronomical STRETCH!!!', 0,'2b0ed59e-570c-42ba-8d83-b140c52c4cc8', 7),
	(5, '2016-10-01', 'A little bit more bend from Juan Mata might have done it. But then a little bit more bend and Petr Cech probably saves it.', 0,'b292a04d-9c7d-4d60-b194-cc3896901c9d', 1),
	(6, '2016-06-02', 'This is promising stuff from Manchester United as Paul Pogba drives through midfield, scattering Arsenal men in his wake. He does take some stopping and it needs three of them to close him out in the end. ', 0,'0720510a-3cfd-43a3-b232-435e3472f0a9', 1),
	(7, '2016-10-07', 'Friday’s Rio Nightlife Pick – Tonight, Palaphita Gávea will be celebrating all sorts of love with the union of Friday and Palaphita together! ', 0,'b292a04d-9c7d-4d60-b194-cc3896901c9d', 2),
	(8, '2016-09-02', 'For the ladies, there is an open bar of SKYY vodka, beer, tropical drinks.',0, '2fff00a2-fbc6-48db-bce4-dbfd94479247', 2),
	(9, '2016-09-07', 'I saw Peter Pan at the RSC as a child - Peter was a very young Mark Rylance. It was probably the first full-length play I ever went to. Can still remember bits of it vividly from 35-odd years ago. ', 0,'b292a04d-9c7d-4d60-b194-cc3896901c9d', 3),
	(10, '2016-01-02', 'This sounds wonderful!',0,'2b0ed59e-570c-42ba-8d83-b140c52c4cc8', 3),
	(11, '2016-09-09', 'Donald Trump is a rich white man pretending to be against the elites', 0,'0720510a-3cfd-43a3-b232-435e3472f0a9', 4),
	(12, '2016-01-02', ' I know, there is a story about a chicken and the sky falling down if I remember correctly.',0,'2fff00a2-fbc6-48db-bce4-dbfd94479247', 4),
	(13, '2016-09-09', 'You can have vegan mayo. It is available in bio shops, but you can also make vegan mayo yourself.', 0,'b292a04d-9c7d-4d60-b194-cc3896901c9d', 5),
	(14, '2016-01-02', ' I think the burger came before the "Big Mac." Anyway, the vendors name is McInnes, so I kind of like that he called it that. Look at it! It is a thing of beauty. LOL! MacDonalds Big Macs look like they have been run over by a truck compared to their advertisments.',0,'b292a04d-9c7d-4d60-b194-cc3896901c9d', 5),
	(15, '2016-09-09', 'This is not, as is often touted, a golden age of theatre making. There is actually a perfect storm of issues here. There are eccentric and expensive patterns of behavior which have become custom and practice, but which disable rather than enable companies from becoming full time.', 0,'b292a04d-9c7d-4d60-b194-cc3896901c9d', 8),
	(16, '2016-01-02', 'I remember attending a D&D a few years ago where lovely Bette Bourne was asked ‘how do you start a company’? The reply was “just book the f**king hall love, then you’ve got to do the f**cking show”. And there’s the point. ',0,'b292a04d-9c7d-4d60-b194-cc3896901c9d', 8),
	(17, '2016-03-09', 'Skiing damages the environment more than any other sport except golf. It is also an extremely expensive sport and "ski towns" are full of shallow, greedy elitists. Why would any decent person want to associate with them?', 0,'0720510a-3cfd-43a3-b232-435e3472f0a9', 9),
	(18, '2016-07-02', 'Nice write up. One piece of advice: dont bring a car. Despite the name, there is no place to park in Park City. ',0,'b292a04d-9c7d-4d60-b194-cc3896901c9d', 9))

	
	as S (Id, Time, Text, Suspended, Creator_Id, Event_Id) 
	ON U.Id = S.Id
	
	WHEN MATCHED AND (
		U.Time <> S.Time
		OR U.Text <> S.Text
		OR U.Suspended <> S.Suspended
		OR U.Creator_Id <> S.Creator_Id
		OR U.Event_Id <> S.Event_Id) 
	THEN UPDATE SET 
	    U.Time = S.Time,
		U.Text = S.Text, 
		U.Suspended = S.Suspended, 
		U.Creator_Id = S.Creator_Id, 
		U.Event_Id = S.Event_Id

	WHEN NOT MATCHED BY TARGET
	THEN INSERT (Id, Time, Text, Suspended, Creator_Id, Event_Id)
		VALUES (S.Id, S.Time, S.Text, S.Suspended, S.Creator_Id, S.Event_Id)
	;
	-- WHEN NOT MATCHED BY SOURCE
	--	THEN DELETE; 
	SET IDENTITY_INSERT [dbo].[Comments] OFF;