create database QuanLyHocVien_LopHoc;
use QuanLyHocVien_LopHoc;

create table Class(
nameClass varchar(5) primary key
);

create table Student(
id int primary key,
name varchar(50),
dateOfBirth date,
address varchar(255),
phoneNumber varchar(10),
email varchar(255),
nameClass varchar(5) not null,
foreign key (nameClass) references Class(nameClass)
);

insert into Class values ('A1'),('A2'),('A3'),('A4');

insert into Student values (1,'Toàn','1998-12-1','QN','0987654321','toan@gmail.com','A2'),
(2,'Linh','2002-12-1','HN','0345627823','linh@gmail.com','A4'),
(3,'Vũ','2000-12-1','TB','0983245214','vu@gmail.com','A3'),
(4,'Hải','1999-12-1','QN','0987654321','hai@gmail.com','A2'),
(5,'Hoàng','1997-12-1','TB','0126306054','hoang@gmail.com','A1');