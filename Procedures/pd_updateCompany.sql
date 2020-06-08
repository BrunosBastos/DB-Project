use LocalDB;
go
CREATE PROCEDURE Project.pd_updateCompany (
@IDCompany INT,
@Contact VARCHAR(50),
@CompanyName VARCHAR(50),
@Website VARCHAR(MAX),
@Logo VARCHAR(MAX),
@FoundationDate VARCHAR(MAX),
@City VARCHAR(50),
@Country VARCHAR(50),
@res VARCHAR(255) output

)
AS
	BEGIN
		BEGIN TRY		
		if @CompanyName is not null
			update Project.Company
			set CompanyName=@CompanyName where IDCompany =@IDCompany
		
		update Project.Company
		set Logo=@Logo,Contact=@Contact,CompanyName=@CompanyName, Website=@Website,FoundationDate=@FoundationDate,City=@City,Country=@Country where IDCompany = @IDCompany

		set @res = 'Success updating the Franchise.'
		END TRY
		BEGIN CATCH
			set @res = 'There was an error trying to update the Company.'
		END CATCH
	end
