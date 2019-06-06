use Shop

go

CREATE FUNCTION [dbo].[CanCompleteOrder]
(
    @orderId int
)
RETURNS INT
AS
BEGIN
	return (select count(*) 
	from OrderItem oi
	where oi.OrderId = @orderId
	and Count > (select top 1 Count from Article where Id = oi.ArticleId))
END

go

CREATE FUNCTION [dbo].[CalculateGatheringCity]
(
    @orderId int

)
RETURNS INT
AS
BEGIN

    RETURN @orderId

END


--CREATE PROCEDURE [dbo].[CanAddArticle]
--(
--	@orderId int,
--    @articleId int,
--	@count int,
--	@itemId int output
--)
--AS
--BEGIN
--	declare @n int
--	declare @itemsCount int = 0
--	declare @articlesInShop int

--	set @itemId = -1

--	--checking if order exists
--	select @n = count(*)
--	from dbo.[Order] where Id = @orderId
--	if (@n <> 1)
--	begin
--		return -1
--	end

--	--checking if article exists
--	select @n = count(*)
--	from dbo.[Article] where Id = @articleId
--	if (@n <> 1)
--	begin
--		return -1
--	end

--	--checking if there are enough items
--	select @articlesInShop = Count
--	from dbo.[Article] where Id = @articleId
--	if (@articlesInShop < @count)
--	begin
--		return -1
--	end

--	--checking if article was previously added to order
--	select @n = count(*)
--	from dbo.[OrderItem] where OrderId = @orderId and ArticleId = @articleId
--	if (@n = 1)
--	begin
--		select @itemsCount = Count, @itemId = Id
--		from dbo.[OrderItem]
--		where OrderId = @orderId and ArticleId = @articleId

--		set @itemsCount = @itemsCount + @count

--		update dbo.[OrderItem]
--		set Count = @itemsCount
--		where Id = @itemId
--		return 0
--	end
--	else if (@n = 0)
--	begin
--		insert into dbo.[OrderItem] (Count, ArrivedAtGatheringCity, ArticleId, OrderId, Price, CurrentCityId, GatheringCityId)
--		values (@count, 0, @articleId, @orderId, 0, null, null);
--		set @itemId = @@IDENTITY
--	end
--	else
--	begin
--		return -1
--	end
	
--    RETURN 0

--END
