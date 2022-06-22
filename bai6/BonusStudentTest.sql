create database StudentTest;
use StudentTest;

create table Student(
RN int primary key,
SName varchar(20),
Age tinyint
);

create table Test(
testID int primary key,
TName varchar(20)
);

create table StudentTest(
RN int not null,
testID int not null,
STDate datetime,
mark float,
primary key (RN,testID),
foreign key (RN) references Student(RN),
foreign key (testID) references Test(testID)
);

-- cau 2
select s.SName,t.TName,st.mark,st.STDate from Student s
join StudentTest st on s.RN = st.RN
join Test t on t.testID = st.testID;
-- cau 3
select s.RN,s.SName,s.Age from Student s
left join StudentTest st on s.RN = st.RN
where st.RN is null;
-- cau 4
select s.SName,t.TName,st.mark,st.STDate from Student s
join StudentTest st on s.RN = st.RN
join Test t on t.testID = st.testID
where st.mark < 5;
-- cau 5
select s.SName,avg(st.mark) as Average from Student s
join StudentTest st on s.RN = st.RN
group by s.SName
order by Average desc;
-- cau 6
select s.SName,avg(st.mark) as Average from Student s
join StudentTest st on s.RN = st.RN
group by s.SName
having avg(st.mark) >= all (select avg(mark) from StudentTest group by RN);
-- cau 7
select t.TName,max(st.mark) as Max_Mark from StudentTest st 
join Test t on t.testID = st.testID
group by t.TName
order by t.TName;
-- cau 8
select s.SName,t.TName from Student s
left join StudentTest st on s.RN = st.RN
left join Test t on t.testID = st.testID;
-- cau 9 
update student set age = age - 1
where RN >0;
-- cau 10 
alter table Student 
add column status varchar(10);
-- cau 11
update Student
set status = 'Young'
where RN > 0 and age < 30;

update Student
set status = 'Old'
where RN > 0 and age >= 30;

select * from student;
-- cau 12
create view vwStudentTest as
select s.SName,t.TName,st.mark,st.STDate from Student s
join StudentTest st on s.RN = st.RN
join Test t on t.testID = st.testID
order by st.STDate; 

select * from vwStudentTest;
-- cau 13 chưa xong
create table Student_temp(
RN int primary key,
SName varchar(20),
Age tinyint,
Status varchar(10)
);

DROP TRIGGER IF EXISTS tgSetStatus;
DELIMITER //
CREATE TRIGGER tgSetStatus
after UPDATE ON student
FOR EACH ROW

BEGIN

 INSERT INTO Student_temp
 set RN = old.RN,
 SName  = old.SName,
 Age = new.Age,
 Status = old.Status if
 -- cần tạo 1 procedure để check giá trị 
END;
//DELIMITER ;

update Student set age = 32
where RN = 1;
select * from Student;
select * from Student_temp;
-- cau 14 chưa xong
