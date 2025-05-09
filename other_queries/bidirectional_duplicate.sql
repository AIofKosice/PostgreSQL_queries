--- Q4 : Convert the given input to expected output --- 

drop table if exists src_dest_distance;
create table src_dest_distance
(
    source          varchar(20),
    destination     varchar(20),
    distance        int
);
insert into src_dest_distance values ('Bangalore', 'Hyderbad', 400);
insert into src_dest_distance values ('Hyderbad', 'Bangalore', 400);
insert into src_dest_distance values ('Mumbai', 'Delhi', 400);
insert into src_dest_distance values ('Delhi', 'Mumbai', 400);
insert into src_dest_distance values ('Chennai', 'Pune', 400);
insert into src_dest_distance values ('Pune', 'Chennai', 400);
insert into src_dest_distance values ('Ukraine', 'kyiv', 1000);

select * from src_dest_distance;


with cte as 
(select *, row_number() over() from src_dest_distance)

select t1.source, t1.destination, t1.distance, t1.row_number, t2.row_number from cte t1
left join cte t2 on 
t1.row_number < t2.row_number and t1.destination = t2.source and t1.source = t2.destination


WITH cte AS (
    SELECT *, ROW_NUMBER() OVER () AS row_number
    FROM src_dest_distance
)
SELECT t1.source, t1.destination, t1.distance, t1.row_number, t2.row_number,
       CASE WHEN t2.row_number IS NOT NULL THEN 'Bidirectional' ELSE 'One-way' END AS route_type
FROM cte t1
LEFT JOIN cte t2 ON 
    t1.row_number < t2.row_number 
    AND t1.destination = t2.source 
    AND t1.source = t2.destination
WHERE t2.row_number IS NOT NULL -- Bidirectional routes
   OR (t2.row_number IS NULL AND NOT EXISTS (
       SELECT 1 FROM cte t3 
       WHERE t3.source = t1.destination 
       AND t3.destination = t1.source 
   ));


