﻿CREATE TABLE [dbo].[Organizers]
(
	[Id]  INT IDENTITY (1, 1) NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(30) NULL,
	[Image] NVARCHAR(200) NULL, 
	[Description]  NVARCHAR (MAX) NULL,
	[Email]   NVARCHAR (256) NULL,
	[Site] NVARCHAR (256) NULL,
)
