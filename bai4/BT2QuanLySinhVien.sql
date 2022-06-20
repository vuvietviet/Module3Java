use quanlybanhang;

insert into customer
values (1,'Minh Quan',10),
(2,'Ngoc Oanh',20),
(3,'Hong Ha',50);

insert into order1 (oID,cID,oDate)
values (1,1,'2006-3-21'),
(2,2,'2006-3-23'),
(3,1,'2006-3-16');

insert into product
values (1,'May Giat',3),
(2,'Tu Lanh',5),
(3,'Dieu Hoa',7),
(4,'Quat',1),
(5,'Bep Dien',2);

insert into orderdetail
values (1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

select oID,oDate,oTotalPrice from order1;

select c.cID, c.cName, p.pName from customer c 
join order1 o on c.cID = o.cID
join orderdetail od on o.oID = od.oID
join product p on od.pID = p.pID;

select c.*, o.oID from customer c
left join order1 o on c.cID = o.cID
where o.cID is null;

select o.oID, o.oDate, sum(od.odQTY * p.pPrice) as oTotalPrice from order1 o
join orderdetail od on o.oID = od.oID
join product p on od.pID = p.pID
group by o.oID;