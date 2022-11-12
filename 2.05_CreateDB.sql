-- some Data Definition Language Commands - creating your own DB

-- create DB
create database if not exists bank_demo;

use bank_demo;

-- create tables (table with only primary key)
drop table if exists district_demo;

CREATE TABLE district_demo (
  `A1` int UNIQUE NOT NULL, -- AS PRIMARY KEY
  `A2` char(20) DEFAULT NULL,
  `A3` varchar(20) DEFAULT NULL, -- char() , varchar(255)
  `A4` int DEFAULT NULL,
  `A5` int DEFAULT NULL,
  `A6` int DEFAULT NULL,
  `A7` int DEFAULT NULL,
  `A8` int DEFAULT NULL,
  `A9` int DEFAULT NULL,
  `A10` float DEFAULT NULL,
  `A11` int DEFAULT NULL,
  `A12` float DEFAULT NULL,
  `A13` float DEFAULT NULL,
  `A14` int DEFAULT NULL,
  `A15` int DEFAULT NULL,
  `A16` int DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (A1)  -- constraint keyword is optional but its a good practice
);
-- check about deprecation of integer length.

select * from district_demo;

-- create a table (table with foreign key)
drop table if exists account_demo;

CREATE TABLE account_demo (
  account_id int UNIQUE NOT NULL,
  district_id int DEFAULT NULL,
  frequency text,
  date int DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (account_id),
  CONSTRAINT FOREIGN KEY (district_id) REFERENCES district_demo(A1)
) ;

select * from account_demo;

-- populating tables
insert into district_demo
values (1,'Hl.m. Praha','Prague',1204953,0,0,0,1,1,100,12541,0.29,0.43,167,85677,99107),
(2,'Benesov','central Bohemia',88884,80,26,6,2,5,46.7,8507,1.67,1.85,132,2159,2674),
 (3,'Beroun','central Bohemia',75232,55,26,4,1,5,41.7,8980,1.95,2.21,111,2824,2813),
 (4,'Kladno','central Bohemia',149893,63,29,6,2,6,67.4,9753,4.64,5.05,109,5244,5892);
 
delete from district_demo;

-- you can also import from a file here
LOAD DATA INFILE '/var/lib/mysql-files/entries.csv' 
INTO TABLE bank_demo.district_demo
FIELDS TERMINATED BY ',';
-- the first time I ran I got an error, had to change some settings:
-- Step 1
show variables like 'local_infile';
set global local_infile = 1;
-- Step 2
show variables like 'secure_file_priv'; -- this gives you the path you need to save the .csv to
-- Step 3
set sql_safe_updates = 0;
-- you can also import from a file by right clicking the respective table and selecting Table Data Import Wizard
 
select * from bank_demo.account_demo;
 
 
-- testing constraints 
insert into account_demo values
(1,4,'POPLATEK MESICNE',950324),
(2,1,'POPLATEK MESICNE',930226),
(2,2,'POPLATEK MESICNE',970707); -- no '5' in district_demo

delete from account_demo;

-- drop column
alter table district_demo
drop column A15;
select * from district_demo;

-- rename table
alter table account_demo
rename to accountDemo;

-- rename column
alter table accountDemo
rename column date to calendar_date;
select * from accountDemo;

-- change to 'date' type
alter table accountDemo
modify calendar_date date;
select * from accountDemo;

-- add new column
alter table accountDemo
add column balance_total int; -- optional 'after calendar_date'

update accountDemo 
set frequency='some czech word'
where frequency='POPLATEK MESICNE';


-- some Data Manipulation Language Commands

-- deletes the record where the condition is met
delete from accountDemo where account_id = 1;

-- deletes all the contents from the table without deleting the table
delete from accountDemo;
delete from district_demo;
-- DELETE only removes the contents of the table, while the DROP command removes the table from the database.