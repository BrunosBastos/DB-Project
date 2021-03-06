USE [p6g2]
GO
/****** Object:  User [p6g2]    Script Date: 12/06/2020 19:11:58 ******/
CREATE USER [p6g2] FOR LOGIN [p6g2] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [p6g2]
GO
/****** Object:  Schema [Project]    Script Date: 12/06/2020 19:11:58 ******/
CREATE SCHEMA [Project]
GO
/****** Object:  UserDefinedFunction [Project].[udf_check_email]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_check_email](@email VARCHAR(50)) RETURNS INT
AS
BEGIN
	IF EXISTS(SELECT * FROM Project.[User] AS U WHERE u.Email = @email)
		RETURN 1;
	RETURN 0;
END
GO
/****** Object:  UserDefinedFunction [Project].[udf_check_username]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create FUNCTION [Project].[udf_check_username](@username VARCHAR(50)) RETURNS INT
AS
BEGIN
	declare @temp as int
	set @temp = ( SELECT UserID FROM Project.Client AS C WHERE C.Username = @username);
	if @temp is null
		return 0;
	return @temp;
END
GO
/****** Object:  UserDefinedFunction [Project].[udf_checkIfFollows]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [Project].[udf_checkIfFollows](@IDFollower INT , @IDFollowed INT) Returns INT
as
	begin

		declare @temp as varchar(50)
		set @temp= ( Select IDFollowed From Project.Follows where IDFollowed=@IDFollowed and IDFollower=@IDFollower);
		if @temp is null
			return 0
		return 1

	end
GO
/****** Object:  UserDefinedFunction [Project].[udf_checkReview]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [Project].[udf_checkReview] (@IDClient INT, @IDGame INT) RETURNS INT
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
/****** Object:  UserDefinedFunction [Project].[udf_checkUserPurchase]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_checkUserPurchase] (@IDClient INT,@IDGame INT) RETURNS INT
AS
	BEGIN
	IF EXISTS ( SELECT TOP 1 Purchase.NumPurchase  FROM Project.Purchase JOIN Project.Copy ON Copy.SerialNum=Purchase.SerialNum WHERE Copy.IDGame=@IDGame AND Purchase.IDClient=@IDClient)
		RETURN 1
	RETURN 0
	END
GO
/****** Object:  UserDefinedFunction [Project].[udf_countuserFollowers]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [Project].[udf_countuserFollowers] (@IDClient INT) RETURNS INT
AS 
	begin
			DECLARE @counter AS INT;
			SELECT @counter= COUNT( IDFollower) FROM Project.[udf_userfollowers] (@IDClient);
			RETURN @counter
	end

GO
/****** Object:  UserDefinedFunction [Project].[udf_countuserGames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_countuserGames] (@IDClient INT) RETURNS INT
AS 
	begin
			DECLARE @counter AS INT;
			SELECT @counter= COUNT( IDGame) FROM Project.[udf_checkusersgames] (@IDClient);
	
				RETURN @counter
	end
GO
/****** Object:  UserDefinedFunction [Project].[udf_getNumberCompGames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_getNumberCompGames] (@IDCompany INT) RETURNS INT
AS
	BEGIN
		DECLARE @counter INT;
		SElECT @counter = COUNT([Name]) FROM Project.udf_getCompGames (@IDCompany);
		RETURN @counter;
	END

GO
/****** Object:  UserDefinedFunction [Project].[udf_getNumberFranchiseComp]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [Project].[udf_getNumberFranchiseComp] (@IDCompany INT) RETURNS INT
AS
	BEGIN
		DECLARE @counter INT;
		SElECT @counter = COUNT(IDFranchise) FROM Project.[udf_getFranchisesComp] (@IDCompany);
		RETURN @counter;
	END
GO
/****** Object:  UserDefinedFunction [Project].[udf_getNumberGameFranchises]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_getNumberGameFranchises] (@IDFranchise INT) RETURNS INT
AS
	BEGIN
		DECLARE @counter INT;
		SElECT @counter = COUNT([Name]) FROM Project.[udf_getGamesFranchise] (@IDFranchise);
		RETURN @counter;
	END
GO
/****** Object:  UserDefinedFunction [Project].[udf_getNumberGenreGames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [Project].[udf_getNumberGenreGames](@GenName Varchar(25)) Returns int
as
	begin
	declare @temp as int
	SELECT @temp=COUNT(Name) FROM Project.udf_getGenreGames(@GenName);
	return @temp;
	end


GO
/****** Object:  UserDefinedFunction [Project].[udf_getNumberOfReviews]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_getNumberOfReviews] (@IDGame INT) RETURNS INT
AS
	Begin
		DECLARE @ret as int;
		SELECT @ret=COUNT(IDReview) From Project.Reviews where Reviews.IDGame=@IDGame;
		return @ret;
	end

GO
/****** Object:  UserDefinedFunction [Project].[udf_getNumberPlatformGames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [Project].[udf_getNumberPlatformGames](@platformName Varchar(30)) returns int
as
begin
	Declare @temp as int
	Select @temp = COUNT(Name) From Project.udf_getPlatformGames(@platformName);
	return @temp;
end
GO
/****** Object:  UserDefinedFunction [Project].[udf_isadmin]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_isadmin] (@email VARCHAR(50)) RETURNS INT
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
/****** Object:  UserDefinedFunction [Project].[udf_isclient]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_isclient] (@email VARCHAR(50)) RETURNS INT
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
/****** Object:  Table [Project].[Purchase]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Purchase](
	[NumPurchase] [int] IDENTITY(1,1) NOT NULL,
	[Price] [decimal](5, 2) NOT NULL,
	[PurchaseDate] [date] NOT NULL,
	[IDClient] [int] NOT NULL,
	[SerialNum] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NumPurchase] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Project].[Game]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Game](
	[IDGame] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](max) NULL,
	[ReleaseDate] [date] NOT NULL,
	[AgeRestriction] [int] NOT NULL,
	[CoverImg] [varchar](max) NULL,
	[Price] [decimal](5, 2) NOT NULL,
	[IDCompany] [int] NOT NULL,
	[IDFranchise] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDGame] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Project].[Copy]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Copy](
	[SerialNum] [int] IDENTITY(100000,1) NOT NULL,
	[IDGame] [int] NOT NULL,
	[PlatformName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SerialNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_checkusersgames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_checkusersgames](@IDClient INT) RETURNS TABLE
AS 
		RETURN ( SELECT Game.*  
		FROM (( Project.Purchase JOIN  Project.[Copy] ON Purchase.SerialNum = [Copy].SerialNum) 
		JOIN  Project.Game ON [Copy].IDGame = Game.IDGame ) 
		WHERE Purchase.IDClient = @IDClient )
GO
/****** Object:  Table [Project].[Follows]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Follows](
	[IDFollower] [int] NOT NULL,
	[IDFollowed] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDFollower] ASC,
	[IDFollowed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_userfollowers]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_userfollowers] (@IDClient INT) RETURNS TABLE
AS
	RETURN ( SELECT IDFollower FROM  Project.Follows WHERE Follows.IDFollowed =  @IDClient)

GO
/****** Object:  Table [Project].[Client]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Client](
	[UserID] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[FullName] [varchar](max) NULL,
	[Sex] [char](1) NULL,
	[Birth] [date] NULL,
	[Balance] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_checkGameofFollows]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Check the people that we follow that have a  specific game in common with the client itself 
create FUNCTION [Project].[udf_checkGameofFollows] (@IDGame INT, @IDClient INT ) RETURNS TABLE
AS
	RETURN (SELECT  DISTINCT Client.UserID,Client.Username 
	FROM ( (Project.Follows
	JOIN Project.Purchase ON Purchase.IDClient = Follows.IDFollowed) 
	JOIN Project.Client ON Client.UserID = Follows.IDFollowed 
	JOIN Project.[Copy] ON ([Copy].SerialNum = Purchase.SerialNum) 
	JOIN Project.Game ON Game.IDGame= [Copy].IDGame)
	WHERE Follows.IDFollower = @IDClient and Game.IDGame=@IDGame)


GO
/****** Object:  UserDefinedFunction [Project].[udf_checkAllGamesinCommon]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_checkAllGamesinCommon] (@IDClient INT, @IDPerson INT ) RETURNS TABLE
AS
	   RETURN (SELECT  Game.IDGame,Game.[Name] FROM  Project.Purchase 
		JOIN Project.[Copy] ON Purchase.SerialNum = [Copy].SerialNum
		JOIN Project.Game ON Game.IDGame = [Copy].IDGame 
		WHERE Purchase.IDClient = @IDClient  OR Purchase.IDClient = @IDPerson
		GROUP BY Game.IDGame,Game.[Name] HAVING COUNT(Game.IDGame) > 1 )
GO
/****** Object:  Table [Project].[Genre]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Genre](
	[GenName] [varchar](25) NOT NULL,
	[Description] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[GenName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Project].[GameGenre]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[GameGenre](
	[IDGame] [int] NOT NULL,
	[GenName] [varchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDGame] ASC,
	[GenName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_getGameGenres]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_getGameGenres] (@IDGame INT) RETURNS TABLE 
AS
	RETURN (SELECT Genre.* FROM Project.GameGenre 
	JOIN Project.Game ON Game.IDGame = GameGenre.IDGame 
	JOIN Project.Genre ON Genre.GenName = GameGenre.GenName
	WHERE Game.IDGame = @IDGame ) 
GO
/****** Object:  Table [Project].[Platform]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Platform](
	[PlatformName] [varchar](30) NOT NULL,
	[ReleaseDate] [date] NOT NULL,
	[Producer] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PlatformName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Project].[PlatformReleasesGame]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[PlatformReleasesGame](
	[IDGame] [int] NOT NULL,
	[PlatformName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDGame] ASC,
	[PlatformName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_getGamePlataforms]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_getGamePlataforms] (@IDGame INT) RETURNS TABLE
AS
	RETURN (SELECT [Platform].* FROM Project.PlatformReleasesGame 
	JOIN Project.Game ON Game.IDGame = PlatformReleasesGame.IDGame 
	JOIN Project.[Platform] ON [Platform].PlatformName = PlatformReleasesGame.PlatformName
	WHERE Game.IDGame = @IDGame)
GO
/****** Object:  UserDefinedFunction [Project].[udf_getPurchaseInfo]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_getPurchaseInfo] (@IDGame INT,@IDClient INT) RETURNS TABLE
AS	
	RETURN (SELECT Purchase.*,Copy.PlatformName FROM Project.Purchase
	JOIN Project.[Copy] ON  Purchase.SerialNum = [Copy].SerialNum
	JOIN Project.Game ON Game.IDGame = [Copy].IDGame
	WHERE Purchase.IDClient = @IDClient AND Game.IDGame=@IDGame) 
GO
/****** Object:  UserDefinedFunction [Project].[udf_getGameDetails]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [Project].[udf_getGameDetails] (@IDGame INT) RETURNS TABLE 
AS
	RETURN ( SELECT * FROM Game WHERE Game.IDGame = @IDGame)

GO
/****** Object:  Table [Project].[Company]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Company](
	[IDCompany] [int] IDENTITY(1,1) NOT NULL,
	[Contact] [varchar](50) NULL,
	[CompanyName] [varchar](30) NOT NULL,
	[Website] [varchar](50) NOT NULL,
	[Logo] [varchar](max) NULL,
	[FoundationDate] [date] NULL,
	[City] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[IDCompany] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_getCompanyDetails]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_getCompanyDetails] (@IDCompany INT) RETURNS TABLE
AS
	RETURN ( SELECT * FROM Company WHERE Company.IDCompany = @IDCompany)
GO
/****** Object:  Table [Project].[Reviews]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Reviews](
	[IDReview] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Text] [varchar](280) NOT NULL,
	[Rating] [decimal](2, 1) NOT NULL,
	[DateReview] [date] NOT NULL,
	[UserID] [int] NOT NULL,
	[IDGame] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDReview] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_getReviewsList]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_getReviewsList] (@IDGame INT) RETURNS TABLE
AS
	RETURN ( SELECT Username,Title,Rating,[Text], Game.[Name],DateReview
	FROM (Project.Reviews JOIN Project.Client ON Reviews.UserID=Client.UserID) JOIN Project.Game ON Reviews.IDGame=Game.IDGame
	where Reviews.IDGame=@IDGame);
GO
/****** Object:  Table [Project].[Franchise]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Franchise](
	[IDFranchise] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Logo] [varchar](max) NULL,
	[IDCompany] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IDFranchise] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_getFranchiseDetails]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_getFranchiseDetails] (@IDFranchise INT) RETURNS TABLE
AS
	RETURN ( SELECT * FROM Franchise WHERE Franchise.IDFranchise =@IDFranchise)
GO
/****** Object:  UserDefinedFunction [Project].[udf_getFranchisesComp]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_getFranchisesComp] (@IDCompany INT) RETURNS TABLE
AS
	RETURN (SELECT Franchise.IDFranchise,Franchise.[Name] FROM Project.Franchise  WHERE IDCompany = @IDCompany)

GO
/****** Object:  UserDefinedFunction [Project].[udf_getGamesFranchise]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_getGamesFranchise] (@IDFranchise INT) RETURNS TABLE
AS
	RETURN (SELECT Game.[Name] FROM Project.Franchise JOIN Project.Game ON Game.IDFranchise = Franchise.IDFranchise WHERE Franchise.IDFranchise=@IDFranchise) 
GO
/****** Object:  UserDefinedFunction [Project].[udf_getCompGames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [Project].[udf_getCompGames] (@IDCompany INT) RETURNS TABLE
AS
	RETURN ( SELECT Game.[Name] FROM Project.Game JOIN Project.Company ON Game.IDCompany = Company.IDCompany WHERE Company.IDCompany=@IDCompany)


GO
/****** Object:  UserDefinedFunction [Project].[udf_checkGameCopies]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [Project].[udf_checkGameCopies] (@IDGame INT, @PlatformName VARCHAR(30)) RETURNS TABLE
AS
			RETURN( SELECT Copy.SerialNum as notBought
			FROM Project.[Copy]  
			WHERE @IDGame = [Copy].IDGame AND @PlatformName = [Copy].PlatformName EXCEPT SELECT [Copy].SerialNum FROM Project.Purchase JOIN Project.[Copy] ON [Copy].SerialNum = Purchase.SerialNum)
GO
/****** Object:  Table [Project].[Discount]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Discount](
	[PromoCode] [int] NOT NULL,
	[Percentage] [int] NOT NULL,
	[DateBegin] [date] NOT NULL,
	[DateEnd] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PromoCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Project].[DiscountGame]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[DiscountGame](
	[PromoCode] [int] NOT NULL,
	[IDGame] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PromoCode] ASC,
	[IDGame] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_checkGameDiscount]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_checkGameDiscount] (@IDGame INT) RETURNS TABLE
AS
	RETURN (SELECT [Percentage] AS [Percentage] FROM Project.Game 
	JOIN Project.DiscountGame ON Game.IDGame =DiscountGame.IDGame 
	JOIN Project.Discount ON Discount.PromoCode =DiscountGame.PromoCode
	WHERE DATEDIFF(DAY,DateEnd,GETDATE()) <0  AND DATEDIFF(DAY,DateBegin,GETDATE()) >0 AND Game.IDGame=@IDGame)

GO
/****** Object:  UserDefinedFunction [Project].[udf_getGenreDetails]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create Function [Project].[udf_getGenreDetails](@GenName Varchar(25)) Returns Table
as
	Return( Select * From Project.Genre where Genre.GenName=@GenName);
GO
/****** Object:  UserDefinedFunction [Project].[udf_getGenreGames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create Function [Project].[udf_getGenreGames](@GenName Varchar(25)) Returns Table
as
	Return ( Select Name From Project.GameGenre Join Project.Game ON GameGenre.IDGame=Game.IDGame where GenName=@GenName);

GO
/****** Object:  UserDefinedFunction [Project].[udf_getPlatformDetails]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [Project].[udf_getPlatformDetails](@platformName Varchar(30)) returns table
as
	RETURN( SELECT * FROM Project.[Platform] where [Platform].PlatformName=@platformName);

GO
/****** Object:  UserDefinedFunction [Project].[udf_getPlatformGames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function [Project].[udf_getPlatformGames](@platformName Varchar(30)) returns table
as
	Return ( Select Game.Name from Project.PlatformReleasesGame 
	JOIN Project.Game ON Game.IDGame=PlatformReleasesGame.IDGame
	where PlatformReleasesGame.PlatformName=@platformName)

GO
/****** Object:  UserDefinedFunction [Project].[udf_mostSoldGames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_mostSoldGames]() RETURNS TABLE
AS
	RETURN (SELECT  top 1000 COUNT(Game.IDGame) as CountPurchases,Game.IDGame, Game.[Name], SUM(Purchase.Price) as Revenue FROM Project.Purchase 
	JOIN Project.[Copy] ON [Copy].SerialNum=Purchase.SerialNum 
	JOIN Project.Game ON Game.IDGame = Copy.IDGame GROUP BY Game.IDGame,Game.Name,Purchase.Price ORDER BY CountPurchases DESC )

GO
/****** Object:  UserDefinedFunction [Project].[udf_getTotalMoney]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_getTotalMoney]() RETURNS TABLE
	RETURN((select SUM(Revenue) AS totMoney FROM Project.udf_mostSoldGames()))
GO
/****** Object:  UserDefinedFunction [Project].[udf_leastSoldGames]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_leastSoldGames]() RETURNS TABLE
AS
	RETURN (SELECT  top 1000 COUNT(Game.IDGame) as CountPurchases,Game.IDGame, Game.[Name] FROM Project.Purchase 
	JOIN Project.[Copy] ON [Copy].SerialNum=Purchase.SerialNum 
	JOIN Project.Game ON Game.IDGame = Copy.IDGame GROUP BY Game.IDGame,Game.Name ORDER BY CountPurchases ASC )

GO
/****** Object:  Table [Project].[Credit]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Credit](
	[NumCredit] [int] IDENTITY(1,1) NOT NULL,
	[MetCredit] [varchar](20) NOT NULL,
	[DateCredit] [date] NOT NULL,
	[ValueCredit] [decimal](4, 2) NOT NULL,
	[IDClient] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NumCredit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [Project].[udf_mostMoneySpent]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [Project].[udf_mostMoneySpent]() RETURNS TABLE
AS
	RETURN (SELECT TOP 1000 IDClient,SUM(ValueCredit) AS Total FROM Project.Credit JOIN Project.Client ON Client.UserID=Credit.IDClient GROUP BY IDClient,ValueCredit order BY Total DESC)

GO
/****** Object:  UserDefinedFunction [Project].[udf_most_Sold_Genres]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_most_Sold_Genres]() RETURNS TABLE
AS
	RETURN ( SELECT GenName,CountPurchases FROM (SELECT IDGame AS TempIDGame,CountPurchases FROM  Project.[udf_mostSoldGames]())
	AS p JOIN Project.Game ON Game.IDGame=TempIDGame 
	JOIN Project.GameGenre ON GameGenre.IDGame=Game.IDGame)
GO
/****** Object:  UserDefinedFunction [Project].[udf_most_Sold_Platforms]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_most_Sold_Platforms]() RETURNS TABLE
AS
	RETURN ( SELECT PlatformName,CountPurchases FROM (SELECT IDGame AS TempIDGame,CountPurchases FROM  Project.[udf_mostSoldGames]())
	AS p JOIN Project.Game ON Game.IDGame=TempIDGame 
	JOIN Project.PlatformReleasesGame ON PlatformReleasesGame.IDGame=Game.IDGame)


GO
/****** Object:  UserDefinedFunction [Project].[udf_favComp]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_favComp]( @IDClient INT) RETURNS TABLE
AS
    RETURN (SELECT TOP 1 CompanyName, COUNT(CompanyName)  as totComp 
    FROM ( ( SELECT IDCompany as IDComp  FROM Project.udf_checkusersgames (@IDClient) )
    AS p  JOIN   Project.Company on Company.IDCompany = IDComp) GROUP BY CompanyName ORDER BY totComp DESC )
GO
/****** Object:  UserDefinedFunction [Project].[udf_favGenre]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [Project].[udf_favGenre]( @IDClient INT) RETURNS TABLE
AS
    RETURN (SELECT TOP 1 GenName, COUNT(GenName) as totGen 
    FROM ( ( SELECT IDGame as IDGameTemp  FROM Project.udf_checkusersgames (@IDClient) )
    AS p  JOIN   Project.GameGenre on GameGenre.IDGame = IDGameTemp) GROUP BY GenName ORDER BY totGen DESC )
GO
/****** Object:  UserDefinedFunction [Project].[udf_favPlatform]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [Project].[udf_favPlatform]( @IDClient INT) RETURNS TABLE
AS
    RETURN ( SELECT TOP 1 PlatformName,COUNT(PlatformName) AS totPlat 
    FROM Project.[Copy] JOIN Project.[Purchase] ON [Copy].SerialNum = [Purchase].SerialNum 
    WHERE Purchase.IDClient = @IDClient 
    GROUP BY PlatformName ORDER BY totPlat DESC )
GO
/****** Object:  UserDefinedFunction [Project].[udf_favFran]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [Project].[udf_favFran]( @IDClient INT) RETURNS TABLE
AS
    RETURN (SELECT TOP 1 Franchise.[Name], COUNT(Franchise.[Name])  as totComp 
    FROM ( ( SELECT IDFranchise as IDFran  FROM Project.udf_checkusersgames (@IDClient) )
    AS p  JOIN Project.Franchise on Franchise.IDFranchise = IDFran) GROUP BY Franchise.[Name] ORDER BY totComp DESC )
GO
/****** Object:  Table [Project].[Admin]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[Admin](
	[UserID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Project].[User]    Script Date: 12/06/2020 19:11:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Project].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varbinary](64) NOT NULL,
	[RegisterDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [Project].[Admin] ([UserID]) VALUES (1)
INSERT [Project].[Client] ([UserID], [Username], [FullName], [Sex], [Birth], [Balance]) VALUES (2, N'JohnyS', N'John Kerry Smith', N'M', CAST(N'2000-10-05' AS Date), CAST(12.00 AS Decimal(5, 2)))
INSERT [Project].[Client] ([UserID], [Username], [FullName], [Sex], [Birth], [Balance]) VALUES (3, N'NKimmy', N'Nancy Black Kim', N'F', CAST(N'1999-01-01' AS Date), CAST(0.00 AS Decimal(5, 2)))
INSERT [Project].[Client] ([UserID], [Username], [FullName], [Sex], [Birth], [Balance]) VALUES (4, N'TimJ0Carrey', N'Tim John Carrey', N'M', CAST(N'1993-04-15' AS Date), CAST(32.56 AS Decimal(5, 2)))
INSERT [Project].[Client] ([UserID], [Username], [FullName], [Sex], [Birth], [Balance]) VALUES (5, N'CorKareembett', N'Kareem Zinca Corbett', N'F', CAST(N'1975-12-13' AS Date), CAST(9.99 AS Decimal(5, 2)))
INSERT [Project].[Client] ([UserID], [Username], [FullName], [Sex], [Birth], [Balance]) VALUES (6, N'Aceu', N'Coco Nava', N'M', CAST(N'1990-10-20' AS Date), CAST(0.00 AS Decimal(5, 2)))
INSERT [Project].[Client] ([UserID], [Username], [FullName], [Sex], [Birth], [Balance]) VALUES (7, N'Shroud', N'Dominik Billy White Armstrong Stokes', N'M', CAST(N'1978-05-12' AS Date), CAST(0.00 AS Decimal(5, 2)))
INSERT [Project].[Client] ([UserID], [Username], [FullName], [Sex], [Birth], [Balance]) VALUES (8, N'Zorlakoka', N'Wesley Marvel Shields', N'M', CAST(N'1983-03-15' AS Date), CAST(0.00 AS Decimal(5, 2)))
INSERT [Project].[Client] ([UserID], [Username], [FullName], [Sex], [Birth], [Balance]) VALUES (9, N'Leav0n', N'Leandro Leonardo Lionel Silva', N'M', CAST(N'2000-09-19' AS Date), CAST(0.00 AS Decimal(5, 2)))
INSERT [Project].[Client] ([UserID], [Username], [FullName], [Sex], [Birth], [Balance]) VALUES (10, N'AceDestiny', N'Chico Carry Me Silva', N'M', CAST(N'2000-06-27' AS Date), CAST(0.00 AS Decimal(5, 2)))
SET IDENTITY_INSERT [Project].[Company] ON 

INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (1, N'beth@softworks.com', N'Bethesda Softworks', N'www.bethesda.net', N'i2.wp.com/www.inforumatik.com/wp-content/uploads/2017/04/data.images.authors.bgs_gear-black.png?resize=256%2C256&ssl=1', CAST(N'1986-06-28' AS Date), N'Rockville, Maryland', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (2, N'privacy_policy@ea.com', N'Electronic Arts', N'www.ea.com', N'cdn.iconscout.com/icon/free/png-256/electronic-arts-2-761658.png', CAST(N'1982-05-27' AS Date), N'Redwood City,California', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (3, N'squareenix@se.com', N'	Square Enix', N'www.square-enix-games.com', N'www.ssbwiki.com/images/a/a6/DragonQuestSymbol.svg', CAST(N'1975-09-22' AS Date), N'Shinjuku, Tokyo', N'Japan')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (4, N'rockstargames@rs.com', N'Rockstar Games', N'www.rockstargames.com', N'cdn.iconscout.com/icon/free/png-256/rockstar-4-282963.png', CAST(N'1998-12-01' AS Date), N'New York City, New York', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (5, N'beth@softworks.com', N'Tencent Games', N'www.tencent.com', N'img.tapimg.com/market/images/07f7fbba25187f74f1509e17fabd3a91.png?imageView2/1/w/256/q/40/interlace/1/ignore-error/1', CAST(N'1998-11-11' AS Date), N'Nanshan,Shenzen', N'China')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (6, N'easports@ea.com', N'EA Sports', N'www.easports.com', N'pbs.twimg.com/profile_images/617071953053028352/AhRCgQq7_400x400.jpg', CAST(N'1991-01-01' AS Date), N'Redwood City,California', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (7, N'konami@pes.com', N'Konami', N'www.konami.com', N'res-1.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1471973547/adsebqux5ocydnqlpv95.png', CAST(N'1969-03-21' AS Date), N'Tokyo', N'Japan')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (8, N'sonygames@sony.com', N'Sony Interactive Entertainment', N'www.sie.com', N'logospng.org/download/sony/logo-sony-256.png', CAST(N'1993-11-16' AS Date), N'San Mateo, California', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (9, N'microstudios@micro.pt', N'Xbox Game Studios', N'www.microsoftstudios.com', N'tweaks.com/img/cat/300.jpg', CAST(N'2002-01-01' AS Date), N'Redmond, Washington', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (10, N'activision@contact.com', N'Activision', N'www.activision.com', N'res-2.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/w099gxyaawn8mjsld0rx', CAST(N'1979-10-01' AS Date), N'Santa Monica, California', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (11, N'billing@blizzard.com', N'Blizzard Entertainment', N'www.blizzard.com', N'dl1.cbsistatic.com/i/2019/06/20/1beee23f-1b12-4364-99c3-ce915d44a160/ca8589b0643aa68e02dcbd0921634cf0/imgingest-286371551299044459.png', CAST(N'1991-02-08' AS Date), N'Irving, California', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (12, N'dmca@noa.nintendo.com', N'Nintendo', N'www.nintendo.com', N'cdn.iconscout.com/icon/free/png-256/nintendo-6-282132.png', CAST(N'1889-09-23' AS Date), N'Kyoto', N'Japan')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (13, N'bandai@namco.com', N'BANDAI NAMCO Entertainment', N'www.bandainamcoent.com', N'res-4.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1418805261/dhgs17yoampfadyglg62.jpg', CAST(N'2006-03-31' AS Date), N'	Tokyo', N'Japan')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (14, N'cap@com.com', N'Capcom', N'www.capcom.co.jp', N'cdn.iconscout.com/icon/free/png-256/capcom-285355.png', CAST(N'1979-05-30' AS Date), N'Osaka', N'Japan')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (15, N'press@wizards.com', N'Wizards of the Coast', N'company.wizards.com', N'pbs.twimg.com/profile_images/378800000138698413/5c74ebfc0015676be7b1cca2bd8c924a.jpeg', CAST(N'1990-01-01' AS Date), N'Renton, Washington', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (16, N'ubi@mail.com', N'Ubisoft', N'www.ubisoft.com', N'triangle-studios.com/wp-content/uploads/2015/11/logo_ubisoft.png', CAST(N'1986-03-12' AS Date), N'Montreuil', N'France')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (17, N'contact@epic.com', N'Epic Games', N'www.epicgames.com', N'img.informer.com/icons_mac/png/128/444/444398.png', CAST(N'1991-01-01' AS Date), N'Cary, North Carolina', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (18, NULL, N'Riot games', N'www.riotgames.com', N's3.us-east-2.amazonaws.com/upload-icon/uploads/icons/png/14871393811551942295-256.png', CAST(N'2006-08-31' AS Date), N'Los Angeles, California', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (19, N'contact@valvesoftware.com', N'Valve', N'www.valvesoftware.com', N'cdn.iconscout.com/icon/free/png-256/valve-51-286093.png', CAST(N'1996-09-24' AS Date), N'Belleveue, Washington', N'United States')
INSERT [Project].[Company] ([IDCompany], [Contact], [CompanyName], [Website], [Logo], [FoundationDate], [City], [Country]) VALUES (20, N'wbsf@warnerbros.com', N'Warner Bros Int. Entertainment', N'www.wbgames.com', N'res-4.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1464182490/wu53830rljaewbldv1no.png', CAST(N'1993-06-23' AS Date), N'Burbank, California', N'United States')
SET IDENTITY_INSERT [Project].[Company] OFF
SET IDENTITY_INSERT [Project].[Copy] ON 

INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100000, 1, N'Nintendo 64')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100001, 1, N'Nintendo 64')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100002, 1, N'Nintendo 64')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100003, 1, N'Nintendo 64')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100004, 2, N'Nintendo DS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100005, 2, N'Nintendo DS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100006, 2, N'Nintendo DS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100007, 2, N'Nintendo DS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100008, 3, N'Android')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100009, 3, N'Android')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100010, 3, N'Android')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100011, 3, N'iOS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100012, 4, N'Nintendo DS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100013, 4, N'Nintendo DS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100014, 4, N'Nintendo DS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100015, 4, N'Nintendo DS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100016, 5, N'Nintendo Switch')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100017, 5, N'Nintendo Switch')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100018, 5, N'Nintendo Switch')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100019, 5, N'Nintendo Switch')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100020, 6, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100021, 6, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100022, 6, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100023, 6, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100024, 7, N'PlayStation 2')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100025, 7, N'GameCube')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100026, 7, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100027, 7, N'PlayStation')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100028, 8, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100029, 8, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100030, 8, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100031, 8, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100032, 9, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100033, 9, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100034, 9, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100035, 9, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100036, 10, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100037, 10, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100038, 10, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100039, 10, N'Wii')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100040, 11, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100041, 11, N'MacOS')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100042, 11, N'Linux')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100043, 11, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100044, 12, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100045, 12, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100046, 12, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100047, 12, N'PlayStation Vita')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100048, 13, N'PlayStation Portable')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100049, 13, N'PlayStation Portable')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100050, 13, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100051, 13, N'Android')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100052, 14, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100053, 14, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100054, 14, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100055, 14, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100056, 15, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100057, 15, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100058, 15, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100059, 15, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100060, 16, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100061, 16, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100062, 16, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100063, 16, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100064, 17, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100065, 17, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100066, 17, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100067, 17, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100068, 18, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100069, 18, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100070, 18, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100071, 18, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100072, 19, N'Nintendo Switch')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100073, 19, N'Nintendo Switch')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100074, 19, N'Nintendo Switch')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100075, 19, N'Nintendo Switch')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100076, 20, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100077, 20, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100078, 20, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100079, 20, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100080, 21, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100081, 21, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100082, 21, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100083, 21, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100084, 22, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100085, 22, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100086, 22, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100087, 22, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100088, 23, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100089, 23, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100090, 23, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100091, 23, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100092, 24, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100093, 24, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100094, 24, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100095, 24, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100096, 25, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100097, 25, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100098, 25, N'Windows 10')
GO
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100099, 25, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100100, 26, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100101, 26, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100102, 26, N'Xbox 360')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100103, 26, N'PlayStation 3')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100104, 27, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100105, 27, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100106, 27, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100107, 27, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100108, 28, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100109, 28, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100110, 28, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100111, 28, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100112, 29, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100113, 29, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100114, 29, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100115, 29, N'Windows 7')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100116, 30, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100117, 30, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100118, 30, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100119, 30, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100120, 31, N'Xbox One')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100121, 31, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100122, 31, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100123, 31, N'Windows 10')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100124, 32, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100125, 32, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100126, 32, N'PlayStation 4')
INSERT [Project].[Copy] ([SerialNum], [IDGame], [PlatformName]) VALUES (100127, 32, N'Windows 10')
SET IDENTITY_INSERT [Project].[Copy] OFF
SET IDENTITY_INSERT [Project].[Credit] ON 

INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (1, N'PayPal', CAST(N'2020-05-01' AS Date), CAST(3.99 AS Decimal(4, 2)), 2)
INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (2, N'MBWay', CAST(N'2020-05-01' AS Date), CAST(19.99 AS Decimal(4, 2)), 2)
INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (3, N'PayPal', CAST(N'2020-05-01' AS Date), CAST(12.00 AS Decimal(4, 2)), 2)
INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (4, N'VISA', CAST(N'2020-03-04' AS Date), CAST(3.99 AS Decimal(4, 2)), 3)
INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (5, N'PayPal', CAST(N'2020-01-01' AS Date), CAST(19.99 AS Decimal(4, 2)), 3)
INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (6, N'VISA', CAST(N'2020-03-22' AS Date), CAST(1.99 AS Decimal(4, 2)), 3)
INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (7, N'PayPal', CAST(N'2020-03-03' AS Date), CAST(1.99 AS Decimal(4, 2)), 4)
INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (8, N'MasterCard', CAST(N'2020-05-01' AS Date), CAST(32.56 AS Decimal(4, 2)), 4)
INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (9, N'PayPal', CAST(N'2020-01-21' AS Date), CAST(1.99 AS Decimal(4, 2)), 5)
INSERT [Project].[Credit] ([NumCredit], [MetCredit], [DateCredit], [ValueCredit], [IDClient]) VALUES (10, N'PayPal', CAST(N'2020-05-01' AS Date), CAST(9.99 AS Decimal(4, 2)), 5)
SET IDENTITY_INSERT [Project].[Credit] OFF
INSERT [Project].[Discount] ([PromoCode], [Percentage], [DateBegin], [DateEnd]) VALUES (1, 50, CAST(N'2020-05-01' AS Date), CAST(N'2020-11-20' AS Date))
INSERT [Project].[Discount] ([PromoCode], [Percentage], [DateBegin], [DateEnd]) VALUES (2, 50, CAST(N'2020-03-01' AS Date), CAST(N'2020-04-20' AS Date))
INSERT [Project].[Discount] ([PromoCode], [Percentage], [DateBegin], [DateEnd]) VALUES (3, 30, CAST(N'2020-06-01' AS Date), CAST(N'2020-11-20' AS Date))
INSERT [Project].[DiscountGame] ([PromoCode], [IDGame]) VALUES (1, 1)
INSERT [Project].[DiscountGame] ([PromoCode], [IDGame]) VALUES (1, 4)
INSERT [Project].[DiscountGame] ([PromoCode], [IDGame]) VALUES (2, 2)
INSERT [Project].[DiscountGame] ([PromoCode], [IDGame]) VALUES (3, 3)
INSERT [Project].[Follows] ([IDFollower], [IDFollowed]) VALUES (2, 3)
INSERT [Project].[Follows] ([IDFollower], [IDFollowed]) VALUES (3, 2)
INSERT [Project].[Follows] ([IDFollower], [IDFollowed]) VALUES (4, 2)
INSERT [Project].[Follows] ([IDFollower], [IDFollowed]) VALUES (5, 2)
INSERT [Project].[Follows] ([IDFollower], [IDFollowed]) VALUES (5, 4)
INSERT [Project].[Follows] ([IDFollower], [IDFollowed]) VALUES (6, 2)
INSERT [Project].[Follows] ([IDFollower], [IDFollowed]) VALUES (6, 5)
SET IDENTITY_INSERT [Project].[Franchise] ON 

INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (1, N'Mario', N'img.pngio.com/filemario-logopng-wikimedia-commons-mario-logo-png-256_256.png', 12)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (2, N'Pokemon', N'res-1.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco/v1487981301/x29qmdr7nzxnpfrplxmd.png', 12)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (3, N'Grand Theft Auto', N'cdn.iconscout.com/icon/free/png-256/gta-283003.png', 4)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (4, N'FIFA', N'images.ctfassets.net/oqcxjunhepvs/29JWmTZaTy66O4SicWsawW/4ecfe87b180f741f8ce37bea3b6ab53e/July-15-2014-1.png', 2)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (5, N'Call of Duty', N'static.cloud-boxloja.com/lojas/wyfyg/produtos/f25a0bd3-cd98-4f34-95e4-f63769130a7e_t260x260.jpg', 10)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (6, N'Left 4 Dead', N'p1.hiclipart.com/preview/391/210/556/left-4-dead-2-icon-2-left-4-dead-b-left-4-dead-logo-png-clipart.jpg', 19)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (7, N'Need For Speed', N'cdn.iconscout.com/icon/free/png-256/need-for-speed-2-569509.png', 2)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (8, N'Assassins Creed', N'i.pinimg.com/originals/9a/22/3d/9a223d796c71d5f1289e9ad36b9c1a72.png', 16)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (9, N'Far Cry', N'p1.hiclipart.com/preview/865/346/322/far-cry-series-icon-far-cry-by-alchemist10-d7isoxh-png-icon.jpg', 16)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (10, N'Pro Evolution Soccer', N'escharts.com/storage/app/uploads/public/5af/59b/40d/5af59b40df255299807350.png', 7)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (11, N'The Legend Of Zelda', N'i.pinimg.com/originals/f2/e4/6f/f2e46f0473b6d637b7ef9b98ca1a334d.png', 12)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (12, N'Battlefield', N'cdn.iconscout.com/icon/free/png-256/battlefield-1-282437.png', 2)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (13, N'Uncharted', N'ih1.redbubble.net/image.1083813143.6081/flat,128x128,075,f-pad,128x128,f8f8f8.jpg', 8)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (14, N'Resident Evil', N'i53.fastpic.ru/big/2013/0322/c8/d743e27bd8e35d690cc63b5d968731c8.png', 14)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (15, N'Halo', N'cdn.shopify.com/s/files/1/1288/8361/files/Halo_Icon.png?9735559993999264622', 9)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (16, N'Tomb Raider', N'portingteam.com/index.php?app=downloads&module=display&section=screenshot&id=7840', 3)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (17, N'The Elder Scrolls', N'images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/79db8688-58ac-41dc-aea8-cc2422e185c7/d4gg9zv-97eb5f08-a4e1-4b97-b1d5-08097cf7639c.png/v1/fill/w_256,h_256,q_80,strp/the_elder_scrolls_v_skyrim___icon_by_j1mb091_d4gg9zv-fullview.jpg', 1)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (18, N'Counter Strike', N'lh3.googleusercontent.com/proxy/nXDUBI7pbshUG-lMatxCxsz6LHaNxRba9rujXSrvjA1uP4La-mn2Fl8_K6cB9tuQYQ7HkDxuiWnyFrduy7E5KjL9BDkT95Vrd_ebGu5u_53N', 19)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (19, N'God Of War', N'ih1.redbubble.net/image.550493323.5957/flat,128x128,075,t.u5.jpg', 8)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (20, N'Warcraft', N'i1.pngguru.com/preview/832/663/631/wow-high-rez-icon-world-of-warcraft-logo-png-clipart.jpg', 11)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (21, N'Forza', N'external-preview.redd.it/k7pYlhS4epFbqAE5uiRf7w5Meg52pgD96TdfI7A1X-M.jpg?auto=webp&s=df7b5ae0c3475dcf8da39e2dea907573290278a9', 9)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (22, N'Mass Effect', N'external-preview.redd.it/YNrBdv5EFiAay3nyOKnlOWyZFYsv6tqooZrOzc7E-Dw.png?auto=webp&s=a5698bb811548620dfc0ce228345b3ac865576e1', 9)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (23, N'Tekken', N'www.esc.watch/storage/app/uploads/public/5a0/ae9/b6a/5a0ae9b6abccf539928704.png', 13)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (24, N'Street Fighter', N'www.ssbwiki.com/images/8/84/StreetFighterSymbol.svg', 14)
INSERT [Project].[Franchise] ([IDFranchise], [Name], [Logo], [IDCompany]) VALUES (25, N'Borderlands', N'steamuserimages-a.akamaihd.net/ugc/250336157155911118/D961B7C5AB064EF1D8037D4921156787D1B89296/', 8)
SET IDENTITY_INSERT [Project].[Franchise] OFF
SET IDENTITY_INSERT [Project].[Game] ON 

INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (1, N'Super Mario 64', N'Super Mario 64 is a 1996 platform video game for the Nintendo 64.', CAST(N'1996-06-23' AS Date), 3, N'gbatemp.net/attachments/super-mario-64-land-png.187279/', CAST(3.99 AS Decimal(5, 2)), 12, 1)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (2, N'New Super Mario Bros.', N'New Super Mario Bros. is a side-scrolling video game.', CAST(N'2006-05-01' AS Date), 3, N'yuzu-emu.org/images/game/boxart/new-super-mario-bros-u-deluxe.png', CAST(3.99 AS Decimal(5, 2)), 12, 1)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (3, N'Super Mario Run', N'Super Mario Run is a 2016 side-scrolling platform mobile game developed and published by Nintendo.', CAST(N'2016-12-15' AS Date), 3, N'a.thumbs.redditmedia.com/N9gGTwEaZJ3D2iGF13A-RRNgeqgPbkNr1jetwhXIVQ0.png', CAST(1.99 AS Decimal(5, 2)), 12, 1)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (4, N'Pokemon Red', N'Pokemon Red Version is role-playing video game developed by Game Freak and published by Nintendo.', CAST(N'1996-03-27' AS Date), 3, N'tecnoblog.net/wp-content/uploads/2011/08/ruby-saphire.jpg', CAST(9.99 AS Decimal(5, 2)), 12, 2)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (5, N'Pokemon Sword', N'Pokemon Sword is a role-playing video game developed by Game Freak and published by Nintendo.', CAST(N'2019-11-15' AS Date), 3, N'www.speedrun.com/themes/pkmnswordshield/cover-256.png', CAST(59.99 AS Decimal(5, 2)), 12, 2)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (6, N'Grand Theft Auto V', N'Grand Theft Auto V is a 2013 action-adventure game published by Rockstar Games.', CAST(N'2013-09-17' AS Date), 18, N'pngimage.net/wp-content/uploads/2018/06/gta-v-icon-png-2.png', CAST(59.99 AS Decimal(5, 2)), 4, 3)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (7, N'FIFA Football 2004', N'FIFA Football 2004 is a football video game developed and published by Electronic Arts', CAST(N'2003-10-24' AS Date), 3, N'upload.wikimedia.org/wikipedia/en/thumb/e/e3/FIFA_Football_2004_cover.jpg/250px-FIFA_Football_2004_cover.jpg', CAST(59.99 AS Decimal(5, 2)), 6, 4)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (8, N'FIFA 20', N'FIFA 20 is a football simulation video game published by Electronic Arts as part of the FIFA series.', CAST(N'2019-07-19' AS Date), 3, N'1.bp.blogspot.com/-rD96Hu8rAyw/XYeClZZIlWI/AAAAAAAABD0/Uocets3DupIJNQgFFAe8l0Hq8Vi5RFOtgCEwYBhgL/s1600/fifa20.jpg', CAST(59.99 AS Decimal(5, 2)), 6, 4)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (9, N'Call of Duty : Black Ops 2', N'Call of Duty: Black Ops II is a 2012 first-person shooter published by Activision.', CAST(N'2012-11-12' AS Date), 18, N'pbs.twimg.com/profile_images/2772600693/ca93f6313b2310cfb4dfdb6c11366775.jpeg', CAST(11.99 AS Decimal(5, 2)), 10, 5)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (10, N'Call of Duty : World at War', N'Call of Duty: World at War is a 2008 first-person shooter video game published by Activision. ', CAST(N'2008-11-11' AS Date), 18, N'p1.hiclipart.com/preview/850/213/205/the-call-of-duty-series-icon-2003-2011-world-at-war-call-of-duty-world-at-war-illustration-png-clipart.jpg', CAST(4.99 AS Decimal(5, 2)), 10, 5)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (11, N'Left 4 Dead 2', N'Left 4 Dead 2 is a 2009 multiplayer survival horror game developed and published by Valve.', CAST(N'2009-11-17' AS Date), 18, N'steamuserimages-a.akamaihd.net/ugc/845968188390814023/37674AD466665B9F4E540AAE7128C51D0C59A1D1/', CAST(5.99 AS Decimal(5, 2)), 19, 6)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (12, N'Need For Speed : Most Wanted', N'Need for Speed: Most Wanted is an open world racing game published by Electronic Arts.', CAST(N'2012-10-30' AS Date), 3, N'cdn6.aptoide.com/imgs/0/e/4/0e492e0ec8a53fa7c3c1fbf5e58c6322_icon.png?w=256', CAST(10.99 AS Decimal(5, 2)), 2, 7)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (13, N'Need For Speed : Shift', N'Need for Speed: Shift is the 13th installment of the racing video game franchise Need for Speed.', CAST(N'2009-07-15' AS Date), 3, N'images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/8dd91536-f09a-487f-838f-140f69ff9d8a/d5reyzt-658a6e08-0dd5-458a-8227-46ed76d956fa.png/v1/fill/w_256,h_256,q_80,strp/need_for_speed_shift_icon_for_obly_tile_by_enigmaxg2_d5reyzt-fullview.jpg', CAST(4.99 AS Decimal(5, 2)), 2, 7)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (14, N'Assassins Creed II', N'Assassins Creed II is a 2009 action-adventure video game developed published by Ubisoft.', CAST(N'2009-11-17' AS Date), 18, N'images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/8dd91536-f09a-487f-838f-140f69ff9d8a/d5ws6i1-1fb4c643-f683-4f93-9f23-bd20f0535403.png/v1/fill/w_256,h_256,q_80,strp/assassin_s_creed_2_icon_for_obly_tile_by_enigmaxg2_d5ws6i1-fullview.jpg', CAST(9.99 AS Decimal(5, 2)), 16, 8)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (15, N'Assassins Creed IV: Black Flag', N'Assassins Creed IV: Black Flag is an action-adventure video game published by Ubisoft.', CAST(N'2013-10-29' AS Date), 18, N'pbs.twimg.com/profile_images/3321242353/74d0589d590170d9a6c914496ffb81d2.jpeg', CAST(19.99 AS Decimal(5, 2)), 16, 8)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (16, N'Far Cry 3', N'Far Cry 3 is a 2012 first-person shooter developed by Ubisoft Montreal and published by Ubisoft.', CAST(N'2012-11-29' AS Date), 18, N'c-sf.smule.com/sf/s34/arr/6e/75/11178429-7c20-4335-8c8e-7771de9945b9.jpg', CAST(19.99 AS Decimal(5, 2)), 16, 9)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (17, N'Far Cry 5', N'Far Cry 5 is a first-person shooter game published by Ubisoft, the 5th game in the Far Cry series.', CAST(N'2018-03-27' AS Date), 18, N'turkce-yama.com/wp-content/uploads/FarCry-5-Simge-256x256.png', CAST(49.99 AS Decimal(5, 2)), 16, 9)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (18, N'Pro Evolution Soccer 2019', N'Pro Evolution Soccer 2019 is a football simulation video game published by Konami', CAST(N'2019-08-08' AS Date), 3, N'i.pinimg.com/474x/15/e8/fa/15e8fa57c4588318250d2676c9f40a56.jpg', CAST(39.99 AS Decimal(5, 2)), 7, 10)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (19, N'The Legend of Zelda: Breath of the Wild', N'The Legend of Zelda: Breath of the Wild is an action-adventure game developed and published by Nintendo', CAST(N'2017-03-03' AS Date), 3, N'i.pinimg.com/474x/15/e8/fa/15e8fa57c4588318250d2676c9f40a56.jpg', CAST(59.99 AS Decimal(5, 2)), 12, 11)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (20, N'Uncharted: Drakes Fortune', N'Uncharted: Drakes Fortune is a 2007 action-adventure game published by Sony Computer Entertainment. It is the first game in the Uncharted series.', CAST(N'2007-01-20' AS Date), 3, N'static.truetrophies.com/boxart/Game_986.png', CAST(9.99 AS Decimal(5, 2)), 1, 13)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (21, N'Uncharted 4: A Thiefs End', N'Uncharted 4: A Thiefs End is a 2016 action-adventure game published by Sony Computer Entertainment.', CAST(N'2007-01-20' AS Date), 3, N'www.truetrophies.com/boxart/Game_4209.png', CAST(9.99 AS Decimal(5, 2)), 1, 13)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (22, N'Battlefield 4', N'Battlefield 4 is a first-person shooter video game developed by video game developer EA DICE and published by Electronic Arts', CAST(N'2013-10-29' AS Date), 18, N'vectorified.com/images/battlefield-4-icon-16x16-33.png', CAST(39.99 AS Decimal(5, 2)), 2, 12)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (23, N'Resident Evil 2', N'Resident Evil 2 is a survival horror game developed and published by Capcom.', CAST(N'2019-01-25' AS Date), 18, N'static.truetrophies.com/boxart/Game_8024.jpg', CAST(39.99 AS Decimal(5, 2)), 14, 14)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (24, N'Halo 5 : Guardian', N'Halo 5: Guardians is a first-person shooter video game developed by 343 Industries and published by Microsoft Studios', CAST(N'2015-10-17' AS Date), 16, N'avatarfiles.alphacoders.com/123/123823.png', CAST(39.99 AS Decimal(5, 2)), 9, 15)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (25, N'Shadow of the Tomb Raider', N'Shadow of the Tomb Raider is an action-adventure video game published by Square Enix.', CAST(N'2018-09-12' AS Date), 18, N'www.truetrophies.com/boxart/Game_7519.jpg', CAST(20.00 AS Decimal(5, 2)), 3, 16)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (26, N'The Elder Scrolls V: Skyrim', N'The Elder Scrolls V: Skyrim is an action role-playing video game published by Bethesda Softworks.', CAST(N'2011-11-11' AS Date), 12, N'images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/i/78aa3687-9f6e-45cc-9450-47d0978a810d/d39n68b-07b03bff-a1c3-4417-be06-a228a0ab0cff.png/v1/fill/w_256,h_256,q_80,strp/elder_scrolls_v___skyrim_icon_by_bonscha_d39n68b-fullview.jpg', CAST(19.99 AS Decimal(5, 2)), 1, 17)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (27, N'Counter Strike Global Offensive', N'Counter-Strike: Global Offensive is a multiplayer first-person shooter video game developed by Valve and Hidden Path Entertainment.', CAST(N'2012-08-21' AS Date), 18, N'p1.hiclipart.com/preview/915/443/598/counter-strike-go-game-icon-pack-cs-go-6-png-icon.jpg', CAST(10.00 AS Decimal(5, 2)), 19, 18)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (28, N'God Of War', N'God of War is an action-adventure game developed by Santa Monica Studio and published by Sony Interactive Entertainment.', CAST(N'2018-04-20' AS Date), 18, N'avatarfiles.alphacoders.com/222/222728.jpg', CAST(40.00 AS Decimal(5, 2)), 8, 19)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (29, N'Warcraft III: Reign of Chaos', N'Warcraft III: Reign of Chaos is a high fantasy real-time strategy computer video game developed and published by Blizzard Entertainment released in July 2002. It is the second sequel to Warcraft: Orcs & Humans', CAST(N'2002-07-03' AS Date), 16, N'dl1.cbsistatic.com/i/2016/07/12/f3f4e353-38aa-4de9-8c87-a6ad905ce9e9/d900d0e88d0f97b1464494805baac237/imgingest-6030158764582817665.png', CAST(5.00 AS Decimal(5, 2)), 11, 20)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (30, N'Mass Effect: Andromeda', N'Mass Effect: Andromeda is an action role-playing video game developed by BioWare and published by Electronic Arts.', CAST(N'2017-03-21' AS Date), 16, N'm.media-amazon.com/images/I/51zkf-kP5yL._AA256_.jpg', CAST(45.00 AS Decimal(5, 2)), 2, 22)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (31, N'Tekken 7', N'Tekken 7 is a fighting game developed and published by Bandai Namco Entertainment.', CAST(N'2015-03-18' AS Date), 18, N'static.truetrophies.com/boxart/Game_5497.png', CAST(49.99 AS Decimal(5, 2)), 13, 23)
INSERT [Project].[Game] ([IDGame], [Name], [Description], [ReleaseDate], [AgeRestriction], [CoverImg], [Price], [IDCompany], [IDFranchise]) VALUES (32, N'Street Fighter', N'Street Fighter V is a fighting game developed by Capcom', CAST(N'2016-02-16' AS Date), 3, N'pbs.twimg.com/profile_images/697220635198689285/T34coLzR_400x400.png', CAST(15.00 AS Decimal(5, 2)), 14, 24)
SET IDENTITY_INSERT [Project].[Game] OFF
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (1, N'Platformer')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (1, N'Side-Scrolling')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (2, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (2, N'Platformer')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (3, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (3, N'Platformer')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (3, N'Role-Playing')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (4, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (4, N'Role-Playing')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (5, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (5, N'Role-Playing')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (6, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (6, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (6, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (7, N'Simulation')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (7, N'Sports')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (8, N'Simulation')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (8, N'Sports')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (9, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (9, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (10, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (10, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (11, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (11, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (11, N'Survival')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (12, N'Racing')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (13, N'Racing')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (14, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (14, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (15, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (15, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (16, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (16, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (16, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (17, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (17, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (17, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (18, N'Simulation')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (18, N'Sports')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (19, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (19, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (19, N'Role-Playing')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (20, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (20, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (20, N'Platformer')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (20, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (21, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (21, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (21, N'Platformer')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (21, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (22, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (22, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (23, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (23, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (23, N'Survival')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (24, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (24, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (24, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (24, N'Strategy')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (25, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (25, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (25, N'Puzzle')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (25, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (26, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (26, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (26, N'Puzzle')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (26, N'Role-Playing')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (27, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (27, N'Shooter')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (27, N'Strategy')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (28, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (28, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (28, N'Puzzle')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (28, N'Role-Playing')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (29, N'Adventure')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (29, N'MMORPG')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (29, N'Strategy')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (30, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (30, N'Role-Playing')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (31, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (31, N'Fighting')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (32, N'Action')
INSERT [Project].[GameGenre] ([IDGame], [GenName]) VALUES (32, N'Fighting')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Action', N'Action games are just that?games where the player is in control of and at the center of the action, which is mainly comprised of physical challenges players must overcome.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Adventure', N'Adventure games are categorized by the style of gameplay, not the story or content. And while technology has given developers new options to explore storytelling in the genre, at a basic level, adventure games haven?t evolved much from their text-based origins.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Battle Royale', N'A battle royale game is a genre that blends the survival, exploration and scavenging elements of a survival game with last man standing gameplay g to stay in safe playable area which shrinks as the time passes, with the winner being the last competitor in the game')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Fighting', N'Fighting games like Mortal Kombat and Street Fighter II focus the action on combat, and in most cases, hand-to-hand combat.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Idle', N'Idle games are simplified games that involve minimal player involvement, such as clicking on an icon over and over. Idle games keep players engaged by rewarding those who complete simple objectives.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'MMORPG', N'MMORPGs involve hundreds of players actively interacting with each other in the same world, and typically, all players share the same or a similar objective.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'MOBA', N'This category combines action games, role-playing games, and real-time strategy games. In this subgenre of strategy games, players usually do not build resources such as bases or combat units.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Platformer', N'Platformer games get their name from the fact that the game?s character interacts with platforms throughout the gameplay.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Puzzle', N'Puzzle or logic games usually take place on a single screen or playfield and require the player to solve a problem to advance the action.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Racing', N'Racing simulator series like Forza and Gran Turismo are some of the most popular games in this category, but arcade classics like Pole Position are included here too. In these games, players race against another opponent or the clock.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Role-Playing', N'Probably the second-most popular game genre, role-playing games, or RPGs, mostly feature medieval or fantasy settings. ')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Shooter', N'Shooters let players use weapons to engage in the action, with the goal usually being to take out enemies or opposing players.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Side-Scrolling', N'A side-scrolling game is a video game in which the gameplay action is viewed from a side-view camera angle, and as the players character moves left or right, the screen scrolls with them. These games make use of scrolling computer display technology.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Simulation', N'Games in the simulation genre have one thing in common?they are all designed to emulate real or fictional reality, to simulate a real situation or event.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Sports', N'Sports games simulate sports like golf, football, basketball, baseball, and soccer. They can also include Olympic sports like skiing, and even pub sports like darts and pool.')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Strategy', N'With gameplay is based on traditional strategy board games, strategy games give players a godlike access to the world and its resources. ')
INSERT [Project].[Genre] ([GenName], [Description]) VALUES (N'Survival', N'The survival horror game Resident Evil was one of the earliest (though a linear game), while more modern survival games like Fortnite take place in open-world game environments and give players access to resources to craft tools, weapons, and shelter to survive as long as possible.')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Android', CAST(N'2006-09-28' AS Date), N'Google')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Dreamcast', CAST(N'1998-11-27' AS Date), N'Sega')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'GameCube', CAST(N'2001-09-14' AS Date), N'Nintendo')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'iOS', CAST(N'2007-06-29' AS Date), N'Apple')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Linux', CAST(N'1991-04-20' AS Date), N'Linux')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'MacOS', CAST(N'2018-11-24' AS Date), N'Apple')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Nintendo 3DS', CAST(N'2011-02-26' AS Date), N'Nintendo')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Nintendo 64', CAST(N'1996-06-23' AS Date), N'Nintendo')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Nintendo DS', CAST(N'2004-12-02' AS Date), N'Nintendo')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Nintendo Switch', CAST(N'2017-03-03' AS Date), N'Nintendo')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'PlayStation', CAST(N'1994-12-03' AS Date), N'Sony')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'PlayStation 2', CAST(N'2000-03-04' AS Date), N'Sony')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'PlayStation 3', CAST(N'2006-11-11' AS Date), N'Sony')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'PlayStation 4', CAST(N'2005-11-13' AS Date), N'Sony')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'PlayStation Portable', CAST(N'2004-12-12' AS Date), N'Sony')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'PlayStation Vita', CAST(N'2011-12-17' AS Date), N'Microsoft')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Sega Saturn', CAST(N'1994-11-22' AS Date), N'Sega')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Wii', CAST(N'2006-11-19' AS Date), N'Nintendo')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Wii U', CAST(N'2012-11-18' AS Date), N'Nintendo')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Windows 10', CAST(N'2015-07-29' AS Date), N'Microsoft')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Windows 7', CAST(N'2009-07-22' AS Date), N'Microsoft')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Xbox 360', CAST(N'2005-11-22' AS Date), N'Microsoft')
INSERT [Project].[Platform] ([PlatformName], [ReleaseDate], [Producer]) VALUES (N'Xbox One', CAST(N'2013-11-22' AS Date), N'Microsoft')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (1, N'Nintendo 64')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (2, N'Nintendo DS')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (3, N'Android')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (3, N'iOS')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (4, N'Nintendo DS')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (5, N'Nintendo Switch')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (6, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (6, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (6, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (6, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (6, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (7, N'GameCube')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (7, N'PlayStation')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (7, N'PlayStation 2')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (7, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (8, N'MacOS')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (8, N'Nintendo Switch')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (8, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (8, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (8, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (8, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (9, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (9, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (9, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (10, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (10, N'Wii')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (10, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (10, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (11, N'Linux')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (11, N'MacOS')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (11, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (11, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (12, N'Android')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (12, N'iOS')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (12, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (12, N'PlayStation Vita')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (12, N'Wii U')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (12, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (12, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (13, N'Android')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (13, N'iOS')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (13, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (13, N'PlayStation Portable')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (13, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (14, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (14, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (14, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (15, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (15, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (15, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (15, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (15, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (15, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (16, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (16, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (16, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (17, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (17, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (17, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (18, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (18, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (18, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (18, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (18, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (18, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (19, N'Nintendo Switch')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (20, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (21, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (22, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (22, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (22, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (23, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (23, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (23, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (24, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (24, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (24, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (25, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (25, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (25, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (26, N'PlayStation 3')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (26, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (26, N'Xbox 360')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (27, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (27, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (28, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (29, N'Windows 7')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (30, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (30, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (30, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (31, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (31, N'Windows 10')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (31, N'Xbox One')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (32, N'PlayStation 4')
INSERT [Project].[PlatformReleasesGame] ([IDGame], [PlatformName]) VALUES (32, N'Windows 10')
SET IDENTITY_INSERT [Project].[Purchase] ON 

INSERT [Project].[Purchase] ([NumPurchase], [Price], [PurchaseDate], [IDClient], [SerialNum]) VALUES (1, CAST(3.99 AS Decimal(5, 2)), CAST(N'2020-05-01' AS Date), 2, 100001)
INSERT [Project].[Purchase] ([NumPurchase], [Price], [PurchaseDate], [IDClient], [SerialNum]) VALUES (2, CAST(3.99 AS Decimal(5, 2)), CAST(N'2020-03-04' AS Date), 3, 100002)
INSERT [Project].[Purchase] ([NumPurchase], [Price], [PurchaseDate], [IDClient], [SerialNum]) VALUES (3, CAST(3.99 AS Decimal(5, 2)), CAST(N'2020-01-02' AS Date), 5, 100003)
INSERT [Project].[Purchase] ([NumPurchase], [Price], [PurchaseDate], [IDClient], [SerialNum]) VALUES (4, CAST(19.99 AS Decimal(5, 2)), CAST(N'2020-05-01' AS Date), 2, 100005)
INSERT [Project].[Purchase] ([NumPurchase], [Price], [PurchaseDate], [IDClient], [SerialNum]) VALUES (5, CAST(19.99 AS Decimal(5, 2)), CAST(N'2020-05-01' AS Date), 3, 100006)
INSERT [Project].[Purchase] ([NumPurchase], [Price], [PurchaseDate], [IDClient], [SerialNum]) VALUES (6, CAST(3.99 AS Decimal(5, 2)), CAST(N'2020-03-22' AS Date), 3, 100009)
INSERT [Project].[Purchase] ([NumPurchase], [Price], [PurchaseDate], [IDClient], [SerialNum]) VALUES (7, CAST(3.99 AS Decimal(5, 2)), CAST(N'2020-01-21' AS Date), 5, 100010)
INSERT [Project].[Purchase] ([NumPurchase], [Price], [PurchaseDate], [IDClient], [SerialNum]) VALUES (8, CAST(3.99 AS Decimal(5, 2)), CAST(N'2020-03-03' AS Date), 4, 100011)
SET IDENTITY_INSERT [Project].[Purchase] OFF
SET IDENTITY_INSERT [Project].[Reviews] ON 

INSERT [Project].[Reviews] ([IDReview], [Title], [Text], [Rating], [DateReview], [UserID], [IDGame]) VALUES (1, N'Very bad game', N'My game keeps crashing. I can not play this...', CAST(1.0 AS Decimal(2, 1)), CAST(N'2020-05-01' AS Date), 2, 1)
INSERT [Project].[Reviews] ([IDReview], [Title], [Text], [Rating], [DateReview], [UserID], [IDGame]) VALUES (2, N'Not that good', N'I really do not like the graphic design :/', CAST(3.0 AS Decimal(2, 1)), CAST(N'2020-03-04' AS Date), 3, 1)
INSERT [Project].[Reviews] ([IDReview], [Title], [Text], [Rating], [DateReview], [UserID], [IDGame]) VALUES (3, N'Amazing', N'I really have fun playing this!', CAST(4.0 AS Decimal(2, 1)), CAST(N'2020-01-02' AS Date), 5, 1)
INSERT [Project].[Reviews] ([IDReview], [Title], [Text], [Rating], [DateReview], [UserID], [IDGame]) VALUES (4, N'Can not stop playing! OMG', N'This game is so addictive, pls send help!', CAST(5.0 AS Decimal(2, 1)), CAST(N'2020-05-01' AS Date), 2, 2)
INSERT [Project].[Reviews] ([IDReview], [Title], [Text], [Rating], [DateReview], [UserID], [IDGame]) VALUES (5, N'Could be worse', N'The game looks nice, but it has some problems in playability', CAST(3.0 AS Decimal(2, 1)), CAST(N'2020-01-01' AS Date), 3, 2)
INSERT [Project].[Reviews] ([IDReview], [Title], [Text], [Rating], [DateReview], [UserID], [IDGame]) VALUES (6, N'Not worth the money!', N'If anyone is reading this pls do not buy this game', CAST(1.0 AS Decimal(2, 1)), CAST(N'2020-03-22' AS Date), 3, 3)
INSERT [Project].[Reviews] ([IDReview], [Title], [Text], [Rating], [DateReview], [UserID], [IDGame]) VALUES (7, N'Couldnt ask for better', N'Really fun, addictive and nostalgic', CAST(4.0 AS Decimal(2, 1)), CAST(N'2020-01-21' AS Date), 5, 3)
INSERT [Project].[Reviews] ([IDReview], [Title], [Text], [Rating], [DateReview], [UserID], [IDGame]) VALUES (8, N'GG', N'good design and playability, but some problems', CAST(3.0 AS Decimal(2, 1)), CAST(N'2020-03-03' AS Date), 4, 3)
SET IDENTITY_INSERT [Project].[Reviews] OFF
SET IDENTITY_INSERT [Project].[User] ON 

INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (1, N'brunobastos@gmail.com', 0x02000000507A3B738A4CF4845C66A2719595B01CCAC3247DA55B9692F42A000BEB3DECADC622AECC128F86A137023663FBA2C1E0, CAST(N'2018-04-04' AS Date))
INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (2, N'client@gmail.com', 0x02000000562F558416C9A253446376444E08C9A0976B468EA6CEBC3E6FC179DA0F390ABE, CAST(N'2018-11-02' AS Date))
INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (3, N'NancyKim@gmail.com', 0x020000004A01D8D7560B3110BAF83EA00FA8238B4ADA12DC58F643C5DA732F07BBBE466D91E9C7ACD150B16373BFE4BD998253CA, CAST(N'2019-11-02' AS Date))
INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (4, N'timcarrey@outlook.com', 0x02000000A0822CA7A8995BA93F4AF8D46523AF4B68003F5672A83553E0488A4EA11FD7540B118CFA7C89E1F328CBBF2E15531305, CAST(N'2019-12-10' AS Date))
INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (5, N'KareemCorbett@gmail.com', 0x02000000F0C5C540F487A93994D2604E7ABC8E2468B1799A796E2D96AA8087848F4A6420C1355A6F34F07824F5F7CC13F86C65A6, CAST(N'2018-10-23' AS Date))
INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (6, N'CocoNava@gmail.com', 0x020000006AD6609080394CD9A4F32A53055E74EE1E5A411C7C3DB8EA5C34D5B16C97F5AEDE5B56F392EBB1E6E30206F894842391, CAST(N'2018-11-11' AS Date))
INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (7, N'dominik_stokes@gmail.com', 0x02000000CB4759A9A87A730FEB6D20EBF8673497AC6980827A5F248B32B3B59B3A5CA24F18AE1B019A70BE0E1599941877A87169, CAST(N'2018-09-22' AS Date))
INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (8, N'Wesley_Shields@gmail.com', 0x02000000EB60D917545F41B0433DD1A8BEC237C68811E8E680A28135CABA3EA8FE0A7132D88125F8DD910E3C96D7CCA3F9386576, CAST(N'2019-01-20' AS Date))
INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (9, N'leandrocoelhom@gmail.com', 0x0200000010DF6E4E355BF7895DBEFF0564E8D8306BAF600F8B50D252D4597F69ADD025D100F9353FE1C0E0813AF6E26289575638, CAST(N'2020-01-01' AS Date))
INSERT [Project].[User] ([UserID], [Email], [Password], [RegisterDate]) VALUES (10, N'procsplayerdaubi@gmail.com', 0x02000000B91EEDBC8D54A27A03ED009BDB5E03375EAC4C74F7E83A67AEE31CB7EB5F676F98877C5880A639D1085D527E707248DE, CAST(N'2019-12-02' AS Date))
SET IDENTITY_INSERT [Project].[User] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Client__536C85E4B319A8CB]    Script Date: 12/06/2020 19:12:01 ******/
ALTER TABLE [Project].[Client] ADD UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__A9D10534A7C6E4F8]    Script Date: 12/06/2020 19:12:01 ******/
ALTER TABLE [Project].[User] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [Project].[Admin]  WITH CHECK ADD  CONSTRAINT [AdminID] FOREIGN KEY([UserID])
REFERENCES [Project].[User] ([UserID])
GO
ALTER TABLE [Project].[Admin] CHECK CONSTRAINT [AdminID]
GO
ALTER TABLE [Project].[Client]  WITH CHECK ADD  CONSTRAINT [ClientID] FOREIGN KEY([UserID])
REFERENCES [Project].[User] ([UserID])
GO
ALTER TABLE [Project].[Client] CHECK CONSTRAINT [ClientID]
GO
ALTER TABLE [Project].[Copy]  WITH CHECK ADD  CONSTRAINT [CopyGame] FOREIGN KEY([IDGame])
REFERENCES [Project].[Game] ([IDGame])
GO
ALTER TABLE [Project].[Copy] CHECK CONSTRAINT [CopyGame]
GO
ALTER TABLE [Project].[Copy]  WITH CHECK ADD  CONSTRAINT [CopyPlatform] FOREIGN KEY([PlatformName])
REFERENCES [Project].[Platform] ([PlatformName])
GO
ALTER TABLE [Project].[Copy] CHECK CONSTRAINT [CopyPlatform]
GO
ALTER TABLE [Project].[Credit]  WITH CHECK ADD  CONSTRAINT [CredClient] FOREIGN KEY([IDClient])
REFERENCES [Project].[Client] ([UserID])
GO
ALTER TABLE [Project].[Credit] CHECK CONSTRAINT [CredClient]
GO
ALTER TABLE [Project].[DiscountGame]  WITH CHECK ADD  CONSTRAINT [CodDiscount] FOREIGN KEY([PromoCode])
REFERENCES [Project].[Discount] ([PromoCode])
GO
ALTER TABLE [Project].[DiscountGame] CHECK CONSTRAINT [CodDiscount]
GO
ALTER TABLE [Project].[DiscountGame]  WITH CHECK ADD  CONSTRAINT [CodGame] FOREIGN KEY([IDGame])
REFERENCES [Project].[Game] ([IDGame])
GO
ALTER TABLE [Project].[DiscountGame] CHECK CONSTRAINT [CodGame]
GO
ALTER TABLE [Project].[Follows]  WITH CHECK ADD FOREIGN KEY([IDFollower])
REFERENCES [Project].[Client] ([UserID])
GO
ALTER TABLE [Project].[Follows]  WITH CHECK ADD FOREIGN KEY([IDFollowed])
REFERENCES [Project].[Client] ([UserID])
GO
ALTER TABLE [Project].[Franchise]  WITH CHECK ADD  CONSTRAINT [Comp] FOREIGN KEY([IDCompany])
REFERENCES [Project].[Company] ([IDCompany])
GO
ALTER TABLE [Project].[Franchise] CHECK CONSTRAINT [Comp]
GO
ALTER TABLE [Project].[Game]  WITH CHECK ADD  CONSTRAINT [IDCompanyGame] FOREIGN KEY([IDCompany])
REFERENCES [Project].[Company] ([IDCompany])
GO
ALTER TABLE [Project].[Game] CHECK CONSTRAINT [IDCompanyGame]
GO
ALTER TABLE [Project].[Game]  WITH CHECK ADD  CONSTRAINT [IDFranchiseGame] FOREIGN KEY([IDFranchise])
REFERENCES [Project].[Franchise] ([IDFranchise])
GO
ALTER TABLE [Project].[Game] CHECK CONSTRAINT [IDFranchiseGame]
GO
ALTER TABLE [Project].[GameGenre]  WITH CHECK ADD  CONSTRAINT [GenGame] FOREIGN KEY([IDGame])
REFERENCES [Project].[Game] ([IDGame])
GO
ALTER TABLE [Project].[GameGenre] CHECK CONSTRAINT [GenGame]
GO
ALTER TABLE [Project].[GameGenre]  WITH CHECK ADD  CONSTRAINT [GenName] FOREIGN KEY([GenName])
REFERENCES [Project].[Genre] ([GenName])
GO
ALTER TABLE [Project].[GameGenre] CHECK CONSTRAINT [GenName]
GO
ALTER TABLE [Project].[PlatformReleasesGame]  WITH CHECK ADD  CONSTRAINT [LaunchedGame] FOREIGN KEY([IDGame])
REFERENCES [Project].[Game] ([IDGame])
GO
ALTER TABLE [Project].[PlatformReleasesGame] CHECK CONSTRAINT [LaunchedGame]
GO
ALTER TABLE [Project].[PlatformReleasesGame]  WITH CHECK ADD  CONSTRAINT [PlatformGame] FOREIGN KEY([PlatformName])
REFERENCES [Project].[Platform] ([PlatformName])
GO
ALTER TABLE [Project].[PlatformReleasesGame] CHECK CONSTRAINT [PlatformGame]
GO
ALTER TABLE [Project].[Purchase]  WITH CHECK ADD  CONSTRAINT [ClientPurchase] FOREIGN KEY([IDClient])
REFERENCES [Project].[Client] ([UserID])
GO
ALTER TABLE [Project].[Purchase] CHECK CONSTRAINT [ClientPurchase]
GO
ALTER TABLE [Project].[Purchase]  WITH CHECK ADD  CONSTRAINT [GamePurchase] FOREIGN KEY([SerialNum])
REFERENCES [Project].[Copy] ([SerialNum])
GO
ALTER TABLE [Project].[Purchase] CHECK CONSTRAINT [GamePurchase]
GO
ALTER TABLE [Project].[Reviews]  WITH CHECK ADD  CONSTRAINT [RevClient] FOREIGN KEY([UserID])
REFERENCES [Project].[Client] ([UserID])
GO
ALTER TABLE [Project].[Reviews] CHECK CONSTRAINT [RevClient]
GO
ALTER TABLE [Project].[Reviews]  WITH CHECK ADD  CONSTRAINT [RevGame] FOREIGN KEY([IDGame])
REFERENCES [Project].[Game] ([IDGame])
GO
ALTER TABLE [Project].[Reviews] CHECK CONSTRAINT [RevGame]
GO
ALTER TABLE [Project].[Client]  WITH CHECK ADD CHECK  (([Balance]>=(0)))
GO
ALTER TABLE [Project].[Discount]  WITH CHECK ADD  CONSTRAINT [chk_Discount] CHECK  (([Percentage]>=(0) AND [Percentage]<=(100)))
GO
ALTER TABLE [Project].[Discount] CHECK CONSTRAINT [chk_Discount]
GO
ALTER TABLE [Project].[Game]  WITH CHECK ADD  CONSTRAINT [chk_AgeRestrict] CHECK  (([AgeRestriction]>=(1) AND [AgeRestriction]<=(18)))
GO
ALTER TABLE [Project].[Game] CHECK CONSTRAINT [chk_AgeRestrict]
GO
ALTER TABLE [Project].[Game]  WITH CHECK ADD CHECK  (([Price]>=(0)))
GO
ALTER TABLE [Project].[Purchase]  WITH CHECK ADD CHECK  (([Price]>=(0)))
GO
ALTER TABLE [Project].[Reviews]  WITH CHECK ADD  CONSTRAINT [Chk_rat] CHECK  (([Rating]>=(0) AND [Rating]<=(5)))
GO
ALTER TABLE [Project].[Reviews] CHECK CONSTRAINT [Chk_rat]
GO
ALTER TABLE [Project].[Reviews]  WITH CHECK ADD CHECK  ((len([Text])>(0)))
GO
ALTER TABLE [Project].[Reviews]  WITH CHECK ADD CHECK  ((len([Title])>(0)))
GO
/****** Object:  StoredProcedure [Project].[pd_addGameGenre]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [Project].[pd_addGameGenre](
	@IDGame int,
	@GenName varchar(25),
	@res varchar(255) output)
as
	begin
		begin try
			If(Select IDGame From Project.Game where IDGame=@IDGame) is not null and (Select GenName From Project.Genre where GenName=@GenName) is not null
				begin
					insert into Project.GameGenre values(@IDGame,@GenName)
					set @res = 'Success adding genre'
				end
			else
				set @res = 'Game or Genre do not exist'
		end try
		begin catch
			set @res = 'Genre is already applied to this game'
		end catch
	end

GO
/****** Object:  StoredProcedure [Project].[pd_addPlatformToGame]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [Project].[pd_addPlatformToGame](
	@IDGame int,
	@PlatformName varchar(30),
	@res varchar(255) output
	)
as
	begin
		begin try
			if(Select IDGame From Project.Game where IDGame=@IDGame) is not null and (Select PlatformName from Project.[Platform] where PlatformName=@PlatformName) is not null
				begin
					insert into Project.PlatformReleasesGame values(@IDGame,@PlatformName)
					set @res = 'Success adding Platform'
				end
			else
				set @res = 'Platform or Game do not exist'
		end try
		begin catch
			set @res = 'Platform is already applied to this game'
		end catch
	end

GO
/****** Object:  StoredProcedure [Project].[pd_deleteFollows]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create Procedure [Project].[pd_deleteFollows](
	@IDFollower INT,
	@IDFollowed INT,
	@res VARCHAR(255) output
	)
	as
	begin
		begin try
			delete from Project.Follows where IDFollowed=@IDFollowed and IDFollower=@IDFollower
			set @res='Success'
		end try
		begin catch
			set @res='Cannot unfollow this Client'
		END CATCH
	END
GO
/****** Object:  StoredProcedure [Project].[pd_filter_CreditHistory]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project].[pd_filter_CreditHistory](
	@IDClient INT,
	@MinValue DECIMAL(5,2),
	@MaxValue DECIMAL(5,2),
	@MinDate DATE,
	@MaxDate DATE,
	@selectedMets VARCHAR(max) -- selected payment methods in the app checkbox
	)
	AS
		BEGIN
			   DECLARE @temp TABLE (
				MetCredit VARCHAR(20), 
				ValueCredit DECIMAL(5,2),
				DateCredit DATE)
				INSERT INTO @temp SELECT MetCredit,ValueCredit,DateCredit FROM Project.Credit where Project.Credit.IDClient =@IDClient
				IF @MinValue is not null
					DELETE FROM @temp WHERE @MinValue>ValueCredit 
				IF @MaxValue is not null 
					DELETE FROM @temp WHERE @MaxValue<ValueCredit
				IF @MinDate is not  null
					DELETE FROM @temp WHERE DATEDIFF(DAY,@MinDate,DateCredit) < 0
				IF @MaxDate is not null
					DELETE FROM @temp WHERE DATEDIFF(DAY,@MaxDate,DateCredit) > 0
				IF @selectedMets is not null	
					DELETE FROM @temp WHERE  MetCredit NOT  IN (SELECT value FROM STRING_SPLIT(@selectedMets, ','));

				SELECT * FROM @temp
		END
GO
/****** Object:  StoredProcedure [Project].[pd_filter_Games]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project].[pd_filter_Games](
	@MinValue DECIMAL (5,2),
	@MaxValue DECIMAL (5,2),
	@MinDate DATE,
	@MaxDate DATE,
	@SelectedPlats VARCHAR(MAX),
	@SelectedGenres VARCHAR(MAX),
	@SelectedAge INT, 
	@MinDiscount INT,
	@GameName VARCHAR(max),  -- user input
	@orderopt VARCHAR(MAX)  -- option to order games
)
AS
	BEGIN
			DECLARE  @tempPurchase TABLE(
				IDGame INT,
				GameName VARCHAR(50),
				[Description] VARCHAR(max),
				ReleaseDate DATE,
				AgeRestriction INT,
				CoverImg varchar(max),
				Price  DECIMAL (5,2),
				IDCompany INT,
				IDFranchise INT,
				GenName VARCHAR(25),
				PlatformName  VARCHAR(30),
				Disc INT
			) 
				DECLARE @tempPer INT;
				INSERT INTO @tempPurchase SELECT Game.*,GameGenre.GenName,PlatformReleasesGame.PlatformName,0
				FROM Project.Game JOIN Project.PlatformReleasesGame ON Game.IDGame=PlatformReleasesGame.IDGame 
				JOIN Project.GameGenre ON GameGenre.IDGame= Game.IDGame
				UPDATE @tempPurchase
				SET Disc =(SELECT IIF (EXISTS (SELECT TOP 1 [Percentage]  FROM Project.udf_checkGameDiscount (IDGame)),(SELECT TOP 1 [Percentage]  FROM Project.udf_checkGameDiscount (IDGame)),0))
				UPDATE @tempPurchase
				SET Price-=Price *Disc/100;
				IF @MinValue is not null
					DELETE FROM @tempPurchase WHERE @MinValue>Price
				IF @MaxValue is not null 
					DELETE FROM @tempPurchase WHERE @MaxValue<Price 
				IF @MinDate is not  null
					DELETE FROM @tempPurchase WHERE DATEDIFF(DAY,@MinDate,ReleaseDate) < 0
				IF @MaxDate is not null
					DELETE FROM @tempPurchase WHERE DATEDIFF(DAY,@MaxDate,ReleaseDate) > 0
				IF @SelectedPlats is not null
					DELETE FROM @tempPurchase WHERE  PlatformName NOT  IN (SELECT value FROM STRING_SPLIT(@SelectedPlats, ','));
                IF @SelectedGenres is not null
					DELETE FROM @tempPurchase WHERE  GenName NOT  IN (SELECT value FROM STRING_SPLIT(@SelectedGenres, ','));
				IF @SelectedAge is not null
					DELETE FROM @tempPurchase WHERE AgeRestriction > @SelectedAge;
				IF @MinDiscount is not null
					DELETE FROM @tempPurchase WHERE  Disc < @MinDiscount
                IF @GameName is not  null
					DELETE FROM @tempPurchase WHERE GameName NOT LIKE  @GameName + '%'
	---ordering options
				IF @orderopt = 'DateDesc'
				BEGIN
					select * from @tempPurchase where ReleaseDate IS NOT NULL ORDER BY ReleaseDate DESC
				END
				IF @orderopt = 'DateAsc'
				BEGIN
					select * from @tempPurchase where ReleaseDate IS NOT NULL ORDER BY ReleaseDate ASC

				END
				if @orderopt = 'NameDesc'
				BEGIN
					select * from @tempPurchase where GameName IS NOT NULL ORDER BY GameName DESC
				END
				if @orderopt ='NameAsc'
				BEGIN
					select * from @tempPurchase where GameName IS NOT NULL ORDER BY GameName ASC
				END
				if @orderopt='PriceAsc'
				BEGIN
					select * from @tempPurchase where Price IS NOT NULL ORDER BY Price ASC
				END
				if @orderopt='PriceDesc'
				BEGIN
					select * from @tempPurchase where Price IS NOT NULL ORDER BY Price DESC
				END
				if @orderopt is null
				BEGIN
					select * from @tempPurchase ORDER BY IDGame
				END
	END

GO
/****** Object:  StoredProcedure [Project].[pd_filter_PurchaseHistory]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Project].[pd_filter_PurchaseHistory](
		@IDClient INT,
		@MinValue DECIMAL (5,2) =NULL,
		@MaxValue DECIMAL (5,2) = NULL,
		@MinDate  DATE =NULL,
		@MaxDate DATE =NULL,
		@GameName VARCHAR(max) =NULL -- user input
		)
	AS
		BEGIN
			declare @temp TABLE (
				Price DECIMAL(5,2),
				PurchaseDate DATE,
				SerialNumber INT,
				GameName VARCHAR(50)
			)
			INSERT INTO @temp(Price,PurchaseDate,SerialNumber,GameName) SELECT Purchase.Price,PurchaseDate,Purchase.SerialNum,[Name]
			FROM  Project.Purchase JOIN Project.[Copy] ON Purchase.SerialNum=Copy.SerialNum 
			JOIN Project.Game ON Game.IDGame = [Copy].IDGame WHERE Purchase.IDClient=@IDClient
			IF @MinValue is not null
				DELETE FROM @temp WHERE @MinValue>Price 
			IF @MaxValue is not null 
				DELETE FROM @temp WHERE @MaxValue<Price
			IF @MinDate is not  null
				DELETE FROM @temp WHERE DATEDIFF(DAY,@MinDate,PurchaseDate) < 0
			IF @MaxDate is not null
				DELETE FROM @temp WHERE DATEDIFF(DAY,@MaxDate,PurchaseDate) > 0
            IF @GameName is not  null
				DELETE FROM @temp WHERE GameName NOT LIKE  @GameName + '%'
					
			SELECT * FROM @temp
		END
GO
/****** Object:  StoredProcedure [Project].[pd_getUserFilter]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [Project].[pd_getUserFilter](@IDClient as int, @email as varchar(50),
@username as varchar(50),@orderby as varchar(30))
as
	begin
		--email,username,orderby
		declare @temp as table(
			Username	varchar(50),
			Email		varchar(50)
		);

		INSERT INTO @temp Select Username,Email 
		From Project.Client JOIN Project.[User] on Client.UserID=[User].UserID 
		where Client.UserID<>@IDClient;

		if @email is not null
			DELETE FROM @temp where Email not like @email+'%'
		
		if @username is not null
			DELETE FROM @temp where Username not like @username+'%'

		if @orderby='UsernameAsc' or @orderby is null
			Select * From @temp ORDER BY Username Asc
		if @orderby='UsernameDesc'
			Select * From @temp ORDER BY Username Desc
		if @orderby='EmailDesc'
			Select * From @temp ORDER BY Email Desc
		if @orderby='EmailAsc'
			Select * From @temp ORDER BY Email 
	end
GO
/****** Object:  StoredProcedure [Project].[pd_insert_Games]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project].[pd_insert_Games] (
	@Name VARCHAR(50),
	@Description VARCHAR(max),
	@ReleaseDate DATE,
	@AgeRestriction INT,
	@CoverImg VARCHAR(max),
	@Price DECIMAL (5,2),
	@IDCompany INT,
	@IDFranchise INT,
	@platforms VARCHAR(max),
	@genres VARCHAR(max),
	@res VARCHAR(35) output,
	@addedGameID INT output
)
AS
	BEGIN 
		BEGIN TRAN
			BEGIN TRY
			    DECLARE @tempcounter INT;
				INSERT INTO Project.Game([Name],[Description],ReleaseDate,AgeRestriction,CoverImg,Price,IDCompany,IDFranchise) 
				VALUES(@Name,@Description,@ReleaseDate,@AgeRestriction,@CoverImg,@Price,@IDCompany,@IDFranchise)
				SELECT TOP 1 @addedGameID=IDGame FROM Project.Game ORDER BY IDGame DESC
				PRINT @addedGameID
				--insert Game Genres
					DECLARE @SP INT
					DECLARE @VALUE VARCHAR(1000)
					WHILE PATINDEX('%' + ',' + '%', @genres ) <> 0
					BEGIN
					SELECT  @SP = PATINDEX('%' + ','  + '%',@genres)
					SELECT  @VALUE = LEFT(@genres , @SP - 1)
					SELECT  @genres = STUFF(@genres, 1, @SP, '')
					INSERT INTO Project.GameGenre(IDGame,GenName) VALUES (@addedGameID,@VALUE)
					END
				--insert Game Platforms
					SET  @SP=0;
					SET @VALUE=''
					WHILE PATINDEX('%' + ',' + '%', @platforms ) <> 0
					BEGIN
					SELECT  @SP = PATINDEX('%' + ','  + '%',@platforms)
					SELECT  @VALUE = LEFT(@platforms , @SP - 1)
					SELECT  @platforms = STUFF(@platforms, 1, @SP, '')
					INSERT INTO Project.PlatformReleasesGame(IDGame,PlatformName) VALUES (@addedGameID,@VALUE)
					END
						
				-- Insert Copies of the Game depending on the number of platforms passed ( 1 copy for each platform)
					SET @tempcounter=1
					WHILE (SELECT COUNT(PlatformName) FROM Project.PlatformReleasesGame WHERE PlatformReleasesGame.IDGame=@addedGameID) >= @tempcounter
					BEGIN
						SET @platforms= (SELECT  PlatformName From (SELECT *,ROW_NUMBER() OVER(ORDER BY PlatformName  DESC) AS mRow FROM Project.PlatformReleasesGame  WHERE @addedGameID=IDGame) as TT WHERE TT.mRow=@tempcounter)
						INSERT INTO Project.[Copy](IDGame,PlatformName) VALUES (@addedGameID,@platforms);
						SET	@tempcounter+=1
					END
					SET @res='Success inserting Games'
			END TRY
			BEGIN CATCH
					SET @res=ERROR_MESSAGE();
					ROLLBACK TRAN
			END CATCH
		IF @@TRANCOUNT>0
		COMMIT TRAN
	END

GO
/****** Object:  StoredProcedure [Project].[pd_insertAdmin]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project].[pd_insertAdmin](
	@Email VARCHAR(50),
	@Password VARCHAR(20),
	@RegisterDate DATE,
	@res VARCHAR(255) OUTPUT
)
	AS
		BEGIN
		BEGIN TRAN
		BEGIN TRY
			DECLARE @UserID INT;
			INSERT INTO Project.[User] VALUES (@Email,ENCRYPTBYPASSPHRASE('**********',@Password),@RegisterDate)
			SET @UserID=(SELECT TOP 1 UserID FROM Project.[User] WHERE @Email=Email order by USERID DESC)
			INSERT INTO Project.[Admin] VALUES (@UserID)
			SET @res='Success inserting new Admin!'
		END TRY
		BEGIN CATCH
			SET @res=ERROR_MESSAGE();
			ROLLBACK TRAN
		END CATCH
		IF @@TRANCOUNT>0
		COMMIT TRAN
		END
GO
/****** Object:  StoredProcedure [Project].[pd_insertCompany]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project].[pd_insertCompany] (
	@Contact VARCHAR(50),
	@CompanyName VARCHAR(30),
	@Website VARCHAR(50),
	@Logo VARCHAR(MAX),
	@FoundationDate DATE,
	@City VARCHAR(50),
	@Country VARCHAR(50),
	@res VARCHAR(255) OUTPUT
)
AS
	BEGIN
		BEGIN TRY
			INSERT INTO Project.Company (Contact,CompanyName,Website,Logo,FoundationDate,City,Country) VALUES (@Contact,@CompanyName,@Website,@Logo,@FoundationDate,@City,@Country)
			SET @res='Success inserting New Company!'
		END TRY
		BEGIN CATCH
			SET @res=ERROR_MESSAGE()
		END CATCH
	END

GO
/****** Object:  StoredProcedure [Project].[pd_insertCredit]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project].[pd_insertCredit](
	@MetCredit varchar(20),
	@DateCredit DATE,
	@ValueCredit DECIMAL (4,2),
	@IDClient INT,
	@res VARCHAR(255) OUTPUT
	)
	AS
		BEGIN
		BEGIN TRAN
			BEGIN TRY
				INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient) VALUES (@MetCredit,@DateCredit,@ValueCredit,@IDClient)
				SET @res='Success Inserting Credit'
			END TRY
			BEGIN CATCH
				SET @res=ERROR_MESSAGE()
			ROLLBACK TRAN
			END CATCH
		IF @@TRANCOUNT>0
		COMMIT TRAN
		END

GO
/****** Object:  StoredProcedure [Project].[pd_insertDiscount]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project].[pd_insertDiscount](
	@PromoCode INT,
	@Percentage INT,
	@DateBegin DATE,
	@DateEnd DATE,

	@res VARCHAR(50)output

)
AS
	BEGIN
		BEGIN TRY
		INSERT INTO Project.Discount (PromoCode,[Percentage],DateBegin,DateEnd) VALUES (@PromoCode,@Percentage,@DateBegin,@DateEnd)
		SET @res='Success Inserting new  Discount'
		END TRY
		BEGIN CATCH
			set @res=ERROR_MESSAGE()
		END CATCH
	END


GO
/****** Object:  StoredProcedure [Project].[pd_insertDiscountGame]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project].[pd_insertDiscountGame](
	@PromoCode INT,
	@IDGame INT,
	@res varchar(255) output
)
AS
	BEGIN
	BEGIN TRY
		DECLARE @tempPer INT;
		SET @tempPer = (SELECT TOP 1 * FROM Project.[udf_checkGameDiscount](@IDGame))
		IF @tempPer IS NOT NULL
			raiserror('Cannot Insert a Discount to This Game, because it has already one active',16,1)
		ELSE
		BEGIN
			INSERT INTO Project.DiscountGame VALUES(@PromoCode,@IDGame)
			SET @res='Success aplying this Discount to this Game!'
		END
	END TRY
	BEGIN CATCH
		SET @res=ERROR_MESSAGE()
	END CATCH
	END
GO
/****** Object:  StoredProcedure [Project].[pd_insertFollows]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project].[pd_insertFollows](
	@IDFollower INT,
	@IDFollowed INT,
	@res VARCHAR(255) output
	)
	AS
	BEGIN
		BEGIN TRY
			INSERT INTO Project.Follows values(@IDFollower,@IDFollowed)
			SET @res='Success inserting new Follower'
		END TRY
		BEGIN CATCH
			SET @res=ERROR_MESSAGE()
		END CATCH
	END
GO
/****** Object:  StoredProcedure [Project].[pd_insertFranchise]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Project].[pd_insertFranchise](
	@Name VARCHAR(30),
	@Logo VARCHAR(MAX),
	@IDCompany INT,
	@res VARCHAR(MAX) OUTPUT
)
AS
	BEGIN
		BEGIN TRY
			INSERT INTO Project.Franchise ([Name],Logo,IDCompany) VALUES (@Name,@Logo,@IDCompany)
			SET @res='Success inserting a new Franchise!'
		END TRY
		BEGIN CATCH
			SET @res=ERROR_MESSAGE()
		END CATCH
	END
GO
/****** Object:  StoredProcedure [Project].[pd_insertGenres]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project].[pd_insertGenres] (
	@GenName VARCHAR(50),
	@Description VARCHAR(MAX),
	@res VARCHAR(35) OUTPUT
)AS 
	BEGIN
		BEGIN TRY
				INSERT INTO Project.Genre VALUES(@GenName,@Description)
				SET @res='Sucess inserting Genre'
		END TRY
		BEGIN CATCH
				SET @res= ERROR_MESSAGE()
		END CATCH
 END
 
GO
/****** Object:  StoredProcedure [Project].[pd_insertPlatforms]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project].[pd_insertPlatforms] (	
		 @PlatformName VARCHAR(30),
		 @ReleaseDate DATE,
		 @Producer VARCHAR(30),
		 @res VARCHAR(255) OUTPUT
)
AS
	BEGIN
		 BEGIN TRY
			INSERT INTO Project.[Platform] VALUES(@PlatformName,@ReleaseDate,@Producer)
			set @res='Success Inserting new Platform!'
		 END TRY
		 BEGIN CATCH
			set @res=ERROR_MESSAGE()
		 END CATCH
	END
GO
/****** Object:  StoredProcedure [Project].[pd_insertPurchase]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [Project].[pd_insertPurchase](
	@PurchaseDate DATE,
	@IDClient INT,
	@IDGame INT,
	@PlatformName VARCHAR(30),
	@res VARCHAR(35) output
	)
	AS
		BEGIN
			BEGIN TRAN
			DECLARE @Price DECIMAL(5,2)
			DECLARE @countDispCopies INT;
			DECLARE @SerialNum INT;
			DECLARE @tempPer decimal(5,2);
			BEGIN TRY
			IF ( (SELECT Project.udf_checkUserPurchase(@IDClient,@IDGame)) = 1)
				raiserror ('User Already Contains that Game',16,1);

			SET @Price = (SELECT Price from Project.Game WHERE Game.IDGame=@IDGame)
			SET @SerialNum= (SELECT top 1 notBought FROM Project.[udf_checkGameCopies] (@IDGame,@PlatformName))
			IF @SerialNum IS NULL
				BEGIN
					INSERT INTO Project.Copy VALUES (@IDGame,@PlatformName)
					SET @SerialNum =( SELECT TOP 1 Copy.SerialNum FROM Project.[Copy] WHERE Copy.IDGame=@IDGame AND Copy.PlatformName=@PlatformName ORDER BY SerialNum DESC  )
				END
			
			SET @tempPer = (SELECT TOP 1 Percentage FROM Project.[udf_checkGameDiscount](@IDGame))
				IF @tempPer is not null 
					BEGIN
						Print @tempPer
						SET @Price=@Price-(@Price*(@tempPer/100))
						Print @Price
					END
			INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) VALUES (@Price,@PurchaseDate,@IDClient,@SerialNum)
			Print @Price
			SET @res ='Success!'
			END TRY
			BEGIN CATCH
				 SET @res= ERROR_MESSAGE()
				 rollback tran
			END CATCH
			if @@TRANCOUNT >0
			COMMIT TRAN
		END

GO
/****** Object:  StoredProcedure [Project].[pd_insertReview]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Project].[pd_insertReview](
	@Title VARCHAR(50),
	@Text VARCHAR(280),
	@Rating DECIMAL (2,1),
	@DateReview DATE,
	@UserID INT ,
	@IDGame INT
	)
	AS
		BEGIN
				INSERT INTO Project.Reviews(Title,[Text],Rating,DateReview,UserID,IDGame) VALUES (@Title,@Text,@Rating,@DateReview,@UserID,@IDGame)
		END
GO
/****** Object:  StoredProcedure [Project].[pd_Login]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




---- PROCEDURES---
create procedure [Project].[pd_Login](
	@Loginemail varchar(50),
	@password varchar(20),
	@response  bit output)
	as
	begin
	  declare @temp varchar(50)
	  set @temp= (select Email FROM Project.[User] where Email=@Loginemail and @password = CONVERT(varchar(20),DECRYPTBYPASSPHRASE('**********',[Password])) )
	  if  (@temp is null)
		set @response=0
	  else
	  set @response=1
	end		
GO
/****** Object:  StoredProcedure [Project].[pd_removeGameDiscount]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [Project].[pd_removeGameDiscount](
@IDGame as int,
@PromoCode as int,
@res as varchar(255) output)
as
	begin
	begin try
			if exists ( select Top 1 * From Project.DiscountGame where IDGame=@IDGame and PromoCode=@PromoCode)
				begin
					DELETE FROM Project.DiscountGame where IDGame=@IDGame and PromoCode=@PromoCode;
				end
			else
				raiserror('This Game does not have this discount',16,1);
	set @res = 'Success removing Discount from game'
	end try
	begin catch
			set @res = error_message();
	end catch				
	end
GO
/****** Object:  StoredProcedure [Project].[pd_removeGameGenre]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Project].[pd_removeGameGenre] (
@IDGame INT,
@GenName VARCHAR(25),
@res VARCHAR(255) OUTPUT
)
AS
	BEGIN
	BEGIN TRY
		IF (( SELECT IDGame FROM Project.GameGenre WHERE GenName=@GenName AND IDGame=@IDGame) IS NOT NULL)
		BEGIN
			DELETE FROM Project.GameGenre WHERE IDGame=@IDGame AND GenName=@GenName
			SET @res='Success'
		END
		ELSE
			RAISERROR('Could not remove the Genre associated within this Game',16,1)
	END TRY
	BEGIN CATCH
		SET @res=ERROR_MESSAGE();
	END CATCH
	END	


GO
/****** Object:  StoredProcedure [Project].[pd_sign_up]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [Project].[pd_sign_up]
    @email VARCHAR(50), 
    @password VARCHAR(20), 
    @registerDate    DATE ,
    @userName VARCHAR(50),
    @fullName VARCHAR(max),
    @sex        CHAR,
    @birth      DATE,
    @response varchar(255) output
as
begin
    begin try

        insert into Project.[User](Email,[Password], RegisterDate) values (@email,ENCRYPTBYPASSPHRASE('**********',@password) ,@registerDate)
        DECLARE @client_id AS INT;
        SELECT @client_id = UserID from Project.[User] where [User].Email=@email
        INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance)  VALUES(@client_id,@userName,@fullName,@sex, @birth,0.0)
        set @response='Success'
    end try
    begin catch
        set @response=ERROR_MESSAGE()
    end catch
end
GO
/****** Object:  StoredProcedure [Project].[pd_updateCompany]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project].[pd_updateCompany] (
@IDCompany INT,
@Contact VARCHAR(50),
@CompanyName VARCHAR(50),
@Website VARCHAR(MAX),
@Logo VARCHAR(MAX),
@FoundationDate VARCHAR(MAX),
@City VARCHAR(50),
@Country VARCHAR(50),
@res VARCHAR(255) output

)
AS
	BEGIN
		BEGIN TRY		
		if @CompanyName is not null
			update Project.Company
			set CompanyName=@CompanyName where IDCompany =@IDCompany
		
		update Project.Company
		set Logo=@Logo,Contact=@Contact,CompanyName=@CompanyName, Website=@Website,FoundationDate=@FoundationDate,City=@City,Country=@Country where IDCompany = @IDCompany

		set @res = 'Success updating the Franchise.'
		END TRY
		BEGIN CATCH
			set @res = 'There was an error trying to update the Company.'
		END CATCH
	END


GO
/****** Object:  StoredProcedure [Project].[pd_updateDiscount]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [Project].[pd_updateDiscount](
	@PromoCode as int,
	@Percentage as int,
	@Begin as Date,
	@End as Date,
	@res as Varchar(255) output)

as
	begin
		begin try

			Update Project.Discount
			set Percentage=@Percentage, DateBegin=@Begin, DateEnd=@End where PromoCode=@PromoCode
			set @res = 'Success updating Discount'


		end try
		begin catch
			set @res = 'Could not update discount'
		end catch
	end





--TRIGGERS
GO
/****** Object:  StoredProcedure [Project].[pd_updateFranchise]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [Project].[pd_updateFranchise](
	@IDFranchise as int,
	@Name as varchar(30),
	@Logo as varchar(max),
	@IDCompany as int,
	@res as varchar(255) output
)
as
	begin
		begin try		
		if @Name is not null
			update Project.Franchise
			set Name=@Name where IDFranchise =@IDFranchise
		
		update Project.Franchise
		set Logo=@Logo,IDCompany=@IDCompany where IDFranchise = @IDFranchise

		set @res = 'Success updating the Franchise.'
		end try
		begin catch
			set @res = 'There was an error trying to update the Franchise.'
		end catch
	end
GO
/****** Object:  StoredProcedure [Project].[pd_updateGame]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [Project].[pd_updateGame](
	@IDGame INT,
	@Name  VARCHAR(50),
	@Description VARCHAR(max),
	@ReleaseDate DATE,
	@AgeRestriction INT,
	@CoverImg VARCHAR(max),
	@Price DECIMAL (5,2),
	@IDCompany INT,
	@IDFranchise INT,
	@res VARCHAR(255) output
)
	AS
	BEGIN
		BEGIN TRY
			IF @Name is not null
			BEGIN
				IF NOT EXISTS( SELECT TOP 1 [Name] FROM Project.Game WHERE Game.[Name] =@Name)
					UPDATE Project.Game	set [Name]=@Name where IDGame =@IDGame
				ELSE IF @Name=(Select TOP 1 Name From Project.Game where IDGame=@IDGame)
					UPDATE Project.Game	set [Name]=@Name where IDGame =@IDGame
				ELSe
					raiserror('Game Name already exists!',16,1);
			END
			IF ((SELECT IDCompany FROM Project.udf_getCompanyDetails(@IDCompany)) is not   null ) UPDATE Project.Game	set IDCompany=@IDCompany where IDGame =@IDGame
			ELSE
				raiserror('Company not found!',16,1);
			if @IDFranchise is not null
			begin
				IF ((SELECT IDFranchise FROM Project.udf_getFranchiseDetails(@IDFranchise)) is not   null ) UPDATE Project.Game	set IDFranchise=@IDFranchise where IDGame =@IDGame
				ELSE
					raiserror('Franchise not found!',16,1);
			end
			UPDATE Project.Game SET [Description]=@Description,ReleaseDate=@ReleaseDate,AgeRestriction=@AgeRestriction,CoverImg=@CoverImg,Price=@Price WHERE IDGame=@IDGame
			SET @res='Success updating Game Info!'
					
		END TRY
		BEGIN CATCH
			SET @res=ERROR_MESSAGE();
		END CATCH
	END


GO
/****** Object:  StoredProcedure [Project].[pd_updateGenre]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project].[pd_updateGenre](
	@GenName as Varchar(25),
	@Description as Varchar(MAX),
	@res as Varchar(MAX) output
)
as
	begin
		begin try
			
			update Project.Genre
			set Description=@Description where GenName=@GenName;

			set @res = 'Success updating the Genre'
		end try
		begin catch
			set @res = 'There was an error updating the Genre'
		end catch
	end

GO
/****** Object:  StoredProcedure [Project].[pd_updatePlatform]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Project].[pd_updatePlatform](
	@PlatformName as Varchar(30),
	@Producer as varchar(30),
	@ReleaseDate as date,
	@res as varchar(255) output)
as
	begin
		begin try
			if @ReleaseDate is not null
				update Project.[Platform]
				set ReleaseDate=@ReleaseDate where PlatformName=@PlatformName;

			if @Producer is not null
				update Project.[Platform]
				set Producer=@Producer where PlatformName=@PlatformName;

			set @res = 'Success updating Platform';
			
		end try
		begin catch
			set @res = 'Could not update Platform';
		end catch
	end

GO
/****** Object:  StoredProcedure [Project].[pd_UpdateUser]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [Project].[pd_UpdateUser](
	      @UserID AS INT,
		  @Email AS VARCHAR(50),
		  @Password AS VARCHAR(20),
		  @UserName AS VARCHAR(50),
		  @FullName AS VARCHAR(MAX),
		  @Sex AS CHAR(1),
		  @Birth AS DATE,
		  @responseMsg VARCHAR(MAX) output
		 )
AS
	BEGIN
			BEGIN TRY
				IF @Email IS NOT NULL
				BEGIN
					IF (Select Project.udf_check_email (@Email)) > 0 AND (Select Email From Project.[User] where UserID=@UserID)<>@Email
					BEGIN
						SET @responseMsg = 'Email in use'
						return
					END
					ELSE
					BEGIN
						UPDATE Project.[User]
						SET Email =@Email
						WHERE UserID=@UserID
					END
				END
				IF @Password IS NOT NULL
				BEGIN
					UPDATE Project.[User]
					SET [Password]=(ENCRYPTBYPASSPHRASE('**********',@Password))
					WHERE UserID=@UserID
				END
				IF @UserName IS NOT NULL
				BEGIN
					IF (Select Project.udf_check_username(@UserName))>0 and (Select Username From Project.Client where UserID=@UserID)<>@UserName 
					BEGIN
						Set @responseMsg = 'Usename in use'
						return
					END
					ELSE
					BEGIn
						UPDATE Project.Client
						SET UserName=@UserName
						WHERE UserID=@UserID
					END
				END
				IF @Sex IS NOT NULL
				BEGIN
					UPDATE Project.Client
					SET Sex=@Sex
					WHERE UserID=@UserID
				END
				SET @responseMsg='Success On Updating Account!'
			END TRY
			BEGIN CATCH
				set @responseMsg='Could not Update Account'
			END CATCH
			PRINT @responseMsg
	END
GO
/****** Object:  Trigger [Project].[trigger_Admin]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [Project].[trigger_Admin] ON [Project].[Admin]
INSTEAD OF INSERT
	AS
		BEGIN
			DECLARE @UserID INT;
			SELECT @UserID = UserID FROM inserted;
			IF EXISTS (SELECT TOP 1 UserID FROM Project.[Admin] WHERE UserID=@UserID)
				raiserror('This User is already an Admin of the Platform!',16,1)
			IF EXISTS (SELECT TOP 1 UserID FROM Project.[Client] WHERE UserID=@UserID)
				raiserror('Cannot be a Client and Admin at the same Time!',16,1)
			ELSE
				INSERT INTO Project.[Admin] VALUES (@UserID)
		END


GO
ALTER TABLE [Project].[Admin] ENABLE TRIGGER [trigger_Admin]
GO
/****** Object:  Trigger [Project].[trigger_Client]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [Project].[trigger_Client] ON [Project].[Client]
INSTEAD OF INSERT
	AS
		BEGIN
				DECLARE	@UserID VARCHAR(50);
				DECLARE	@userName VARCHAR(50);
				DECLARE	@fullName VARCHAR(max);
				DECLARE @sex        CHAR;
				DECLARE	@birth      DATE;
				SELECT @UserID=UserID,@userName=Username,@fullName=FullName,@sex=Sex,@birth=Birth from inserted
				IF ((SELECT Project.udf_check_username(@userName))>0)
					raiserror('Username already taken!',16,1)
				IF EXISTS (SELECT  TOP 1 UserID from Project.Client WHERE UserID = @UserID)
					raiserror('ID already in use!',16,1)
				ELSE
					INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance)  VALUES(@UserID,@userName,@fullName,@sex, @birth,0.0)
		END

GO
ALTER TABLE [Project].[Client] ENABLE TRIGGER [trigger_Client]
GO
/****** Object:  Trigger [Project].[trigger_Company]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Project].[trigger_Company] ON [Project].[Company]
INSTEAD OF INSERT
	AS
		BEGIN
			DECLARE @Contact VARCHAR(50);
			DECLARE @CompanyName VARCHAR(30);
			DECLARE @Website VARCHAR(50);
			DECLARE @Logo VARCHAR(MAX);
			DECLARE @FoundationDate DATE;
			DECLARE	@City VARCHAR(50);
			DECLARE	@Country VARCHAR(50);
			SELECT @Contact=Contact,@CompanyName=CompanyName,@Website=Website,@Logo=Logo,@FoundationDate=FoundationDate,@City=City,@Country=Country FROM inserted;
			IF EXISTS (SELECT TOP 1 CompanyName FROM Project.Company WHERE CompanyName=@CompanyName)
			RAISERROR('This Company Name Already Exists!',16,1)
			ELSE
			INSERT INTO Project.Company(Contact,CompanyName,Website,Logo,FoundationDate,City,Country) VALUES (@Contact,@CompanyName,@Website,@Logo,@FoundationDate,@City,@Country)
		END
GO
ALTER TABLE [Project].[Company] ENABLE TRIGGER [trigger_Company]
GO
/****** Object:  Trigger [Project].[trigger_credit]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [Project].[trigger_credit] ON [Project].[Credit]
INSTEAD OF INSERT
AS
	BEGIN
			DECLARE @MetCredit as VARCHAR(20);
			DECLARE @DateCredit as DATE;
			DECLARE @ValueCredit as DECIMAL(4,2);
			DECLARE @IDClient AS INT;
			
			SELECT @MetCredit = MetCredit,@DateCredit = DateCredit, @ValueCredit = ValueCredit,@IDClient = IDClient FROM INSERTED;
				IF NOT EXISTS(select UserID FROM Project.Client WHERE @IDClient=UserID)
					RAISERROR('User not found!',16,1)
				ELSE
				BEGIN
					INSERT INTO Project.Credit(MetCredit,DateCredit,ValueCredit,IDClient) VALUES (@MetCredit,@DateCredit,@ValueCredit,@IDClient)
					UPDATE Project.Client
						SET Balance+=@ValueCredit 
						WHERE Project.Client.UserID=@IDClient
				END
	END

GO
ALTER TABLE [Project].[Credit] ENABLE TRIGGER [trigger_credit]
GO
/****** Object:  Trigger [Project].[trigger_Discount]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Project].[trigger_Discount] ON [Project].[Discount]
INSTEAD OF INSERT
AS
	BEGIN
		DECLARE @PromoCode INT;
		DECLARE		@Percentage INT;
		DECLARE		@DateBegin DATE;
		DECLARE		@DateEnd DATE;
		DECLARE		@IDGame INT;
		SELECT @PromoCode=PromoCode,@Percentage=[Percentage],@DateBegin=DateBegin,@DateEnd=DateEnd from inserted
		IF EXISTS (SELECT TOP 1 PromoCode FROM Project.Discount WHERE Discount.PromoCode = @PromoCode) 
			RAISERROR('This PromoCode already exists!',16,1)
		ELSE
			INSERT INTO Project.Discount (PromoCode,[Percentage],DateBegin,DateEnd) VALUES (@PromoCode,@Percentage,@DateBegin,@DateEnd)
	END
GO
ALTER TABLE [Project].[Discount] ENABLE TRIGGER [trigger_Discount]
GO
/****** Object:  Trigger [Project].[trigger_DiscountGame]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [Project].[trigger_DiscountGame] ON [Project].[DiscountGame]
INSTEAD OF INSERT
	AS
		BEGIN 
			DECLARE @PromoCode INT;
			DECLARE @IDGame INT;
			SELECT @PromoCode=PromoCode,@IDGame=IDGame FROM inserted;
			IF NOT EXISTS (SELECT TOP 1 PromoCode	FROM Project.Discount WHERE PromoCode=@PromoCode)
				raiserror('This Promotional Code does not exist!',16,1)
			IF NOT EXISTS (SELECT TOP 1 IDGame	FROM Project.Game WHERE IDGame=@IDGame)
				raiserror('This Game does not exist!',16,1)
			IF EXISTS (SELECT TOP 1 PromoCode FROM Project.DiscountGame  WhERE DiscountGame.IDGame=@IDGame AND DiscountGame.PromoCode=@PromoCode)
				raiserror('Cannot Insert same Discount to the Same Game',16,1)
			else
				INSERT INTO Project.DiscountGame VALUES(@PromoCode,@IDGame)
		END

GO
ALTER TABLE [Project].[DiscountGame] ENABLE TRIGGER [trigger_DiscountGame]
GO
/****** Object:  Trigger [Project].[trigger_insertFollows]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [Project].[trigger_insertFollows] on [Project].[Follows]
instead of insert
AS
	BEGIN
		
		declare @idfollowed as int
		declare @idfollower as int
		declare @temp as int

		select @idfollower=IDFollower, @idfollowed=IDFollowed from inserted;

		if @idfollower=@idfollowed
			raiserror('You cannot follow yourself',16,1);

		set @temp = (select Project.udf_checkIfFollows(@idfollower,@idfollowed))
		print @temp
		print @idfollower
		print @idfollowed
		if @temp=0
			insert into Project.Follows(IDFollower,IDFollowed) values (@idfollower, @idfollowed);
		else if @temp=1
			raiserror('User is already being followed',16,1);
	END

GO
ALTER TABLE [Project].[Follows] ENABLE TRIGGER [trigger_insertFollows]
GO
/****** Object:  Trigger [Project].[trigger_Franchise]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [Project].[trigger_Franchise] ON [Project].[Franchise]
INSTEAD OF INSERT
	AS
		BEGIN
			DECLARE @Name VARCHAR(30);
			DECLARE @Logo VARCHAR(MAX);
			DECLARE @IDCompany INT;
			SELECT @Name=[Name],@Logo=Logo,@IDCompany=IDCompany FROM inserted;
			IF EXISTS (SELECT TOP 1 [Name] FROM Project.Franchise WHERE Franchise.[Name] = @Name  )
				RAISERROR('This Franchise Name Already Exists!',16,1)
			PRINT @IDCompany
			IF EXISTS (SELECT TOP 1 IDCompany FROM Project.Company WHERE Company.IDCompany = @IDCompany  )
				BEGIN
					PRINT 'OLA'
					INSERT INTO Project.Franchise ([Name],Logo,IDCompany) VALUES (@Name,@Logo,@IDCompany)
				END
			ELSE
				BEGIN
					PRINT ERROR_Message()
					RAISERROR('Error!Invalid Company!',16,1)
				END
		END

GO
ALTER TABLE [Project].[Franchise] ENABLE TRIGGER [trigger_Franchise]
GO
/****** Object:  Trigger [Project].[trigger_insertGames]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [Project].[trigger_insertGames] ON [Project].[Game]
INSTEAD OF INSERT
AS 
	BEGIN
	DECLARE @IDGame INT;
	DECLARE  @Name VARCHAR(50);
	DECLARE @Description VARCHAR(max);
	DECLARE @ReleaseDate DATE;
	DECLARE @AgeRestriction INT;
	DECLARE @CoverImg VARCHAR(max);
	DECLARE	@Price DECIMAL (5,2);
	DECLARE	@IDCompany INT;
	DECLARE	@IDFranchise INT;
	DECLARE @tempcounter INT;
	DECLARE @Plat VARCHAR(30);
	SELECT @IDGame=IDGame,@Name=[Name],@Description=[Description],@ReleaseDate=ReleaseDate,@AgeRestriction=AgeRestriction,@CoverImg=CoverImg,@Price=Price,@IDCompany=IDCompany,@IDFranchise=IDFranchise FROM inserted;
	IF EXISTS(SELECT TOP 1 [Name] From Project.Game WHERE Game.[Name]=@Name)
		raiserror('Game Already Exists!',16,1);
	ELSE
	PRINT ('ENTREI')
		INSERT INTO Project.Game VALUES(@Name,@Description,@ReleaseDate,@AgeRestriction,@CoverImg,@Price,@IDCompany,@IDFranchise)
	END


GO
ALTER TABLE [Project].[Game] ENABLE TRIGGER [trigger_insertGames]
GO
/****** Object:  Trigger [Project].[trigger_Genres]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

 CREATE TRIGGER [Project].[trigger_Genres] ON [Project].[Genre]
 INSTEAD OF INSERT
 AS
	BEGIN
		DECLARE @GenName VARCHAR(50);
		DECLARE @Description VARCHAR(35);
		SELECT @GenName=GenName,@Description=[Description] FROM inserted;
		IF EXISTS ( SELECT TOP 1 GenName FROM Project.Genre WHERE Genre.GenName=@GenName)
			RAISERROR('This Genre Name Already Exists!',16,1)
		ELSE
			INSERT INTO Project.Genre VALUES (@GenName,@Description)
	END

GO
ALTER TABLE [Project].[Genre] ENABLE TRIGGER [trigger_Genres]
GO
/****** Object:  Trigger [Project].[trigger_Platforms]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [Project].[trigger_Platforms] ON [Project].[Platform]
INSTEAD OF INSERT
AS
	BEGIN
		DECLARE  @PlatformName VARCHAR(30);
		DECLARE @ReleaseDate DATE;
		DECLARE @Producer VARCHAR(30);
		SELECT @PlatformName=PlatformName,@ReleaseDate=ReleaseDate,@Producer=Producer FROM inserted;
		IF EXISTS (SELECT TOP 1 PlatformName FROM Project.[Platform] WHERE @PlatformName=PlatformName)
				RAISERROR('This Platform Name already Exists!',16,1)
		ELSE
			BEGIN
				INSERT INTO Project.[Platform] VALUES (@PlatformName,@ReleaseDate,@Producer)
			END
	END

GO
ALTER TABLE [Project].[Platform] ENABLE TRIGGER [trigger_Platforms]
GO
/****** Object:  Trigger [Project].[trigger_purchase]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create TRIGGER [Project].[trigger_purchase] ON [Project].[Purchase]
INSTEAD OF INSERT
AS
	BEGIN
				DECLARE @Price  AS DECIMAL(5,2);
				DECLARE @PurchaseDate AS DATE;
				DECLARE	@IDClient AS INT;
				DECLARE @SerialNum AS INT;
				DECLARE @IDGame AS INT;
				DECLARE @tempPer AS INT;
				SELECT * FROM inserted
				SELECT @Price = Price , @PurchaseDate=PurchaseDate,@IDClient=IDClient,@SerialNum=SerialNum FROM INSERTED;
				if @Price - (SELECT Balance FROM Project.Client WHERE Client.UserID =@IDClient) >0
				BEGIN
					raiserror('Not enough balance to buy this game',16,1)

				END
				ELSE
					BEGIN TRY
						UPDATE Project.Client 
						SET Balance-=@Price WHERE Project.Client.UserID=@IDClient
						INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) VALUES (@Price,@PurchaseDate,@IDClient,@SerialNum)
						
					END TRY
					BEGIN CATCH
					 PRINT 'Error on line ' + CAST(ERROR_LINE() AS VARCHAR(10))
					 raiserror ('Error while inserting purchase values', 16, 1);
					END CATCH
	END

GO
ALTER TABLE [Project].[Purchase] ENABLE TRIGGER [trigger_purchase]
GO
/****** Object:  Trigger [Project].[trigger_review]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [Project].[trigger_review] ON [Project].[Reviews]
instead of insert
AS
	BEGIN
	BEGIN TRY
		DECLARE @Title AS VARCHAR(50);
		DECLARE @Text  AS VARCHAR(280);
		DECLARE @Rating AS DECIMAL (2,1);
		DECLARE @DateReview AS DATE;
		DECLARE @UserID AS INT;
		DECLARE @IDGame AS INT;
		DECLARE  @temp AS INT;
		SELECT @Title = Title, @Text = [Text] , @Rating = Rating, @DateReview = DateReview, @UserID = UserID, @IDGame = IDGame FROM INSERTED;
		SET @temp = (SELECT Project.[udf_checkReview](@UserID,@IDGame));
		if @temp = 0 
			INSERT INTO Project.Reviews(Title,[Text],Rating,DateReview,UserID,IDGame) VALUES (@Title,@Text,@Rating,@DateReview,@UserID,@IDGame)
		else
		 UPDATE Project.Reviews

		 SET Title=@Title,[Text]=@Text, Rating=@Rating, DateReview=@DateReview
		 WHERE Project.Reviews.IDGame = @IDGame AND Project.Reviews.UserID=@UserID
	END TRY
	BEGIN CATCH
		 raiserror ('Could not Insert/Update Review', 16, 1);
	END CATCH
	END
GO
ALTER TABLE [Project].[Reviews] ENABLE TRIGGER [trigger_review]
GO
/****** Object:  Trigger [Project].[trigger_User]    Script Date: 12/06/2020 19:12:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [Project].[trigger_User] ON [Project].[User]
INSTEAD OF INSERT
	AS
		BEGIN
			DECLARE  @Email VARCHAR(50);
			DECLARE	 @Password VARCHAR(30);
			DECLARE	 @RegisterDate DATE;
			SELECT @Email=Email,@Password=CONVERT(VARCHAR(20),DECRYPTBYPASSPHRASE('**********',[Password])),@RegisterDate=RegisterDate  FROM inserted
			IF ( (SELECT Project.udf_check_email(@Email)) = 1 )
				raiserror('Email already in use',16,1)
			ELSE
				INSERT INTO Project.[User] (Email,[Password],RegisterDate) VALUES(@Email,ENCRYPTBYPASSPHRASE('**********',@Password),@RegisterDate)
		END
GO
ALTER TABLE [Project].[User] ENABLE TRIGGER [trigger_User]
GO
