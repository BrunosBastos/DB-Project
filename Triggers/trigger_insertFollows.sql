use LocalDB;
drop trigger Project.trigger_insertFollows
go
Create Trigger Project.trigger_insertFollows on Project.Follows
instead of insert
as
	begin
		
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
	end
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

