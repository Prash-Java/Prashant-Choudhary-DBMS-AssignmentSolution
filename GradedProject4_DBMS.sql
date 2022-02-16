/*Creating Database TRAVELONTHEGO And Using It*/
create database if not exists `TravelOnTheGo`;
use `TravelOnTheGo`;
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