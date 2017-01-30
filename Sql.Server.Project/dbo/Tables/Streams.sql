CREATE TABLE [dbo].[Streams] (
    [Id]            NVARCHAR(128) NOT NULL,
    [Name]          NVARCHAR (MAX) NULL,
    [IsGroupStream] BIT            NOT NULL,
    [Group_Id]      INT            NULL,
	[User_Id]		NVARCHAR(128)	NULL,
    [Photo]			NVARCHAR(100) NULL, 
    CONSTRAINT [PK_dbo.Streams] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Streams_dbo.Groups_Group_Id] FOREIGN KEY ([Group_Id]) REFERENCES [dbo].[Groups] ([Id]),
    CONSTRAINT [FK_dbo.Streams_dbo.Users_Id] FOREIGN KEY ([User_Id]) REFERENCES [dbo].[Users] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Id]
    ON [dbo].[Streams]([Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Group_Id]
    ON [dbo].[Streams]([Group_Id] ASC);

