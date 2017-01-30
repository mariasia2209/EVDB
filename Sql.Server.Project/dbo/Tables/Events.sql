CREATE TABLE [dbo].[Events] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [CreationTime] DATETIME       NOT NULL,
    [EventBegin]   DATETIME       NOT NULL,
    [EventEnd]     DATETIME       NOT NULL,
    [Location]     NVARCHAR (MAX) NULL,
	[Latitude]	   FLOAT		  NULL, 
	[Longitude]	   FLOAT		  NULL,
    [Description]  NVARCHAR (MAX) NULL,
    [Suspended]    BIT            NOT NULL,
    [Creator_Id]   NVARCHAR(128)            NULL,
    [Stream_Id]    NVARCHAR(128)            NULL,
	[Organizer_Id] INT NULL,
    [Image] NVARCHAR(200) NULL, 
    [Name] NVARCHAR(MAX) NOT NULL, 
    [Priority] FLOAT  NOT NULL, 
    [Category_Id] INT NOT NULL, 
    [BackgroundColor] NVARCHAR(30) NULL, 
    [TitleColor] NVARCHAR(30) NULL, 
    [EventStatus] NVARCHAR(10) NULL , 
	[GoogleId] NVARCHAR(64) NULL,
    [Status] BIT  NOT NULL default 1,
    CONSTRAINT [PK_dbo.Events] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Events_dbo.Streams_Stream_Id] FOREIGN KEY ([Stream_Id]) REFERENCES [dbo].[Streams] ([Id]),
    CONSTRAINT [FK_dbo.Events_dbo.Users_Creator_Id] FOREIGN KEY ([Creator_Id]) REFERENCES [dbo].[Users] ([Id]),
	CONSTRAINT [FK_dbo.Events_dbo.Organizers_Organizer_Id] FOREIGN KEY ([Organizer_Id]) REFERENCES [dbo].[Organizers] ([Id]),
	CONSTRAINT [FK_dbo.Events_dbo.Categories_Category_Id] FOREIGN KEY ([Category_Id]) REFERENCES [dbo].[Categories] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Creator_Id]
    ON [dbo].[Events]([Creator_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Stream_Id]
    ON [dbo].[Events]([Stream_Id] ASC);

