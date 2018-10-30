-- 物联网1603 郭治洪 201616070320 数据库实验二

-- 创建数据库 学生选课数据库
CREATE DATABASE SCT;
GO
USE SCT;/*选中SCT数据库*/
GO
--创建院系表
CREATE TABLE Dept
(
	D# char(2) PRIMARY KEY NOT NULL,
	Dname char(10) NOT NULL,
	Dean char(10) NOT NULL, --系主任
);
GO
--创建教师表
CREATE TABLE Teacher
(
	T# char(3) PRIMARY KEY NOT NULL,
	Tname char(10) NOT NULL,
	D# char(2) NOT NULL,
	Salary float(2),
	FOREIGN KEY(D#) REFERENCES Dept(D#) --外键
);
GO
--创建课程表
CREATE TABLE Course
(
	C# char(3) PRIMARY KEY NOT NULL,
	Cname char(12) NOT NULL,
	Chours integer NOT NULL,
	Credit float(1) NOT NULL,
	T# char(3) NOT NULL,
	FOREIGN KEY(T#) REFERENCES Teacher(T#)
);
GO
--创建学生表
CREATE TABLE Student
(
	S# char(8) PRIMARY KEY NOT NULL,--主键为学号
	Sname char(10) NOT NULL,
	Ssex char(2) NOT NULL,
	Sage integer NOT NULL,
	D# char(2) NOT NULL,
	Sclass char(6) NOT NULL,
	FOREIGN KEY(D#) REFERENCES Dept(D#) --外键约束
);
GO
--创建选课表
CREATE TABLE SC
(
	S# char(8) NOT NULL,
	C# char(3) NOT NULL,
	Score float(1)
	FOREIGN KEY(S#) REFERENCES Student(S#),
	FOREIGN KEY(C#) REFERENCES Course(C#)
);

