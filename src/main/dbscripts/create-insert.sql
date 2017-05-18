
drop table if EXISTS user_roles;
drop table if EXISTS user_friends;
drop table if EXISTS tweet_comments;
drop TABLE IF EXISTS tweets;
drop TABLE if EXISTS users;
drop table if EXISTS roles;


------------TABLE ROLE--------
create table roles(
	role_id int primary key,
	role varchar(15) not null
);

----------TABLE USERS----------------
create table users(
	user_id SERIAL  primary key,
	username varchar(32) unique not null,
	password varchar(32) not null,
	email varchar(50) unique not null,
	first_name varchar(32) not null,
	last_name varchar(32) not null,
	enabled boolean default true
);

------TABLE USER_ROLES---------------
create table user_roles(
	id_user int not null references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE,
	id_role int not null references roles(role_id) ON DELETE CASCADE ON UPDATE CASCADE
);

create table tweets(
	tweet_id SERIAL primary key,
	tweet_content varchar(140),
	tweet_date TIMESTAMP not null,
	id_user int not null references users(user_id)
);

create table tweet_comments(
	tweet_comment_id serial primary key,
	id_tweet int not null references tweets(tweet_id),
	comment_content varchar(140) not null,
	comment_date timestamp not null
);

create table user_friends(
	user_1_id int not null references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE ,
	user_2_id int not null references users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
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

INSERT INTO "public".users (username, password, email, first_name, last_name, enabled, image) VALUES ('asdxcxcxfggh', '$2a$10$phyEoJccwQdjd/fjNF570OJeA1hdeHaOYNkXwcPUXlDhkZYlGMShy', 'jhebfjkb@jkb2.jnj', 'vbnm,./', 'fghjkl', true,'xcxv' );

-----------------------------ROLES--------------------------------
insert into roles(role_id, role) values(1, 'ROLE_ADMIN'),(2, 'ROLE_USER'),(3, 'ROLE_MODERATOR');

-----------------------------USERS--------------------------------
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (13, 'sxdcfhbjknl', '11111111', 'jhebfjkndl2efjkb@jkb2.jnj', 'vbnm,./', 'fghjkl;''', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (15, 'erklfjvndskjvn', '11111111', '12@mail.ru', 'bkfgdbkj', 'mkl;gbmwjkbl', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (14, 'newuser', '11111111', 'sdhbcjk@jksdfn.ds', 'user', 'user', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (18, 'bejkjsdfjb', '11111111', 'bvsdjk@jhsg.ru', 'fjhdfjksb', 'hiwergbisejkb', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (19, 'dmn', 'fgmdg', 'sdfhndf@djksf.tu', 'dfsg', 'sdfg', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (20, 'dfhbdjka', '11111111', 'jhasdbfjas@dfjk.ru', 'jkdfngjkasdbji', 'JHESNGJKJIdf', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (21, 'sdfhg', 'sdh', 'sfdj@mail.ru', 'sdfh', 'sdfh', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (22, 'ghcghvhgkl1', '11111111', 'ghhg@hjsdbjh.ru', 'qwegrjhvjh', 'ghchgcjk', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (23, 'kdfjhgjk', '1111', 'jhvjh@mail.ru', '123jhkh', '2gjkv2ghj', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (24, 'sdg2', '232', 'erg@mail.ru', 'wer2', '5234vwe', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (25, '1123fd', '11', 'dsgsd', 'dfsg2', 'fd2', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (26, 'fgh', 'dfh1', 'dsg@mail.ru', 'jk1j', '233qw', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (27, 'dfg', '234ws', 'sdfjk@djks.ru', 'jhvbjhv1', '1ghvjh1', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (4, 'rgbwerfv', '11111111', '1234@mail.ru', 'qwe', 'erfgew', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (6, 'testtes', '11111111', '4321@mail.ru', 'stas', 'stas', true);
INSERT INTO public.users (user_id, username, password, email, first_name, last_name, enabled) VALUES (28, 'fgv121', '11111111', 'asdfc@mail.ru', 'jkhasdfb', 'gkjh', true);
insert into public.users (user_id, username, password, email, first_name, last_name, enabled) values (1, 'stas', 'abc123', 'stas@mail.ru', 'Stas', 'Bogdanschi', true);
insert into public.users (user_id, username, password, email, first_name, last_name, enabled) values (2,'peter', 'abc124','patrick@mail.ru', 'Peter', 'Panfilov',true);

-----------------------USER-ROLES-----------------------------
INSERT INTO public.user_roles (id_user, id_role) VALUES ( 4, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (13, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (14, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (15, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES ( 4, 1);
INSERT INTO public.user_roles (id_user, id_role) VALUES (18, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (19, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (20, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (21, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (22, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (23, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (24, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (25, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (26, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (27, 2);
INSERT INTO public.user_roles (id_user, id_role) VALUES (28, 2);
insert into public.user_roles (id_user, id_role) values ( 1, 1);
insert into public.user_roles (id_user, id_role) values ( 2, 2);
insert into public.user_roles (id_user, id_role) values ( 1, 3);
insert into public.user_roles (id_user, id_role) values ( 6, 1);
insert into public.user_roles (id_user, id_role) values ( 6, 2);



-------------------------------TWEETS------------------------------
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (1, 'srtjbjklenfsvd', '2017-05-10 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (2, 'dfjksnvjkdbasfnv;kldf;', '2017-05-10 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (3, 'dukfbvasdhklfbvkjwbadfkjlbv', '2017-05-10 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (4, 'rgsdfknv;jelsfbv;ieon', '2017-05-10 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (5, 'erfbvejwkfbv', '2017-05-10 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (6, 'rthdfbvjkewbfivdul', '2017-05-10 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (7, 'new tweet', '2017-05-10 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (8, 'sajdnfvjkasbjklbasb', '2017-05-12 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (9, 'New tweet', '2017-05-12 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (10, 'This tweet should be first', '2017-05-12 00:00:00.000000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (12, 'dfbhsaddgfn', '2017-05-12 11:02:16.911000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (13, 'This should be first tweet NOW', '2017-05-12 11:05:12.891000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (11, 'at this time it''s first tweet', '2017-05-12 11:05:32.254000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (14, 'bgadfhbsdfgnb', '2017-05-12 12:01:09.337000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (15, 'srtnhdfn', '2017-05-12 12:01:21.085000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (16, 'sdfnsasf', '2017-05-12 12:01:30.665000', 6);
INSERT INTO public.tweets (tweet_id, tweet_content, tweet_date, id_user) VALUES (17, 'sfvdgvkajs, v', '2017-05-12 12:04:58.981000', 6);

--------------------------USER FRIENDS-------------------
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (4, 6);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (4, 13);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (4, 14);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (13, 6);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (13, 14);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (13, 4);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (14, 6);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (14, 4);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 15);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 14);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 19);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 21);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 26);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 23);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 25);

