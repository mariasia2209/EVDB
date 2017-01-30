CREATE TABLE [dbo].[Notifications]
(
	[Id] INT IDENTITY (1, 1) NOT NULL , 
    [Recipient_Id] NVARCHAR(128) NOT NULL, 
    [Sender_Id] NVARCHAR(128) NOT NULL, 
    [Type] TINYINT NULL, 
    [TimeSent] DATETIME NOT NULL, 
    [ObjectLink] NVARCHAR(200) NULL, 
    [Message] NVARCHAR(200) NULL, 
    [IsUnread] BIT NOT NULL, 
	CONSTRAINT [PK_dbo.Notifications] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_Notifications_Users_Sender] FOREIGN KEY ([Sender_Id]) REFERENCES [Users]([Id]) ON DELETE NO ACTION, 
    CONSTRAINT [FK_Notifications_Users_Recipient] FOREIGN KEY ([Recipient_Id]) REFERENCES [Users]([Id]) ON DELETE NO ACTION 
)
GO
CREATE NONCLUSTERED INDEX [IX_Sender_Id]
    ON [dbo].[Notifications]([Sender_Id] ASC);

GO
CREATE NONCLUSTERED INDEX [IX_Recipient_Id]
    ON [dbo].[Notifications]([Recipient_Id] ASC);


