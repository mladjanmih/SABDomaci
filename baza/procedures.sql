use Shop

go

CREATE PROCEDURE [dbo].[CanAddArticle]
(
	@orderId int,
    @articleId int,
	@count int,
	@itemId int output
)
AS
BEGIN
	declare @n int
	declare @itemsCount int = 0
	declare @articlesInShop int
	declare @price decimal(10, 3), @shopDiscount int
	declare @shopId int, @articlePrice decimal(10, 3), @articleDiscount decimal(10, 3)

	set @itemId = -1

	--checking if order exists
	select @n = count(*)
	from dbo.[Order] where Id = @orderId
	if (@n <> 1)
	begin
		return -1
	end

	--checking if article exists
	select @n = count(*)
	from dbo.[Article] where Id = @articleId
	if (@n <> 1)
	begin
		return -1
	end

	--checking if there are enough items
	select @articlesInShop = Count, @shopId = ShopId, @articlePrice = Price
	from dbo.[Article] where Id = @articleId
	if (@articlesInShop < @count)
	begin
		return -1
	end

	--checking if article was previously added to order
	select @n = count(*)
	from dbo.[OrderItem] where OrderId = @orderId and ArticleId = @articleId
	if (@n = 1)
	begin
		select @itemsCount = Count, @itemId = Id
		from dbo.[OrderItem]
		where OrderId = @orderId and ArticleId = @articleId

		set @itemsCount = @itemsCount + @count
		
		select @shopDiscount = Discount from Shop where Id = @shopId 
		set @price = @itemsCount * @articlePrice
		if (@shopDiscount is not null)
			set @articleDiscount = (@price * @shopDiscount) / 100.0

		update dbo.[OrderItem]
		set Count = @itemsCount,
		Price = @articlePrice,
		Discount = @articleDiscount
		where Id = @itemId
		return 0
	end
	else if (@n = 0)
	begin
		select @shopDiscount = Discount from Shop where Id = @shopId 
		set @price = @count * @articlePrice
		if (@shopDiscount is not null)
			set @articleDiscount = (@price * @shopDiscount) / 100.0
		
			
		insert into dbo.[OrderItem] (Count, ArrivedAtGatheringCity, ArticleId, OrderId, Price, Discount, CurrentCityId, GatheringCityId)
		values (@count, 0, @articleId, @orderId, @price, @articleDiscount, null, null);
		set @itemId = @@IDENTITY
	end
	else
	begin
		return -1
	end
	
    RETURN 0

END

go

CREATE PROCEDURE dbo.CompleteOrder
(
    @orderId int
)
AS
begin
	declare @orderStatus varchar(10)
	declare @cursorItem cursor
	declare @validOrder int

	declare @itId int, @itCnt int, @itPrc decimal(10, 3), @articleId int
	declare @articleCnt int, @articlePrice decimal(10, 3), @finalPrice decimal(10, 3)


	select @orderStatus = State
	from [Order] 
	where Id = @orderId

	if (@orderStatus <> 'created')
	begin
		return -1;
	end

	set @validOrder = dbo.CanCompleteOrder(@orderId)

	if (@validOrder <> 0) 
	begin
		return -1
	end

	set @cursorItem = cursor for
	select Id, Price, Count, ArticleId
	from OrderItem
	where OrderId = @orderId

	open @cursorItem

	fetch next from @cursorItem 
	into @itId, @itPrc, @itCnt, @articleId

	while (@@FETCH_STATUS = 0) 
	begin
		select @articleCnt = Count
		from Article
		where Id = @articleId

		set @finalPrice = @finalPrice + @itPrc
		set @articleCnt = @articleCnt - @itCnt

		update Article
		set Count = @articleCnt
		where Id = @articleId

		fetch next from @cursorItem 
		into @itId, @itPrc, @itCnt
	end

	update dbo.[Order]
	set State = 'sent',
	Price = @finalPrice,
	SentTime = GETDATE(),
	ItemsGathered = 0
	

	close @cursorItem
	deallocate @cursorItem

	RETURN 0 
end