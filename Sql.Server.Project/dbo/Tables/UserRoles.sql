CREATE TABLE [dbo].[UserRoles]
(
	[Id] INT IDENTITY (1, 1) NOT NULL,
	[UserId] NVARCHAR(128) NOT NULL, 
    [RoleId] NVARCHAR(128) NOT NULL, 
    CONSTRAINT [PK_dbo.UserRoles] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UserRoles_ToTable] FOREIGN KEY ([UserId]) REFERENCES [Users]([Id]), 
    CONSTRAINT [FK_UserRoles_ToTable_1] FOREIGN KEY ([RoleId]) REFERENCES [Roles]([Id]) 
)
