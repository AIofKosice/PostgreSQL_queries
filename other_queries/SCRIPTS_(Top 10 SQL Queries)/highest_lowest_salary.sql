--- Q2: Display highest and lowest salary --- 

drop table if exists employee;
create table employee
(
	id 			int primary key GENERATED ALWAYS AS IDENTITY,
	name 		varchar(100),
	dept 		varchar(100),
	salary 		int
);
insert into employee values(default, 'Alexander', 'Admin', 6500);
insert into employee values(default, 'Leo', 'Finance', 7000);
insert into employee values(default, 'Robin', 'IT', 2000);
insert into employee values(default, 'Ali', 'IT', 4000);
insert into employee values(default, 'Maria', 'IT', 6000);
insert into employee values(default, 'Alice', 'Admin', 5000);
insert into employee values(default, 'Sebastian', 'HR', 3000);
insert into employee values(default, 'Emma', 'Finance', 4000);
insert into employee values(default, 'John', 'HR', 4500);
insert into employee values(default, 'Kabir', 'IT', 8000);

select * from employee;


---------------CTE

WITH CTE AS(
SELECT dept, MIN(Salary) AS min_salary, MAX(Salary) max_salary
FROM employee
GROUP BY dept
)

SELECT e.*, CTE.min_salary, CTE.max_salary
FROM employee as e
INNER JOIN CTE on CTE.dept = e.dept
ORDER BY dept;

--------------subquery_select 
SELECT e.*,
(SELECT MAX(Salary) FROM employee e2 WHERE e.dept = e2.dept),
(SELECT MIN(Salary) FROM employee e2 WHERE e.dept = e2.dept)
FROM employee e
ORDER BY e.dept

--------------subquery_join
SELECT e.*, sub.min_salary, sub.max_salary
FROM employee e
INNER JOIN (SELECT dept, MIN(Salary) as min_salary, MAX(Salary) as max_salary FROM employee GROUP BY dept) sub on sub.dept = e.dept
ORDER BY dept

--------------window function
SELECT *,
MIN(Salary) OVER(PARTITION BY dept RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as min_salary,
MAX(Salary) OVER(PARTITION BY dept RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as max_salary
FROM employee
ORDER BY dept


