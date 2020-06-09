use LocalDB;

drop proc Project.pd_updateFranchise;
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


