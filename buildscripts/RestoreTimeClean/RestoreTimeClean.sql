use master
go

if exists (select * from sys.databases where name='RestoreTimeClean')
begin
	ALTER DATABASE RestoreTimeClean SET single_USER with rollback immediate
	drop database RestoreTimeClean
end
go


create database RestoreTimeClean
go

alter database RestoreTimeClean set recovery full
go

use RestoreTimeClean
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


backup database [RestoreTimeClean] to disk='C:\github\app-lab\backups\RestoreTimeClean\RestoreTimeClean.bak'

while (@i<10)
begin
insert into steps values (@i, getdate())
select @i=@i+1
waitfor delay '00:00:10'
end
backup log [RestoreTimeClean] to disk='C:\github\app-lab\backups\RestoreTimeClean\RestoreTimeClean_1.trn'


while (@i<20)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:10'
end

backup log [RestoreTimeClean] to disk='C:\github\app-lab\backups\RestoreTimeClean\RestoreTimeClean_2.trn'

while (@i<30)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:10'
end


backup log [RestoreTimeClean] to disk='C:\github\app-lab\backups\RestoreTimeClean\RestoreTimeClean_3.trn'

--backup database [RestoreTimeClean] to disk='C:\github\app-lab\backups\RestoreTimeClean\RestoreTimeClean2.bak'

set @i=0
while (@i<10)
begin
insert into steps values (@i, getdate())
select @i=@i+1
waitfor delay '00:00:10'
end
backup log [RestoreTimeClean] to disk='C:\github\app-lab\backups\RestoreTimeClean\RestoreTimeClean_21.trn'

while (@i<20)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:10'
end


backup log [RestoreTimeClean] to disk='C:\github\app-lab\backups\RestoreTimeClean\RestoreTimeClean_22.trn'

while (@i<30)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:10'
end


backup log [RestoreTimeClean] to disk='C:\github\app-lab\backups\RestoreTimeClean\RestoreTimeClean_23.trn'

