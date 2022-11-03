create table if not exists parking(
 id serial primary key,
 ardess varchar(128) not null,
 name varchar(128),
 type varchar(128)  not null
);

create table if not exists parking_user(
 id serial primary key,
 login varchar(32) not null,
 password varchar(32) not null,
 first_name varchar(32),
 secon_name varchar(32),
 last_name varchar(32),
 phone_number varchar(128),
 card_number varchar(32),
 role varchar(32) not null
);

create table if not exists car(
 id serial primary key,
 model varchar(128),
 number varchar(128) not null,
 weight float4 not null,
 user_id int8  not null,
 constraint user_id_fk foreign key (user_id) references parking_user(id)
);


create table if not exists parking_place(
 number int4 not null,
 flor int4 not null,
 primary key(number,flor), 
 cost int4 not null,
 car_id int4,
 constraint car_id_fk foreign key (car_id) references car(id),
 parking_id int8,
 constraint parking_id_fk foreign key (parking_id) references parking(id)
);

create table if not exists orders(
 id bigserial primary key,
 date_from timestamp not null,
 date_to timestamp,
 overtime boolean,
 pp_number int4 not null,
 pp_flor int4 not null,
 FOREIGN KEY (pp_number, pp_flor) REFERENCES parking_place (number, flor)
);

drop table  car cascade;
drop table  orders  cascade;
drop table  parking_user cascade;
drop table  parking cascade;
drop table  parking_place cascade;