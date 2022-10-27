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

create table if not exists book(
	id bigserial primary key,
	name varchar(128),
	producer varchar(128),
	date date,
	a_id int8,
	constraint a_id_fk foreign key (a_id) references author(id),
	shelf_id int8,
	constraint shelf_id_fk foreign key (shelf_id) references shelf(id)
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

insert into author values (nextval('author_id_seq'), 'Лев','Толстой','Николаевич');
insert into author (last_name) values('Народ');

insert into poem (name, content, date, a_id) values ('Анна Коренина','Anna Corenina', '24.02.1870', 1);








