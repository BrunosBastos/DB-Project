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
	  set @temp= (SELECT  [Admin].UserID  FROM (Project.[User] JOIN Project.[Admin] on [User].UserID = [Admin].USERID ) WHERE Email = @email);
	  if  (@temp is null)
		 set @id=0;
	  else
		 set @id=@temp	
	  RETURN @id;
END
GO


SELECT * FROM (Project.[User] LEFT OUTER JOIN Project.[Admin] on [User].UserID = [Admin].USERID ) WHERE Email = 'brunobastos@gmail.com' ;