/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
PRINT N'Populate data in Users table...'
:r ..\PostDeploymentScripts\Users_Populate.sql

PRINT N'Populate data in Categories table...'
:r ..\PostDeploymentScripts\Categories_Populate.sql

PRINT N'Populate data in Events table...'
:r ..\PostDeploymentScripts\Events_Populate.sql

PRINT N'Populate data in Comments table...'
:r ..\PostDeploymentScripts\Comments_Populate.sql

PRINT N'Populate data in News table...'
:r ..\PostDeploymentScripts\News_Populate.sql

PRINT N'Populate data in Likes table...'
:r ..\PostDeploymentScripts\Likes_Populate.sql

PRINT N'Populate data in Groups table...'
:r ..\PostDeploymentScripts\Groups_Populate.sql

PRINT N'Populate data in UserGroups table...'
:r ..\PostDeploymentScripts\UserGroups_Populate.sql

PRINT N'Populate data in EventsSubscriptions table...'
:r ..\PostDeploymentScripts\EventsSubscriptions_Populate.sql