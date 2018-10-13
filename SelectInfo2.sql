USE SCT;
--（1）	检索所有姓张，且名字的最后一个字为“三”的同学的姓名和学号；
SELECT S#,Sname 
FROM Student
WHERE Sname LIKE '张%三';
--（2）	检索所有姓张，且姓名为双字的同学的姓名和学号；
SELECT S#,Sname 
FROM Student
WHERE Sname LIKE '张 _ _';
--（3）	检索03系教师的平均工资；
SELECT AVG(Salary) AS [AVG(Salary)]
FROM Teacher
WHERE D#='03';
--（4）	检索查询年龄在19~22岁（包括19岁和22岁）之间的学生的姓名、年龄和出生年月；
SELECT Sname,Sage,2018-Sage AS [Birthday]
FROM Student
WHERE Sage BETWEEN 19 AND 22;
--（5）	检索选修了001号课程的学生的学号和姓名；    
SELECT Student.S#,Student.Sname
FROM Student,SC
WHERE (C#='001') AND (Student.S#=SC.S#);
--（6）	在选课表中，检索成绩大于80分的所有学生的学号和姓名，要求确保结果的唯一性。
SELECT DISTINCT Student.S#,Student.Sname
FROM Student,SC
WHERE (Score > 80) AND (Student.S#=SC.S#);
--（7）	检索不及格课程超过一门的同学的学号和姓名；
SELECT DISTINCT Student.S#,Student.Sname
FROM Student,SC
WHERE SC.S# IN (SELECT S#
				FROM SC
				WHERE Score <60
				GROUP BY S# 
				HAVING COUNT(*) >=2 )
		   AND Student.S#=SC.S#;

--（8）	检索选修了“数据结构”课程的学生的学号、姓名和成绩，并按成绩由高到低的顺序进行排序；
SELECT Student.S#,Student.Sname,SC.Score
FROM Student,SC,Course
WHERE  Course.Cname='数据结构' AND Student.S#=SC.S# AND SC.C#=Course.C#
ORDER BY SC.Score DESC;
--（9）	检索平均成绩不及格的学生的学号、姓名及平均成绩。
SELECT Student.Sname,SC.S#,AVG(Score) AS [AVG(Score)]
FROM SC,Student
WHERE SC.S# = Student.S#
GROUP BY SC.S#,Student.Sname
HAVING AVG(Score)<60 
