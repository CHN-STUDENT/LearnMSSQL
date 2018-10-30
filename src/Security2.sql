-- 创建数据库 学生选课数据库
CREATE DATABASE SCT_Bak;
GO
USE SCT_Bak;/*选中SCT数据库*/

/*
	特别注意：
	如果您使用 ALTER TABLE 语句添加主键，必须把主键列声明为不包含 NULL 值（在表首次创建时）。
	如果您使用 ALTER TABLE 语句添加主键，必须把主键列声明为不包含 NULL 值（在表首次创建时）。
	如果您使用 ALTER TABLE 语句添加主键，必须把主键列声明为不包含 NULL 值（在表首次创建时）。
	http://www.runoob.com/sql/sql-primarykey.html
*/

--创建院系表
CREATE TABLE Dept
(
	D# char(2) NOT NULL,
	Dname char(10) NOT NULL,
	Dean char(10) NOT NULL, --系主任
);
--创建教师表
CREATE TABLE Teacher
(
	T# char(3) NOT NULL,
	Tname char(10) NOT NULL,
	D# char(2) NOT NULL,
	Salary float(2)
);
--创建课程表
CREATE TABLE Course
(
	C# char(3) NOT NULL,
	Cname char(12) NOT NULL,
	Chours integer ,
	Credit float(1),
	T# char(3) 
);
--创建学生表
CREATE TABLE Student
(
	S# char(8) NOT NULL,--主键为学号
	Sname char(10) NOT NULL,
	Ssex char(2) NOT NULL,
	Sage integer NOT NULL,
	D# char(2) NOT NULL,
	Sclass char(6)
);
--创建选课表
CREATE TABLE SC
(
	S# char(8) NOT NULL,
	C# char(3) NOT NULL,
	Score float(1)
);
ALTER TABLE Dept ADD CONSTRAINT Dept_PR_D# PRIMARY KEY(D#);
ALTER TABLE Student ADD CONSTRAINT Student_PR_S# PRIMARY KEY(S#);
ALTER TABLE Course ADD CONSTRAINT Course_PR_C# PRIMARY KEY(C#);
ALTER TABLE Teacher ADD CONSTRAINT Teacher_PR_T# PRIMARY KEY(T#);
ALTER TABLE Student ADD CONSTRAINT Student_FR_D# REFERENCES Dept(D#);
ALTER TABLE SC ADD CONSTRAINT SC_FR_S# REFERENCES Student(S#);
ALTER TABLE SC ADD CONSTRAINT SC_FR_C# REFERENCES Course(C#);
ALTER TABLE Course ADD CONSTRAINT Course_FR_T# REFERENCES Teacher(T#);
ALTER TABLE Teacher ADD CONSTRAINT Teacher_FR_D# REFERENCES Dept(D#); 