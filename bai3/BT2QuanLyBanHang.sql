create database QuanLyBanHang;
use QuanLyBanHang;

create table Customer(
cID int primary key,
cName varchar(50),
cAge int
);

create table Order1(
oID int primary key,
cID int not null,
oDate date,
oTotalPrice int,
foreign key (cID) references Customer (cID)
);

create table Product(
pID int primary key,
pName varchar(50),
pPrice int
);

create table OrderDetail(
oID int not null,
pID int not null,
odQTY int,
foreign key (oID) references Order1(oID),
foreign key (pID) references Product(pID)
);

