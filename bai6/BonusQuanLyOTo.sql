CREATE DATABASE `QuanLyOTo`;
use quanlyoto;

CREATE TABLE NhaCungCap (
MaNhaCC int primary key,
TenNhaCC varchar(50),
DiaChi varchar(50),
SoDT int unique,
MaSoThue int unique);

CREATE TABLE LoaiDichVu (
MaLoaiDV int primary key,
TenLoaiDv varchar(100) );

CREATE TABLE MucPhi (
MaMP int primary key,
DonGia int,
Mota varchar(255) );

CREATE TABLE DongXe (
DongXe varchar(25) primary key,
HangXe varchar(25),
SoChoNgoi int );

CREATE TABLE DangKyCungCap (
MaDKCC int primary key,
MaNhaCC int not null,
MaLoaiDV int not null,
DongXe varchar(25) not null,
MaMP int not null,
foreign key (MaNhaCC) references NhaCungCap(MaNhaCC),
foreign key (MaLoaiDv) references LoaiDichVu(MaLoaiDV),
foreign key (DongXe) references DongXe(DongXe),
foreign key (MaMP) references MucPhi(MaMP) 
);
-- cau 3
select * from dongXe
where soChoNgoi > 5;
-- cau 4 
select ncc.*, dx.hangXe, mp.donGia from nhaCungCap ncc
join dangKyCungCap dk on ncc.maNhaCC = dk.maNhaCC
join dongXe dx on dk.dongXe = dx.dongXe
join mucPhi mp on mp.maMP = dk.maMP
where (dx.hangXe = 'Toyota' and mp.donGia = 15000) or
(dx.hangXe = 'KIA' and mp.donGia = 20000);
-- cau 5 
select * from nhaCungCap
order by tenNhaCC;
select * from nhaCungCap
order by maSoThue desc;
-- cau 6
select ncc.tenNhaCC, dx.hangXe, dx.dongXe, count(dk.maDKCC) from nhaCungCap ncc
join dangKyCungCap dk on ncc.maNhaCC = dk.maNhaCC
join dongXe dx on dk.dongXe = dx.dongXe
where dk.ngayBatDauCC = '2015-11-20'
group by ncc.tenNhaCC;
-- cau 7
select hangxe from dongXe
group by hangxe;
-- cau 8
select dk.maDKCC, ncc.maNhaCC,ncc.tenNhaCC,ncc.diaChi,ncc.maSoThue,ldv.TenLoaiDv,mp.donGia,
		dx.hangXe,dk.ngayBatDauCC,dk.ngayKetThucCC
from nhaCungCap ncc
left join dangKyCungCap dk on ncc.maNhaCC = dk.maNhaCC
left join dongXe dx on dk.dongXe = dx.dongXe
left join mucPhi mp on mp.maMP = dk.maMP
left join loaidichvu ldv on ldv.MaLoaiDV = dk.MaLoaiDV;
-- cau 9
select ncc.*, dx.hangXe, dx.dongXe from nhaCungCap ncc
join dangKyCungCap dk on ncc.maNhaCC = dk.maNhaCC
join dongXe dx on dk.dongXe = dx.dongXe
where dx.dongXe = 'Hiace' or dx.dongXe = 'Cerato';
-- cau 10
select ncc.*, dk.maDKCC from nhaCungCap ncc
left join dangKyCungCap dk on ncc.maNhaCC = dk.maNhaCC
where  dk.maDKCC is null;