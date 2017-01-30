CREATE TABLE [dbo].[Logins]
(
	[Id] INT IDENTITY (1, 1) NOT NULL,
	[LoginProvider] NVARCHAR(128) NOT NULL , 
    [ProviderKey] NVARCHAR(128) NOT NULL, 
    [UserId] NVARCHAR(128) NOT NULL, 
    CONSTRAINT [PK_dbo.Logins] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UserLogins_ToTable] FOREIGN KEY ([UserId]) REFERENCES [Users]([Id])
)
