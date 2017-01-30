CREATE TABLE [dbo].[Users] (
    [Id]                      NVARCHAR (128)  NOT NULL,
    [CreatedDate]             DATETIME        NULL,
    [ModifiedDate]            DATETIME        NULL,
    [UserName]				  NVARCHAR (256)  NOT NULL,
    [FirstName]               NVARCHAR (30)   NULL,
    [SecondName]              NVARCHAR (30)   NULL,
    [Email]                   NVARCHAR (256)  NULL,
    [PasswordHash]            NVARCHAR (MAX)  NULL,
    [IsBanned]                BIT             DEFAULT ((0)) NOT NULL,
    [Image]                   NVARCHAR (200)  NULL, 
    [BirthDate]               DATETIME        NULL,
    [EmailConfirmed]          BIT             NOT NULL,
    [SecurityStamp]           NVARCHAR (MAX)  NULL,
    [PhoneNumber]             NVARCHAR (MAX)  NULL,
    [PhoneNumberConfirmed]    BIT             NOT NULL,
    [TwoFactorEnabled]        BIT             NOT NULL,
    [LockoutEndDateUtc]       DATETIME        NULL,
    [LockoutEnabled]          BIT             NOT NULL,
    [AccessFailedCount]       INT             NOT NULL,
    [IsActive]                BIT             NULL,
    [Sex]                     SMALLINT        NOT NULL,
    [LocationId]              INT             NULL,
    [About]                   NVARCHAR (MAX)  NULL,
    [GoogleToken]             NVARCHAR (1024) NULL,

    CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED ([Id] ASC)
);

