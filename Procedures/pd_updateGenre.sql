use LocalDB;

drop proc Project.pd_updateGenre;
go
Create Procedure Project.pd_updateGenre(
	@GenName as Varchar(25),
	@Description as Varchar(MAX),
	@res as Varchar(MAX) output
)
as
	begin
		begin try
			
			update Project.Genre
			set Description=@Description where GenName=@GenName;

			set @res = 'Success updating the Genre'
		end try
		begin catch
			set @res = 'There was an error updating the Genre'
		end catch
	end