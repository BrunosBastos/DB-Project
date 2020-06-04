use LocalDB
go
drop procedure Project.pd_getUserFilter;
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

exec Project.pd_getUserFilter 2,'Coco','A',null
