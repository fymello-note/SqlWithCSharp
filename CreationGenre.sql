USE testDatabase;


SELECT film.FilmId, film.Title, film.ReleaseDate, film.Producer, film.Director, genre.[Name] 
From dbo.Film as film inner join dbo.Genre as genre
on Film.GenreId = Genre.GenreId;

SELECT * FROM [Film];

--CREATE TABLE Genre (
--	GenreId SMALLINT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
--	[Name] VARCHAR(50) NOT NULL
--);

SET IDENTITY_INSERT dbo.Genre ON;

INSERT INTO dbo.Genre (GenreId, [Name]) VALUES (1, 'Azione'), (2, 'Romantico'), (3, 'Avventura');

SET IDENTITY_INSERT dbo.Genre OFF;

INSERT INTO dbo.Genre ([Name]) OUTPUT inserted.* VALUES ('Thriller');

-- int (o Int32) -> INT 32 bit
-- short (o Int16) -> SMALLINT 16 bit
-- byte -> TINYINT -- 8 bit (255)

ALTER TABLE Film ADD GenreId SMALLINT NULL FOREIGN KEY REFERENCES dbo.Genre(GenreId);

UPDATE dbo.Film SET GenreId = 1;

ALTER TABLE Film ALTER COLUMN GenreId SMALLINT NOT NULL;