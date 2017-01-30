CREATE TABLE [dbo].[Comments] (
    [Id]         INT            IDENTITY (1, 1) NOT NULL,
    [Time]       DATETIME       NOT NULL,
    [Text]       NVARCHAR (MAX) NOT NULL,
    [Suspended]  BIT            NOT NULL,
    [Creator_Id] NVARCHAR(128)	NOT NULL,
    [Event_Id]   INT            NOT NULL,
    CONSTRAINT [PK_dbo.Comments] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Comments_dbo.Events_Event_Id] FOREIGN KEY ([Event_Id]) REFERENCES [dbo].[Events] ([Id]),
    CONSTRAINT [FK_dbo.Comments_dbo.Users_Creator_Id] FOREIGN KEY ([Creator_Id]) REFERENCES [dbo].[Users] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Creator_Id]
    ON [dbo].[Comments]([Creator_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Event_Id]
    ON [dbo].[Comments]([Event_Id] ASC);

