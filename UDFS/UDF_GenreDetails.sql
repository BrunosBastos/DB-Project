use LocalDB;
go
create Function Project.udf_getGenreDetails(@GenName Varchar(25)) Returns Table
as
	Return( Select * From Project.Genre where Genre.GenName=@GenName);
go
go
Create Function Project.udf_getGenreGames(@GenName Varchar(25)) Returns Table
as
	Return ( Select Name From Project.GameGenre Join Project.Game ON GameGenre.IDGame=Game.IDGame where GenName=@GenName);

go
go
Create Function Project.udf_getNumberGenreGames(@GenName Varchar(25)) Returns int
as
	begin
	declare @temp as int
	SELECT @temp=COUNT(Name) FROM Project.udf_getGenreGames(@GenName);
	return @temp;
	end
go
