﻿/*
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
PRINT N'Populate data in Users table...'
MERGE [dbo].[Users] U
USING (VALUES
	('d813919f-ba33-44a0-b2e3-4619d70792bf', 'martahryvniak@gmail.com', 'Marta','Hryvniak','martahryvniak@gmail.com','APFipQIYjmdWbtiJtbgpmZPUmU15PbScut5CqykRLxd4+BuuY6jab0CTsh+QO/VyXA==',0,NULL,'2016-05-13',0,'e3b4539b-effd-468e-81f3-d0f0ca5991de',NULL,0,0,NULL,0,0,1,0,1,NULL,NULL),
	('0720510a-3cfd-43a3-b232-435e3472f0a9', 'maksym08@gmail.com', 'Maksym', 'Kyselytsia', 'maksym08@gmail.com', 'ALwE5oHXOV9bBdonogyIAO5CHM3XYgKgK+gsTYjpPtfgFPOrQ9cvwj4vt2poU2REGQ==', 0, NULL, '2016-05-13', 0, '9e75cb88-b13f-4a66-aa6e-f3d478acd5d5',NULL,0, 0, NULL,1,0,1,1,1,NULL,NULL),
	('2b0ed59e-570c-42ba-8d83-b140c52c4cc8', 'vira.dovbniak@gmail.com', 'Vira', 'Dovbniak', 'vira.dovbniak@gmail.com', 'AJdsHZXsbMRISJx77pu7Y6aug2ERxURoQjiPdGklYdviGODxjCxfqUVQ0Z78DBz/mQ==', 0, NULL,'2016-05-13', 0, 'bf1275d1-8437-4535-b13d-7027b8f40d18', NULL, 0, 0, NULL, 1, 0, 1, 0, 1,NULL,NULL),		
	('b292a04d-9c7d-4d60-b194-cc3896901c9d', 'vova.kachanovsky@gmail.com', 'Vova', 'Kachanovsky', 'vova.kachanovsky@gmail.com', 'AHJRsT/94WCj4qHq4Ex3IdQSWZg2dAFUw81m4AteQpEY2S0djI9VCSLT1KCD3L6aow==', 0, NULL, '2016-05-13', 0,	'c1215ff0-5b68-4ce7-befe-5a24d1ed50ee',NULL,0, 0, NULL,1,0,1,1,1,NULL,NULL),
	('2fff00a2-fbc6-48db-bce4-dbfd94479247', 'vova.kalyniak@gmail.com','Vova', 'Kalyniak', 'vova.kalyniak@gmail.com', 'ABfgT1qXJa3E/Nu2Px8JiZtLwS0doKhPTjVPoezQVILJy0fZOKw6vAz2KhA5vquIOg==', 0, NULL,'2016-05-13', 0, '5f4d3247-d1bf-4f1d-a589-21a50b607de0',NULL,0, 0, NULL,1,0,1,1,1,NULL,NULL))
	
	as S (Id, UserName, FirstName, SecondName, Email, PasswordHash, IsBanned, Image, Birthdate, EmailConfirmed, SecurityStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEndDateUtc, LockoutEnabled, AccessFailedCount, IsActive, Sex, LocationId, About, GoogleToken) 
	ON U.Id = S.Id
	
	WHEN MATCHED AND (
		U.UserName <> S.UserName
		OR U.FirstName <> S.FirstName
		OR U.SecondName <> S.SecondName
		OR U.Email <> S.Email
		OR U.PasswordHash <> S.PasswordHash) 
	THEN UPDATE SET 
	    U.UserName = S.UserName,
		U.FirstName = S.FirstName, 
		U.SecondName = S.SecondName, 
		U.Email = S.Email, 
		U.PasswordHash = S.PasswordHash,
		U.ModifiedDate = GETDATE()

	WHEN NOT MATCHED BY TARGET
	THEN INSERT (Id, CreatedDate, UserName, FirstName, SecondName, Email, PasswordHash, IsBanned, Image,  Birthdate, EmailConfirmed, SecurityStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEndDateUtc, LockoutEnabled, AccessFailedCount, IsActive, Sex, LocationId, About, GoogleToken)
		VALUES (S.Id, GETDATE(), S.UserName, S.FirstName, S.SecondName, S.Email, S.PasswordHash, S.IsBanned, S.Image, S.Birthdate, S.EmailConfirmed, S.SecurityStamp, S.PhoneNumber, S.PhoneNumberConfirmed, S.TwoFactorEnabled, S.LockoutEndDateUtc, S.LockoutEnabled, S.AccessFailedCount, S.IsActive, S.Sex, S.LocationId, S.About, S.GoogleToken)
	;
	-- WHEN NOT MATCHED BY SOURCE
	--	THEN DELETE; 

PRINT N'Populate data in Categories table...'
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

PRINT N'Populate data in Events table...'
SET ansi_warnings OFF
SET IDENTITY_INSERT [dbo].[Events] ON;

MERGE [dbo].[Events] U
USING (VALUES
	(1, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Cristiano Ronaldo is 39th career hat-trick gave Real Madrid a derby win over city rivals Atletico to increase their lead at the top of La Liga.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'Real-Madrids-German-midfielder-Toni-Kro.jpg', 'Football match: Sporting CP	-	Real Madrid', 100, 1, NULL, NULL, NULL, NULL),
	(2, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Andy Murray will face Novak Djokovic with the ATP World Tour Finals title and year-end number one ranking at stake on Sunday.',0,'2b0ed59e-570c-42ba-8d83-b140c52c4cc8',NULL,NULL,'novak-andy-600-04-1465023015.jpg', 'Tennis: Andy Murray v Novak Djokovic', 100, 1, NULL, NULL, NULL, NULL),
	(3, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Wayne Rooney claims he suffered disgraceful treatment on England duty',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'manars12pa_1390815i.jpg', 'Football: Manchester United - Arsenal', 100, 1, NULL, NULL, NULL, NULL),
	(4, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'England forwards coach Steve Borthwick looks set to join the British and Irish Lions coaching team for next year tour of New Zealand.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'jimmy-adams-hampshire-county-championship_3476502.jpg', 'Cricket: Durham v Hampshire', 100, 1, NULL, NULL, NULL, NULL),
	(5, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Amethyst Club A-GoGo re-opened on Soi LK Metro on 3rd November but has already gone dark. It was reported dark on the 15th and 16th of November.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'slider-9.jpg', 'Party in disco club LK Metro', 100, 2, NULL, NULL, NULL, NULL),
	(6, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'A new bar has opened on Soi 6 named Miss B Haven. It opened on the 11th November and is located mid soi on the north side, next door to Chilli Bar',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'haven_01.jpg', 'Party in disco club Haven', 100, 2, NULL, NULL, NULL, NULL),
	(7, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Lita Bar , the ladyboy bar that had closed on Soi BJ off Walking Street, has reopened on Soi Post Office (Soi 13/2).',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'72234-640x360-640-cargo.jpg', 'Party in disco club More', 100, 2, NULL, NULL, NULL, NULL),
	(8, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'On Soi Diamond the previous location of The Sea gogo has become Diamond Sports Bar, which is always deserted when I walk past.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'Ibiza-club.jpg', 'Party in disco club Ibiza', 100, 2, NULL, NULL, NULL, NULL),
	(9, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'In an extract from her new book Christmas Days, Jeanette Winterson shares her childhood memories and favourite seasonal recipes, including Mum’s mince pies and Dads sherry trifle',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'JeanetteWinterson_1548541c.jpg', 'Christmas stories with  Winterson family', 100, 3, NULL, NULL, NULL, NULL),
 	(10, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'The director Sally Cookson is renowned for turning family shows upside down. As her National Theatre Peter Pan opens, she talks GoogleId why she made Wendy the real star of the show',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'allison-wiliams-peter-pan-hed-2014.jpg', 'Watching "Peter Pan"', 100, 3, NULL, NULL, NULL, NULL),
	(11, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'The mother who left all her money to animals rather than her daughter. The man forced to read out a catalogue of his father failings. Wills can leave emotional scars',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'picnic-with-family.jpg', 'Picnic with family', 100, 3, NULL, NULL, NULL, NULL),
	(12, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Be honest with yourself GoogleId why you dislike them, try to befriend them. And never let your child know you feel that way',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'picnic-with-children.jpg', 'Picnic with children', 100, 3, NULL, NULL, NULL, NULL),
	(13, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'President-elect Trump will have GoogleId 4,000 government positions to fill, including some of the most important posts in the US government. His team has been at work coming up with possible candidates for the top jobs, but there is a smaller universe of Republicans who were close to his campaign. Much of the Washington establishment kept him at arms length. Others, including some former GOP cabinet secretaries, rejected him entirely.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'Reuters-Donald-Trump-Black-pastors.jpg', 'Meeting with Trump', 100, 4, NULL, NULL, NULL, NULL),
	(14, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Washington (CNN)Retired Army Lt. Gen. Michael Flynn, President-elect Donald Trump preferred choice for National Security Adviser, was running a company that was lobbying on behalf of foreign clients even as he was receiving classified intelligence briefings during the campaign.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'MeetingMichaelFlynn.jpg', 'Meeting Michael Flynn with congress', 100, 4, NULL, NULL, NULL, NULL),
	(15, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'"He has the confidence of our caucus and will do a great job for our candidates running in 2018. The map is tough for Democrats, but I have no doubt that Senator-elect Van Hollen is up to the task," said Senate Minority Leader Chuck Schumer, himself the new head of the Senate Democrats.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'MeetingPoliticsGroup.jpg', 'Meeting politics group', 100, 4, NULL, NULL, NULL, NULL),
	(16, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Japanese Prime Minister Shinzo Abe said Thursday he had a "very candid discussion" with President-elect Donald Trump, during a brief press availability following their in-person meeting.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'MeetingDonaldTrumpWithJapanPolitisians.jpg', 'Meeting Donald Trump with Japan politisians', 100, 4, NULL, NULL, NULL, NULL),
	(17, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Even though Scott Kaiser had a healthy diet and stayed active with regular cardio and weight lifting, he realized he was developing a double chin, something that also seemed to plague other men in his family.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'Dr-A-P-J-abdul-Kalam.jpg', 'Free lecture from famous doctors', 100, 5, NULL, NULL, NULL, NULL),
	(18, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Leeza Gibbons may be best known for her co-hosting role on “Entertainment Tonight” or for winning “The Apprentice” in the final season that Donald Trump hosted, but now, she is making name for herself in the medical space by raising awareness for caregivers.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'susskindphysics.jpg', 'Free lecture from famous doctors', 100, 5, NULL, NULL, NULL, NULL),
	(19, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'People who rely on food pantries for their meals may not receive enough dairy, fruits or vegetables to get all the nutrients they need for a healthy diet, two recent studies suggest.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'hqdefault.jpg', 'Free lecture from famous doctors', 100, 5, NULL, NULL, NULL, NULL),
	(20, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'NEW ORLEANS — Moderate drinking may have positive effects on some aspects of heart health beyond those seen with light drinking, a new study from Australia finds. The people in the study who drank 10 to 20 grams of alcohol per day were less likely to develop a condition called metabolic syndrome, which is linked with heart disease, compared with the people who drank less than 10 g of alcohol per day. In the U.S., a standard drink contains GoogleId 14 g of alcohol, according to the National Institute on Alcohol Abuse and Alcoholism.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'34A6BC9F00000578-3611506-Drinking_alcohol.jpg', 'Free lecture from famous doctors about alcohol', 100, 5, NULL, NULL, NULL, NULL),
	(21, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Service providers have begun phasing out contracts, which is a blessing and a curse. On the one hand, there are no strict rules, no automatic renewals, and no elaborate termination steps. Then again, some people have to buy their expensive smartphones outright, where once they were heavily discounted. Until recently, your only options were to pay in advance with companies like T-Mobile or Cricket.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'635821216948056369-websummit.jpg', 'Scientific-tech conference', 100, 6, NULL, NULL, NULL, NULL),
	(22, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'The most advanced weather satellite ever built rocketed into space Saturday night, part of an $11 billion effort to revolutionize forecasting and save lives.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'ScientificConference.jpg', 'Scientific conference', 100, 7, NULL, NULL, NULL, NULL),
	(23, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Pictures at an Exhibition presents Descriptions of one notable show every weekday ',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'PaintingExhibition.jpg', 'Painting exhibition', 100, 8, NULL, NULL, NULL, NULL),
	(24, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'With the Museum of Modern Art in New York preparing to open a much-anticipated Francis Picabia retrospective on Monday, we turn back to the September 1970 issue of ARTnews, in which Philip Pearlstein wrote an essay GoogleId the artist. ',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'33341_2595749.jpg', 'Exhibition of landscapes', 100, 8, NULL, NULL, NULL, NULL),
	(25, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'The Museum of Contemporary Art, Chicago announced today that Dimitris Daskalopoulos and Nickol Hackett joined its board of trustees on October 31. Daskalopoulos, an ARTnews Top 200 collector, is the founder and member of the board of the Greek investments',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'2b39eefca4cdbc62580a55100b8928e8.jpg', 'Portrait exhibition', 100, 8, NULL, NULL, NULL, NULL),
	(26, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'With the President-Elect’s administration filling up with Islamophobes and white nationalists, I’m looking for laughs where I can find them these days. And, bless it, the presidential pool report from Berlin, where President Barack Obama just visited with world leaders.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'Food-Beyond-the-Still-Life-2012.jpg', 'Still life exhibition', 100, 8, NULL, NULL, NULL, NULL),
	(27, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'Passengers trying to fly in and out of JFK, La Guardia and Newark airports for the holidays better buckle up for disappointments.A new study shows that flights involving the three New York City-area airports are more than twice as likely to be canceled than the national average during the Thanksgiving and Christmas holiday season.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'TourToUSA.jpg', 'Tour to USA', 100, 9, NULL, NULL, NULL, NULL),
	(28, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'American travelers are changing the international vacation destination map as global terror attacks have altered perceived safety risks, a survey released this week from travel insurance provider Allianz Global Assistance found.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'GRJ-A4plus-EFC-Grand-Tour-of-New-England-Canada-in-the-Fall.jpg', 'Tour to Canada', 100, 9, NULL, NULL, NULL, NULL),
	(29, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'One of the biggest diamonds ever found is on display at the Smithsonian National Museum of Natural History. The Foxfire diamond is the largest uncut, gem-quality diamond ever mined in North America. It weighs 187 carats, or 1.3 ounces.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'Europa-3.jpg', 'Tour to Europa', 100, 9, NULL, NULL, NULL, NULL),
	(30, '2016-10-15', '2016-10-15','2016-10-15',NULL,NULL,NULL,'BOSTON –  Authorities say the death of an elderly man on a JetBlue flight from Florida to Boston is not considered suspicious. Massachusetts State Police spokesman David Procopio says the man, whose name was not immediately released, died of apparent natural causes during the flight Thursday from Fort Myers.',0,'d813919f-ba33-44a0-b2e3-4619d70792bf',NULL,NULL,'20359-1.jpg', 'Tour to Florida', 100, 9, NULL, NULL, NULL, NULL))
	
	as S (Id, CreationTime, EventBegin, EventEnd, Location, Latitude, Longitude, Description, Suspended, Creator_Id, Stream_Id, Organizer_Id, Image, Name, Priority, Category_Id, BackgroundColor, TitleColor, EventStatus, GoogleId) 
	ON U.Id = S.Id
	
	WHEN MATCHED AND (
		U.CreationTime <> S.CreationTime
		OR U.EventBegin <> S.EventBegin
		OR U.EventEnd <> S.EventEnd
		OR U.Location <> S.Location
		OR U.Latitude <> S.Latitude
		OR ISNULL(U.Image,'') <> ISNULL(S.Image,'')) 
	THEN UPDATE SET 
	    U.CreationTime = S.CreationTime,
		U.EventBegin = S.EventBegin, 
		U.EventEnd = S.EventEnd, 
		U.Location = S.Location, 
		U.Latitude = S.Latitude,
		U.Image = S.Image

	WHEN NOT MATCHED BY TARGET
	THEN INSERT (Id, CreationTime, EventBegin, EventEnd, Location, Latitude, Longitude, Description,  Suspended, Creator_Id, Stream_Id, Organizer_Id, Image, Name, Priority, Category_Id, BackgroundColor, TitleColor, EventStatus, GoogleId)
		VALUES (S.Id, S.CreationTime, S.EventBegin, S.EventEnd, S.Location, S.Latitude, S.Longitude, S.Description, S.Suspended, S.Creator_Id, S.Stream_Id, S.Organizer_Id, S.Image, S.Name, S.Priority, S.Category_Id, S.BackgroundColor, S.TitleColor, S.EventStatus, S.GoogleId)
	;
	-- WHEN NOT MATCHED BY SOURCE
	--	THEN DELETE; 
	SET IDENTITY_INSERT [dbo].[Events] OFF;

PRINT N'Populate data in Comments table...'
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

PRINT N'Populate data in News table...'
SET ansi_warnings OFF
SET IDENTITY_INSERT [dbo].[News] ON;

MERGE [dbo].[News] U
USING (VALUES
	(1, 'Ronaldo scores hat-trick in Madrid derby', 'Cristiano Ronaldo is 39th career hat-trick gave Real Madrid a derby win over city rivals Atletico to increase their lead at the top of La Liga.', NULL, 1,'2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(2, 'Andy Murray v Novak Djokovic', 'Andy Murray will face Novak Djokovic with the ATP World Tour Finals title and year-end number one ranking at stake on Sunday.', NULL, 2, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(3, 'Wayne Rooney', 'Wayne Rooney claims he suffered disgraceful treatment on England duty',  NULL, 3, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(4, 'England forwards coach Steve Borthwick set to join 2017 Lions set-up', 'England forwards coach Steve Borthwick looks set to join the British and Irish Lions coaching team for next year tour of New Zealand.',  NULL, 4, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(5, 'Amethyst goes Dark on Soi LK Metro', 'Amethyst Club A-GoGo re-opened on Soi LK Metro on 3rd November but has already gone dark. It was reported dark on the 15th and 16th of November.', NULL, 5, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(6, ' Miss B Haven...', 'A new bar has opened on Soi 6 named Miss B Haven. It opened on the 11th November and is located mid soi on the north side, next door to Chilli Bar', NULL, 6, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(7, ' Normal service resuming...', 'Lita Bar , the ladyboy bar that had closed on Soi BJ off Walking Street, has reopened on Soi Post Office (Soi 13/2).', NULL, 7, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(8, 'Passion for sale...', 'On Soi Diamond the previous location of The Sea gogo has become Diamond Sports Bar, which is always deserted when I walk past.', NULL, 8, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(9, 'Jeanette Winterson: my family Christmas', 'In an extract from her new book Christmas Days, Jeanette Winterson shares her childhood memories and favourite seasonal recipes, including Mum’s mince pies and Dads sherry trifle', NULL, 9, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
 	(10, 'How I made Wendy the real star of Peter Pan', 'The director Sally Cookson is renowned for turning family shows upside down. As her National Theatre Peter Pan opens, she talks GoogleId why she made Wendy the real star of the show', NULL, 10, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(11, 'When wills go bad: ‘It was the cruellest thing you could imagine’', 'The mother who left all her money to animals rather than her daughter. The man forced to read out a catalogue of his father failings. Wills can leave emotional scars', NULL, 11, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(12, '7 things to do if you don’t like your children’s friends', 'Be honest with yourself GoogleId why you dislike them, try to befriend them. And never let your child know you feel that way', NULL, 12, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(13,  'Who could be in Trump Cabinet?', 'President-elect Trump will have GoogleId 400 government positions to fill, including some of the most important posts in the US government. His team has been at work coming up with possible candidates for the top jobs, but there is a smaller universe of Republicans who were close to his campaign. Much of the Washington establishment kept him at arms length. Others, including some former GOP cabinet secretaries, rejected him entirely.', NULL, 13, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(14, 'Michael Flynn ran company that lobbied for foreign clients while he received intel briefings', 'Washington (CNN)Retired Army Lt. Gen. Michael Flynn, President-elect Donald Trump preferred choice for National Security Adviser, was running a company that was lobbying on behalf of foreign clients even as he was receiving classified intelligence briefings during the campaign.', NULL, 14, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(15, 'Freshman Van Hollen takes over Dems Senate campaign arm', '"He has the confidence of our caucus and will do a great job for our candidates running in 2018. The map is tough for Democrats, but I have no doubt that Senator-elect Van Hollen is up to the task," said Senate Minority Leader Chuck Schumer, himself the new head of the Senate Democrats.', NULL, 15, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(16, 'Japan Abe on US mission to "build trust" with Donald Trump', 'Japanese Prime Minister Shinzo Abe said Thursday he had a "very candid discussion" with President-elect Donald Trump, during a brief press availability following their in-person meeting.', NULL, 16, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(17, 'Doctors see surge in men seeking surgery-free double chin solution', 'Even though Scott Kaiser had a healthy diet and stayed active with regular cardio and weight lifting, he realized he was developing a double chin, something that also seemed to plague other men in his family.', NULL, 17, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(18, 'Trump Apprentice alum Leeza Gibbons on the importance of caregiving', 'Leeza Gibbons may be best known for her co-hosting role on “Entertainment Tonight” or for winning “The Apprentice” in the final season that Donald Trump hosted, but now, she is making name for herself in the medical space by raising awareness for caregivers.', NULL, 18, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(19, 'Reliance on food pantries can make healthy eating difficult', 'People who rely on food pantries for their meals may not receive enough dairy, fruits or vegetables to get all the nutrients they need for a healthy diet, two recent studies suggest.', NULL, 19, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(20, 'Moderate drinking may have some heart benefits', 'NEW ORLEANS — Moderate drinking may have positive effects on some aspects of heart health beyond those seen with light drinking, a new study from Australia finds. The people in the study who drank 10 to 20 grams of alcohol per day were less likely to develop a condition called metabolic syndrome, which is linked with heart disease, compared with the people who drank less than 10 g of alcohol per day. In the U.S., a standard drink contains GoogleId 14 g of alcohol, according to the National Institute on Alcohol Abuse and Alcoholism.', NULL, 20, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(21, 'Tech Q&A: Running a background check, avoiding cell phone contracts', 'Service providers have begun phasing out contracts, which is a blessing and a curse. On the one hand, there are no strict rules, no automatic renewals, and no elaborate termination steps. Then again, some people have to buy their expensive smartphones outright, where once they were heavily discounted. Until recently, your only options were to pay in advance with companies like T-Mobile or Cricket.', NULL, 21, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(22, 'Keeping your secrets safe on Amazon, Google, Facebook and Netflix', 'Google often auto-completes your search terms based on personal information, such as your location and previous searches. Anyone looking over your shoulder or borrowing your device might be surprised by the guesses Google makes. Google products that collect your information include Chrome, Google Maps, and YouTube.', NULL, 21, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(23, 'The hidden costs of new car infotainment systems', 'These days, a new car is basically a computer with wheels. Trunks open automatically. The car parks itself. Rear cameras show you what you can’t see. If you lock your keys inside, you can open the doors by satellite. The flashiest new gadget: a touch screen in the middle of your dashboard. There’s a lot to love GoogleId these infotainment systems. Depending on the brand, you can organize your music, program the GPS and dictate text messages. Console screens are as wide as small tablets and they’re easy to read, even when you’re behind the wheel.', NULL, 21, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(24, 'How is Wikileaks publishing files even after Assange Internet was cut?', 'Assange has been holed up in the Ecuadorean Embassy in London for five years, but Wikileaks managed on Tuesday to unleash yet another massive dump of Locations hacked from key Hillary Clinton aide John Podesta. Those disclosures came a day after his international hacktivist group said their leader access to the cyber world was severed by the South Ameerican government.', NULL, 21, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(25, 'Advanced weather satellite rockets into space', 'The most advanced weather satellite ever built rocketed into space Saturday night, part of an $11 billion effort to revolutionize forecasting and save lives.', NULL, 22, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(26, 'Space station welcomes the oldest woman astronaut, and a bit of Mars', 'The International Space Station gained three new residents Saturday, including the oldest and most experienced woman to orbit the world.', NULL, 22, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(27, 'Newfound spider species masquerades as a dried-up leaf', 'In the animal kingdom, someCreationTimes the best survival strategy is to pretend to be something you are not — either to ambush unsuspecting prey or to convince predators that you are not very tasty', NULL, 22, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(28, 'Exploring Mars Ashley Dvorkin speaks with the brains behind the National Geographic miniseries Mars MARS National Geographic Channels MARS explores colonization of the red planet', 'National Geographic Channel’s new event series “MARS” mixes documentary with scripted drama to explore the colonization of Mars in the year 2033.', NULL, 22, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(29, 'ELMAR HESS AT WHITECONCEPTS, BERLIN', 'Pictures at an Exhibition presents Descriptions of one notable show every weekday ', NULL, 23, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(30, 'FRANCIS PICABIA, ART-WORLD JAILER: PHILIP PEARLSTEIN ON ‘ONE OF THE PRIME MOVERS OF MODERN ART,’ IN 1970', 'With the Museum of Modern Art in New York preparing to open a much-anticipated Francis Picabia retrospective on Monday, we turn back to the September 1970 issue of ARTnews, in which Philip Pearlstein wrote an essay GoogleId the artist. ', NULL, 24, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(31, 'DIMITRIS DASKALOPOULOS, NICKOL HACKETT JOIN MCA CHICAGO BOARD OF TRUSTEES', 'The Museum of Contemporary Art, Chicago announced today that Dimitris Daskalopoulos and Nickol Hackett joined its board of trustees on October 31. Daskalopoulos, an ARTnews Top 200 collector, is the founder and member of the board of the Greek investments', NULL, 25, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(32, 'GRIM PRESIDENTIAL POOL REPORT REFERENCES EDWARD HOPPER, NORMAN MAILER', 'With the President-Elect’s administration filling up with Islamophobes and white nationalists, I’m looking for laughs where I can find them these days. And, bless it, the presidential pool report from Berlin, where President Barack Obama just visited with world leaders.', NULL, 26, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(33, 'These are the worst airports to travel through during the holidays', 'Passengers trying to fly in and out of JFK, La Guardia and Newark airports for the holidays better buckle up for disappointments.A new study shows that flights involving the three New York City-area airports are more than twice as likely to be canceled than the national average during the Thanksgiving and Christmas holiday season.', NULL, 27, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(34, 'Terror attacks are changing American holiday travel decisions, survey reports', 'American travelers are changing the international vacation destination map as global terror attacks have altered perceived safety risks, a survey released this week from travel insurance provider Allianz Global Assistance found.', NULL, 28, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(35, 'Giant, uncut Foxfire diamond goes on display at Smithsonian', 'One of the biggest diamonds ever found is on display at the Smithsonian National Museum of Natural History. The Foxfire diamond is the largest uncut, gem-quality diamond ever mined in North America. It weighs 187 carats, or 1.3 ounces.', NULL, 29, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'),
	(36, 'Elderly man dies on JetBlue flight from Florida to Boston', 'BOSTON –  Authorities say the death of an elderly man on a JetBlue flight from Florida to Boston is not considered suspicious. Massachusetts State Police spokesman David Procopio says the man, whose name was not immediately released, died of apparent natural causes during the flight Thursday from Fort Myers.', NULL, 30, '2b0ed59e-570c-42ba-8d83-b140c52c4cc8', '2016-03-03 7:29:29 AM'))
	
	as S (Id, Heading, Description, Image, Event_Id, Author_Id, Time) 
	ON U.Id = S.Id
	
	WHEN MATCHED AND (
		U.Heading <> S.Heading
		OR U.Description <> S.Description
		OR U.Image <> S.Image
		OR U.Event_Id <> S.Event_Id
		OR U.Author_Id <> S.Author_Id
		OR U.Time <> S.Time) 
	THEN UPDATE SET 
		U.Heading = S.Heading,
		U.Description = S.Description,
		U.Image = S.Image,
		U.Event_Id = S.Event_Id,
		U.Author_Id = S.Author_Id,
		U.Time = S.Time

	WHEN NOT MATCHED BY TARGET
	THEN INSERT (Id, Heading, Description, Image, Event_Id, Author_Id, Time)
		VALUES (S.Id, S.Heading, S.Description, S.Image, S.Event_Id, S.Author_Id, S.Time)
	;
	-- WHEN NOT MATCHED BY SOURCE
	--	THEN DELETE; 
	SET IDENTITY_INSERT [dbo].[News] OFF;

PRINT N'Populate data in Likes table...'
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

PRINT N'Populate data in Groups table...'
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

PRINT N'Populate data in UserGroups table...'

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



PRINT N'Populate data in EventsSubscriptions table...'
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
GO
