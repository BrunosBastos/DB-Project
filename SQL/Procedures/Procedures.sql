---- PROCEDURES---
create procedure Project.pd_Login(
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
go


go
create procedure Project.pd_sign_up
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
go

GO
CREATE PROCEDURE Project.pd_insertCredit(
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

go
CREATE PROCEDURE Project.pd_insertPurchase(
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
			DECLARE @tempPer INT;
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
			
			SET @tempPer = (SELECT TOP 1 * FROM Project.[udf_checkGameDiscount](@IDGame))
				IF @tempPer is not null 
					BEGIN
						SET @Price-=@Price*(@tempPer/100)
					END
			INSERT INTO Project.Purchase(Price,PurchaseDate,IDClient,SerialNum) VALUES (@Price,@PurchaseDate,@IDClient,@SerialNum)
			SET @res ='Success!'
			END TRY
			BEGIN CATCH
				 SET @res= ERROR_MESSAGE()
				 rollback tran
			END CATCH
			if @@TRANCOUNT >0
			COMMIT TRAN
		END

go


GO
CREATE PROCEDURE Project.pd_filter_PurchaseHistory(
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
go
go
CREATE PROCEDURE Project.pd_filter_CreditHistory(
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
go
CREATE PROCEDURE Project.pd_filter_Games(
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

go

go
Create PROCEDURE Project.pd_UpdateUser(
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
				raiserror('Could not Update Account',16,1)
				set @responseMsg=error_message()
			END CATCH
			PRINT @responseMsg
	END
go

CREATE PROCEDURE Project.pd_insert_Games (
	@Name  VARCHAR(50),
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
						
				-- Insert 4 Copies of the Game
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


CREATE PROCEDURE Project.pd_insertGenres (
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

CREATE PROCEDURE Project.pd_insertFranchise(
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


go
CREATE PROCEDURE Project.pd_insertPlatforms (	
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

CREATE PROCEDURE Project.pd_insertCompany (
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

GO
create PROCEDURE Project.pd_insertDiscount(
	@PromoCode INT,
	@Percentage INT,
	@DateBegin DATE,
	@DateEnd DATE,

	@res VARCHAR(50)output

)
AS
	BEGIN
	BEGIN TRAN
		BEGIN TRY
		INSERT INTO Project.Discount (PromoCode,[Percentage],DateBegin,DateEnd) VALUES (@PromoCode,@Percentage,@DateBegin,@DateEnd)
		SET @res='Success Inserting new  Discount'
		END TRY
		BEGIN CATCH
			set @res=ERROR_MESSAGE()
			Rollback
		END CATCH
	IF @@TRANCOUNT>0
	COMMIT TRAN
END


GO

CREATE PROCEDURE Project.pd_insertDiscountGame(
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

GO
CREATE PROCEDURE Project.pd_insertAdmin(
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
go


CREATE PROCEDURE Project.pd_insertFollows(
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
go


Create Procedure Project.pd_getUserFilter(@IDClient as int, @email as varchar(50),
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
go


CREATE PROCEDURE Project.pd_updateCompany (
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
CREATE PROCEDURE Project.pd_updatePlatform(
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

go	
Create Procedure Project.pd_updateFranchise(
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
Create Procedure Project.pd_deleteFollows(
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
			set @res=ERROR_MESSAGE()
		END CATCH
	END

go
CREATE PROCEDURE Project.pd_updateGame(
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
				IF NOT EXISTS( SELECT TOP 1 [Name] FROM Project.Game WHERE Game.[Name] =@Name) UPDATE Project.Game	set [Name]=@Name where IDGame =@IDGame
				ELSE
					raiserror('Game Name already exists!',16,1);
			END
			IF ((SELECT IDCompany FROM Project.udf_getCompanyDetails(@IDCompany)) is not   null ) UPDATE Project.Game	set IDCompany=@IDCompany where IDGame =@IDGame
			ELSE
				raiserror('Company not found!',16,1);
			IF ((SELECT IDCompany FROM Project.udf_getFranchiseDetails(@IDFranchise)) is not   null ) UPDATE Project.Game	set IDCompany=@IDCompany where IDGame =@IDGame
			ELSE
				raiserror('Franchise not found!',16,1);
			UPDATE Project.Game SET [Description]=@Description,ReleaseDate=@ReleaseDate,AgeRestriction=@AgeRestriction,CoverImg=@CoverImg,Price=@Price WHERE IDGame=@IDGame
			SET @res='Success updating Game Info!'
					
		END TRY
		BEGIN CATCH
			SET @res=ERROR_MESSAGE();
		END CATCH
	END
