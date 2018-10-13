-- 物联网1603 郭治洪 201616070320 数据库实验二

-- 学生选课数据库插入数据 
USE SCT;
--根据外键约束，插入数据必须按照顺序，不然会提示冲突，无法执行
GO
--插入Dept表数据
INSERT INTO Dept VALUES('01','机电','李三');
INSERT INTO Dept VALUES('02','能源','李四');
INSERT INTO Dept VALUES('03','计算机','李五');
INSERT INTO Dept VALUES('04','自动控制','李六');
GO
--插入Student表数据
insert into Student values('98030101','张三','男',20,'03','980301');
insert into Student values('98030102','张四','男',20,'03','980301');
insert into Student values('98030103','张五','男',19,'03','980301');
insert into Student values('98040201','王三','男',20,'04','980402');
insert into Student values('98040202','王四','男',21,'04','980402');
insert into Student values('98040203','王五','女',19,'04','980402');
GO
--插入Teacher表数据
INSERT INTO Teacher VALUES('001','赵三','01',1200.00);
INSERT INTO Teacher VALUES('002','赵四','03',1400.00);
INSERT INTO Teacher VALUES('003','赵五','03',1000.00);
INSERT INTO Teacher VALUES('004','赵六','04',1100.00);
GO
--插入Course表数据
INSERT INTO Course VALUES('001','数据库',40,6,'001');
INSERT INTO Course VALUES('003','数据结构',40,6,'003');
INSERT INTO Course VALUES('004','编译原理',40,6,'001');
INSERT INTO Course VALUES('005','C 语言',30,4.5,'003');
INSERT INTO Course VALUES('002','高等数学',80,12,'004');
GO
--插入SC表数据
INSERT INTO SC VALUES('98030101','001',92);
INSERT INTO SC VALUES('98030101','002',85);
INSERT INTO SC VALUES('98030101','003',88);
INSERT INTO SC VALUES('98040202','002',90);
INSERT INTO SC VALUES('98040202','003',80);
INSERT INTO SC VALUES('98040202','001',55);
INSERT INTO SC VALUES('98040203','003',56);
INSERT INTO SC VALUES('98030102','001',54);
INSERT INTO SC VALUES('98030102','002',85);
INSERT INTO SC VALUES('98030102','003',48);
GO
