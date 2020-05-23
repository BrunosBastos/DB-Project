use LocalDB
go
create procedure Project.pd_Login(
	@Loginemail varchar(50),
	@password varchar(20),
	@response  bit output)
	as
	begin
	  declare @temp varchar(50)
	  set @temp= (select Email FROM Project.[User] where Email=@Loginemail and @password = [Password] )
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
    @response INT output
as
begin
    begin try

        insert into Project.[User](Email,[Password], RegisterDate) values (@email, @password,@registerDate)
        DECLARE @client_id AS INT;
        SELECT @client_id = UserID from Project.[User] where [User].Email=@email
        INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance)  VALUES(@client_id,@userName,@fullName,@sex, @birth,0.0)
        set @response=1
    end try
    begin catch
        set @response=0
    end catch
end
go

CREATE PROCEDURE Project.pd_getFranchiseData(@IDFranchise INT) 
AS
	SELECT * FROM Project.Franchise WHERE Franchise.IDFranchise = @IDFranchise
GO

CREATE Procedure Project.pd_getCompData(@IDCompany INT)
AS
	SELECT * FROM Project.Company WHERE Company.IDCompany = @IDCompany
GO

CREATE PROCEDURE Project.pd_getCompFranchise (@IDFranchise INT, @IDCompany INT)
AS 
	SELECT Company.* FROM ( Company JOIN CompFranchise ON CompFranchise.IDCompany = Company.IDCompany ) WHERE  CompFranchise.IDCompany = @IDCompany AND CompFranchise.IDFranchise = @IDFranchise
go

CREATE PROCEDURE Project.pd_getGameGenres(@IDGame int)
AS
	SELECT  Distinct Genre.* FROM (Project.Genre JOIN  Project.GameGenre ON Genre.GenName = GameGenre.GenName ) WHERE GameGenre.IDGame = @IDGame
go


