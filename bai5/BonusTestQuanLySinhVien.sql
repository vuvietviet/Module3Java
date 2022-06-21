create database TestQuanLySinhVien;
use TestQuanLySinhVien;

create table Students(
studentID int primary key,
studentName varchar(50),
age int,
email varchar(100),
check (age >15 and age < 50)
);

create table Subjects(
subjectID int primary key,
subjectName varchar(50)
);

create table Classes(
classID int primary key,
className varchar(50)
);

create table Marks(
markID int primary key,
mark int,
subjectID int,
studentID int,
foreign key (subjectID) references Subjects(subjectID),
foreign key (studentID) references Students(studentID)
);

create table ClassStudent(
studentID int,
classID int,
primary key(classID, studentID),
foreign key (studentID) references Students(studentID),
foreign key (classID) references Classes(classID)
);

insert into Students
values (1,'Nguyen Quang An',18,'an@yahoo.com'),
(2,'Nguyen Cong Vinh',20,'vinh@gmail.com'),
(3,'Nguyen Van Quyen',19,'quyen'),
(4,'Pham Thanh Binh',25,'binh@com'),
(5,'Nguyen Van Tai Em',30,'taiem@sport.vn');

insert into Classes
values (1,'C0706L'),(2,'C0708G');

insert into ClassStudent
values (1,1),(2,1),(3,2),(4,2),(5,2);

insert into Subjects
values (1,'SQL'),(2,'Java'),(3,'C'),(4,'Visual Basic');

insert into Marks
values (1,8,1,1),(2,4,2,1),(3,9,1,1),(4,7,1,3),(5,3,1,4),(6,5,2,5),
(7,8,3,3),(8,1,3,5),(9,3,2,4);

select * from Students;

select * from Subjects;

select s.studentID,s.studentName,avg(m.mark)
from Students s
join Marks m on s.studentID = m.studentID
group by s.studentID,s.studentName;

select s.studentID,s.studentName,sb.subjectName,m.mark from Students s
join Marks m on s.studentID = m.studentID
join Subjects sb on m.subjectID = sb.subjectID 
having m.mark >= all (select mark from Marks);

select * from Marks
order by mark desc;

alter table subjects
modify column subjectName varchar(255);

alter table ClassStudent
drop constraint classstudent_ibfk_1;

alter table ClassStudent
drop constraint classstudent_ibfk_2;

alter table Marks
drop constraint marks_ibfk_1;

alter table Marks
drop constraint marks_ibfk_2;

delete from Students 
where studentID = 1;

alter table Students
add column Status bit default 1;

update Students
set status = 0
where studentID > 0;
-- câu 7 vì ít record nên có thể update thủ công từng dòng
-- câu 10 có thể cho tham chiếu bằng null thì có thể xóa mà không cần xóa quan hệ 