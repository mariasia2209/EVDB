CREATE TABLE [dbo].[Reposts] (
    [Id]               INT      IDENTITY (1, 1) NOT NULL,
    [Time]             DATETIME NOT NULL,
    [Suspended]        BIT      NOT NULL,
    [Reposter_Id]      NVARCHAR(128)      NULL,
    [Stream_Id]        NVARCHAR(128)      NULL,
    [RepostedEvent_Id] INT      NULL,
    CONSTRAINT [PK_dbo.Reposts] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Reposts_dbo.Events_RepostedEvent_Id] FOREIGN KEY ([RepostedEvent_Id]) REFERENCES [dbo].[Events] ([Id]),
    CONSTRAINT [FK_dbo.Reposts_dbo.Streams_Stream_Id] FOREIGN KEY ([Stream_Id]) REFERENCES [dbo].[Streams] ([Id]),
    CONSTRAINT [FK_dbo.Reposts_dbo.Users_Reposter_Id] FOREIGN KEY ([Reposter_Id]) REFERENCES [dbo].[Users] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Reposter_Id]
    ON [dbo].[Reposts]([Reposter_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Stream_Id]
    ON [dbo].[Reposts]([Stream_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_RepostedEvent_Id]
    ON [dbo].[Reposts]([RepostedEvent_Id] ASC);

