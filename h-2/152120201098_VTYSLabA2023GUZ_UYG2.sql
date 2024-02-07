CREATE DATABASE KutuphaneBilgiSistemi

use KutuphaneBilgiSistemi

CREATE TABLE Yazarlar
(
	YazarID int PRIMARY Key not null,
	Ad varchar(50) not null,
	Soyad varchar(50) not null,
	DogumTarihi date,
	Ulke varchar(50),
)


CREATE TABLE Kitaplar
(
	KitapID int PRIMARY Key not NULL,
	KitapAdi varchar(100) not NULL,
	ISBN varchar(13) not NULl,
	YayinEvi varchar(100),
	BasimTarihi date,
	StokAdeti int,
	YazarID int foreign key (YazarID) references Yazarlar(YazarID)
)

CREATE TABLE KutuphaneUyeleri
(
	UyeID int PRIMARY KEY not null,
	Ad varchar(50) not null,
	Soyad varchar(50) not null,
	Telefon varchar(15),
	Adres varchar(255),
)

CREATE TABLE OduncAlinanKitaplar
(
	OduncID int PRIMARY Key not null,
	KitapID int foreign key(KitapID) references Kitaplar(KitapID),
	UyeID int foreign key(UyeID) references KutuphaneUyeleri(UyeID),
	AlisTarihi date,
	TeslimTarihi date
)