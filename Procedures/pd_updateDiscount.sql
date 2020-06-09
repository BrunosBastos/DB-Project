use LocalDB;

Drop proc Project.pd_updateDiscount
go
Create Procedure Project.pd_updateDiscount(
	@PromoCode as int,
	@Percentage as int,
	@Begin as Date,
	@End as Date,
	@res as Varchar(255) output)

as
	begin
		begin try

			Update Project.Discount
			set Percentage=@Percentage, DateBegin=@Begin, DateEnd=@End where PromoCode=@PromoCode
			set @res = 'Success updating Discount'


		end try
		begin catch
			set @res = 'Could not update discount'
		end catch
	end
