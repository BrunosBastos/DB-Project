---UDFS-----
go 
CREATE FUNCTION Project.udf_check_email(@email VARCHAR(50)) RETURNS INT
AS
BEGIN
	IF EXISTS(SELECT * FROM Project.[User] AS U WHERE u.Email = @email)
		RETURN 1;
	RETURN 0;
END
GO

Create FUNCTION Project.udf_check_username(@username VARCHAR(50)) RETURNS INT
AS
BEGIN
	declare @temp as int
	set @temp = ( SELECT UserID FROM Project.Client AS C WHERE C.Username = @username);
	if @temp is null
		return 0;
	return @temp;
END
GO


GO
CREATE FUNCTION Project.udf_isadmin (@email VARCHAR(50)) RETURNS INT
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
CREATE FUNCTION Project.udf_isclient (@email VARCHAR(50)) RETURNS INT
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

CREATE FUNCTION Project.udf_checkusersgames(@IDClient INT) RETURNS TABLE
AS 
		RETURN ( SELECT Game.*  
		FROM (( Project.Purchase JOIN  Project.[Copy] ON Purchase.SerialNum = [Copy].SerialNum) 
		JOIN  Project.Game ON [Copy].IDGame = Game.IDGame ) 
		WHERE Purchase.IDClient = @IDClient )
GO
CREATE FUNCTION Project.[udf_countuserGames] (@IDClient INT) RETURNS INT
AS 
	begin
			DECLARE @counter AS INT;
			SELECT @counter= COUNT( IDGame) FROM Project.[udf_checkusersgames] (@IDClient);
	
				RETURN @counter
	end
GO

CREATE FUNCTION Project.udf_userfollowers (@IDClient INT) RETURNS TABLE
AS
	RETURN ( SELECT IDFollower FROM  Project.Follows WHERE Follows.IDFollowed =  @IDClient)

GO

create FUNCTION Project.[udf_countuserFollowers] (@IDClient INT) RETURNS INT
AS 
	begin
			DECLARE @counter AS INT;
			SELECT @counter= COUNT( IDFollower) FROM Project.[udf_userfollowers] (@IDClient);
			RETURN @counter
	end

GO



go
--Check the people that we follow that have a  specific game in common with the client itself 
create FUNCTION Project.udf_checkGameofFollows (@IDGame INT, @IDClient INT ) RETURNS TABLE
AS
	RETURN (SELECT  DISTINCT Client.UserID,Client.Username 
	FROM ( (Project.Follows
	JOIN Project.Purchase ON Purchase.IDClient = Follows.IDFollowed) 
	JOIN Project.Client ON Client.UserID = Follows.IDFollowed 
	JOIN Project.[Copy] ON ([Copy].SerialNum = Purchase.SerialNum) 
	JOIN Project.Game ON Game.IDGame= [Copy].IDGame)
	WHERE Follows.IDFollower = @IDClient and Game.IDGame=@IDGame)


GO

go
Create Function Project.udf_checkIfFollows(@IDFollower INT , @IDFollowed INT) Returns INT
as
	begin

		declare @temp as varchar(50)
		set @temp= ( Select IDFollowed From Project.Follows where IDFollowed=@IDFollowed and IDFollower=@IDFollower);
		if @temp is null
			return 0
		return 1

	end
go

--Get all Games that two users have in common 
GO
CREATE FUNCTION Project.udf_checkAllGamesinCommon (@IDClient INT, @IDPerson INT ) RETURNS TABLE
AS
	   RETURN (SELECT  Game.IDGame,Game.[Name] FROM  Project.Purchase 
		JOIN Project.[Copy] ON Purchase.SerialNum = [Copy].SerialNum
		JOIN Project.Game ON Game.IDGame = [Copy].IDGame 
		WHERE Purchase.IDClient = @IDClient  OR Purchase.IDClient = @IDPerson
		GROUP BY Game.IDGame,Game.[Name] HAVING COUNT(Game.IDGame) > 1 )
GO

CREATE FUNCTION Project.udf_getGameGenres (@IDGame INT) RETURNS TABLE 
AS
	RETURN (SELECT Genre.* FROM Project.GameGenre 
	JOIN Project.Game ON Game.IDGame = GameGenre.IDGame 
	JOIN Project.Genre ON Genre.GenName = GameGenre.GenName
	WHERE Game.IDGame = @IDGame ) 
GO

CREATE FUNCTION Project.udf_getGamePlataforms (@IDGame INT) RETURNS TABLE
AS
	RETURN (SELECT [Platform].* FROM Project.PlatformReleasesGame 
	JOIN Project.Game ON Game.IDGame = PlatformReleasesGame.IDGame 
	JOIN Project.[Platform] ON [Platform].PlatformName = PlatformReleasesGame.PlatformName
	WHERE Game.IDGame = @IDGame)
GO

GO
CREATE FUNCTION Project.udf_getPurchaseInfo (@IDGame INT,@IDClient INT) RETURNS TABLE
AS	
	RETURN (SELECT Purchase.*,Copy.PlatformName FROM Project.Purchase
	JOIN Project.[Copy] ON  Purchase.SerialNum = [Copy].SerialNum
	JOIN Project.Game ON Game.IDGame = [Copy].IDGame
	WHERE Purchase.IDClient = @IDClient AND Game.IDGame=@IDGame) 
GO


CREATE FUNCTION Project.udf_getGameDetails (@IDGame INT) RETURNS TABLE 
AS
	RETURN ( SELECT * FROM Game WHERE Game.IDGame = @IDGame)

GO


GO
CREATE FUNCTION Project.udf_getCompanyDetails (@IDCompany INT) RETURNS TABLE
AS
	RETURN ( SELECT * FROM Company WHERE Company.IDCompany = @IDCompany)
GO

go 
CREATE FUNCTION Project.udf_getReviewsList (@IDGame INT) RETURNS TABLE
AS
	RETURN ( SELECT Username,Title,Rating,[Text], Game.[Name],DateReview
	FROM (Project.Reviews JOIN Project.Client ON Reviews.UserID=Client.UserID) JOIN Project.Game ON Reviews.IDGame=Game.IDGame
	where Reviews.IDGame=@IDGame);
go
go
CREATE FUNCTION Project.[udf_getNumberOfReviews] (@IDGame INT) RETURNS INT
AS
	Begin
		DECLARE @ret as int;
		SELECT @ret=COUNT(IDReview) From Project.Reviews where Reviews.IDGame=@IDGame;
		return @ret;
	end

GO
go
CREATE FUNCTION Project.udf_getFranchiseDetails (@IDFranchise INT) RETURNS TABLE
AS
	RETURN ( SELECT * FROM Franchise WHERE Franchise.IDFranchise =@IDFranchise)
GO

CREATE FUNCTION Project.udf_getFranchisesComp (@IDCompany INT) RETURNS TABLE
AS
	RETURN (SELECT Franchise.IDFranchise,Franchise.[Name] FROM Project.Franchise  WHERE IDCompany = @IDCompany)

GO

CREATE FUNCTION Project.udf_getGamesFranchise (@IDFranchise INT) RETURNS TABLE
AS
	RETURN (SELECT Game.[Name] FROM Project.Franchise JOIN Project.Game ON Game.IDFranchise = Franchise.IDFranchise WHERE Franchise.IDFranchise=@IDFranchise) 
GO

CREATE FUNCTION Project.[udf_getNumberGameFranchises] (@IDFranchise INT) RETURNS INT
AS
	BEGIN
		DECLARE @counter INT;
		SElECT @counter = COUNT([Name]) FROM Project.[udf_getGamesFranchise] (@IDFranchise);
		RETURN @counter;
	END
GO


CREATE FUNCTION Project.udf_getCompGames (@IDCompany INT) RETURNS TABLE
AS
	RETURN ( SELECT Game.[Name] FROM Project.Game JOIN Project.Company ON Game.IDCompany = Company.IDCompany WHERE Company.IDCompany=@IDCompany)


GO

CREATE FUNCTION Project.[udf_getNumberCompGames] (@IDCompany INT) RETURNS INT
AS
	BEGIN
		DECLARE @counter INT;
		SElECT @counter = COUNT([Name]) FROM Project.udf_getCompGames (@IDCompany);
		RETURN @counter;
	END

GO


CREATE FUNCTION Project.[udf_getNumberFranchiseComp] (@IDCompany INT) RETURNS INT
AS
	BEGIN
		DECLARE @counter INT;
		SElECT @counter = COUNT(IDFranchise) FROM Project.[udf_getFranchisesComp] (@IDCompany);
		RETURN @counter;
	END
GO


CREATE FUNCTION Project.udf_checkReview (@IDClient INT, @IDGame INT) RETURNS INT
AS
BEGIN
		DECLARE @id as INT;
		DECLARE @temp as VARCHAR(50);
		set @temp = (SELECT IDReview FROM Project.Reviews JOIN Project.Game ON Game.IDGame = Reviews.IDGame  WHERE Reviews.UserID = @IDClient AND Game.IDGame = @IDGame)
		IF (@temp is null)  
			set @id=0;
		ELSE
			set @id=@temp;
		RETURN @id;
END
GO



CREATE FUNCTION Project.udf_checkGameCopies (@IDGame INT, @PlatformName VARCHAR(30)) RETURNS TABLE
AS
			RETURN( SELECT Copy.SerialNum as notBought
			FROM Project.[Copy]  
			WHERE @IDGame = [Copy].IDGame AND @PlatformName = [Copy].PlatformName EXCEPT SELECT [Copy].SerialNum FROM Project.Purchase JOIN Project.[Copy] ON [Copy].SerialNum = Purchase.SerialNum)
go

CREATE FUNCTION Project.udf_checkGameDiscount (@IDGame INT) RETURNS TABLE
AS
	RETURN (SELECT [Percentage] AS [Percentage] FROM Project.Game 
	JOIN Project.DiscountGame ON Game.IDGame =DiscountGame.IDGame 
	JOIN Project.Discount ON Discount.PromoCode =DiscountGame.PromoCode
	WHERE DATEDIFF(DAY,DateEnd,GETDATE()) <0  AND DATEDIFF(DAY,DateBegin,GETDATE()) >0 AND Game.IDGame=@IDGame)

GO




create Function Project.udf_getGenreDetails(@GenName Varchar(25)) Returns Table
as
	Return( Select * From Project.Genre where Genre.GenName=@GenName);
go


Create Function Project.udf_getGenreGames(@GenName Varchar(25)) Returns Table
as
	Return ( Select Name From Project.GameGenre Join Project.Game ON GameGenre.IDGame=Game.IDGame where GenName=@GenName);

go
Create Function Project.[udf_getNumberGenreGames](@GenName Varchar(25)) Returns int
as
	begin
	declare @temp as int
	SELECT @temp=COUNT(Name) FROM Project.udf_getGenreGames(@GenName);
	return @temp;
	end


go
create FUNCTION Project.udf_getPlatformDetails(@platformName Varchar(30)) returns table
as
	RETURN( SELECT * FROM Project.[Platform] where [Platform].PlatformName=@platformName);

go
go
Create Function Project.udf_getPlatformGames(@platformName Varchar(30)) returns table
as
	Return ( Select Game.Name from Project.PlatformReleasesGame 
	JOIN Project.Game ON Game.IDGame=PlatformReleasesGame.IDGame
	where PlatformReleasesGame.PlatformName=@platformName)

go
Create Function Project.[udf_getNumberPlatformGames](@platformName Varchar(30)) returns int
as
begin
	Declare @temp as int
	Select @temp = COUNT(Name) From Project.udf_getPlatformGames(@platformName);
	return @temp;
end
go

CREATE FUNCTION Project.[udf_checkUserPurchase] (@IDClient INT,@IDGame INT) RETURNS INT
AS
	BEGIN
	IF EXISTS ( SELECT TOP 1 Purchase.NumPurchase  FROM Project.Purchase JOIN Project.Copy ON Copy.SerialNum=Purchase.SerialNum WHERE Copy.IDGame=@IDGame AND Purchase.IDClient=@IDClient)
		RETURN 1
	RETURN 0
	END
GO
go
CREATE FUNCTION Project.[udf_mostSoldGames]() RETURNS TABLE
AS
	RETURN (SELECT  top 1000 COUNT(Game.IDGame) as CountPurchases,Game.IDGame, Game.[Name], SUM(Purchase.Price) as Revenue FROM Project.Purchase 
	JOIN Project.[Copy] ON [Copy].SerialNum=Purchase.SerialNum 
	JOIN Project.Game ON Game.IDGame = Copy.IDGame GROUP BY Game.IDGame,Game.Name,Purchase.Price ORDER BY CountPurchases DESC )

go
CREATE FUNCTION Project.udf_getTotalMoney() RETURNS TABLE
	RETURN((select SUM(Revenue) AS totMoney FROM Project.udf_mostSoldGames()))
go
CREATE FUNCTION Project.[udf_leastSoldGames]() RETURNS TABLE
AS
	RETURN (SELECT  top 1000 COUNT(Game.IDGame) as CountPurchases,Game.IDGame, Game.[Name] FROM Project.Purchase 
	JOIN Project.[Copy] ON [Copy].SerialNum=Purchase.SerialNum 
	JOIN Project.Game ON Game.IDGame = Copy.IDGame GROUP BY Game.IDGame,Game.Name ORDER BY CountPurchases ASC )

GO


CREATE FUNCTION Project.udf_mostMoneySpent() RETURNS TABLE
AS
	RETURN (SELECT TOP 1000 IDClient,SUM(ValueCredit) AS Total FROM Project.Credit JOIN Project.Client ON Client.UserID=Credit.IDClient GROUP BY IDClient,ValueCredit order BY Total DESC)

GO
CREATE FUNCTION Project.udf_most_Sold_Genres() RETURNS TABLE
AS
	RETURN ( SELECT GenName,CountPurchases FROM (SELECT IDGame AS TempIDGame,CountPurchases FROM  Project.[udf_mostSoldGames]())
	AS p JOIN Project.Game ON Game.IDGame=TempIDGame 
	JOIN Project.GameGenre ON GameGenre.IDGame=Game.IDGame)
go

GO
CREATE FUNCTION Project.udf_most_Sold_Platforms() RETURNS TABLE
AS
	RETURN ( SELECT PlatformName,CountPurchases FROM (SELECT IDGame AS TempIDGame,CountPurchases FROM  Project.[udf_mostSoldGames]())
	AS p JOIN Project.Game ON Game.IDGame=TempIDGame 
	JOIN Project.PlatformReleasesGame ON PlatformReleasesGame.IDGame=Game.IDGame)


GO
go
CREATE FUNCTION Project.udf_favComp( @IDClient INT) RETURNS TABLE
AS
    RETURN (SELECT TOP 1 CompanyName, COUNT(CompanyName)  as totComp 
    FROM ( ( SELECT IDCompany as IDComp  FROM Project.udf_checkusersgames (@IDClient) )
    AS p  JOIN   Project.Company on Company.IDCompany = IDComp) GROUP BY CompanyName ORDER BY totComp DESC )
GO

CREATE FUNCTION Project.udf_favGenre( @IDClient INT) RETURNS TABLE
AS
    RETURN (SELECT TOP 1 GenName, COUNT(GenName) as totGen 
    FROM ( ( SELECT IDGame as IDGameTemp  FROM Project.udf_checkusersgames (@IDClient) )
    AS p  JOIN   Project.GameGenre on GameGenre.IDGame = IDGameTemp) GROUP BY GenName ORDER BY totGen DESC )
GO


CREATE FUNCTION Project.udf_favPlatform( @IDClient INT) RETURNS TABLE
AS
    RETURN ( SELECT TOP 1 PlatformName,COUNT(PlatformName) AS totPlat 
    FROM Project.[Copy] JOIN Project.[Purchase] ON [Copy].SerialNum = [Purchase].SerialNum 
    WHERE Purchase.IDClient = @IDClient 
    GROUP BY PlatformName ORDER BY totPlat DESC )
GO

go
CREATE FUNCTION Project.udf_favFran( @IDClient INT) RETURNS TABLE
AS
    RETURN (SELECT TOP 1 Franchise.[Name], COUNT(Franchise.[Name])  as totComp 
    FROM ( ( SELECT IDFranchise as IDFran  FROM Project.udf_checkusersgames (@IDClient) )
    AS p  JOIN Project.Franchise on Franchise.IDFranchise = IDFran) GROUP BY Franchise.[Name] ORDER BY totComp DESC )
go
