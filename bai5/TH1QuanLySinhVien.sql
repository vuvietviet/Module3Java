use quanlysinhvien;

select Address, count(StudentID) as 'Amount of student' from student
group by address; 

select s.StudentID, s.StudentName, AVG(Mark) from student s
join mark m on s.StudentID = m.StudentID
group by s.StudentID, s.StudentName;

select s.StudentID, s.StudentName, AVG(Mark) from student s
join mark m on s.StudentID = m.StudentID
group by s.StudentID, s.StudentName
having avg(mark) > 15;

select s.StudentID, s.StudentName, AVG(Mark) from student s
join mark m on s.StudentID = m.StudentID
group by s.StudentID, s.StudentName
having AVG(Mark) >= All (select avg(mark) from mark group by mark.StudentID);