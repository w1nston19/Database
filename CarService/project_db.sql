DROP TABLE IF EXISTS booking;
DROP TABLE IF EXISTS partition_order_history;
DROP TABLE IF EXISTS partition_order_parts_mapping;
DROP TABLE IF EXISTS partition_order;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS owner;
DROP TABLE IF EXISTS manufacturer;
DROP TABLE IF EXISTS vehicle;
DROP TABLE IF EXISTS worker;
DROP TABLE IF EXISTS repairment_order;


 
 /*MANUFACTURER*/

CREATE TABLE manufacturer (
  id int NOT NULL,
  name varchar(45) NOT NULL,
  manufacturer_rating tinyint DEFAULT NULL,
  PRIMARY KEY (id),
  CHECK (manufacturer_rating >=0 AND manufacturer_rating<=10)
) 

INSERT INTO manufacturer (id, name, manufacturer_rating) VALUES (1,'Dodge',4),(2,'BMW',9),(3,'Mercury',3),(4,'Bentley',8),(5,'GMC',2),(6,'Dodge',5),(7,'Kia',10),(8,'Volkswagen',9),(9,'Mitsubishi',3),(10,'Dodge',7),(11,'Audi',8),(12,'Mazda',5),(13,'Audi',3),(14,'Oldsmobile',4),(15,'Volvo',6),(16,'Volkswagen',8),(17,'Buick',8),(18,'Suzuki',3),(19,'Mercury',9),(20,'Saab',8),(21,'Toyota',2),(22,'Nissan',1),(23,'Chevrolet',3),(24,'Toyota',1),(25,'Smart',7),(26,'Pontiac',6),(27,'Chevrolet',7),(28,'Lexus',4),(29,'Lotus',9),(30,'Lincoln',9);
/*WORKER*/

CREATE TABLE worker (
  id int NOT NULL,
  name varchar(45) NOT NULL,
  salary int NOT NULL,
  PRIMARY KEY (id),
  CHECK (salary >= 650)
) 
INSERT INTO worker (id, name, salary) VALUES (1,'Marian Ognyanov', 750),(2,'Dimitur Valentinov', 1050),(3,'Simeon Damyanski', 1300),(4, 'Atanas Simeonov',1250),(5,'Valentin Ivanov',690),(6,'Martin Petrov',1550),(7,'Vladimir Ivanov',1200),(8,'Atanas Koychev',1400),(9, 'Stefan Dimitrov',920),(10,'Martin Kirilov',800),(11,'Kalin Kamenov',1050),(12,'Dimitur Yonov', 1240),(13,'Milen Dimitrov',2100),(14,'Ivan Shumenov',1320),(15,'Mihail Stanchev',1455),(16,'Ivan Aleksandrov',1410),(17,'Cvetomir Kirilov',1600),(18,'Denis Adrianov',750),(19,'Anton Aleksandrov',1800),(20,'Nikolai Dimitrov',2100),(21,'Ivelin Vasilev',1300),(22,'Kamen Krustev',1200),(23,'Mihaela Staneva',950),(24,'Radostin Danchev',1650),(25,'Velizar Milchev',1950),(26,'Victoria Traykova',800),(27,'Lubomir Mihaylov',1100),(28,'Denislav Mladenov',900),(29,'Daniel Makov',700),(30,'Stanislav Arikov',1360);
/* Ne znaeh dali da ostavq tezi ili da napisha novi no za vseki sluchai tezi sum gi ostavil
1,'Rodie Hirjak',1274),(2,'Fielding Dooher',683),(3,'Concettina Grushin',607),(4,'Rozamond Dring',781),(5,'Miles Marion',516),(6,'Pietra Straniero',1620),(7,'Elna MacAvaddy',703),(8,'Benedicta Say',1546),(9,'Sebastiano Tomsen',734),(10,'Dniren Pedrol',656),(11,'Alexander Pipworth',922),(12,'Amberly Grzesiewicz',1020),(13,'Kenna Ledrun',1034),(14,'Bekki Pitford',994),(15,'Leese Whellams',1929),(16,'Bram Deek',502),(17,'Odell Norcock',965),(18,'Sheeree Chatenet',663),(19,'Dory Deehan',766),(20,'Bank Bremond',1509),(21,'Myca McCloughen',1556),(22,'Ynez Coggins',538),(23,'Oliy Weems',798),(24,'Willie Chaffe',857),(25,'Barrett Nehl',1229),(26,'Elke Faircley',752),(27,'Addy Maas',1679),(28,'Christiana McGiveen',1017),(29,'Dom MacDiarmond',1372),(30,'Zorine Pond-Jones',584);
*/
/*OWNER*/

CREATE TABLE owner (
  id int NOT NULL IDENTITY,
  name varchar(45) NOT NULL,
  age int NOT NULL,
  gender varchar(45) DEFAULT NULL,
  PRIMARY KEY (id),
  CHECK (age >= 18)
) 

SET IDENTITY_INSERT owner ON
INSERT INTO owner (id,name, age, gender) VALUES (1,'Marjorie Glanville',67,'Female'),(2,'Anthe Hearfield',74,'Female'),(3,'Eolanda Teresse',18,'Female'),(4,'Dilly Chafer',67,'Male'),(5,'Chrystal Scoines',62,'Female'),(6,'Aluino MacLise',63,'Male'),(7,'Arleen Blankman',64,'Female'),(8,'Cherish Symcock',29,'Female'),(9,'Winthrop Taverner',69,'Male'),(10,'Fredra Morffew',18,'Female'),(11,'Corbin Teaser',18,'Male'),(12,'Barbabas Rubi',89,'Male'),(13,'Shay Wynrehame',18,'Female'),(14,'Kim Garretson',18,'Male'),(15,'Mariann Onion',29,'Female'),(16,'Cornie Rosini',47,'Female'),(17,'Felizio Prover',18,'Male'),(18,'Dorthea Gard',18,'Female'),(19,'Nev Leebeter',50,'Male'),(20,'Cesya Hazeup',18,'Female'),(21,'Sandra Alleyn',18,'Female'),(22,'Bert Lamy',98,'Male'),(23,'Gizela Kruszelnicki',88,'Female'),(24,'Lurette Kaser',18,'Female'),(25,'Tobie Locks',69,'Male'),(26,'Mirabelle Ratlee',19,'Female'),(27,'Cecilia Trebble',46,'Female'),(28,'Halette Teresia',89,'Female'),(29,'Twila Schwand',47,'Female'),(30,'Thedrick Overill',38,'Male');
SET IDENTITY_INSERT owner OFF

/* VEHICLE */

CREATE TABLE vehicle (
  id int NOT NULL IDENTITY,
  model varchar(45) NOT NULL,
  manufacturer_id int NOT NULL,
  owner_id int DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX ownerId_idx (owner_id),
  INDEX manufacturer_id_idx (manufacturer_id),
  INDEX manufacturerId_idx (manufacturer_id),
  CONSTRAINT manufacturerId FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (id),
  CONSTRAINT ownerId FOREIGN KEY (owner_id) REFERENCES owner (id)
) 

SET IDENTITY_INSERT vehicle ON 
INSERT INTO vehicle (id, manufacturer_id, model ,owner_id) VALUES (1,19, 'Sable' ,10),(2,14, 'Bravada' ,22),(3,27, 'Traverse' ,9),(4,14,'Cutlass',14),(5,7,'Sorento',14),(6,10,'Durango',22),(7,14,'Aurora',18),(8,21,'Sienna',3),(9,24,'Supra',26),(10,29,'Esprit',19),(11,28,'UX',18),(12,19,'Milan',19),(13,17,'Lucerne',12),(14,13,'A6',7),(15,5,'Envoy',22),(16,10,'Dakota',16),(17,1,'Magnum',2),(18,15,'C30',27),(19,14,'Intrigue',26),(20,18,'Ciaz',29),(21,18,'Ertiga',13),(22,7,'Carens',9),(23,26,'G8',12),(24,11,'Q3',20),(25,28,'CT',22),(26,10,'Intrepid',2),(27,16,'Passat',20),(28,14,'442',29),(29,30,'Nautilus',23),(30,3,'Cougar',2);

SET IDENTITY_INSERT vehicle OFF
/*PARTS*/

CREATE TABLE parts (
  id int NOT NULL,
  name varchar(45) DEFAULT NULL,
  manufacturer_id int NOT NULL,
  price int NOT NULL,
  replacement_price int NOT NULL,
  PRIMARY KEY (id),
  INDEX manufacturer_id_idx (manufacturer_id),
  CONSTRAINT manufacturer_id FOREIGN KEY (manufacturer_id) REFERENCES manufacturer (id),
) 

INSERT INTO parts (id, name, manufacturer_id, price, replacement_price) VALUES (1,'Mirrors',11,379,542),(2,'Lights',17,249,551),(3,'Hoods',23,304,583),(4,'Computer',18,381,522),(5,'GPS',9,224,569),(6,'Tires',17,201,567),(7,'Door',2,355,570),(8,'Radiator',18,259,587),(9,'Airbag',8,341,556),(10,'Engine',30,444,575);


/*REPAIRMENT ORDER*/

CREATE TABLE repairment_order (
  id int NOT NULL IDENTITY,
  message varchar(45) NOT NULL,
  worker_id int NOT NULL,
  vehicle_id int NOT NULL,
  PRIMARY KEY (id),
  INDEX workerId_idx (worker_id),
  INDEX vehicleIdss_idx (vehicle_id),
  CONSTRAINT vehicleIdss FOREIGN KEY (vehicle_id) REFERENCES vehicle (id),
  CONSTRAINT workerId FOREIGN KEY (worker_id) REFERENCES worker (id)
)
SET IDENTITY_INSERT repairment_order ON
INSERT INTO repairment_order (id, message, worker_id, vehicle_id) VALUES (1,'Repair Sweetheart',13,21),(2,'Woman 100 crash repair',19,1),(3,'Money Order',1,27),(4,'My order',3,16),(5,'Dude Car',7,8),(6,'Mitsu',24,8),(7,'Latlux',26,19),(8,'Alphazap',27,28),(9,'Alpha',10,10),(10,'Ventosanzap',29,15);
SET IDENTITY_INSERT repairment_order OFF
/*BOOKING*/

CREATE TABLE booking (
	repairment_order_id int NOT NULL,
	start_date datetime NOT NULL,
	end_date datetime NOT NULL,
	PRIMARY KEY (repairment_order_id),
	INDEX reparimentOrderId_idx (repairment_order_id),
	CONSTRAINT reparimentOrderId FOREIGN KEY (repairment_order_id) REFERENCES repairment_order (id)
) 

INSERT INTO booking (repairment_order_id,start_date,end_date) VALUES (1,'2022-06-12 23:46:49','2022-08-23 21:02:09'),(2,'2022-06-12 17:40:45','2022-01-20 13:01:37'),(3,'2022-06-29 20:32:46','2022-06-09 01:42:25'),(5,'2022-06-10 03:39:07','2021-10-04 04:05:53'),(4,'2022-05-27 19:55:37','2021-08-24 03:30:47'),(7,'2022-05-31 15:02:27','2022-01-16 19:19:21'),(6,'2022-06-26 03:51:02','2021-12-24 08:57:05'),(8,'2022-06-06 20:38:29','2022-07-23 12:53:30'),(9,'2022-06-05 13:54:59','2021-07-25 23:39:36'),(10,'2022-06-14 03:04:03','2021-12-05 17:11:42');

/*PARTITION ORDER*/

CREATE TABLE partition_order (
  id int NOT NULL IDENTITY,
  message varchar(45) DEFAULT NULL,
  owner_id int NOT NULL,
  PRIMARY KEY (id),
  INDEX ownerId_idx (owner_id),
  CONSTRAINT ownerIds FOREIGN KEY (owner_id) REFERENCES owner (id)
) 

SET IDENTITY_INSERT partition_order ON
INSERT INTO partition_order (id, message, owner_id) VALUES (1,'Spirtow Order',26),(2,'Gift',28),(3,'For Sam',30),(4,'For Nelly',27),(5,'Maria',8),(6,'Sons first car upgrade',1),(7,'Kaboom',30),(8,'For my sweet car',2),(9,'First Order for enhancement',4),(10,'Pannier',3);
SET IDENTITY_INSERT partition_order OFF
/*PARTITION ORDER HISTORY*/

CREATE TABLE partition_order_history (
  partition_order_id int NOT NULL,
  updated_on datetime DEFAULT NULL,
  is_completed tinyint NOT NULL,
  PRIMARY KEY (partition_order_id),
  INDEX orderForPartsIds_idx (partition_order_id),
  CONSTRAINT partitionOrderId FOREIGN KEY (partition_order_id) REFERENCES partition_order (id)
) 

INSERT INTO partition_order_history (partition_order_id, updated_on, is_completed) VALUES (10,'2022-05-10 04:05:40',0),(7,'2022-05-18 20:20:38',0),(8,'2022-05-14 17:41:58',0),(1,'2022-05-09 10:10:47',0),(5,'2022-05-27 11:35:06',1),(3,'2022-05-17 09:00:13',1),(9,'2022-05-08 13:04:11',0),(4,'2022-05-03 13:10:50',0),(2,'2022-05-23 00:50:54',1),(6,'2022-05-20 00:09:49',0);


/*PARTITION ORDER PARTS MAPPING*/

CREATE TABLE partition_order_parts_mapping (
  part_id int DEFAULT NULL,
  order_id int DEFAULT NULL,
  INDEX partIds_idx (part_id),
  INDEX orderIds_idx (order_id),
  CONSTRAINT orderIds FOREIGN KEY (order_id) REFERENCES partition_order (id),
  CONSTRAINT partIds FOREIGN KEY (part_id) REFERENCES parts (id)
) 

INSERT INTO partition_order_parts_mapping (part_id, order_id) VALUES (9,5),(9,8),(5,6),(1,8),(1,2),(3,8),(1,10),(6,6),(8,3),(8,2),(3,7),(6,3),(7,7),(3,4),(9,6),(8,1),(4,5),(4,10),(2,3),(8,8),(1,8),(9,3),(7,8),(3,10),(3,9),(10,4),(4,6),(6,8),(4,5),(4,10);
