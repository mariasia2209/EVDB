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