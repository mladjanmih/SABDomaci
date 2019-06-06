use Shop

go


--CREATE TRIGGER OrderItemPrice
--    ON [dbo].[OrderItem]
--    FOR INSERT, UPDATE
--    AS
--    BEGIN
--		declare @cursorI cursor
--		declare @articleId int, @count int
--		declare @articlePrice money
--		declare @itemId int, @shopId int
--		declare @cityId int

--		set @cursorI = cursor for
--		select ArticleId, Count, Id
--		from inserted

--		open @cursorI

--		fetch next from @cursorI
--		into @articleId, @count, @itemId

--		while (@@FETCH_STATUS = 0) 
--		begin
--			select @articlePrice = Price, @shopId = ShopId 
--			from dbo.[Article] where
--			Id = @articleId

--			select @cityId = CityId
--			from Shop
--			where Id = @shopId

--			update dbo.[OrderItem]
--			set Price = @count * @articlePrice,
--			CurrentCityId = @cityId
--			where Id = @itemId

--			fetch next from @cursorI
--			into @articleId, @count, @itemId
--		end

--		close @cursorI
--		deallocate @cursorI
--    END
