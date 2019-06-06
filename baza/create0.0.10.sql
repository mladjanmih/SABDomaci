create database Shop

go

use Shop
go

CREATE TABLE [Article]
( 
	[Id]                 integer  IDENTITY  NOT NULL ,
	[Name]               varchar(100)  NOT NULL ,
	[Price]              integer  NOT NULL 
	CONSTRAINT [IntDefValue_986541460]
		 DEFAULT  0,
	[Count]              integer  NOT NULL 
	CONSTRAINT [IntDefValue_953180553]
		 DEFAULT  0,
	[ShopId]             integer  NOT NULL 
)
go

ALTER TABLE [Article]
	ADD CONSTRAINT [XPKArticle] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [Buyer]
( 
	[Id]                 integer  IDENTITY  NOT NULL ,
	[Name]               varchar(100)  NOT NULL ,
	[CityId]             integer  NOT NULL ,
	[Balance]            money  NOT NULL 
	CONSTRAINT [IntDefValue_583962515]
		 DEFAULT  0
)
go

ALTER TABLE [Buyer]
	ADD CONSTRAINT [XPKBuyer] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [City]
( 
	[Id]                 integer  IDENTITY  NOT NULL ,
	[Name]               varchar(100)  NOT NULL 
)
go

ALTER TABLE [City]
	ADD CONSTRAINT [XPKCity] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [ItemTransportInfo]
( 
	[OrderItemId]        integer  NOT NULL ,
	[SourceCity]         integer  NULL ,
	[DestinationCity]    integer  NULL ,
	[DaysLeft]           integer  NULL 
	CONSTRAINT [IntDefValue_2108901948]
		 DEFAULT  0
)
go

ALTER TABLE [ItemTransportInfo]
	ADD CONSTRAINT [XPKItemTransportInfo] PRIMARY KEY  CLUSTERED ([OrderItemId] ASC)
go

CREATE TABLE [Line]
( 
	[IdCity1]            integer  NOT NULL ,
	[IdCity2]            integer  NOT NULL ,
	[Distance]           integer  NULL 
	CONSTRAINT [IntDefValue_452097164]
		 DEFAULT  0,
	[Id]                 integer  IDENTITY  NOT NULL 
)
go

ALTER TABLE [Line]
	ADD CONSTRAINT [XPKLine] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [Order]
( 
	[Id]                 integer  IDENTITY  NOT NULL ,
	[BuyerId]            integer  NOT NULL ,
	[State]              varchar(10)  NULL 
	CONSTRAINT [OrderStatus_233897343]
		CHECK  ( [State]='R' OR [State]='S' OR [State]='C' ),
	[Price]              money  NOT NULL 
	CONSTRAINT [IntDefValue_839771820]
		 DEFAULT  0,
	[SentTime]           datetime  NULL ,
	[ReceivedTime]       datetime  NULL ,
	[Discount]           money  NOT NULL 
	CONSTRAINT [IntDefValue_1061260663]
		 DEFAULT  0,
	[ExtraDiscount]      bit  NULL ,
	[DestinationCityId]  integer  NULL ,
	[ItemsGathered]      bit  NULL ,
	[CurrentCityId]      integer  NULL 
)
go

ALTER TABLE [Order]
	ADD CONSTRAINT [XPKOrder] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [OrderItem]
( 
	[Id]                 integer  IDENTITY  NOT NULL ,
	[Count]              integer  NOT NULL 
	CONSTRAINT [IntDefValue_425953997]
		 DEFAULT  0,
	[OrderId]            integer  NOT NULL ,
	[Price]              money  NOT NULL 
	CONSTRAINT [IntDefValue_392593090]
		 DEFAULT  0,
	[ArticleId]          integer  NOT NULL ,
	[CurrentCityId]      integer  NULL ,
	[ArrivedAtGatheringCity] bit  NULL ,
	[GatheringCityId]    integer  NULL 
)
go

ALTER TABLE [OrderItem]
	ADD CONSTRAINT [XPKOrderItem] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [OrderTransportInfo]
( 
	[OrderId]            integer  NOT NULL ,
	[DestinationCity]    integer  NULL ,
	[SourceCity]         integer  NULL ,
	[DaysLeft]           integer  NULL 
	CONSTRAINT [IntDefValue_1422084584]
		 DEFAULT  0
)
go

ALTER TABLE [OrderTransportInfo]
	ADD CONSTRAINT [XPKOrderTransportInfo] PRIMARY KEY  CLUSTERED ([OrderId] ASC)
go

CREATE TABLE [ReservedFunds]
( 
	[OrderId]            integer  NOT NULL ,
	[Id]                 integer  IDENTITY  NOT NULL ,
	[Amount]             money  NOT NULL 
	CONSTRAINT [IntDefValue_826720720]
		 DEFAULT  0,
	[BuyerId]            integer  NOT NULL 
)
go

ALTER TABLE [ReservedFunds]
	ADD CONSTRAINT [XPKReservedFunds] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [Shop]
( 
	[Id]                 integer  IDENTITY  NOT NULL ,
	[Name]               varchar(100)  NOT NULL ,
	[Discount]           integer  NULL 
	CONSTRAINT [IntDefValue_299724416]
		 DEFAULT  0,
	[CityId]             integer  NOT NULL 
)
go

ALTER TABLE [Shop]
	ADD CONSTRAINT [XPKShop] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [Transaction]
( 
	[ShopId]             integer  NOT NULL ,
	[BuyerId]            integer  NOT NULL ,
	[Id]                 integer  IDENTITY  NOT NULL ,
	[TotalAmount]        char(18)  NULL ,
	[Provision]          money  NOT NULL 
	CONSTRAINT [IntDefValue_1322097080]
		 DEFAULT  0,
	[ProvisionPercentage] integer  NULL 
	CONSTRAINT [IntDefValue_82109853]
		 DEFAULT  0,
	[TransferedAmount]   money  NOT NULL 
	CONSTRAINT [IntDefValue_1684328983]
		 DEFAULT  0
)
go

ALTER TABLE [Transaction]
	ADD CONSTRAINT [XPKTransaction] PRIMARY KEY  CLUSTERED ([Id] ASC)
go


ALTER TABLE [Article]
	ADD CONSTRAINT [R_20] FOREIGN KEY ([ShopId]) REFERENCES [Shop]([Id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Buyer]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([CityId]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [ItemTransportInfo]
	ADD CONSTRAINT [R_26] FOREIGN KEY ([OrderItemId]) REFERENCES [OrderItem]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ItemTransportInfo]
	ADD CONSTRAINT [R_27] FOREIGN KEY ([SourceCity]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ItemTransportInfo]
	ADD CONSTRAINT [R_28] FOREIGN KEY ([DestinationCity]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Line]
	ADD CONSTRAINT [R_1] FOREIGN KEY ([IdCity1]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Line]
	ADD CONSTRAINT [R_2] FOREIGN KEY ([IdCity2]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Order]
	ADD CONSTRAINT [R_6] FOREIGN KEY ([BuyerId]) REFERENCES [Buyer]([Id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Order]
	ADD CONSTRAINT [R_25] FOREIGN KEY ([DestinationCityId]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Order]
	ADD CONSTRAINT [R_31] FOREIGN KEY ([CurrentCityId]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [OrderItem]
	ADD CONSTRAINT [R_8] FOREIGN KEY ([OrderId]) REFERENCES [Order]([Id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [OrderItem]
	ADD CONSTRAINT [R_21] FOREIGN KEY ([ArticleId]) REFERENCES [Article]([Id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [OrderItem]
	ADD CONSTRAINT [R_24] FOREIGN KEY ([CurrentCityId]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [OrderItem]
	ADD CONSTRAINT [R_30] FOREIGN KEY ([GatheringCityId]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [OrderTransportInfo]
	ADD CONSTRAINT [R_32] FOREIGN KEY ([OrderId]) REFERENCES [Order]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [OrderTransportInfo]
	ADD CONSTRAINT [R_33] FOREIGN KEY ([DestinationCity]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [OrderTransportInfo]
	ADD CONSTRAINT [R_34] FOREIGN KEY ([SourceCity]) REFERENCES [City]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [ReservedFunds]
	ADD CONSTRAINT [R_19] FOREIGN KEY ([OrderId]) REFERENCES [Order]([Id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [ReservedFunds]
	ADD CONSTRAINT [R_29] FOREIGN KEY ([BuyerId]) REFERENCES [Buyer]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Shop]
	ADD CONSTRAINT [R_10] FOREIGN KEY ([CityId]) REFERENCES [City]([Id])
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
