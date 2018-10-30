USE SCT;
--（1）	检索教师表中所有工资少于1500元或者工资大于2000元，并且是03系的教师姓名和工资。
SELECT Tname,Salary
FROM Teacher
WHERE D# = '03' AND ( Salary <1500 OR Salary >2000 );
-- （2）检索学生表(Student)中所有年龄大于19岁的学生的年龄及姓名。
SELECT Sname,Sage 
FROM Student
WHERE Sage>19
--（3）	在选课表中，检索成绩大于80分的所有学生的学号和姓名，要求确保结果的唯一性。
--DISTINCT 关键字用来去重
SELECT distinct Student.S#,Student.Sname
FROM SC,Student
WHERE ( Score > 80 ) AND (Student.S#=SC.S#)
--（4）	检索选课表中所有不及格的学生的学号、课程号和成绩。
SELECT S#,C#,Score
FROM SC
WHERE ( Score < 60 )
--（5）	检索选课表的所有信息，并按成绩由高到低的顺序进行排序。
SELECT *
FROM SC
ORDER BY Score DESC ;
