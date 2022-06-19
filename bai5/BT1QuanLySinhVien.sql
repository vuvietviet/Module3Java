use quanlysinhvien;

select * from subject
group by SubID, SubName
having Credit >= all (select Credit from subject);

select s.SubID, s.SubName,s.Credit,s.Status,m.Mark from subject s 
left join mark m on s.SubID = m.SubID
group by s.SubID, s.SubName
having m.Mark >= all (select Mark from mark);

select s.StudentID,s.StudentName,avg(m.Mark) as AverageMark from student s 
join mark m on s.StudentID = m.StudentID
group by s.StudentID,s.StudentName
order by avg(m.Mark) desc;