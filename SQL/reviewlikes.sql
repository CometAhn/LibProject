CREATE TABLE IF NOT EXISTS reviewlikes(
   id int NOT NULL auto_increment,
   review_id int not null,
   login_lid VARCHAR(10) NOT NULL,
   PRIMARY KEY (id)
)default CHARSET=utf8;

Select * from reviewlikes;