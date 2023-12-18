CREATE DATABASE QUIZ_TASK

use QUIZ_TASK

CREATE TABLE Authors (
  Id INT PRIMARY KEY,
  Name VARCHAR(40),
  Surname VARCHAR(40)
);

CREATE TABLE Books (
  Id INT PRIMARY KEY,
  Name VARCHAR(90) CHECK
 (LEN(Name) BETWEEN 2 AND 90),
  AuthorId INT,
  PageCount INT CHECK (PageCount >=10),
  FOREIGN KEY (AuthorId)
  REFERENCES Authors(Id)
);

CREATE VIEW BooksWithAuthorFullName 
AS 
SELECT b.Id, b.Name, b.PageCount,CONCAT(a.Name,'',a.Surname) AS AuthorFullName FROM Books b 
JOIN Authors a 
ON b.AuthorId=a.Id;

select * from BooksWithAuthorFullName


CREATE PROCEDURE SearchBooks
  @searchTerm VARCHAR(90)
AS
BEGIN
  SELECT Id, Name, PageCount,
AuthorFullName
  FROM BooksWithAuthorFullName
  WHERE Name LIKE'%'+@searchTerm+'%'OR
  AuthorFullName LIKE'%'+ @searchTerm+'%';
END;

CREATE PROCEDURE InsertAuthor
  @Name VARCHAR(60),
  @Surname VARCHAR(60)
AS
BEGIN
 INSERT INTO Authors (Name,Surname)
 VALUES (@Name, @Surname);
END;

CREATE PROCEDURE UpdateAuthor
  @Id INT,
  @Name VARCHAR(60),
  @Surname VARCHAR(60)
AS
BEGIN
  UPDATE Authors
  SET Name=@Name, Surname=@Surname
  WHERE Id=@Id;
END;

CREATE PROCEDURE DeleteAuthor
  @Id INT
AS
BEGIN
  DELETE FROM Authors
  WHERE Id=@Id;
END;

CREATE VIEW AuthorsSummary 
AS 
SELECT a.Id,CONCAT(a.Name,'',a.Surname)AS FullName,COUNT(b.Id) AS BooksCount,MAX(b.PageCount) AS MaxPageCountFROM Authors a 
LEFT JOIN Books b 
ON a.Id=b.AuthorId
GROUP BY a.Id, a.Name, a.Surname;

INSERT INTO Authors (Id, Name, Surname) VALUES
(1, 'Cingiz','Abdullayev'),
(2, 'Huseyn','Cavid'),
(3, 'Ilyas','Efendiyev'),
(4, 'Mir Celal','Pasayev'),
(5, 'Celil','Memmedquluzade')

INSERT INTO Books (Id, Name, AuthorId, PageCount) VALUES
(91,'Mavi melekler', 1, 140),
(92,'Azer', 2, 100),
(93,'Intizar', 3, 180),
(94,'Dirilen adam', 4, 150),
(95,'Posta kutusu', 5, 120);