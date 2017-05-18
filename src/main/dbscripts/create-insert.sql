
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
	password varchar(60) not null,
	email varchar(50) unique not null,
	first_name varchar(32) not null,
	last_name varchar(32) not null,
	enabled boolean default true,
	image VARCHAR(150)
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
	id_user int not null references users(user_id),
	retweet_id int not null REFERENCES tweets(tweet_id),
	is_comment BOOLEAN DEFAULT FALSE
);

-- create table tweet_comments(
-- 	tweet_comment_id serial primary key,
-- 	id_tweet int not null references tweets(tweet_id),
-- 	comment_content varchar(140) not null,
-- 	comment_date timestamp not null
-- );

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
insert into public.users (username, password, email, first_name, last_name, enabled, image) values ('stas', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'stas@mail.ru', 'Stas', 'Bogdanschi', true, null);
insert into public.users (username, password, email, first_name, last_name, enabled, image) values ('peter', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.','patrick@mail.ru', 'Peter', 'Panfilov',true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'sxdcfhbjknl', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'jhebfjkndl2efjkb@jkb2.jnj', 'vbnm', 'fghjkl', true, NULL );
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'erklfjvndskjvn', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', '12@mail.ru', 'bkfgdbkj', 'mkl;gbmwjkbl', true, NULL );
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'newuser', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'sdhbcjk@jksdfn.ds', 'user', 'user', true, NULL );
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'bejkjsdfjb', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'bvsdjk@jhsg.ru', 'fjhdfjksb', 'hiwergbisejkb', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'dmn', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'sdfhndf@djksf.tu', 'dfsg', 'sdfg', true, NULL );
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'dfhbdjka', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'jhasdbfjas@dfjk.ru', 'jkdfngjkasdbji', 'JHESNGJKJIdf', true, NULL );
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'sdfhg', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'sfdj@mail.ru', 'sdfh', 'sdfh', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'ghcghvhgkl1', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'ghhg@hjsdbjh.ru', 'qwegrjhvjh', 'ghchgcjk', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'kdfjhgjk', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'jhvjh@mail.ru', '123jhkh', '2gjkv2ghj', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'sdg2', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'erg@mail.ru', 'wer2', '5234vwe', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ('1123fd', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'dsgsd', 'dfsg2', 'fd2', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'fgh', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'dsg@mail.ru', 'jk1j', '233qw', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'dfg', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'sdfjk@djks.ru', 'jhvbjhv1', '1ghvjh1', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ('rgbwerfv', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', '1234@mail.ru', 'qwe', 'erfgew', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ('testtes', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', '4321@mail.ru', 'stas', 'stas', true, null);
INSERT INTO public.users (username, password, email, first_name, last_name, enabled, image) VALUES ( 'fgv121', '$2a$10$PZj/LoJPDO5pYugt7LYev.FajQ014Xpj7i50rzDHY4XbYSwfv.NX.', 'asdfc@mail.ru', 'jkhasdfb', 'gkjh', true, null);



-----------------------USER-ROLES-----------------------------
INSERT INTO public.user_roles (id_user, id_role) VALUES ( 1, 1);
INSERT INTO public.user_roles (id_user, id_role) VALUES ( 2, 3);

-------------------------------TWEETS------------------------------
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ('srtjbjklenfsvd', '2017-05-10 00:00:00.000000', 11, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ('dfjksnvjkdbasfnv;kldf;', '2017-05-10 00:00:00.000000', 17, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ('dukfbvasdhklfbvkjwbadfkjlbv', '2017-05-10 00:00:00.000000', 6, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ('rgsdfknv;jelsfbv;ieon', '2017-05-10 00:00:00.000000', 6, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ('erfbvejwkfbv', '2017-05-10 00:00:00.000000', 6, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ('rthdfbvjkewbfivdul', '2017-05-10 00:00:00.000000', 3, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ('new tweet', '2017-05-10 00:00:00.000000', 6, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ('sajdnfvjkasbjklbasb', '2017-05-12 00:00:00.000000', 4, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ('New tweet', '2017-05-12 00:00:00.000000', 7, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ( 'This tweet should be first', '2017-05-12 00:00:00.000000', 6, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ( 'dfbhsaddgfn', '2017-05-12 11:02:16.911000', 2, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ( 'This should be first tweet NOW', '2017-05-12 11:05:12.891000', 4, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ( 'at this time it''s first tweet', '2017-05-12 11:05:32.254000', 8, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ( 'bgadfhbsdfgnb', '2017-05-12 12:01:09.337000', 15, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ( 'srtnhdfn', '2017-05-12 12:01:21.085000', 6, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ( 'sdfnsasf', '2017-05-12 12:01:30.665000', 9, NULL, false);
INSERT INTO public.tweets (tweet_content, tweet_date, id_user, retweet_id, is_comment) VALUES ( 'sfvdgvkajs, v', '2017-05-12 12:04:58.981000', 13, NULL , false);

--------------------------USER FRIENDS-------------------
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (4, 6);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (4, 13);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (4, 9);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (13, 6);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (13, 14);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (13, 4);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (12, 6);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (14, 4);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 15);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 14);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (3, 15);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (5, 8);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 11);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (5, 11);
INSERT INTO public.user_friends (user_1_id, user_2_id) VALUES (6, 17);

