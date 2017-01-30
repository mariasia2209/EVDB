CREATE TABLE [dbo].[Subscriptions] (
    [Id]        INT      IDENTITY (1, 1) NOT NULL,
    [Time]      DATETIME NOT NULL,
    [Users_Id]  NVARCHAR(128)      NOT NULL,
    [Stream_Id] NVARCHAR(128)      NOT NULL,
    [Suspended] BIT NOT NULL, 
    CONSTRAINT [PK_dbo.Subscriptions] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Subscriptions_dbo.Streams_Stream_Id] FOREIGN KEY ([Stream_Id]) REFERENCES [dbo].[Streams] ([Id]),
    CONSTRAINT [FK_dbo.Subscriptions_dbo.Users_Users_Id] FOREIGN KEY ([Users_Id]) REFERENCES [dbo].[Users] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Users_Id]
    ON [dbo].[Subscriptions]([Users_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Stream_Id]
    ON [dbo].[Subscriptions]([Stream_Id] ASC);

