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

Select * from Project.Follows;

insert into Project.Follows values(8,2)
select Project.udf_checkIfFollows(4,3)