/*APPROACH--1 Decomposing Passenger table into Passenger and Routes Table that have primary keys and foriegn keys
which is related with Price table*/
/*Creating Database TRAVELONTHEGO And Using It*/
/*Schema or Database Creation, Usage and removal*/
create database if not exists `TravelOnTheGo`;
use `TravelOnTheGo`;
drop database if exists `travelonthego`;
/*-----------------------------------------------------------------------------------*/

/* 1) You are required to create two tables PASSENGER and PRICE with the following
attributes and properties*/
CREATE TABLE IF NOT EXISTS `PRICE` (
    Bus_Type VARCHAR(20) NOT NULL,
    Distance INT NOT NULL,
    Price INT NOT NULL,
    PRIMARY KEY (Distance , Bus_Type)
);

CREATE TABLE IF NOT EXISTS `ROUTES`(
Route_Id int primary key auto_increment,
Category VARCHAR(20) NOT NULL,
Boarding_City VARCHAR(50) NOT NULL,
Destination_City VARCHAR(50) NOT NULL,
Distance INT NOT NULL,
Bus_Type VARCHAR(20) NOT NULL,
foreign key(Distance,Bus_Type) references PRICE(Distance,Bus_Type)
);

CREATE TABLE IF NOT EXISTS `PASSENGER` (
Passenger_Id int primary key auto_increment,
Passenger_name VARCHAR(50) NOT NULL,
Gender VARCHAR(5) NOT NULL,
Route_Id int not null,
foreign key(Route_Id) references Routes(Route_Id)
);
/*-----------------------------------------------------------------------------------*/

/* 2) Insert the following data in the tables*/
INSERT INTO travelonthego.price (Bus_Type,Distance,Price) VALUES ("Sleeper", 350, 770);
INSERT INTO travelonthego.price VALUES ("Sleeper", 500, 1100);
INSERT INTO travelonthego.price VALUES ("Sleeper", 600, 1320);
INSERT INTO travelonthego.price VALUES ("Sleeper", 700, 1540);
INSERT INTO travelonthego.price VALUES ("Sleeper", 1000, 2200);
INSERT INTO travelonthego.price VALUES ("Sleeper", 1200, 2640);
INSERT INTO travelonthego.price VALUES ("Sleeper", 1500, 2700);
INSERT INTO travelonthego.price VALUES ("Sitting", 500, 620);
INSERT INTO travelonthego.price VALUES ("Sitting", 600, 744);
INSERT INTO travelonthego.price VALUES ("Sitting", 700, 868);
INSERT INTO travelonthego.price VALUES ("Sitting", 1000, 1240);
INSERT INTO travelonthego.price VALUES ("Sitting", 1200, 1488);
INSERT INTO travelonthego.price VALUES ("Sitting", 1500, 1860);

INSERT INTO travelOnTheGo.Routes(Route_Id,Category,Boarding_City,Destination_City,Distance,Bus_Type) VALUES 
(default,"AC","Bengaluru","Chennai",350,"Sleeper");
/*Query Involving Only Values And Strings Enclosed In Double Quotes*/
INSERT INTO travelOnTheGo.Routes VALUES (default,"Non-AC","Mumbai","Hyderabad",700,"Sitting");
/*Query Involving Only Values And Strings Enclosed In Single Quotes*/
INSERT INTO travelOnTheGo.Routes VALUES (default,'AC','Panaji', 'Bengaluru',600,'Sleeper');
INSERT INTO travelOnTheGo.Routes VALUES (default,'AC','Chennai','Mumbai',1500,'Sleeper');
INSERT INTO travelOnTheGo.Routes VALUES (default,'Non-AC','Trivandrum','panaji',1000,'Sleeper');
INSERT INTO travelOnTheGo.Routes VALUES (default,'AC','Nagpur','Hyderabad',500,'Sitting');
INSERT INTO travelOnTheGo.Routes VALUES (default,'Non-AC','panaji','Mumbai',700,'Sleeper');
INSERT INTO travelOnTheGo.Routes VALUES (default,'Non-AC','Hyderabad','Bengaluru',500,'Sitting');
INSERT INTO travelOnTheGo.Routes VALUES (default,'AC','Pune','Nagpur',700,'Sitting');

INSERT INTO travelonthego.Passenger(Passenger_Id,Passenger_Name,Gender,Route_Id) VALUES 
(default,"Sejal","F",1);
/*Query Involving Only Values And Strings Enclosed In Double Quotes*/
INSERT INTO travelonthego.Passenger VALUES (default,"Anmol","M",2);
/*Query Involving Only Values And Strings Enclosed In Single Quotes*/
INSERT INTO travelonthego.Passenger VALUES (default,'Pallavi','F',3);
INSERT INTO travelonthego.Passenger VALUES (default,'Khusboo','F',4);
INSERT INTO travelonthego.Passenger VALUES (default,'Udit','M',5);
INSERT INTO travelonthego.Passenger VALUES (default,'Ankur','M',6);
INSERT INTO travelonthego.Passenger VALUES (default,'Hemant','M',7);
INSERT INTO travelonthego.Passenger VALUES (default,'Manish','M',8);
INSERT INTO travelonthego.Passenger VALUES (default,'Piyush','M',9);
/*-----------------------------------------------------------------------------------*/

/* 3) How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/
select p.gender,count(p.gender) from TravelOnTheGo.Passenger p, TravelOnTheGo.Routes r where p.Route_Id=r.Route_Id and r.Distance>=600 
group by p.gender;
/*-----------------------------------------------------------------------------------*/

/* 4) Find the minimum ticket price for Sleeper Bus.*/
select pr.Bus_Type,min(pr.Price) as min_price from TravelOnTheGo.Price pr where pr.Bus_Type='Sleeper';
/*-----------------------------------------------------------------------------------*/

/* 5) Select passenger names whose names start with character 'S'*/
select  p.Passenger_name from TravelOnTheGo.Passenger p where p.Passenger_name LIKE 'S%';
/*-----------------------------------------------------------------------------------*/

/* 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/
select p.Passenger_name,r.Boarding_City,r.Destination_city,r.Bus_Type,pr.Price from TravelOnTheGo.Passenger p 
inner join TravelOnTheGo.Routes r ON p.Route_Id=r.Route_Id inner join TravelOnTheGo.Price pr on 
r.Distance=pr.Distance AND r.Bus_Type=pr.Bus_Type;
/*-----------------------------------------------------------------------------------*/

/* 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s*/
/*Assuming To Get All Passengers Who Have Travelled In Sitting Bus_Type for Distance within 1000 Kms*/
select p.Passenger_name,pr.price as ticket_price from TravelOnTheGo.Passenger p INNER JOIN TravelOnTheGo.Routes r 
ON p.Route_Id=r.Route_Id AND r.Distance<=1000 AND r.Bus_Type='Sitting' INNER JOIN TravelOnTheGo.Price pr ON 
r.Bus_Type=pr.Bus_Type AND r.Distance=pr.Distance;
/*Assuming To Get All Passengers Who Have Travelled In Sitting Bus_Type for Distance Exactly Equals 1000 Kms*/
select p.Passenger_name,pr.price as ticket_price from TravelOnTheGo.Passenger p INNER JOIN TravelOnTheGo.Routes r 
ON p.Route_Id=r.Route_Id AND r.Distance=1000 AND r.Bus_Type='Sitting' INNER JOIN TravelOnTheGo.Price pr ON 
r.Bus_Type=pr.Bus_Type AND r.Distance=pr.Distance;
/*-----------------------------------------------------------------------------------*/

/* 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/
select pr.Bus_Type,pr.price from TravelOnTheGo.Passenger p,TravelOnTheGo.Routes r,TravelOnTheGo.Price pr 
where p.passenger_name='Pallavi' AND p.Route_Id=r.Route_id AND r.Distance=pr.Distance;
/*-----------------------------------------------------------------------------------*/

/* 9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.*/
select distinct(Routes.Distance) as distances from TravelOnTheGo.Routes order by Routes.Distance desc;
/*-----------------------------------------------------------------------------------*/

/*10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/
SELECT p.Passenger_name, (r.Distance / (SELECT SUM(r.Distance) FROM TravelOnTheGo.Routes r)) * 100 AS 
percentage_of_distance FROM TravelOnTheGo.Passenger p INNER JOIN TravelOnTheGo.Routes r ON p.Route_Id=r.Route_id;
/*-----------------------------------------------------------------------------------*/

/*11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise  */
select pr.Distance as distance,pr.Price as price,
CASE
WHEN pr.Price>1000 THEN 'Expensive'
WHEN pr.price>500 and pr.Price<1000 THEN 'Average Cost'
Else 'Cheap Otherwise'
End as categories
from TravelOnTheGo.Price pr;
/*----------------------------------------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------------------------------------*/

/*APPROACH-3, Creating Entire Attributes of Passenger Table As Combination of primary key and enforcing foreign 
key that is primary key in Price table */
/*Creating Database TRAVELONTHEGO And Using It*/
create database if not exists `TravelOnTheGo`;
use `TravelOnTheGo`;
/*-----------------------------------------------------------------------------------*/

/* 1) You are required to create two tables PASSENGER and PRICE with the following
attributes and properties*/

create table if not exists TravelOnTheGo.`Price`(
Bus_Type varchar(20),
Distance int,
Price int,
primary key(Bus_Type,Distance)
);

create table if not exists TravelOnTheGo.`Passenger`(
Passenger_name varchar(50),
Category varchar(30),
Gender varchar(5),
Boarding_City varchar(50),
Destination_City varchar(50),
Distance int,
Bus_Type varchar(20),
primary key(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type),
foreign key(Bus_Type,Distance) references travelonthego.`price`(Bus_Type,Distance)
);

/*-----------------------------------------------------------------------------------*/

/* 2) Insert the following data in the tables*/
/*Inserting Data In Price Table*/
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 350, 770);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 500, 1100);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 600, 1320);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 700, 1540);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 1000, 2200);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 1200, 2640);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 1500, 2700);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 500, 620);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 600, 744);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 700, 868);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 1000, 1240);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 1200, 1488);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 1500, 1860);

/*Inserting Data In Passenger Table*/
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 700, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');
 /*----------------------------------------------------------------------------------------------------*/
 select * from TravelOnTheGo.`Passenger`;
 select * from TravelOnTheGo.`Price`;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->3 How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/
select p.gender,count(p.gender) from travelonthego.passenger p where p.distance>=600 group by (p.Gender);
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->4 Find the minimum ticket price for Sleeper Bus.*/
select pr.Bus_Type,min(pr.price) as minimum_ticket_price from travelonthego.price pr where pr.Bus_Type='Sleeper';
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->5 Select passenger names whose names start with character 'S'*/
select p.Passenger_name as passenger_names from travelonthego.passenger p where p.Passenger_name like 'S%';
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->6 Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/
select p.Passenger_name,p.Boarding_city,p.Destination_city,p.Bus_type,pr.Price from travelonthego.passenger p,
travelonthego.price pr where p.Bus_type=pr.Bus_type and p.Distance=pr.Distance group by p.Passenger_name;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->7 What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s*/
/*Assuming To Get All Passengers Who Have Travelled In Sitting Bus_Type for Distance within 1000 Kms*/
select p.Passenger_name,pr.price as ticket_price from TravelOnTheGo.Passenger p, travelonthego.price pr
where p.Bus_Type='Sitting' and p.Distance<=1000 and p.Bus_Type=pr.Bus_Type
and p.Distance=pr.Distance group by p.Passenger_name;
/*Assuming To Get All Passengers Who Have Travelled In Sitting Bus_Type for Distance Exactly Equals 1000 Kms*/
select p.Passenger_name,pr.price as ticket_price from TravelOnTheGo.Passenger p, travelonthego.price pr
where p.Bus_Type='Sitting' and p.Distance=1000 and p.Bus_Type=pr.Bus_Type
and p.Distance=pr.Distance group by p.Passenger_name;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->8 What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/
select pr.Bus_Type,pr.Price from passenger p, price pr where p.Passenger_name='Pallavi'
and p.Distance=pr.Distance group by pr.Bus_Type;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->9 List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.*/
select p.Distance as distances from travelonthego.passenger p group by p.Distance order by p.Distance desc;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->10 Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/

SELECT p.Passenger_name, (p.Distance / (SELECT SUM(p.Distance) FROM TravelOnTheGo.passenger p)) * 100 AS 
percentage_of_distance FROM TravelOnTheGo.Passenger p;
/*----------------------------------------------------------------------------------------------------*/
/*Answer-->11 Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/

select pr.Distance as distance,pr.Price as price,
CASE
WHEN pr.Price>1000 THEN 'Expensive'
WHEN pr.price>500 and pr.Price<1000 THEN 'Average Cost'
Else 'Cheap Otherwise'
End as categories
from TravelOnTheGo.Price pr;
/*----------------------------------------------------------------------------------------------------------*/

/*APPROACH-2  Assuming exactly the table structure given in problem statement, without any primary/foreign keys*/
/*Creating Database TRAVELONTHEGO And Using It*/
create database if not exists `TravelOnTheGo`;
use `TravelOnTheGo`;
drop database if exists `travelonthego`;
/*-----------------------------------------------------------------------------------*/

/* 1) You are required to create two tables PASSENGER and PRICE with the following
attributes and properties*/
create table if not exists TravelOnTheGo.`Passenger`(
Passenger_name varchar(50),
Category varchar(30),
Gender varchar(5),
Boarding_City varchar(50),
Destination_City varchar(50),
Distance int,
Bus_Type varchar(20)
);

create table if not exists TravelOnTheGo.`Price`(
Bus_Type varchar(20),
Distance int,
Price int
);
/*-----------------------------------------------------------------------------------*/

/* 2) Insert the following data in the tables*/
/*Inserting Data In Price Table*/
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 350, 770);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 500, 1100);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 600, 1320);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 700, 1540);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 1000, 2200);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 1200, 2640);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sleeper', 1500, 2700);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 500, 620);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 600, 744);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 700, 868);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 1000, 1240);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 1200, 1488);
insert into TravelOnTheGo.`Price`(Bus_Type,Distance,Price) values('Sitting', 1500, 1860);

/*Inserting Data In Passenger Table*/
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Sejal', 'AC', 'F', 'Bengaluru', 'Chennai', 350, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Anmol', 'Non-AC', 'M', 'Mumbai', 'Hyderabad', 700, 'Sitting');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Pallavi', 'AC', 'F', 'Panaji', 'Bengaluru', 600, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Khusboo', 'AC', 'F', 'Chennai', 'Mumbai', 1500, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Udit', 'Non-AC', 'M', 'Trivandrum', 'panaji', 1000, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Ankur', 'AC', 'M', 'Nagpur', 'Hyderabad', 500, 'Sitting');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Hemant', 'Non-AC', 'M', 'panaji', 'Mumbai', 700, 'Sleeper');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Manish', 'Non-AC', 'M', 'Hyderabad', 'Bengaluru', 500, 'Sitting');
insert into TravelOnTheGo.`Passenger`(Passenger_name,Category,Gender,Boarding_City,Destination_City,Distance,Bus_Type)
 values('Piyush', 'AC', 'M', 'Pune', 'Nagpur', 700, 'Sitting');
 /*----------------------------------------------------------------------------------------------------*/
 select * from TravelOnTheGo.`Passenger`;
 select * from TravelOnTheGo.`Price`;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->3 How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/
select p.gender,count(p.gender) from travelonthego.passenger p where p.distance>=600 group by (p.Gender);
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->4 Find the minimum ticket price for Sleeper Bus.*/
select pr.Bus_Type,min(pr.price) as minimum_ticket_price from travelonthego.price pr where pr.Bus_Type='Sleeper';
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->5 Select passenger names whose names start with character 'S'*/
select p.Passenger_name as passenger_names from travelonthego.passenger p where p.Passenger_name like 'S%';
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->6 Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output*/
select p.Passenger_name,p.Boarding_city,p.Destination_city,p.Bus_type,pr.Price from travelonthego.passenger p,
travelonthego.price pr where p.Bus_type=pr.Bus_type and p.Distance=pr.Distance group by p.Passenger_name;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->7 What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s*/
/*Assuming To Get All Passengers Who Have Travelled In Sitting Bus_Type for Distance within 1000 Kms*/
select p.Passenger_name,pr.price as ticket_price from TravelOnTheGo.Passenger p, travelonthego.price pr
where p.Bus_Type='Sitting' and p.Distance<=1000 and p.Bus_Type=pr.Bus_Type
and p.Distance=pr.Distance group by p.Passenger_name;
/*Assuming To Get All Passengers Who Have Travelled In Sitting Bus_Type for Distance Exactly Equals 1000 Kms*/
select p.Passenger_name,pr.price as ticket_price from TravelOnTheGo.Passenger p, travelonthego.price pr
where p.Bus_Type='Sitting' and p.Distance=1000 and p.Bus_Type=pr.Bus_Type
and p.Distance=pr.Distance group by p.Passenger_name;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->8 What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/
select pr.Bus_Type,pr.Price from passenger p, price pr where p.Passenger_name='Pallavi'
and p.Distance=pr.Distance group by pr.Bus_Type;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->9 List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.*/
select p.Distance as distances from travelonthego.passenger p group by p.Distance order by p.Distance desc;
/*----------------------------------------------------------------------------------------------------*/

/*Answer-->10 Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/

SELECT p.Passenger_name, (p.Distance / (SELECT SUM(p.Distance) FROM TravelOnTheGo.passenger p)) * 100 AS 
percentage_of_distance FROM TravelOnTheGo.Passenger p;
/*----------------------------------------------------------------------------------------------------*/
/*Answer-->11 Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise*/

select pr.Distance as distance,pr.Price as price,
CASE
WHEN pr.Price>1000 THEN 'Expensive'
WHEN pr.price>500 and pr.Price<1000 THEN 'Average Cost'
Else 'Cheap Otherwise'
End as categories
from TravelOnTheGo.Price pr;
/*----------------------------------------------------------------------------------------------------------*/
