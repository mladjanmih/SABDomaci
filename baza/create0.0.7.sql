create database Shop

go

use Shop

go


CREATE TABLE [Account]
( 
	[Balance]            decimal(10,3)  NOT NULL 
	CONSTRAINT [IntDefValue_1230269099]
		 DEFAULT  0,
	[Id]                 integer  NOT NULL 
)
go

ALTER TABLE [Account]
	ADD CONSTRAINT [XPKAccount] PRIMARY KEY  CLUSTERED ([Id] ASC)
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
	[CityId]             integer  NOT NULL 
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
	[State]              char  NULL ,
	[Price]              decimal(10,3)  NOT NULL 
	CONSTRAINT [IntDefValue_839771820]
		 DEFAULT  0,
	[SentTime]           datetime  NULL ,
	[ReceivedTime]       datetime  NULL ,
	[Discount]           decimal(10,3)  NOT NULL 
	CONSTRAINT [IntDefValue_1061260663]
		 DEFAULT  0,
	[ExtraDiscount]      bit  NULL ,
	[DestinationCityId]  integer  NULL 
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
	[Price]              decimal(10,3)  NOT NULL 
	CONSTRAINT [IntDefValue_392593090]
		 DEFAULT  0,
	[ArticleId]          integer  NOT NULL ,
	[CurrentCityId]      integer  NULL 
)
go

ALTER TABLE [OrderItem]
	ADD CONSTRAINT [XPKOrderItem] PRIMARY KEY  CLUSTERED ([Id] ASC)
go

CREATE TABLE [ReservedFunds]
( 
	[AccountId]          integer  NOT NULL ,
	[OrderId]            integer  NOT NULL ,
	[Id]                 integer  IDENTITY  NOT NULL ,
	[Amount]             decimal(10,3)  NOT NULL 
	CONSTRAINT [IntDefValue_826720720]
		 DEFAULT  0
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
	[Provision]          decimal(10,3)  NOT NULL 
	CONSTRAINT [IntDefValue_1322097080]
		 DEFAULT  0,
	[ProvisionPercentage] integer  NULL 
	CONSTRAINT [IntDefValue_82109853]
		 DEFAULT  0,
	[TransferedAmount]   decimal(10,3)  NOT NULL 
	CONSTRAINT [IntDefValue_1684328983]
		 DEFAULT  0
)
go

ALTER TABLE [Transaction]
	ADD CONSTRAINT [XPKTransaction] PRIMARY KEY  CLUSTERED ([Id] ASC)
go


ALTER TABLE [Account]
	ADD CONSTRAINT [R_5] FOREIGN KEY ([Id]) REFERENCES [Buyer]([Id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
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


ALTER TABLE [ReservedFunds]
	ADD CONSTRAINT [R_17] FOREIGN KEY ([AccountId]) REFERENCES [Account]([Id])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [ReservedFunds]
	ADD CONSTRAINT [R_19] FOREIGN KEY ([OrderId]) REFERENCES [Order]([Id])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
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
