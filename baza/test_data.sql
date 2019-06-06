use shop

go

insert into City(Name)
values
('Kragujevac'),
('Beograd'),
('Nis'),
('Novi Sad'),
('Jagodina'),
('Krusevac'),
('Negotin'),
('Subotica')

insert into Line(IdCity1, IdCity2, Distance)
values
(1, 2, 4),
(1, 3, 5),
(2, 4, 3),
(4, 8, 4),
(1, 5, 2),
(3, 5, 2),
(2, 8, 8)

insert into Shop(Name, CityId, Discount)
values 
('Gigatron', 1, 2),
('WinWin', 2, 0),
('BC Group', 3, 5),
('Tehnomanija', 4, 6)

insert into Article(Name, Count, Price, ShopId)
values 
('Punjac', 10, 2456, 1),
('Monitor', 10, 14000, 2),
('Tastatura', 10, 1500, 4),
('Baterija', 10, 1700, 3),
('Ranac', 15, 3000, 1)

insert into Buyer(Name, Balance, CityId)
values ('Marko Markovic', 15000, 7),
('Petar Petrovic', 7000, 8)


