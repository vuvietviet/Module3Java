create database Test1QuanLySinhVien;
use Test1QuanLySinhVien;

create table Khoa(
maKhoa int primary key,
tenKhoa varchar(10)
);

create table MonHoc(
maMH int primary key,
tenMH varchar(50),
soTiet int
);

create table Lop(
maLop int primary key,
tenLop varchar(10),
maKhoa int not null,
foreign key (maKhoa) references Khoa(maKhoa)
);

create table SinhVien(
maSV int primary key,
hoTen varchar(50),
ngaySinh date,
hocBong int,
gioiTinh varchar(10),
maLop int not null,
foreign key (maLop) references Lop(maLop)
);

create table KetQua(
diem float,
maMH int not null,
maSV int not null,
foreign key (maMH) references MonHoc(maMH),
foreign key (maSV) references SinhVien(maSV)
);

select * from SinhVien
where hoTen like 'Trần%';

select * from SinhVien
where gioiTinh = 'nu' and hocBong is not null;

select * from SinhVien
where gioiTinh = 'nu' or hocBong is not null;

select * from SinhVien
where year(ngaysinh) between 1978 and 1985;

select * from SinhVien
order by maSV;

select * from SinhVien
order by hocBong desc;

select sv.maSV,sv.hoTen,sv.hocBong,k.tenKhoa from sinhVien sv
join Lop on sv.maLop = Lop.maLop
join khoa k on Lop.maKhoa = k.maKhoa
where sv.hocBong is not null and k.maKhoa = 1;

select lop.tenLop, count(sv.maSV) from lop
join SinhVien sv on sv.maLop = Lop.maLop
group by lop.tenLop;

select k.tenKhoa, count(sv.maSV) from sinhVien sv
join Lop on sv.maLop = Lop.maLop
join khoa k on Lop.maKhoa = k.maKhoa
group by k.tenKhoa;

select k.tenKhoa, count(sv.maSV) as 'so SV nu' from sinhVien sv
join Lop on sv.maLop = Lop.maLop
join khoa k on Lop.maKhoa = k.maKhoa
where sv.gioiTinh = 'nu'
group by k.tenKhoa;

select lop.tenLop, sum(sv.hocBong) from lop
join SinhVien sv on sv.maLop = Lop.maLop
group by lop.tenLop;

select k.tenKhoa, sum(sv.hocBong) from sinhVien sv
join Lop on sv.maLop = Lop.maLop
join khoa k on Lop.maKhoa = k.maKhoa
group by k.tenKhoa;

select k.maKhoa,k.tenKhoa, count(sv.maSV) as 'SoLuong' from sinhVien sv
join Lop on sv.maLop = Lop.maLop
join khoa k on Lop.maKhoa = k.maKhoa
group by k.maKhoa,k.tenKhoa
having soLuong > 100;

select k.maKhoa,k.tenKhoa, count(sv.maSV) as 'SoLuong' from sinhVien sv
join Lop on sv.maLop = Lop.maLop
join khoa k on Lop.maKhoa = k.maKhoa
where sv.gioiTinh = 'nu'
group by k.maKhoa,k.tenKhoa
having soLuong > 50;

select * from sinhVien
group by maSV, hoTen
having hocBong >= all (select hocBong from sinhVien);

select sv.*, kq.diem,m.tenMH from sinhVien sv
join KetQua kq on sv.maSV = kq.maSV
join monHoc m on kq.maMH = m.maMH
group by sv.maSV, sv.hoTen
having kq.diem >= all (select diem from ketQua where maMH = 3);