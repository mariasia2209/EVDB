CREATE TABLE [dbo].[UserGroups] (
    [User_Id]  NVARCHAR(128) NOT NULL,
    [Group_Id] INT NOT NULL,
    CONSTRAINT [PK_dbo.UserGroups] PRIMARY KEY CLUSTERED ([User_Id] ASC, [Group_Id] ASC),
    CONSTRAINT [FK_dbo.UserGroups_dbo.Groups_Group_Id] FOREIGN KEY ([Group_Id]) REFERENCES [dbo].[Groups] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_dbo.UserGroups_dbo.Users_User_Id] FOREIGN KEY ([User_Id]) REFERENCES [dbo].[Users] ([Id]) ON DELETE NO ACTION
);


GO
CREATE NONCLUSTERED INDEX [IX_User_Id]
    ON [dbo].[UserGroups]([User_Id] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Group_Id]
    ON [dbo].[UserGroups]([Group_Id] ASC);

