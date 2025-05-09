--- Q1: Delete duplicate data --- 

drop table if exists cars;
create table cars
(
	model_id		int primary key,
	model_name		varchar(100),
	color			varchar(100),
	brand			varchar(100)
);
insert into cars values(1,'Leaf', 'Black', 'Nissan');
insert into cars values(2,'Leaf', 'Black', 'Nissan');
insert into cars values(3,'Model S', 'Black', 'Tesla'); 
insert into cars values(4,'Model X', 'White', 'Tesla');
insert into cars values(5,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(6,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(7,'Ioniq 6', 'White', 'Hyundai');

select * from cars;

-----------partition by, row_number
SELECT * from cars
WHERE model_id in 
(SELECT model_id FROM 
(SELECT *, ROW_NUMBER() OVER(PARTITION BY model_name, color, brand) AS row_num FROM cars) as win
WHERE win.row_num > 1)

-- SELECT * from cars
-- WHERE model_id in 
-- (SELECT ROW_NUMBER() OVER(PARTITION BY model_name, color, brand) AS row_num FROM cars)


-----------min_id
SELECT * 
FROM CARS
WHERE MODEL_ID NOT IN (SELECT MIN(MODEL_ID) FROM CARS
GROUP BY MODEL_NAME, COLOR, BRAND);




