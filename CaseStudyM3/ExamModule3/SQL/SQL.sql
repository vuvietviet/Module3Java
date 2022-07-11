create database QuanLyNhanVien_PhongBan;
use QuanLyNhanVien_PhongBan;

create table Department(
nameDepartment varchar(50) primary key
);

create table Staff(
id int primary key,
name varchar(50),
dateOfBirth date,
address varchar(255),
phoneNumber varchar(10),
email varchar(255),
nameDepartment varchar(50) not null,
foreign key (nameDepartment) references Department(nameDepartment)
);

insert into Department values ('ke toan'),('ky thuat'),('hanh chinh'),('nhan su');

insert into Staff values (1,'Nguyen Van Toan','1998-12-01','QN','0987654321','toan@gmail.com','ke toan'),
(2,'Mai Thuy Linh','2002-02-01','HN','0345627823','linh@gmail.com','ky thuat'),
(3,'Le Van Vu','2000-07-01','TB','0983245214','vu@gmail.com','hanh chinh'),
(4,'Vo Quang Hai','1999-12-17','QN','0987654321','hai@gmail.com','nhan su'),
(5,'Dinh Thach Hoang','1997-10-14','TB','0126306054','hoang@gmail.com','ke toan');