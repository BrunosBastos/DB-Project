use LocalDB;
go
Create Procedure Project.pd_removeGameDiscount(
	@IDGame as int,
	@PromoCode as int,
	@res as varchar(255) output)
as
	begin
	
			if exists ( select Top 1 * From Project.DiscountGame where IDGame=@IDGame and PromoCode=@PromoCode)
				begin
					DELETE FROM Project.DiscountGame where IDGame=@IDGame and PromoCode=@PromoCode;
					set @res = 'Success removing Discount from game'
				end
			else
				set @res = 'This Game does not have this discount'
	end