create database Kitabxana

use Kitabxana

Create table Books
(
Id int primary key identity,
Name nvarchar(100) check (LEN(Name)>2),
PageCount int  check (PageCount>10)
)

Create table Authors
(
Id int primary key identity,
Name nvarchar(25),
Surname nvarchar(25),
)

Alter TABLE Books
Add AuthorId int FOREIGN KEY REFERENCES Authors(Id)

Select b.Id, b.Name, b.PageCount, a.Name+' '+a.Surname AuthorFullName From Books b 
Join Authors a ON b.AuthorId=a.Id

create procedure usp_GetbyNameAndAuthor
@name nvarchar(100),
@author nvarchar(25)
AS
Begin
    Select b.Id, b.Name, b.PageCount, a.Name+' '+a.Surname AuthorFullName From Books b 
    Join Authors a ON b.AuthorId=a.Id where b.Name like '%'+@name+'%' and a.Name+' '+a.Surname like '%'+@author+'%'
END

