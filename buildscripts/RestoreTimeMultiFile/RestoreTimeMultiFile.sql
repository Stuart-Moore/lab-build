use master
go

if exists (select * from sys.databases where name='RestoreTimeMultiFile')
begin
	ALTER DATABASE RestoreTimeMultiFile SET single_USER with rollback immediate
	drop database RestoreTimeMultiFile
end
go


create database RestoreTimeMultiFile
go

alter database RestoreTimeMultiFile set recovery full
go

use RestoreTimeMultiFile
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


backup database [RestoreTimeMultiFile] to disk='C:\github\app-lab\backups\RestoreTimeMultiFile\RestoreTimeMultiFile.bak'

while (@i<10)
begin
insert into steps values (@i, getdate())
select @i=@i+1
waitfor delay '00:00:10'
end
backup log [RestoreTimeMultiFile] to disk='C:\github\app-lab\backups\RestoreTimeMultiFile\RestoreTimeMultiFile_1.trn'


while (@i<20)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:10'
end

backup log [RestoreTimeMultiFile] to disk='C:\github\app-lab\backups\RestoreTimeMultiFile\RestoreTimeMultiFile_2.trn'

while (@i<30)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:10'
end


backup log [RestoreTimeMultiFile] to disk='C:\github\app-lab\backups\RestoreTimeMultiFile\RestoreTimeMultiFile_3.trn'

set @i=0
while (@i<10)
begin
insert into steps values (@i, getdate())
select @i=@i+1
waitfor delay '00:00:10'
end
backup log [RestoreTimeMultiFile] to disk='C:\github\app-lab\backups\RestoreTimeMultiFile\RestoreTimeMultiFile_21.trn'



while (@i<20)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:10'
end

declare @filepath varchar(255)
select @filepath=replace(physical_name,'.mdf','1.ndf') from sys.database_files where type=0
select @filepath

declare @sql nvarchar(512)
select @sql = 'alter database [RestoreTimeMultiFile] add file (name=''data2'', filename='''+ @filepath + ''')'

exec sp_executesql @sql
backup log [RestoreTimeMultiFile] to disk='C:\github\app-lab\backups\RestoreTimeMultiFile\RestoreTimeMultiFile_22.trn'

while (@i<30)
begin
insert into steps values (@i,getdate())
select @i=@i+1
waitfor delay '00:00:10'
end


backup log [RestoreTimeMultiFile] to disk='C:\github\app-lab\backups\RestoreTimeMultiFile\RestoreTimeMultiFile_23.trn'

