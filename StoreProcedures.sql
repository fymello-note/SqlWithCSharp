SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- sempre da mettere queste cose:
-- Author:		Matteo Massimello
-- Create date: 09-01-2026 12:16
-- Description:	It create a User in the User table.
-- nel caso in cui la modifichi aggiungere il proprio nome come Contributers, e anche last Review:
-- Contributers: Matteo (tipo)
-- Last Review: 09-01-2026 (tipo)
-- =============================================
CREATE PROCEDURE InsertUser  -- usp (utente store procedures) -> da usare al posto di sp (esempio usp_InsertUser)
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@UserName VARCHAR(20),
	@Password VARCHAR(32)
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO dbo.[User] (FirstName, LastName, UserName, [Password]) 
		VALUES (@FirstName, @LastName, @UserName, @Password);

END
GO
