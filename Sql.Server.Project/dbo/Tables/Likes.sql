CREATE TABLE [dbo].[Likes] (
    [Id]            INT      IDENTITY (1, 1) NOT NULL,
    [Time]          DATETIME NOT NULL,
    [LikedEvent_Id] INT      NULL,
    [Liker_Id]      NVARCHAR(128)      NULL,
    CONSTRAINT [PK_dbo.Likes] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Likes_dbo.Events_LikedEvent_Id] FOREIGN KEY ([LikedEvent_Id]) REFERENCES [dbo].[Events] ([Id]),
    CONSTRAINT [FK_dbo.Likes_dbo.Users_Liker_Id] FOREIGN KEY ([Liker_Id]) REFERENCES [dbo].[Users] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_LikedEvent_Id]
    ON [dbo].[Likes]([LikedEvent_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Liker_Id]
    ON [dbo].[Likes]([Liker_Id] ASC);

