use master
go

if exists (select * from sys.databases where name='SingleRestore')
begin
	ALTER DATABASE SingleRestore SET single_USER with rollback immediate
	drop database SingleRestore
end
go


create database SingleRestore
go

alter database SingleRestore set recovery full
go

use SingleRestore

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



backup database [SingleRestore] to disk='C:\github\app-lab\backups\SingleRestore\SingleRestore.bak'