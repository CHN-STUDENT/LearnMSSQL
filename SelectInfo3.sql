USE SCT; --不要忘了这句，要不然可能查不到
--别忘了这句！！！！
--别忘了！！！
--不然可能出事情的！！！
--一定要小心！！！
--一定要谨慎！！！
--记住！！！
--（1）	检索有薪水差额的任意两位教师的姓名及二者的工资差额；
    Select DISTINCT T1.Tname, T2.Tname
    From Teacher AS T1, Teacher AS T2
    Where T1.Salary > T2.Salary; 
--（2）	检索“001”号课成绩比“002”号课成绩高的所有学生的姓名、001号课程成绩、002号课程成绩及成绩差；
	SELECT DISTINCT Student.Sname,
		SC1.Score AS [Score(001)],
		SC2.Score AS [Score(002)],
		(SC1.Score-SC2.Score) AS [Difference]
	FROM SC AS SC1,
		 SC AS SC2,
		 Student
	WHERE (SC1.C#='001' AND SC2.C#='002') 
			AND (SC1.S#=SC2.S#) 
			AND (SC1.Score>SC2.Score) 
			AND (SC1.S#=Student.S#);
--（3）	检索选修‘001’号课程有成绩差的任意两位同学的学号和成绩差；
	SELECT DISTINCT SC1.S# AS [S1.S#],SC2.S# AS [S2.S#],
			(SC1.Score-SC2.Score) AS [Difference]
	FROM SC AS SC1,
			SC AS SC2
	WHERE (SC1.Score!=SC2.Score) 
			AND (SC1.S#!=SC2.S#)
			AND (SC1.C#='001')
			AND (SC2.C#='001')
			AND (SC1.C#=SC2.C#);
--（4）	检索选修了001号课程的学生的学号和姓名；
	SELECT Student.Sname,SC.S#
	FROM Student,SC
	WHERE (Student.S#=SC.S#) AND (SC.C#='001');
--（5）	检索有两门及以上不及格(超过一门）课程同学的学号及其平均成绩；
	--这里平时成绩是他整个的平均成绩
	SELECT S#,AVG(Score)
	FROM SC
	--括号内为不及格超过一门的同学的学号
	WHERE S# IN(SELECT S#
				FROM SC
				WHERE Score <60
				GROUP BY S#
				HAVING COUNT(*) >=2)
	GROUP BY S#;
--（6）	找出001号课成绩最高的学生的学号；
	SELECT S#
	FROM SC
	WHERE C#='001' 
		  AND Score=(SELECT MAX(Score) FROM SC);
	  --成绩等于最高值，可以用SELECT MAX(Score) FROM SC 选出
--（7）	找出张三同学成绩最低的课程号；
	SELECT Min(SC.Score) AS [张三最低的成绩]
	FROM SC
	WHERE SC.Score IN (SELECT SC.Score
					   FROM SC,Student
					   WHERE SC.S#=Student.S# 
							 AND Student.Sname='张三');
--（8）	列出没学过李明老师讲授任何一门课程的所有同学的姓名；
	/*
		最内层查询：从Teacher表查询李明老师的工号（T#）
		次内层查询：从Course表查询所有由李明老师的工号（T#）所教的课程号（C#) 
			联立条件：Course.T#=Teacher.T#
		次外层查询：从SC表查询所有没有由李明老师的工号（T#）所教的课程号（C#)的学生的学号(S#)
			联立条件：Course.C#=SC.C#	
		最外层查询：从Student表查询所有没有由李明老师的工号（T#）所教的课程号（C#)的学生的学号(S#)的学生姓名(Sname)
			联立条件：SC.S#=Student.S#	
		其中联立条件是每个表的外键，即每层AND后面是与外层查询的表连接条件，即选择查询的内容
	*/
	SELECT Sname FROM Student --查询所有没选择查询由李明老师的工号所教的课程号的学生的学号的学生姓名	
	WHERE EXISTS
	(
		SELECT S# FROM SC --查询所有没选择查询由李明老师的工号所教的课程号的学生的学号
		WHERE NOT EXISTS
			(
				SELECT C# FROM Course --查询由李明老师的工号所教的课程号
				WHERE EXISTS
				(
					SELECT T# FROM Teacher --查询李明老师的工号
					WHERE Teacher.Tname='李明' 
						  AND Course.T#=Teacher.T# 
				)
				AND Course.C#=SC.C#			
			)
		AND SC.S#=Student.S#	
	);
--（9）	列出学过98030101号同学学过所有课程的同学的学号；
--（10）	新建Table: SCt(S#, C#, Score), 将检索到的成绩不及格同学的记录新增到该表中；
	USE SCT;
	SELECT S#,C#,Score
	INTO SCt --直接将结果插入新表
	FROM SC
	WHERE ( Score < 60 );
	--检索插入的新表
	SELECT * FROM SCt;
--（11）	从SCt表中删除有两门不及格课程的所有同学；
--（12）	将张三同学001号课的成绩置为其班级该门课的平均成绩。
