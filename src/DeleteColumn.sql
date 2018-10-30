--删掉表中所有的行
--先删关联关系最少的表
USE SCT;

DELETE FROM SC;
DELETE FROM Course;
DELETE FROM Teacher;
DELETE FROM Student;
DELETE FROM Dept;



