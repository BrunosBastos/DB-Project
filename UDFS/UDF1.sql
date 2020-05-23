CREATE FUNCTION Project.[udf_check_email](@email VARCHAR(50)) RETURNS INT
AS
BEGIN
	IF EXISTS(SELECT * FROM Project.[User] AS U WHERE u.Email = @email)
		RETURN 1;
	RETURN 0;
END
GO

CREATE FUNCTION Project.[udf_check_username](@username VARCHAR(50)) RETURNS INT
AS
BEGIN
	IF EXISTS(SELECT * FROM Project.Client AS C WHERE C.Username = @username)
		RETURN 1;
	RETURN 0;
END
GO


GO
CREATE FUNCTION Project.[udf_isadmin] (@email VARCHAR(50)) RETURNS INT
AS
BEGIN
	  declare @temp varchar(50)
	  declare @id INT --gets the admin id,
	  set @temp= (SELECT  [Admin].UserID  FROM (Project.[User] JOIN Project.[Admin] on [User].UserID = [Admin].UserID ) WHERE Email = @email);
	  if  (@temp is null)
		 set @id=0;
	  else
		 set @id=@temp	
	  RETURN @id;
END
GO


GO
CREATE FUNCTION Project.[udf_isclient] (@email VARCHAR(50)) RETURNS INT
AS
BEGIN
	  declare @temp varchar(50)
	  declare @id INT --gets the client id,
	  set @temp= (SELECT  Client.UserID  FROM (Project.[User] JOIN Project.Client on [User].UserID = Client.UserID ) WHERE Email = @email);
	  if  (@temp is null)
		 set @id=0;
	  else
		 set @id=@temp	
	  RETURN @id;
END
GO


CREATE FUNCTION Project.[udf_checkusersgames](@IDClient INT) RETURNS TABLE
AS 
		RETURN ( SELECT Game.*  
		FROM (( Project.Purchase JOIN  Project.[Copy] ON Purchase.SerialNum = [Copy].SerialNum) 
		JOIN  Project.Game ON [Copy].IDGame = Game.IDGame ) 
		WHERE Purchase.IDClient = @IDClient )
GO
SELECT * FROM Project.[udf_checkusersgames] (5)
SELECT * FROM Project.[udf_checkusersgames] (10)

GO
CREATE FUNCTION Project.[udf_countuserGames] (@IDClient INT) RETURNS INT
AS 
	begin
			DECLARE @counter AS INT;
			SELECT @counter= COUNT( IDGame) FROM Project.[udf_checkusersgames] (@IDClient);
	
				RETURN @counter
	end
GO
CREATE FUNCTION Project.[udf_userfollowers] (@IDClient INT) RETURNS TABLE
AS
	RETURN ( SELECT IDFollower FROM  Project.Follows WHERE Follows.IDFollowed =  @IDClient)

GO

SELECT * FROM Project.[udf_userfollowers] (2)

go

CREATE FUNCTION Project.[udf_countuserFollwers] (@IDClient INT) RETURNS INT
AS 
	begin
			DECLARE @counter AS INT;
			SELECT @counter= COUNT( IDFollower) FROM Project.[udf_userfollowers] (@IDClient);
			RETURN @counter
	end
GO
SELECT  Project.[udf_countuserFollwers] (2)

GO


--Check the people that we follow that have a  specific game in common with the client itself 
CREATE FUNCTION Project.[udf_checkGameofFollows] (@IDGame INT, @IDClient INT ) RETURNS TABLE
AS
	RETURN (SELECT  DISTINCT Client.UserID,Client.Username 
	FROM ( (Project.Follows
	JOIN Project.Purchase ON Purchase.IDClient = Follows.IDFollowed) 
	JOIN Project.Client ON Client.UserID = Follows.IDFollowed 
	JOIN Project.[Copy] ON ([Copy].SerialNum = Purchase.SerialNum) 
	JOIN Project.Game ON Game.IDGame= @IDGame)
	WHERE Follows.IDFollower = @IDClient)


go

SELECT * FROM Project.udf_checkGameofFollows (3,2);
GO


--Get all Games that two users have in common 
go
CREATE FUNCTION Project.[udf_checkAllGamesinCommon] (@IDClient INT, @IDPerson INT ) RETURNS TABLE
AS
	   RETURN (SELECT  Game.IDGame,Game.[Name] FROM  Project.Purchase 
		JOIN Project.[Copy] ON Purchase.SerialNum = [Copy].SerialNum
		JOIN Project.Game ON Game.IDGame = [Copy].IDGame 
		WHERE Purchase.IDClient = @IDClient  OR Purchase.IDClient = @IDPerson
		GROUP BY Game.IDGame,Game.[Name] HAVING COUNT(Game.IDGame) > 1 )
GO


/*
 (

	*/
go
SELECT * FROM Project.[udf_checkAllGamesinCommon] (2,5);
/*
create FUNCTION Project.[udf_getfranchise] (@IDGame INT) RETURNS TABLE
	RETURN (SELECT DISTINCT Franchise. * FROM ( Project.Game JOIN Project.Franchise ON Game.IDFranchise = Franchise.IDFranchise) WHERE Game.IDGame = @IDGame )
	GO
SELECT * FROM Project.[udf_getfranchise](4)
*/


SELECT * FROM  Project.[User]
