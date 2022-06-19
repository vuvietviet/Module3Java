use quanlysinhvien;

select * from student;

select * from student
where Status = true;

select * from subject
where Credit < 10;

select student.StudentID, student.StudentName, class.ClassName from student 
join class on student.ClassID = class.ClassID
where class.ClassName = 'A1';

select s.StudentID, s.StudentName, sb.SubName, m.Mark from student s 
join (subject sb join mark m on sb.SubID = m.SubID) on s.StudentID = m.StudentID
where sb.SubName = 'CF';