-- CREATE DATABASE testDatabase;

--USE testDatabase;

--CREATE TABLE dbo.[User] (
--	UserId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
--	FirstName VARCHAR(50) NOT NULL,
--	LastName VARCHAR(50) NOT NULL,
--	UserName VARCHAR(20) NOT NULL UNIQUE,
--	[Password] VARCHAR(32) NOT NULL,
--	CreationDate DATETIME2(3) NOT NULL DEFAULT GETDATE(),
--);

SET NOCOUNT ON;
INSERT INTO dbo.[User] (FirstName, LastName, UserName, [Password]) VALUES ('Mario', 'Rossi', 'mario.rossi2', 'mariorossibest');
INSERT INTO dbo.[User] (FirstName, LastName, UserName, [Password])
 OUTPUT inserted.*
 VALUES ('Mario', 'Rossi', 'mario.rossi2', 'mariorossibest');

SELECT * FROM dbo.[User];

UPDATE [User] 
SET FirstName = 'TEST', LastName = 'TEST', [Password] = 'testbest' 
OUTPUT inserted.*, '***', deleted.* 
WHERE UserId = 2;

DELETE FROM [User] OUTPUT deleted.* WHERE UserId = 2;

SELECT * FROM [User] WHERE [UserName] LIKE 'mario.rossi%';
SELECT * FROM [User] WHERE [CreationDate] BETWEEN '20260109' AND '20260109 10:19';
-- SELECT * FROM [User] WHERE [CreationDate] BETWEEN CAST(GETDATE() AS DATE) AND '20260109 10:19';
-- DATEADD(MINUTES, 19, DATEADD(HOUR, 10, CAST( CAST(GETDATE() AS DATE) AS DATETIME))); per scrivere la data alle 10:19
-- CONVERT(VARCHAR(10) CAST(GETDATE() AS DATE)) + ' 10:19'

TRUNCATE TABLE dbo.[User];

EXECUTE dbo.InsertUser 'Mario', 'Rossi', 'mario.rossi5', 'mariobest';
EXECUTE dbo.InsertUser @FirstName = 'Mario', @LastName = 'Rossi', @UserName = 'mario.rossi6', @Password = 'mariobest';
SELECT * FROM dbo.[User];

ALTER TABLE dbo.[User] ADD LastModificationDate DATETIME2(3);

UPDATE dbo.[User] SET LastModificationDate = GETDATE();