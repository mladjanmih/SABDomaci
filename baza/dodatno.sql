use Shop

alter table Article
add constraint UQ_Article_Shop_Name
unique (ShopId, Name)

alter table City
add constraint UQ_Name
unique (Name)

alter table Shop
add constraint UQ_Shop_Name
unique (Name)

go


CREATE PROCEDURE dbo.EraseAll

AS
	delete from [Transaction]
	delete from [ReservedFunds]
	delete from [Line]
	delete from [OrderItem]
	delete from [Order]
	delete from [Article]
	delete from [Shop]
	delete from [Buyer]
	delete from [City]
RETURN 0 