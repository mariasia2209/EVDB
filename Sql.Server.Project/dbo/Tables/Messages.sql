CREATE TABLE [dbo].[Messages] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [Text]         NVARCHAR (MAX) NULL,
    [Time]         DATETIME       NOT NULL,
    [Author_Id]    NVARCHAR(128)            NULL,
    [Recipient_Id] NVARCHAR(128)            NULL,
    CONSTRAINT [PK_dbo.Messages] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.Messages_dbo.Users_Author_Id] FOREIGN KEY ([Author_Id]) REFERENCES [dbo].[Users] ([Id]),
    CONSTRAINT [FK_dbo.Messages_dbo.Users_Recipient_Id] FOREIGN KEY ([Recipient_Id]) REFERENCES [dbo].[Users] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Author_Id]
    ON [dbo].[Messages]([Author_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Recipient_Id]
    ON [dbo].[Messages]([Recipient_Id] ASC);

