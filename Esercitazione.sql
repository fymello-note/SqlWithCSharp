Use EsercitazioneDb;

/*CREATE TABLE [User] (
	UserId INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	UserName VARCHAR(100) NOT NULL,
	[Password] varchar(32) NOT NULL,
	Flag_Form BIT NOT NULL default 0,
	CreationDate DATETIME2(3) NOT NULL DEFAULT GETDATE(),
	CompileDate DATETIME2(3) NULL DEFAULT NULL
);

CREATE TABLE [Question] (
	QuestionId SMALLINT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
	[Text] VARCHAR(max) NOT NULL
);*/

/*INSERT INTO dbo.[User](FirstName, LastName, UserName, [Password]) VALUES ('Matteo', 'Massimello', 'Matteo.Massimello', 'Matteobest1!');*/

select * from [User];

INSERT INTO [Question]([Text]) VALUES ('Hai la patente?');

CREATE TABLE Answer (
	AnswerId INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
	QuestionId SMALLINT NOT NULL FOREIGN KEY REFERENCES [Question] (QuestionId),
	UserId INT NOT NULL FOREIGN KEY REFERENCES [User] (UserId),
	Answer BIT NOT NULL
);

ALTER TABLE Answer DROP COLUMN Answer
ALTER TABLE Answer ADD AnswerValue bit not null

alter table Answer ADD CONSTRAINT UQ_Answer_QuestionId_UserId UNIQUE (QuestionId, UserId);

SELECT * FROM Answer;

TRUNCATE TABLE Answer;

UPDATE [User] SET Flag_Form = 0;

INSERT INTO dbo.[User](FirstName, LastName, UserName, [Password]) VALUES ('Ciccio', 'Merlino', 'Ciccio.Merlino', '123');