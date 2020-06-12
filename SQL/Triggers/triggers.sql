go
CREATE TRIGGER Project.trigger_review ON Project.[Reviews]
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
go


go
CREATE TRIGGER Project.trigger_credit ON Project.Credit
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

create TRIGGER Project.trigger_purchase ON Project.Purchase
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



CREATE TRIGGER Project.trigger_insertGames ON Project.Game
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


go
go
CREATE TRIGGER Project.trigger_Client ON Project.Client
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

go
 

 CREATE TRIGGER Project.trigger_Genres ON Project.Genre
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

go


CREATE TRIGGER Project.trigger_Franchise ON Project.Franchise
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

go

CREATE TRIGGER Project.trigger_Platforms ON Project.[Platform]
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

CREATE TRIGGER Project.trigger_Company ON Project.[Company]
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

CREATE TRIGGER Project.trigger_Discount ON Project.Discount
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
go
CREATE TRIGGER Project.trigger_DiscountGame ON Project.DiscountGame
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



GO
CREATE TRIGGER Project.trigger_Admin ON Project.[Admin]
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
CREATE TRIGGER Project.trigger_User ON Project.[User]
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
go



CREATE TRIGGER Project.trigger_insertFollows on Project.Follows
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

go

