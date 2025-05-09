--- Q10: Pizza Delivery Status --- 

drop table if exists cust_orders;
create table cust_orders
(
cust_name   varchar(50),
order_id    varchar(10),
status      varchar(50)
);

insert into cust_orders values ('John', 'J1', 'DELIVERED');
insert into cust_orders values ('John', 'J2', 'DELIVERED');
insert into cust_orders values ('David', 'D1', 'SUBMITTED');
insert into cust_orders values ('David', 'D2', 'DELIVERED'); -- This record is missing in question
insert into cust_orders values ('David', 'D3', 'CREATED');
insert into cust_orders values ('Smith', 'S1', 'SUBMITTED');
insert into cust_orders values ('Krish', 'K1', 'CREATED');
commit;

select * from cust_orders


--first option
select cust_name as customer_name, 'COMPLEATED' as status
from cust_orders
where status = 'DELIVERED' and cust_name not in (select cust_name from cust_orders where status in ('SUBMITTED','CREATED'))

--another option
select cust_name as customer_name, 'COMPLETED' as status
from cust_orders D
where D.status = 'DELIVERED'
and not exists (select 1 from cust_orders d2
                where d2.cust_name=d.cust_name
                and d2.status in ('SUBMITTED','CREATED'))
				
union all -- just look
select cust_name as customer_name, 'IN PROGRESS' as status
from cust_orders D
where D.status = 'DELIVERED'
and  exists (select 1 from cust_orders d2
                where d2.cust_name=d.cust_name
                and d2.status in ('SUBMITTED','CREATED'))
union all
select cust_name as customer_name, 'AWAITING PROGRESS' as status
from cust_orders D
where D.status = 'SUBMITTED'
and not exists (select 1 from cust_orders d2
                where d2.cust_name=d.cust_name
                and d2.status in ('DELIVERED'))
union -- removing duplicates, hm
select cust_name as customer_name, 'AWAITING SUBMISSION' as status
from cust_orders D
where D.status = 'CREATED'
and not exists (select 1 from cust_orders d2
                where d2.cust_name=d.cust_name
                and d2.status in ('DELIVERED','SUBMITTED'));