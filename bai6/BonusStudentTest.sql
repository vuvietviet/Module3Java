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
select s.SName,if(t.TName is null,'NULL',t.TName) from Student s
left join StudentTest st on s.RN = st.RN
left join Test t on t.testID = st.testID;
-- cau 9 
update student set age = age - 1
where RN >0;
-- cau 10 
alter table Student 
add column status varchar(10);
-- cau 11
	-- cách 1:
update Student
set status = 'Young'
where RN > 0 and age < 30;

update Student
set status = 'Old'
where RN > 0 and age >= 30;
select * from student;
	-- cách 2:
update Student 
set status = if(age < 30,'Young','Old') where RN > 0;
select * from student;
-- cau 12
create view vwStudentTest as
select s.SName,t.TName,st.mark,st.STDate from Student s
join StudentTest st on s.RN = st.RN
join Test t on t.testID = st.testID
order by st.STDate; 

select * from vwStudentTest;
-- cau 13 chưa xong
	-- cách 1: lưu thay đổi ra bảng riêng
create table Student_temp(
RN int primary key,
SName varchar(20),
Age tinyint,
Status varchar(10)
);

DELIMITER //
 DROP PROCEDURE IF EXISTS `checkLogin`//
 CREATE PROCEDURE `checkLogin`(
    IN input_age int,
    OUT result VARCHAR(255)
)
BEGIN
    /*Bien flag luu tru age. Mac dinh la -1*/
    DECLARE flag INT DEFAULT -1;
     
    /*Thuc hien truy van gan age vao bien flag*/
    SELECT age INTO flag FROM student
    WHERE age = input_age;
 
    /*Sau khi thuc hien lenh select nay ma ko co du lieu thi
      luc nay flag se khong thay doi. Chinh vi the neu flag = -1 tuc la sai thong tin
    */
    IF (flag <= 0) THEN
            SET result = 'Dang nhap sai';
        ELSEIF (flag < 30) THEN
            SET result = 'Young';
        ELSE
            SET result = 'Old';
    END IF;
END
 //DELIMITER ;

DROP TRIGGER IF EXISTS tgSetStatus;
DELIMITER //
CREATE TRIGGER tgSetStatus
after UPDATE ON student
FOR EACH ROW

BEGIN
 call checkLogin(new.age,@result);
 INSERT INTO Student_temp
 set RN = old.RN,
 SName  = old.SName,
 Age = new.Age,
 Status = (select@result);
END;
//DELIMITER ;

update Student set age = 32
where RN = 1;
select * from Student;
select * from Student_temp;
	-- cách 2: thay đổi luôn trên bảng cơ sở
DROP TRIGGER IF EXISTS tgSetStatus_1;
DELIMITER //
CREATE TRIGGER tgSetStatus_1
before UPDATE ON student -- nếu đổi before thành after thì sẽ không chạy được
FOR EACH ROW

BEGIN
	SET new.Status=if(NEW.Age<30,'Young','Old');
END;
//DELIMITER ;

update Student set age = 35
where RN = 4;
select * from Student;

-- cau 14 
drop view if exists view_1;
CREATE VIEW view_1 as
SELECT s.SName ,t.TName ,st.Mark
FROM Student as s 
		LEFT JOIN studenttest as st on s.Rn=st.RN 
        LEFT JOIN Test as t on st.TestId =t.TestID;
        
DELIMITER //
DROP PROCEDURE IF EXISTS spViewStatus //
CREATE PROCEDURE spViewStatus(IN Name1 NVARCHAR(20),IN Name2 NVARCHAR(20),OUT output1 nvarchar(50),OUT output2 int)
	BEGIN
		 DECLARE diem float;
		IF Name1 not in( SELECT SName FROM Student) or Name2 not in (SELECT TName FROM Test) 
 			THEN 
 				SET output1='Không tìm thấy';
 		ELSE 
			SELECT Mark INTO diem FROM view_1 WHERE view_1.SName=Name1 and view_1.TName=Name2;
            set  output2 = diem;
 			IF diem>=5 then
				SET output1='Đỗ';
			ELSEIF diem<5 then
				SET output1='Trượt';
			ELSE
				SET output1='Chưa thi';
			end if;
 		end if;
	END 
//delimiter ;

CALL spViewStatus('Tuan Minh','SQL1',@a,@b);
SELECT @a as 'Trạng thái ',@b as 'Điểm';
