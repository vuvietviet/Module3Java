create database Demo;
use Demo;

create table Products(
id int primary key,
productCode varchar(50),
productName varchar(50),
productPrice int,
productAmount int,
productDescription varchar(255),
productStatus bit
);
-- buoc 3
explain select * from Products 
where productCode = "B";

create unique index index_1 
on Products(productCode);

explain select * from Products 
where productCode = "B";

alter table Products drop index index_1;


explain select * from Products 
where productName = "C2" or productName = "Revive";

alter table Products 
add index index_2 (productName,productPrice);

explain select * from Products 
where productName = "C2" or productName = "Revive";

alter table Products drop index index_2;
-- buoc 4
create view view_1 as
select productCode,productName,productPrice,productStatus
from Products;

UPDATE view_1
SET productPrice = 16000
WHERE productCode = 'C';

drop view view_1;

-- cau 5
DELIMITER //
DROP PROCEDURE IF EXISTS `procedure_show`//
create procedure procedure_show ()
begin
select * from products;
end;
//delimiter ;

DELIMITER //
DROP PROCEDURE IF EXISTS `procedure_add`//
create procedure procedure_add (in id int, in pc varchar(50),in pn varchar(50),
in pp int,in pa int,in pd varchar(255),in ps bit)
begin
insert into Products values (id,pc,pn,pp,pa,pd,ps);
end;
//delimiter ;

DELIMITER //
DROP PROCEDURE IF EXISTS `procedure_edit`//
create procedure procedure_edit (in id2 int, in pc2 varchar(50),in pn2 varchar(50),
in pp2 int,in pa2 int,in pd2 varchar(255),in ps2 bit)
begin
update Products 
set id = id2,productCode = pc2,productName = pn2,productPrice = pp2,
productAmount = pa2,productDescription = pd2,productStatus = ps2
where id = id2;
end;
//delimiter ;

DELIMITER //
DROP PROCEDURE IF EXISTS `procedure_delete`//
create procedure procedure_delete (in id2 int)
begin
delete from products
where id = id2;
end;
//delimiter ;
