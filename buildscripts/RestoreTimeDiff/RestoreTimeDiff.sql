use master
go

if exists (select * from sys.databases where name='restoretimestripe')
begin
	ALTER DATABASE RestoreTimeStripe SET single_USER with rollback immediate
	drop database restoretimestripe
end
go


create database restoretimestripe
go

alter database RestoreTimeStripe set recovery full
go

use restoretime
go

IF EXISTS (SELECT * FROM SYS.tables WHERE name='steps')
begin
	drop table steps
end
go

create table steps(
step integer,
dt datetime2
);
go

declare @i integer

set @i=0


backup database [RestoreTimeStripe] to 
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime.bak',
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime1.bak'

while (@i<10)
begin
insert into steps values (@i, getdate())
select @i=@i+1
waitfor delay '00:00:30'
end
backup log [RestoreTimeStripe] to 
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_1.trn',
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_1a.trn'

while (@i<20)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:30'
end


backup log [RestoreTimeStripe] to 
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_2.trn',
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_2a.trn'

while (@i<30)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:30'
end


backup log [RestoreTimeStripe] to 
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_3.trn',
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_3a.trn'

backup database [RestoreTimeStripe] to 
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime2.bak',
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime2a.bak'

while (@i<10)
begin
insert into steps values (@i, getdate())
select @i=@i+1
waitfor delay '00:00:30'
end
backup log [RestoreTimeStripe] to 
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_21.trn',
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_21a.trn'

while (@i<20)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:30'
end


backup log [RestoreTimeStripe] to 
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_22.trn',
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_22a.trn'

while (@i<30)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:30'
end


backup log [RestoreTimeStripe] to 
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_23.trn',
disk='C:\github\app-lab\backups\RestoreTimeStripe\restoretime_23a.trn'

