﻿/*
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

if not exists (select 1 from dbo.RoomTypes)
begin
    insert into dbo.RoomTypes(Title, Description, Price)
    values ('King Size Bed', 'A room with a king size bed, a window, a bar and a jakuzi', 100),
    ('Two Queen Size Bed', 'A room with a two queen size beds, a window, a bar and a jakuzi', 120),
    ('Presidential Suite', 'Four rooms, each with a king size bed and windows', 205)
end

if not exists (select 1 from dbo.Rooms)
begin
    declare @roomId1 int;
    declare @roomId2 int;
    declare @roomId3 int;

    select @roomId1 = Id from dbo.RoomTypes where Title = 'King Size Bed';
    select @roomId2 = Id from dbo.RoomTypes where Title = 'Two Queen Size Bed';
    select @roomId3 = Id from dbo.RoomTypes where Title = 'Presidential Suite';

    insert into dbo.Rooms(RoomNumber, RoomTypeId)
    values ('101', @roomId1),
    ('102', @roomId1),
    ('103', @roomId1),
    ('201', @roomId2),
    ('202', @roomId2),
    ('203', @roomId2),
    ('301', @roomId3)
end