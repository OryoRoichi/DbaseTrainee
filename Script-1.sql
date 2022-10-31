create table if not exists archive(
	id bigserial primary key,
	number varchar(128)
);

create table if not exists book_case(
	id bigserial primary key,
	number varchar(128),
	archive_id int8,
	constraint arc_id_fk foreign key (archive_id) references archive(id)
);

create table if not exists shelf(
	id bigserial primary key,
	number varchar(128),
	book_case_id int8,
	constraint book_case_id_fk foreign key (book_case_id) references book_case(id)
);

create table if not exists author(
	id bigserial primary key,
	first_name varchar(32),
	last_name varchar(32),
	middle_name varchar(32),
	birthdate date
);

create table if not exists book(
	id bigserial primary key,
	name varchar(128),
	producer varchar(128),
	date date,
	number int
	a_id int8,
	constraint a_id_fk foreign key (a_id) references author(id),
	shelf_id int8,
	constraint shelf_id_fk foreign key (shelf_id) references shelf(id)
);

create table if not exists poem(
	id bigserial primary key,
	name varchar(128),
	content text,
	date timestamp,
	a_id int8,
	constraint a_id_fk foreign key (a_id) references author(id),
	book_id int8,
	constraint book_id_fk foreign key (book_id) references book(id)
);



alter table book drop column a_id cascade;

alter table book add column a_id int8;
alter table book add constraint a_id_fk foreign key (a_id) references author(id);

alter table book drop column a_id;
alter table book add column number int8;

drop table book cascade;
drop table poem;

alter table archive alter column number set not null;

alter table book_case alter column number set not null;
alter table book_case alter column archive_id set not null;

alter table shelf alter column number set not null;
alter table shelf alter column book_case_id set not null;

alter table book alter column name set not null;
alter table book alter column number set not null;
alter table book alter column a_id set not null;
alter table book alter column shelf_id set not null;

alter table poem alter column content set not null;

alter table author  alter column last_name set not null;




truncate author restart identity cascade;
truncate archive  restart identity cascade ;


insert into author values (nextval('author_id_seq'), 'Лев','Толстой','Николаевич');
insert into author values (nextval('author_id_seq'), 'Энест','Хемингуэй');
insert into author values (nextval('author_id_seq'), 'Брэм','Стокер');
insert into author values (nextval('author_id_seq'), 'Мэри','Шелли');
insert into author values (nextval('author_id_seq'), 'Джордж','Оруэлл');
insert into author values (nextval('author_id_seq'), 'Говард','Лавкрафт');
insert into author values (nextval('author_id_seq'), 'Эдгар','По','Аллан');
insert into author values (nextval('author_id_seq'), 'Стивен','Кинг');
insert into author values (nextval('author_id_seq'), 'Густав','Майринк');
insert into archive  values (nextval('archive_id_seq'), 1);
insert into archive  values (nextval('archive_id_seq'), 1);

insert into book_case values (nextval('book_case_id_seq'),1, 1);
insert into book_case values (nextval('book_case_id_seq'),2, 1);
insert into book_case values (nextval('book_case_id_seq'),3, 2);
insert into book_case values (nextval('book_case_id_seq'),4, 2);

insert into shelf values (nextval('shelf_id_seq'),1, 1);
insert into shelf values (nextval('shelf_id_seq'),2, 1);
insert into shelf values (nextval('shelf_id_seq'),3, 2);
insert into shelf values (nextval('shelf_id_seq'),4, 2);
insert into shelf values (nextval('shelf_id_seq'),5, 3);
insert into shelf values (nextval('shelf_id_seq'),6, 3);
insert into shelf values (nextval('shelf_id_seq'),7, 4);
insert into shelf values (nextval('shelf_id_seq'),8, 4);

insert into book values (nextval('book_id_seq'),'Книга1','prod1','24.02.1952',1,1,1);
insert into book values (nextval('book_id_seq'),'Книга2','prod2','24.02.1935',2,2,1);
insert into book values (nextval('book_id_seq'),'Книга3','prod3','24.02.1897',2,2,1);
insert into book values (nextval('book_id_seq'),'Книга4','prod4','24.02.1818',3,3,1);
insert into book values (nextval('book_id_seq'),'Книга5','prod5','24.02.1949',4,4,1);
insert into book values (nextval('book_id_seq'),'Книга6','prod6','24.02.1945',5,5,1);
insert into book values (nextval('book_id_seq'),'Книга7','prod7','24.02.1923',5,5,1);
insert into book values (nextval('book_id_seq'),'Книга8','prod8','24.02.1843',6,6,1);
insert into book values (nextval('book_id_seq'),'Книга9','prod9','24.02.1996',7,7,1);
insert into book values (nextval('book_id_seq'),'Книга10','prod10','24.02.1986',7,8,1);
insert into book values (nextval('book_id_seq'),'Книга11','prod11','24.02.1914',8,8,1);

insert into poem (name, content, date, a_id, book_id) values ('Анна Коренина','Anna Corenina', '24.02.1870', 1,1);
insert into poem (name, content, date, a_id, book_id) values ('Старик и море','the Old man and the Sea', '24.02.1952', 2,2);
insert into poem (name, content, date, a_id, book_id) values ('Зелёные холмы Африки','Green Hills of Africa', '24.02.1935', 2,2);
insert into poem (name, content, date, a_id, book_id) values ('Дра́кула','Dracule', '24.02.1897', 3,3);
insert into poem (name, content, date, a_id, book_id) values ('Франкенштейн','Франкенштейн, или Современный Прометей', '24.02.1818', 4,4);
insert into poem (name, content, date, a_id, book_id) values ('1984','1984', '24.02.1949', 5,5);
insert into poem (name, content, date, a_id, book_id) values ('Скотный двор','Скотный двор', '24.02.1945', 5,5);
insert into poem (name, content, date, a_id, book_id) values ('Крысы в стенах','Крысы в стенах', '24.02.1923', 6,6);
insert into poem (name, content, date, a_id, book_id) values ('Золотой жук','Золотой жук', '24.02.1843', 7,7);
insert into poem (name, content, date, a_id, book_id) values ('Безнадёга','Безнадёга', '24.02.1996', 8,8);
insert into poem (name, content, date, a_id, book_id) values ('Оно','IT', '24.02.1986',8,8 );
insert into poem (name, content, date, a_id, book_id) values ('Голем','Голем', '24.02.1914', 9,9);

update author set birthdate ='28.08.1828' where last_name = 'Толстой';
update author set birthdate ='02.06.1961' where last_name = 'Хемингуэй';
update author set birthdate ='8.11.1847' where last_name = 'Стокер';
update author set birthdate ='30.08.1797' where last_name = 'Шелли';
update author set birthdate ='25.06.1903' where last_name = 'Оруэлл';
update author set birthdate ='20.08.1890' where last_name = 'Лавкрафт';
update author set birthdate ='19.01.1809' where last_name = 'По';
update author set birthdate ='21.09.1947' where last_name = 'Кинг';
update author set birthdate ='19.01.1868' where last_name = 'Майринк';


select * from poem p where p.date < '01.01.1951' and p.date > '01.01.1901';

select * from poem p where p.book_id in (select b.id from book b where b.producer = 'prod3');


