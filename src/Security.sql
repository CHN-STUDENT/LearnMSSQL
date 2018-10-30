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

-- 这是先创建表然后添加主键和外键约束，注意主键约束要求该列不包含NULL值

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
/*
	特别注意：
	如果您使用 ALTER TABLE 语句添加主键，必须把主键列声明为不包含 NULL 值（在表首次创建时）。
	如果您使用 ALTER TABLE 语句添加主键，必须把主键列声明为不包含 NULL 值（在表首次创建时）。
	如果您使用 ALTER TABLE 语句添加主键，必须把主键列声明为不包含 NULL 值（在表首次创建时）。
	http://www.runoob.com/sql/sql-primarykey.html
*/

--1.	为上述各个表设置主键约束、外键约束；
ALTER TABLE Dept ADD CONSTRAINT Dept_PR_D# PRIMARY KEY(D#);
ALTER TABLE Student ADD CONSTRAINT Student_PR_S# PRIMARY KEY(S#);
ALTER TABLE Course ADD CONSTRAINT Course_PR_C# PRIMARY KEY(C#);
ALTER TABLE Teacher ADD CONSTRAINT Teacher_PR_T# PRIMARY KEY(T#);
ALTER TABLE Student ADD CONSTRAINT Student_FR_D# FOREIGN KEY (D#)REFERENCES Dept(D#);
ALTER TABLE SC ADD CONSTRAINT SC_FR_S#  FOREIGN KEY (S#) REFERENCES Student(S#);
ALTER TABLE SC ADD CONSTRAINT SC_FR_C#  FOREIGN KEY (C#) REFERENCES Course(C#);
ALTER TABLE Course ADD CONSTRAINT Course_FR_T#  FOREIGN KEY (T#) REFERENCES Teacher(T#);
ALTER TABLE Teacher ADD CONSTRAINT Teacher_FR_D# FOREIGN KEY (D#) REFERENCES Dept(D#);

--3.	设置学生的年龄必须在15到25之间；

ALTER TABLE Student ADD CONSTRAINT Student_CK_Sage CHECK (Sage >=15 AND Sage<= 25);
ALTER TABLE Student ADD CONSTRAINT Student_CK_Ssex CHECK (Ssex='男' OR Ssex='女');
-- 等价于 ALTER TABLE Student ADD CONSTRAINT Student_CK_Ssex CHECK (Ssex IN ('男','女') );


--4.	为Teacher添加一个身份证号属性，属性名ID_no，要求：必须符合真实身份证的编号要求，而且不能为空，且值唯一；
/*
	XXXXXX | XXXX | XX | XX | XXX | X
 	123456   789A   BC   DE   FGH   I
	1.前六位行政区号 有固定表
	2.年份 1900-今年
	3.月/日 符合规范
	4.最后一位校验码能根据前17位计算匹配
	5.且前17位数字，最后一位0-9或X
*/

ALTER TABLE Student ADD ID_no char(18) unique(ID_no);
-- alter table student add constraint CK_ID_Format check ((id like '[0-9][0-9][0-9][0-9][0-9][0-9][1-2][0-9][0-9][0-9][0-1][0-9][0-3][0-9][0-9][0-9][0-9]X') OR (id like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9][0-9][0-9][0-9]'))
ALTER TABLE Student ADD CONSTRAINT CK_ID_Format CHECK ((ID_no like '[0-9][0-9][0-9][0-9][0-9][0-9][1-2][0-9][0-9][0-9][0-1][0-9][0-3][0-9][0-9][0-9][0-9]X') OR (ID_no like '[0-9][0-9][0-9][0-9][0-9][0-9][1-2][0-9][0-9][0-9][0-1][0-9][0-3][0-9][0-9][0-9][0-9][0-9]'));
ALTER TABLE Student ADD CONSTRAINT CK_ID_Format2 CHECK(LEN(ID_no)=18);
ALTER TABLE Student ADD CONSTRAINT CK_ID_Format3 CHECK(ISDATE (CONVERT ( integer,SUBSTRING(ID_no,7,8)))=1)
-- 能力和时间不够，剩余不做。

--5.	请向题设给定的各表中插入合适的元组，对上述四点完整性约束进行验证（主键、外键、性别、年龄、身份证号）。

--测试数据，并非严格规范。
--插入Dept表数据
INSERT INTO Dept VALUES('01','机电','李三');
INSERT INTO Dept VALUES('02','能源','李四');
INSERT INTO Dept VALUES('03','计算机','李五');
INSERT INTO Dept VALUES('04','自动控制','李六');
GO
INSERT INTO Student VALUES('98040203','王五','女',19,'04','980402','12345619980101002X');
INSERT INTO Student VALUES('98040203','王五','女',19,'04','980402','12345619980101002X');
INSERT INTO Student VALUES('98030103','张五','男',19,'03','980301','12345619985101001X');
INSERT INTO Student VALUES('98030101','张三','无',20,'03','980301','12345619980101001X');
INSERT INTO Student VALUES('98040202','王四','男',21,'04','980402','12345619980101001X');
INSERT INTO Student VALUES('98030102','张四','男',20,'03','980301','12345619980101001X');
INSERT INTO Student VALUES('98040201','王三','男',20,'04','980402','123456200019390000');


--撤销主键外键约束

ALTER TABLE Teacher DROP CONSTRAINT Teacher_FR_D#;
ALTER TABLE Student DROP CONSTRAINT Student_FR_D#;
ALTER TABLE SC DROP CONSTRAINT SC_FR_C#;
ALTER TABLE SC DROP CONSTRAINT SC_FR_S#;
ALTER TABLE Student DROP CONSTRAINT Student_CK_Sage;
ALTER TABLE Student DROP CONSTRAINT Student_CK_Ssex;
ALTER TABLE Student DROP CONSTRAINT Student_PR_S#;
ALTER TABLE Course DROP CONSTRAINT Course_FR_T#;
ALTER TABLE Course DROP CONSTRAINT Course_PR_C#;
ALTER TABLE Teacher DROP CONSTRAINT Teacher_PR_T#;
ALTER TABLE Dept DROP CONSTRAINT Dept_PR_D#;

USE master;
DROP DATABASE SCT_Bak;