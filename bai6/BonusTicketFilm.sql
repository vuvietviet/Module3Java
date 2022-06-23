create database TicketFilm;
use TicketFilm;

create table tblPhong(
phongID int,
ten_phong varchar(20),
trang_thai tinyint 
);

create table tblPhim(
phimID int,
ten_phim varchar(30),
loai_phim varchar(25),
thoi_gian int
);

create table tblGhe(
gheID int,
phongID int not null,
so_ghe varchar(10)
);

create table tblVe(
phimID int not null,
gheID int not null,
ngay_chieu datetime,
trang_thai varchar(20)
);

alter table tblPhong add primary key(phongID);
alter table tblGhe add primary key(gheID);
alter table tblPhim add primary key(phimID);
alter table tblVe add primary key(phimID,gheID);

alter table tblVe add foreign key(phimID) references tblPhim(phimID);
alter table tblVe add foreign key(gheID) references tblGhe(gheID);
alter table tblGhe add foreign key(phongID) references tblPhong(phongID);

insert into tblPhim values (1,'Em bé Hà Nội','Tâm lý',90),
(2,'Nhiệm vụ bất khả thi','Hành động',100),
(3,'Dị nhân','Viễn tưởng',90),
(4,'Cuốn theo chiều gió','Tình cảm',120);

insert into tblPhong values (1,'Phòng chiếu 1',1),
(2,'Phòng chiếu 2',1),
(3,'Phòng chiếu 3',0);

insert into tblGhe values (1,1,'A3'),(2,1,'B5'),(3,2,'A7'),(4,2,'D1'),(5,3,'T2');

insert into tblVe values (1,1,'2008-10-20','Đã bán'),
(1,3,'2008-11-20','Đã bán'),
(1,4,'2008-12-23','Đã bán'),
(2,1,'2009-2-14','Đã bán'),
(3,1,'2009-2-14','Đã bán'),
(2,5,'2008-3-8','Chưa bán'),
(2,3,'2008-3-8','Chưa bán');

-- cau 2
select * from tblPhim
order by thoi_gian;

-- cau 3
select * from tblPhim
having thoi_gian >= all (select thoi_gian from tblPhim);

-- cau 4
select * from tblPhim
having thoi_gian <= all (select thoi_gian from tblPhim);

-- cau 5
select * from tblGhe
where so_ghe like 'A%';

-- cau 6
alter table tblPhong
modify trang_thai varchar(25);

-- cau 7
update tblPhong
set trang_thai = IF(trang_thai = 0, 'Đang sửa', IF(trang_thai = 1, 'Đang sử dụng', 'Unknow'))
where phongID > 0;

-- cau 8
select * from tblPhim
having length(ten_phim) > 15 and length(ten_phim) < 25;

-- cau 9
select concat(ten_phong,trang_thai) as 'Trạng thái phòng chiếu' from tblPhong;

-- cau 10
create table tblRank(
STT int primary key auto_increment,
Ten_phim varchar(30),
Thoi_gian int
);
insert into tblRank (ten_phim,thoi_gian) select Ten_phim,Thoi_gian from tblPhim
order by ten_phim;
-- cau 11
-- a
alter table tblPhim
add column mo_ta varchar(255);
-- b
update tblPhim
set mo_ta = concat('Đây là bộ phim thể loại ',loai_phim)
where phimID > 0;
-- c
select * from tblPhim;
-- d
update tblPhim
set mo_ta = replace(mo_ta,'bộ phim','film')
where phimID > 0;
-- e
select * from tblPhim;
-- cau 12
alter table tblVe drop foreign key tblve_ibfk_1;
alter table tblVe drop foreign key tblve_ibfk_2;
alter table tblGhe drop foreign key tblghe_ibfk_1;

-- cau 13
delete from tblGhe where gheID > 0;

-- cau 14
select now() as Now, addtime(now(),5000 * 60) as 'Now5000';
