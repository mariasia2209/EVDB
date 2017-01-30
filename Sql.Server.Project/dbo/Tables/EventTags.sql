CREATE TABLE [dbo].[EventTags]
(
	[Event_Id] INT NOT NULL, 
	[Tag_Id] INT NOT NULL , 
    CONSTRAINT [PK_dbo.EventTags] PRIMARY KEY CLUSTERED ([Event_Id] ASC, [Tag_Id] ASC),
    CONSTRAINT [FK_dbo.EventTags_dbo.Events_Event_Id] FOREIGN KEY ([Event_Id]) REFERENCES [dbo].[Events] ([Id]),
    CONSTRAINT [FK_dbo.EventTags_dbo.Tags_Tag_Id] FOREIGN KEY ([Tag_Id]) REFERENCES [dbo].[Tags] ([Id])
);


GO
CREATE NONCLUSTERED INDEX [IX_Tag_Id]
    ON [dbo].[EventTags]([Tag_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Event_Id]
    ON [dbo].[EventTags]([Event_Id] ASC);
