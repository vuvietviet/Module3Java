CREATE database QuanLyDiemThi;
use QuanLyDiemThi;

create table HocSinh(
MaHS varchar(20) not null primary key,
TenHS varchar(50), 
NgaySinh datetime,
Lop varchar(20),
GT varchar(20)
);

create table MonHoc(
MaMH varchar(20) not null primary key,
TenMH varchar(50)
);

create table BangDiem(
MaHS varchar(20) not null,
MaMH varchar(20) not null,
DiemThi int,
NgayKT datetime,
primary key(MaHS, MaMH),
foreign key(MaHS) references HocSinh(MaHS),
foreign key(MaMH) references MonHoc(MaMH)
);

create table GiaoVien(
MaGV varchar(20) not null primary key,
TenGV varchar(50),
SDT varchar(10)
);

alter table MonHoc
	add column MaGV varchar (20);
alter table MonHoc 
	add foreign key(MaGV) references GiaoVien(MaGV);