select * from poem p where p.date < '01.01.1951' and p.date > '01.01.1901';

select * from poem p where p.book_id in (select b.id from book b where b.producer = 'prod3');



select * from author a where a.id in (select a_id  from book b where b.shelf_id  in (
select s.id from shelf s where s.book_case_id in (
select bc.id from book_case bc where bc.archive_id = 2))); 


select *from poem p where p.date >'01.01.1701' and p.date < '01.01.1800' and p.book_id in(
select b.id  from book b where b.shelf_id  in (
select s.id from shelf s where s.book_case_id in (
select bc.id from book_case bc where bc.archive_id = 1)));

select * from poem p where p.a_id in(
select a.id from author a where a.birthdate > '01.01.1801' and a.birthdate <'01.01.1900')
and p.book_id in(
select b.id  from book b where b.shelf_id  in (
select s.id from shelf s where s.book_case_id in (
select bc.id from book_case bc where bc.archive_id = 1)));
--произведения книги и авторов 20го века
CREATE VIEW Auth_Book_poems (name,first_name,last_name,poem_name,date) as
select b."name",a."first_name",a."last_name",p."name",p.date from poem p 
FULL OUTER JOIN book b ON p.book_id = b.id 
FULL OUTER JOIN author a ON p.a_id = a.id 
WHERE p.date > '01.01.1900' AND  p.date < '01.01.2000';  


-- овер тайм флажек в тру а если  то в фолс
create or replace function update_overtime(int8) returns void as
$body$
declare
 d date;
 over  boolean;
 t timestamp;
begin
	select o.date_to from orders o where o.id= $1 into d;
	select o.overtime from orders o where o.id =$1 into over;
	select now() +  interval '2 day' into t;
  if d < now() then 
  	update orders set overtime = true where id = $1;
  elsif over = true  then 
  	update orders  set date_to = t,
  		 overtime = false where id = $1;
  	end if;
 end;
$body$
language plpgsql;

select update_overtime(5);
  
-- orders overtime = true , set overtime = false , date_to = null
-- parking place car_id = null 
create or replace function fre_parking_place() returns void  as
$body$
declare
 	o orders;
 	pp parking_place;
begin
	select * from parking_place into pp;
	for o  in select * from orders where overtime = true 
	loop 
		update orders set overtime = false and date_to = null,
				pp.car_id = null;
			return query select parking_p.floor and parking_p.number from parking_place parking_p;
	end loop;
 end;
$body$
language plpgsql;

select fre_parking_place();