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

create procedure usp_InsertAuthorData
@name nvarchar(25),
@surname nvarchar(25)
AS
Begin
    INSERT INTO Authors (Name,Surname)
VALUES (@name,@surname);
END

create procedure usp_UpdateAuthorData
@id int,
@name nvarchar(25),
@surname nvarchar(25)
AS
Begin
    UPDATE Authors
  SET Name = @name, Surname = @surname
WHERE Authors.Id=@id;
END


create procedure usp_DeleteAuthorData
@id int
AS
Begin
    DELETE FROM Authors WHERE Authors.Id=@id;
END


CREATE VIEW usv_AuthorInfo
AS
SELECT a.Id, a.Name+' '+a.Surname FullName,Count(*) BooksCount, Max(b.PageCount) MaxPageCount
FROM Authors a
Join Books b
ON a.Id = b.AuthorId
Group by a.Id,a.Name,a.Surname
Group by a.Id
