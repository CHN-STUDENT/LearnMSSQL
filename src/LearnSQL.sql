
/*
	熟悉数据库查询语句：
	包括新建数据库，新建表，删除数据库，删除表，表中添加元素，查询表内容等
	参考官方教程：
	https://docs.microsoft.com/zh-cn/sql/ssms/tutorials/lesson-2-writing-transact-sql?view=sql-server-2014
	https://docs.microsoft.com/zh-cn/sql/t-sql/statements/statements?view=sql-server-2017
	https://docs.microsoft.com/zh-cn/sql/t-sql/lesson-1-creating-database-objects?view=sql-server-2017
	这只是很简单实验，用来熟悉数据库。
*/
-- By 郭治洪 201616070320 物联网1603班

USE master;--选中系统数据库MASTER表
CREATE DATABASE TEST;--创建TEST数据库
/*更多详细参数选项可以参考官网文档https://docs.microsoft.com/zh-cn/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-2017*/
GO
--GO 这是为了区分何和实现多条语句，对一个数据库操作可以不写
USE TEST;
GO
--选中刚才创建的数据库
CREATE TABLE dbo.INFO --管理员情况下dbo 是默认架构。 dbo 代表数据库所有者
(Sname nchar(10)  NOT NULL,--关于变量类型也可以参考官方文档https://docs.microsoft.com/zh-cn/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-2017
Snum nchar(10) PRIMARY KEY NOT NULL, --PRIMARY KEY 主键设置
Ssex nchar(2) NOT NULL,
Sgrade float
);
GO
--新建表操作，并且设置表格式
INSERT dbo.INFO (Sname,Snum,Ssex,Sgrade)
	VALUES('Mike','01','M',99.0);
GO
INSERT dbo.INFO (Sname,Snum,Ssex,Sgrade)
	VALUES('John','02','M',NULL);
GO
--插入数据
UPDATE dbo.INFO
	SET Sgrade='02'
	WHERE Snum='02'
GO
--更新数据
SELECT * FROM dbo.INFO;
GO   
--查询所有数据
DELETE FROM dbo.INFO;  
GO
--删除表中所有行
DROP TABLE dbo.INFO;
GO
--删除表
USE master;--不切换数据库无法删除
GO
DROP DATABASE TEST;
GO
--删除数据库
/*一般来说，应该先删除表中数据，才能删除表，删除表后，才能删除数据库*/