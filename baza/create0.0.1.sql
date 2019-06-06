
CREATE TABLE [Account]
( 
	[Balance]            decimal(10,3)  NULL ,
	[Id]                 integer  NOT NULL 
)
go

ALTER TABLE [Account]
	ADD CONSTRAINT [XPKAccount] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [Article]
( 
	[Id]                 integer  NOT NULL ,
	[Name]               varchar(100)  NULL ,
	[Price]              integer  NULL 
)
go

ALTER TABLE [Article]
	ADD CONSTRAINT [XPKArticle] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [Buyer]
( 
	[Id]                 integer  NOT NULL ,
	[Name]               varchar(100)  NULL ,
	[CityId]             integer  NOT NULL 
)
go

ALTER TABLE [Buyer]
	ADD CONSTRAINT [XPKBuyer] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [City]
( 
	[Id]                 integer  NOT NULL ,
	[Name]               varchar(100)  NULL 
)
go

ALTER TABLE [City]
	ADD CONSTRAINT [XPKCity] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [CityConnection]
( 
	[IdCity1]            integer  NOT NULL ,
	[IdCity2]            integer  NOT NULL ,
	[Distance]           integer  NULL 
)
go

ALTER TABLE [CityConnection]
	ADD CONSTRAINT [XPKCityConnection] PRIMARY KEY  CLUSTERED ([IdCity1] ASC,[IdCity2] ASC)
go

CREATE TABLE [Order]
( 
	[Id]                 integer  NOT NULL ,
	[BuyerId]            integer  NULL ,
	[State]              char  NULL ,
	[Price]              decimal(10,3)  NULL ,
	[SentTime]           datetime  NULL ,
	[ReceivedTime]       datetime  NULL ,
	[CityId]             integer  NULL ,
	[Discount]           decimal(10,3)  NULL ,
	[ExtraDiscount]      bit  NULL 
)
go

ALTER TABLE [Order]
	ADD CONSTRAINT [XPKOrder] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [OrderItem]
( 
	[Id]                 integer  NOT NULL ,
	[Count]              integer  NULL ,
	[OrderId]            integer  NOT NULL ,
	[ArticleId]          integer  NULL ,
	[ShopId]             integer  NULL ,
	[Price]              decimal(10,3)  NULL 
)
go

ALTER TABLE [OrderItem]
	ADD CONSTRAINT [XPKOrderItem] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [ReservedFunds]
( 
	[AccountId]          integer  NOT NULL ,
	[OrderId]            integer  NOT NULL ,
	[Id]                 integer  NOT NULL ,
	[Amount]             decimal(10,3)  NULL 
)
go

ALTER TABLE [ReservedFunds]
	ADD CONSTRAINT [XPKReservedFunds] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [Shop]
( 
	[Id]                 integer  NOT NULL ,
	[Name]               varchar(100)  NULL ,
	[Discount]           integer  NULL ,
	[CityId]             integer  NOT NULL 
)
go

ALTER TABLE [Shop]
	ADD CONSTRAINT [XPKShop] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [ShopItem]
( 
	[ArticleId]          integer  NOT NULL ,
	[ShopId]             integer  NOT NULL ,
	[Count]              integer  NULL 
)
go

ALTER TABLE [ShopItem]
	ADD CONSTRAINT [XPKShopItem] PRIMARY KEY  CLUSTERED ([ArticleId] ASC,[ShopId] ASC)
go

CREATE TABLE [Transaction]
( 
	[ShopId]             integer  NOT NULL ,
	[BuyerId]            integer  NOT NULL ,
	[Id]                 integer  NOT NULL ,
	[TotalAmount]        char(18)  NULL ,
	[Provision]          decimal(10,3)  NULL ,
	[ProvisionPercentage] integer  NULL ,
	[TransferedAmount]   decimal(10,3)  NULL 
)
go

ALTER TABLE [Transaction]
	ADD CONSTRAINT [XPKTransaction] PRIMARY KEY  CLUSTERED ([Id] ASC)
go


ALTER TABLE [Account]
	ADD CONSTRAINT [R_5] FOREIGN KEY ([Id]) REFERENCES [Buyer]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Buyer]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([CityId]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [CityConnection]
	ADD CONSTRAINT [R_1] FOREIGN KEY ([IdCity1]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [CityConnection]
	ADD CONSTRAINT [R_2] FOREIGN KEY ([IdCity2]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Order]
	ADD CONSTRAINT [R_6] FOREIGN KEY ([BuyerId]) REFERENCES [Buyer]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Order]
	ADD CONSTRAINT [R_7] FOREIGN KEY ([CityId]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [OrderItem]
	ADD CONSTRAINT [R_8] FOREIGN KEY ([OrderId]) REFERENCES [Order]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [OrderItem]
	ADD CONSTRAINT [R_13] FOREIGN KEY ([ArticleId],[ShopId]) REFERENCES [ShopItem]([ArticleId],[ShopId])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [ReservedFunds]
	ADD CONSTRAINT [R_17] FOREIGN KEY ([AccountId]) REFERENCES [Account]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ReservedFunds]
	ADD CONSTRAINT [R_19] FOREIGN KEY ([OrderId]) REFERENCES [Order]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Shop]
	ADD CONSTRAINT [R_10] FOREIGN KEY ([CityId]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [ShopItem]
	ADD CONSTRAINT [R_11] FOREIGN KEY ([ArticleId]) REFERENCES [Article]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ShopItem]
	ADD CONSTRAINT [R_12] FOREIGN KEY ([ShopId]) REFERENCES [Shop]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Transaction]
	ADD CONSTRAINT [R_14] FOREIGN KEY ([ShopId]) REFERENCES [Shop]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Transaction]
	ADD CONSTRAINT [R_18] FOREIGN KEY ([BuyerId]) REFERENCES [Buyer]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go
