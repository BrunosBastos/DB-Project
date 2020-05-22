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
	@Regemail VARCHAR(50), 
	@regpassword VARCHAR(20), 
	@registerDate    DATE ,
	@userName VARCHAR(50),
	@fullName VARCHAR(max),
	@sex		CHAR,
	@birth      DATE,
	@response INT output
as
begin
	begin try

		insert into Project.[User](Email,[Password], RegisterDate) values (@Regemail, @regpassword, @registerDate)
		DECLARE @client_id AS INT;
		SELECT @client_id = UserID from Project.[User] where [User].Email=@email;
		INSERT INTO Project.Client(UserID,Username,FullName,Sex,Birth,Balance)  VALUES(@client_id,@userName,@fullName,@sex,@birth,0.0);
		set @response=0
	end try
	begin catch
		set @response=1
	end catch
end
go