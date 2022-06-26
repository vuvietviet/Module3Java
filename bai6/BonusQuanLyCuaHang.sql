CREATE DATABASE `QuanLyCuaHang`;
use quanLyCuaHang;

-- KHACHHANG (MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK)
CREATE TABLE KhachHang (
MAKH int(5) primary key auto_increment,
HoTen varchar(50) NOT NULL,
DChi varchar (255),
SODT varchar(10) NOT NULL,
NGSinh date,
DoanhSo float default 0,
NGDK date 
);

-- NHANVIEN (MANV,HOTEN, NGVL, SDT)
CREATE TABLE NhanVien (
MANV int primary key auto_increment,
HoTen varchar(50) NOT NULL,
NGVL date NOT NULL, 
SDT varchar(10) NOT NULL 
);

-- SANPHAM (MASP,TENSP, DVT, NUOCSX, GIA)
CREATE TABLE SanPham (
MASP int primary key auto_increment,
TENSP varchar(50) NOT NULL,
DVT varchar(25),
NUOCSX varchar(50),
Gia float 
);

-- HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
CREATE TABLE HoaDon (
SoHD int primary key auto_increment,
NGHD date,
MaKH int not null,
MANV int not null,
TRIGIA float default 0,
foreign key(MAKH) references KHACHHANG(MAKH),
foreign key(MANV) references NHANVIEN(MANV) );

-- CTHD (SOHD,MASP,SL) hóa đơn chi tiết.
CREATE TABLE CTHD (
SOHD int not null,
MASP int not null,
SL int,
primary key(SOHD, MASP),
foreign key(SOHD) references HOADON(SOHD),
foreign key(MASP) references SANPHAM(MASP) );

-- Nên tạo các trigger cho các bảng chứa các cột tính toán 
-- trước khi chèn dữ liệu vào

INSERT INTO KHACHHANG (HOTEN, DCHI, SODT, NGSINH, NGDK) VALUES 
('Nguyen Van Thanh', 'HN', '0981113333', '1992-04-4', '2021-03-01'),
('Tran Trung Dung', 'HN', '0981112222', '1990-05-23', '2021-03-02'),
('NGuyen Thi Hoa', 'ND', '0972334778', '1988-02-09', '2021-03-05'),
('Le Manh Hung', 'BG', '0962234777', '1985-11-09', '2021-04-21'),
('Tran Ngoc Anh', 'QN', '0913424289', '1993-10-08', '2021-06-18');

INSERT INTO NHANVIEN (HOTEN, NGVL, SDT) VALUES 
('Tran Duc Chinh', '2018-09-10', '0982113113'),
('Le Thu Trang', '2019-06-11', '0968221221'),
('Tran Trung Duc', '2019-10-10', '0919234234');

INSERT INTO SANPHAM (TENSP, DVT, NUOCSX, GIA) VALUES
('Bat', 'chiếc', 'VietNam', 2000),
('Thia', 'chiếc', 'VietNam', 1000),
('Dĩa', 'chiếc', 'VietNam', 500),
('Cốc', 'chiếc', 'VietNam', 4000),
('Đĩa', 'chiếc', 'TrungQuoc', 1000),
('Chổi', 'chiếc', 'TrungQuoc', 2000),
('Gương', 'chiếc', 'TrungQuoc', 9000),
('Quạt', 'chiếc', 'TrungQuoc', 12000),
('Dầu Gội', 'bộ', 'ThaiLan', 10000),
('Sữa Tắm', 'bộ', 'ThaiLan', 8000),
('Kem Đánh răng', 'tuýp', 'ThaiLan', 5000);

INSERT INTO HOADON (NGHD, MAKH, MANV) values
('2022-02-03', 2, 1),
('2022-03-04', 1, 2),
('2022-03-08', 3, 2),
('2022-03-09', 3, 3),
('2022-03-09', 4, 1),
('2022-03-09', 5, 1);


INSERT INTO CTHD (SOHD,MASP,SL) VALUES
(1, 1, 2),(1, 2, 1),(1, 4, 1),(1,3 , 1), (1, 5, 1),
(2, 8, 1), (2, 2, 1), (2, 11, 1), (2, 4, 1), 
(3, 3, 1), (3, 6, 1), (3, 7, 1), 
(4, 9, 1), (4, 10, 1), (4, 3, 1), 
(5, 9, 1), (5, 10, 1),
(6, 5, 1), (6, 1, 1), (6, 7, 1);

DROP TRIGGER IF EXISTS tgSetTriGia;
DELIMITER $$
CREATE TRIGGER tgSetTriGia
 after insert on CTHD
 for each row
 BEGIN
	update HOADON 
    set TRIGIA = TRIGIA + (new.SL * (select Gia from SanPham where MASP = new.MASP)) where SOHD = new.SOHD;
End;
$$

DROP TRIGGER IF EXISTS tgDeleteTriGia;
DELIMITER $$
CREATE TRIGGER tgDeleteTriGia
 after delete on CTHD
 for each row
 BEGIN
	update HoaDon
set TRIGIA = TRIGIA - (old.SL * (select Gia from SANPHAM where MASP = old.MASP)) where SOHD = old.SOHD;
End;
$$

-- DROP TRIGGER IF EXISTS tgSetDoanhSoCuaKH;
-- DELIMITER $$
-- CREATE TRIGGER tgSetDoanhSoCuaKH
--  after update on hoaDon
--  for each row
--  BEGIN
-- 	   update khachHang 
--     set DOANHSO = new.triGia  where maKH = new.maKH; Đây là trường hợp mỗi khách hàng chỉ có 1 hóa đơn duy nhất
-- End;
-- $$

-- cau 1 Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2022 ?
select count( DISTINCT cthd.maSP) from cthd 
join hoaDon on cthd.soHD = hoaDon.soHD
where year(hoaDon.ngHD) = 2022;

-- cau 2 Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
select max(triGia), min(triGia) from hoaDon ;

-- cau 3 Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2022 là bao nhiêu?
select avg(triGia) from hoaDon
where year(ngHD) = 2022;

-- cau 4 Tính doanh thu bán hàng trong năm 2022 ?
select sum(triGia) as 'Doanh thu năm 2022' from hoaDon
where year(ngHD) = 2022;

-- cau 5 Tìm số hóa đơn có trị giá cao nhất trong năm 2022 ? 
select soHD, triGia from hoaDon 
where trigia >= all (select triGia from hoaDon);

-- cau 6 Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2022 ?
select k.hoTen from hoaDon h 
join khachHang k on h.maKH = k.maKH
where trigia >= all (select triGia from hoaDon);

-- cau 7 In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất ?
DROP view IF EXISTS view_TongDoanhSoKH;
create view view_TongDoanhSoKH as
	select maKH, sum(triGia) as DS from hoaDon
	group by maKH;
    
select k.maKH, k.hoTen, t.DS from view_tongDoanhSoKH t
    join khachHang k on t.maKH = k.maKH 
    order by t.DS desc
    limit 3;
    
-- cau 8 In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
	-- Tìm ra 3 mức giá cao nhất
select gia from sanPham
group by gia
order by gia desc
limit 3;
	-- In ra danh sách sản phẩm có giá bằng 1 trong 3 cái giá đó
select maSP, tenSP, gia from sanPham
where gia = 12000 or gia = 10000 or gia = 9000
order by gia desc;

-- cau 9 In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá 
	  -- bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
select maSP, tenSP, gia from sanPham
where (gia = 12000 or gia = 10000 or gia = 9000) and nuocSX = 'ThaiLan'
order by gia desc;

-- cau 10 In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá 
	   -- bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
select gia from sanPham
where nuocSX = 'TrungQuoc'
group by gia
order by gia desc
limit 3;

select maSP, tenSP, gia from sanPham
where (gia = 12000 or gia = 2000 or gia = 9000) and nuocSX = 'TrungQuoc'
order by gia desc;

-- cau 11 In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
DROP view IF EXISTS view_TongDoanhSoKH;
create view view_TongDoanhSoKH as
	select maKH, sum(triGia) as DS from hoaDon
	group by maKH;
    
select k.maKH, k.hoTen, t.DS from view_tongDoanhSoKH t
    join khachHang k on t.maKH = k.maKH 
    order by t.DS desc
    limit 3;

-- cau 12 Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
select count(maSP) as SPTrungQuoc from sanPham
where nuocSX = 'TrungQuoc';

-- cau 13 Tính tổng số sản phẩm của từng nước sản xuất.
select NuocSX,count(maSP) as TongSP from sanPham
group by nuocSX;

-- cau 14 Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
select NuocSX,max(gia),min(gia),avg(gia) from sanPham
group by nuocSX;

-- cau 15 Tính doanh thu bán hàng mỗi ngày.
select ngHD, sum(triGia) as DoanhThuMoiNgay from hoaDon
group by ngHD;

-- cau 16 Tính tổng số lượng của từng sản phẩm bán ra trong tháng 3/2022.
select c.maSP,s.tenSP, sum(c.SL)from sanPham s
join cthd c on s.maSP = c.maSP
join hoaDon h on h.soHD = c.soHD
where year(h.ngHD) = 2022 and month(h.ngHD) = 3
group by c.maSP;

-- cau 17 Tính doanh thu bán hàng của từng tháng trong năm 2022.
select month(ngHD) as Thang, sum(triGia) as DoanhThu from hoaDon
where year(ngHD) = 2022
group by Thang;

-- cau 18 Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
select SoHD, count(maSP) from cthd
group by soHD
having count(maSP) >= 4;

-- cau 19 Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
select c.SoHD, count(c.maSP) from cthd c 
join sanPham s on c.maSP = s.maSP
where s.nuocSX = 'VietNam'
group by c.soHD
having count(c.maSP) = 3;

-- cau 20 Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
select k.maKH,k.hoTen, count(h.soHD) as SoLanMuaHang from khachHang k
join hoaDon h on k.maKH = h.makH
group by k.maKH
having SoLanMuaHang >= all (select count(h.soHD) from khachHang k
							join hoaDon h on k.maKH = h.makH
							group by k.maKH);
                            
-- cau 21 Tháng mấy trong năm 2022, doanh số bán hàng cao nhất ?
select month(ngHD) as Thang, sum(triGia) as DoanhThu from hoaDon
where year(ngHD) = 2022
group by Thang
having DoanhThu >= all (select sum(triGia) from hoaDon
						where year(ngHD) = 2022
						group by month(ngHD));
                        
-- cau 22 Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2022.
select s.maSP, s.tenSP, sum(c.SL) as TongSoLuong from sanPham s
join cthd c on s.maSP = c.maSP
join hoaDon h on h.soHD = c.soHD
where year(h.ngHD) = 2022
group by c.maSP
having TongSoLuong <= all(select sum(c.SL) from sanPham s
							join cthd c on s.maSP = c.maSP
							join hoaDon h on h.soHD = c.soHD
							where year(h.ngHD) = 2022
							group by c.maSP);
                            
-- cau 23 Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
select maSP, tenSP,nuocSX,gia from sanPham
having gia = (select max(gia) from sanPham where nuocSX = 'VietNam') or
	   gia = (select max(gia) from sanPham where nuocSX = 'TrungQuoc') or
       gia = (select max(gia) from sanPham where nuocSX = 'ThaiLan');
       
-- cau 24 Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
select nuocSX, count(maSP), count(distinct gia) from sanPham
group by nuocSX
having count(maSP) >= 3;

-- cau 25 Trong 4 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
DROP view IF EXISTS view_4KhachDoanhSoMax;
create view view_4KhachDoanhSoMax as
	select k.maKH, k.hoTen, t.DS from view_tongDoanhSoKH t
    join khachHang k on t.maKH = k.maKH 
    order by t.DS desc
    limit 4;
    
select v.maKH,v.hoTen, count(h.soHD) as SoLanMuaHang from view_4KhachDoanhSoMax v
join hoaDon h on v.maKH = h.makH
group by v.maKH
having SoLanMuaHang >= all (select count(h.soHD) from view_4KhachDoanhSoMax v
							join hoaDon h on v.maKH = h.makH
							group by v.maKH);