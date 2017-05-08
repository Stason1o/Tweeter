-- Schema: twitter

-- DROP SCHEMA twitter;

CREATE SCHEMA twitter
  AUTHORIZATION stas;

------------TABLE ROLE--------
create table roles(
	role_id int primary key,
    role varchar(15) not null
);

----------TABLE USERS----------------
create table users(
	user_id SERIAL  primary key,
    username varchar(30) unique not null,
    password varchar(30) not null,
    email varchar(50) unique not null,
    first_name varchar(20) not null,
    last_name varchar(20) not null,
    enabled boolean default true
);

------TABLE USER_ROLES---------------
create table user_roles(
	id_user int not null references users(user_id),
    id_role int not null references roles(role_id)    
);

create table tweets(
	tweet_id SERIAL primary key,
	tweet_content varchar(140),
	tweet_date date not null,
	id_user int not null references users(user_id)
);

create table tweet_comments(
	tweet_comment_id serial primary key,
	id_tweet int not null references tweets(tweet_id),
	comment_content varchar(50) not null,
	comment_date date not null,
	
);

----------------------TRIGGERS AND PROCS---------------------
CREATE OR REPLACE FUNCTION insert_in_user_roles()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO user_roles (id_user, id_role) VALUES(NEW.user_id, 2);
  RETURN NEW;
END; $$ LANGUAGE 'plpgsql';

CREATE TRIGGER setRoleAfterUserInsert
AFTER INSERT ON users
FOR EACH ROW 
execute procedure insert_in_user_roles();




----------------------------INSERTS IN TABLES-------------------------------
insert into roles(role_id, role) values(1, 'ROLE_ADMIN'),(2, 'ROLE_USER'),(3, 'ROLE_MODERATOR');
insert into users(username, password, email, first_name, last_name, enabled) 
values	('stas', 'abc123', 'stas@mail.ru', 'Stas', 'Bogdanschi', true), 
		('peter', 'abc124','patrick@mail.ru', 'Peter', 'Panfilov',true);
insert into user_roles(id_user, id_role) values(1, 1), (2, 2),(1, 3);

insert into users(username, password, email, first_name, last_name, enabled) 
values	('pavel', 'qwe', 'pavel@mail.ru', 'Pasha', 'Pasha', true);


insert into tweets(tweet_id, tweet_content, tweet_date, id_user)
values	(1, 'Hello I am first', '1/18/1999', 3),
	(2, 'Hello I am second','1/18/1999', 4);