# create database
create database if not exists librarydb;

use librarydb;

# create table
CREATE TABLE IF NOT EXISTS booklist(
	bid int NOT NULL auto_increment,
	title VARCHAR(20),
	writer VARCHAR(20),
	description TEXT,
   	category VARCHAR(20),
	publisher VARCHAR(20),
	stock LONG,
	book_cover  VARCHAR(20),
	date VARCHAR(20),
	PRIMARY KEY (bid)
)default CHARSET=utf8;

create table Cart ( 
	id int NOT NULL auto_increment,
	login_lid varchar(10) not null,
	library_bid int NOT NULL,
   PRIMARY KEY (id)
) default CHARSET=utf8;

create table if not exists loan( 
	id int NOT NULL auto_increment,
    login_lid varchar(10) NOT NULL,
	library_bid int NOT NULL,
    start_date  varchar(20) NOT NULL,
    return_date varchar(20),
    end_date  varchar(20) NOT NULL,
	period int,
    status boolean not null,
   reviewed boolean not null default 0,
   PRIMARY KEY (id)
) default CHARSET=utf8;

create table Login ( 
    lid varchar(10) not null,
    password varchar(40) not null,
    password_key varchar(10) not null,
    token varchar(15) not null default 0,
    name varchar(10) not null,
    gender varchar(4),
    birth  varchar(10),
    email  varchar(30),
    phone varchar(20),
    address varchar(90),
    address_detail varchar(90),
    regist_day varchar(50), 
    grade boolean not null default 0,
    used boolean not null default 1,
    overdue varchar(20), 
    review_count int not null default 0,
    loan_count int not null default 0,
    emailkey varchar(10),
    checked boolean not null default 0,
    temppw boolean default 0,
    primary key(lid) 
) default CHARSET=utf8;

create table if not exists recommend(
	id int NOT NULL auto_increment,
	library_bid int NOT NULL,
    month int not null,
   PRIMARY KEY (id)
) default CHARSET=utf8;

CREATE TABLE IF NOT EXISTS review(
   id int NOT NULL auto_increment,
   login_lid VARCHAR(10) NOT NULL,
   library_bid int not null,
   loan_id int not null,
   title VARCHAR(20),
   contents VARCHAR(20),
   date VARCHAR(20),
   score int,
   PRIMARY KEY (id)
)default CHARSET=utf8;

#create fk
-- cart fk
alter table cart add foreign key(login_lid) references login( lid )on delete cascade;
alter table cart add foreign key(library_bid) references booklist( bid )on delete cascade;

-- loan fk
alter table loan add foreign key(login_lid) references login( lid )on delete cascade;
alter table loan add foreign key(library_bid) references booklist( bid )on delete cascade;

-- recommend fk
alter table recommend add foreign key(library_bid) references booklist( bid )on delete cascade;

-- review fk
alter table review add foreign key(login_lid) references login( lid )on delete cascade;
alter table review add foreign key(library_bid) references booklist( bid )on delete cascade;
alter table review add foreign key(loan_id) references loan( id )on delete cascade;

# create data
-- book
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목1', '작가1', '내용1', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목2', '작가2', '내용2', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목3', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목4', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목5', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목6', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목7', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목8', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목9', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목10', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목11', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목12', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목13', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목14', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목15', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목16', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목17', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목18', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목19', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());
insert into booklist(Title, Writer, description, category, publisher, stock, book_cover, date) values('제목20', '작가', '내용', '분류', '출판사', 5, '/img/banner_1.jpg', CURRENT_TIMESTAMP());

# recommend
insert into recommend(month, library_bid) values(9, 3);
insert into recommend(month, library_bid) values(9, 7);
insert into recommend(month, library_bid) values(9, 14);
insert into recommend(month, library_bid) values(10, 4);
insert into recommend(month, library_bid) values(10, 7);
insert into recommend(month, library_bid) values(10, 15);


# id : admin | pw : 1
insert into login(lid, password, password_key, name, gender, birth, email, phone, address, address_detail, regist_day, grade, used, checked, temppw) values('admin','562be3445d93d0121c585d7e7c382d738f80a140','4svTH7r','김이름','남','2010/10/10','admin@ipi.pw', '010-0000-0000','주소','상세주소', CURRENT_TIMESTAMP(), 1, 1,1,0);
