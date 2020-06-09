use LocalDB;

go
drop proc Project.pd_updatePlatform
go
Create Procedure Project.pd_updatePlatform(
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
	
