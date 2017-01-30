CREATE TABLE [dbo].[EventSubscriptions] (
    [Id]            INT      IDENTITY (1, 1) NOT NULL,
    [Time]          DATETIME NOT NULL,
    [Event_Id]      INT      NOT NULL,
    [Subscriber_Id] NVARCHAR(128)      NOT NULL,
    [Suspended] BIT NOT NULL, 
	[Type] INT NOT NULL, 
    CONSTRAINT [PK_dbo.EventSubscriptions] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_dbo.EventSubscriptions_dbo.Events_Event_Id] FOREIGN KEY ([Event_Id]) REFERENCES [dbo].[Events] ([Id]),
    CONSTRAINT [FK_dbo.EventSubscriptions_dbo.Users_Subscriber_Id] FOREIGN KEY ([Subscriber_Id]) REFERENCES [dbo].[Users] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Event_Id]
    ON [dbo].[EventSubscriptions]([Event_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Subscriber_Id]
    ON [dbo].[EventSubscriptions]([Subscriber_Id] ASC);

