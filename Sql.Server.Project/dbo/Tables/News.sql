CREATE TABLE [dbo].[News]
(
	[Id] INT IDENTITY(1,1) NOT NULL,
	[Heading] NVARCHAR(20) NOT NULL,
	[Description] NVARCHAR(MAX) NOT NULL,
    [Image] NVARCHAR(200) NULL,
	[Event_Id] INT NOT NULL,
	[Author_Id] NVARCHAR(128) NOT NULL,
	[Time] DATETIME  NOT NULL,
	CONSTRAINT [PK_dbo.News] PRIMARY KEY CLUSTERED ([Id] ASC),
	CONSTRAINT [FK_dbo.News_dbo.Events_Event_Id] FOREIGN KEY ([Event_Id]) REFERENCES [dbo].[Events] ([Id]),
	CONSTRAINT [FK_dbo.News_dbo.Users_Author_Id] FOREIGN KEY ([Author_Id]) REFERENCES [dbo].[Users] ([Id]),
)
