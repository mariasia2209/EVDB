CREATE TABLE [dbo].[Claims]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [UserId] NVARCHAR(128) NOT NULL, 
    [ClaimType] NVARCHAR(MAX) NULL, 
    [ClaimValue] NVARCHAR(MAX) NULL, 
    CONSTRAINT [FK_UserClaims_ToTable] FOREIGN KEY ([UserId]) REFERENCES [Users]([Id])
)
