-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: hosteldb
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `complaint`
--

DROP TABLE IF EXISTS `complaint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complaint` (
  `complaint_id` int NOT NULL,
  `roll_no` int NOT NULL,
  `description` varchar(400) DEFAULT NULL,
  `registered_date` date NOT NULL,
  `resolved_date` date DEFAULT '2099-01-01',
  PRIMARY KEY (`complaint_id`,`roll_no`),
  KEY `fk_student_complaint` (`roll_no`),
  CONSTRAINT `fk_student_complaint` FOREIGN KEY (`roll_no`) REFERENCES `student` (`roll_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complaint`
--

LOCK TABLES `complaint` WRITE;
/*!40000 ALTER TABLE `complaint` DISABLE KEYS */;
INSERT INTO `complaint` VALUES (1,3,'test','2021-04-28','2025-01-01');
/*!40000 ALTER TABLE `complaint` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `complaint_in` BEFORE INSERT ON `complaint` FOR EACH ROW begin
declare r int;
    declare i int;
    set new.registered_date=curdate();
set r=new.roll_no;
    set i=(select complaint_id from complaint where roll_no=r order by complaint_id desc limit 1);
    if(isnull(i)) then set i=0;
    end if;
    set new.complaint_id=i+1;    
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `chk_st_comp` BEFORE INSERT ON `complaint` FOR EACH ROW begin  
      if  (select year from student where roll_no=new.roll_no)='0' then
       SIGNAL SQLSTATE '45000'   
       SET MESSAGE_TEXT = 'Ex-students are not eligible';
       end if; 
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `current_students`
--

DROP TABLE IF EXISTS `current_students`;
/*!50001 DROP VIEW IF EXISTS `current_students`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `current_students` AS SELECT 
 1 AS `name`,
 1 AS `roll_no`,
 1 AS `dob`,
 1 AS `gender`,
 1 AS `address`,
 1 AS `contact_no`,
 1 AS `year`,
 1 AS `branch`,
 1 AS `hostel_id`,
 1 AS `flat`,
 1 AS `room`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `name` varchar(40) NOT NULL DEFAULT 'abc',
  `employee_id` int NOT NULL DEFAULT '0',
  `dob` date DEFAULT '2009-07-09',
  `gender` enum('f','m') DEFAULT 'f',
  `address` varchar(200) DEFAULT 'xyz',
  `contact_no` int DEFAULT '123456',
  `date_of_joining` date NOT NULL DEFAULT '2009-07-09',
  `termination_date` date DEFAULT '2099-01-01',
  `designation` enum('room-clean','warden','mess','office','other') DEFAULT 'other',
  `hostel_id` int DEFAULT '1',
  `salary` int DEFAULT '10000',
  PRIMARY KEY (`employee_id`),
  KEY `fk_emp_hostel` (`hostel_id`),
  CONSTRAINT `fk_emp_hostel` FOREIGN KEY (`hostel_id`) REFERENCES `hostel` (`hostel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('Ram',14,'1985-02-03','m','pooioiwueryt',123456,'2021-04-26','2099-01-01','warden',2,60000),('Test',24,'1995-02-03','f','jkljie',546899,'2021-04-29','2099-01-01','warden',3,60000),('test',1234,'1900-02-02','m',NULL,32,'2021-04-28',NULL,'warden',1,60000);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employeeSalary` BEFORE INSERT ON `employee` FOR EACH ROW begin
    if new.designation="Room-clean" then
set new.salary=20000 ;
elseif new.designation="Warden" then
set new.salary=60000 ;
    elseif new.designation="Mess" then
set new.salary=20000 ;
elseif new.designation="Office" then
set new.salary=45000 ;
    else
set new.salary=15000 ;
end if ;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `employee_in` BEFORE INSERT ON `employee` FOR EACH ROW begin
    set new.date_of_joining=curdate();
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `failed_student`
--

DROP TABLE IF EXISTS `failed_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_student` (
  `name` varchar(40) NOT NULL,
  `roll_no` int NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('f','m') DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `contact_no` int DEFAULT NULL,
  `year` enum('0','1','2','3','4') NOT NULL,
  `branch` enum('cse','me','eee','ece','biotech') NOT NULL,
  `hostel_id` int NOT NULL,
  `flat` int NOT NULL,
  `room` enum('a','b','c','d','e') NOT NULL,
  PRIMARY KEY (`roll_no`),
  KEY `fk_hostel_failed_student` (`hostel_id`),
  CONSTRAINT `fk_hostel_failed_student` FOREIGN KEY (`hostel_id`) REFERENCES `hostel` (`hostel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_student`
--

LOCK TABLES `failed_student` WRITE;
/*!40000 ALTER TABLE `failed_student` DISABLE KEYS */;
INSERT INTO `failed_student` VALUES ('a1',1,'2000-01-01','f','a',1,'1','cse',1,101,'a'),('b1',2,'2000-01-01','m','a',1,'1','biotech',1,101,'b'),('e3',25,'1999-01-01','f','a',1,'3','eee',2,102,'e');
/*!40000 ALTER TABLE `failed_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gate_record`
--

DROP TABLE IF EXISTS `gate_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gate_record` (
  `roll_no` int NOT NULL,
  `purpose` varchar(400) DEFAULT NULL,
  `entry_time` datetime DEFAULT NULL,
  `exit_time` datetime NOT NULL,
  PRIMARY KEY (`exit_time`,`roll_no`),
  KEY `fk_student_gate_record` (`roll_no`),
  CONSTRAINT `fk_student_gate_record` FOREIGN KEY (`roll_no`) REFERENCES `student` (`roll_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gate_record`
--

LOCK TABLES `gate_record` WRITE;
/*!40000 ALTER TABLE `gate_record` DISABLE KEYS */;
INSERT INTO `gate_record` VALUES (3,'test','2021-04-28 13:12:41','2021-04-28 13:03:06'),(33,'testing','2021-04-28 16:33:07','2021-04-28 16:32:36');
/*!40000 ALTER TABLE `gate_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `gate_record_out` BEFORE INSERT ON `gate_record` FOR EACH ROW begin
     set new.exit_time=now(); 
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `chk_st_gate` BEFORE INSERT ON `gate_record` FOR EACH ROW begin  
      if  (select year from student where roll_no=new.roll_no)='0' then
       SIGNAL SQLSTATE '45000'   
       SET MESSAGE_TEXT = 'Ex-students are not permitted';
       end if; 
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `hostel`
--

DROP TABLE IF EXISTS `hostel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hostel` (
  `name` varchar(40) NOT NULL,
  `hostel_id` int NOT NULL,
  `capacity` int DEFAULT NULL,
  `no_students` int DEFAULT NULL,
  `no_rooms_available` int DEFAULT NULL,
  PRIMARY KEY (`hostel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostel`
--

LOCK TABLES `hostel` WRITE;
/*!40000 ALTER TABLE `hostel` DISABLE KEYS */;
INSERT INTO `hostel` VALUES ('Orchid Woods',1,450,3,447),('Shivalaya',2,900,9,891),('Whitefield',3,450,4,446);
/*!40000 ALTER TABLE `hostel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `name` varchar(40) NOT NULL,
  `roll_no` int NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('f','m') DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `contact_no` int DEFAULT NULL,
  `year` enum('1','2','3','4','0') NOT NULL,
  `branch` enum('cse','me','eee','ece','biotech') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hostel_id` int NOT NULL,
  `flat` int DEFAULT NULL,
  `room` enum('a','b','c','d','e') DEFAULT NULL,
  PRIMARY KEY (`roll_no`),
  KEY `fk_hostel_student` (`hostel_id`),
  CONSTRAINT `fk_hostel_student` FOREIGN KEY (`hostel_id`) REFERENCES `hostel` (`hostel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('c1',3,'1999-01-01','f','a',1,'1','me',1,101,'c'),('d1',4,'1999-01-01','m','a',1,'1','cse',1,101,'d'),('e1',5,'2000-01-01','f','a',1,'1','me',1,101,'e'),('a2',11,'1999-01-01','m','a',1,'2','cse',2,101,'a'),('b2',12,'1999-01-01','f','a',1,'2','eee',2,101,'b'),('c2',13,'2000-01-01','m','a',1,'2','cse',2,101,'c'),('d2',14,'1999-01-01','f','a',1,'2','cse',2,101,'d'),('a3',21,'2000-01-01','f','a',1,'3','cse',2,102,'a'),('b3',22,'2000-01-01','m','a',1,'3','ece',2,102,'b'),('c3',23,'2000-01-01','f','a',1,'3','cse',2,102,'c'),('d3',24,'1999-01-01','m','a',1,'3','cse',2,102,'d'),('a4',31,'2000-01-01','m','a',1,'4','eee',3,101,'a'),('b4',32,'2000-01-01','f','a',1,'4','cse',3,101,'b'),('c4',33,'1999-01-01','m','a',1,'4','ece',3,101,'c'),('d4',34,'1999-01-01','f','a',1,'4','eee',3,101,'d');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `roomAllotment` BEFORE INSERT ON `student` FOR EACH ROW begin
declare n int; 
    declare r int; 
        declare h int;
    declare f varchar(1); 
        set h=0;
        
        if new.year like '1' then set h=1 ;
        end if;
        if new.year like '2' then set h=2 ;
        end if;
        if new.year like '3' then set h=2;
        end if;
        if new.year like '4' then set h=3 ;
        end if;

set new.hostel_id=h ;
        set n=availableRooms(h);

        if n>0 then
set r=(select flat from student where hostel_id=h and year!='0' order by flat desc limit 1) ;
            
            set f=(select room from student where flat=r and hostel_id=h and year!='0' order by room desc limit 1);

            if isnull(r) then
            set r=100;set f='E';
            end if;
            if mod(r,100)=18 then

if f='A' then
set new.flat=r;
                    set new.room='B';

elseif f='B' then
set new.flat=r;
                    set new.room='C';

elseif f='C' then
set new.flat=r;
                    set new.room='D';

elseif f='D' then
set new.flat=r;
                    set new.room='E';

else
set new.flat=((r/100)+1)*100 + 1;
                    set new.room='A';

end if;
            else

if f='A' then
set new.flat=r;
                    set new.room='B';

elseif f='B' then
set new.flat=r;
                    set new.room='C';

elseif f='C' then
set new.flat=r;
                    set new.room='D';

elseif f='D' then
set new.flat=r;
                    set new.room='E';

else
set new.flat=r + 1;
                    set new.room='A';

end if;

            end if;

else
set new.flat=NULL;
            set new.room=NULL;
        end if;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `chk_age_student` BEFORE INSERT ON `student` FOR EACH ROW begin  
      if  TIMESTAMPDIFF(YEAR, new.dob, curdate())<17  then
       SIGNAL SQLSTATE '45000'   
       SET MESSAGE_TEXT = 'Students should be atleast 17 year old.';
       end if; 
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `iupdateHostel` AFTER INSERT ON `student` FOR EACH ROW begin
     update hostel
     set no_rooms_available=availableRooms(hostel_id);
     update hostel
     set no_students=capacity-no_rooms_available;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `uroomAllotment` BEFORE UPDATE ON `student` FOR EACH ROW this:
begin
declare n int; 
    declare r int; 
        declare h int;
    declare f varchar(1); 
        set h=0;
        
        if new.year like '0' then leave this;
        end if;
        if new.year like old.year then leave this;
        end if;      
        
        if new.year like '1' then set h=1 ;
        end if;
        if new.year like '2' then set h=2 ;
        end if;
        if new.year like '3' then set h=2;
        end if;
        if new.year like '4' then set h=3 ;
        end if;

set new.hostel_id=h ;
        set n=availableRooms(h);

        if n>0 then
set r=(select flat from student where hostel_id=h and year!='0'  order by flat desc limit 1) ;

                set f=(select room from student where flat=r and hostel_id=h and year!='0' order by room desc limit 1);

            if isnull(r) then
            set r=100;set f='E';
            end if;
            if mod(r,100)=18 then

if f='A' then
set new.flat=r;
                    set new.room='B';

elseif f='B' then
set new.flat=r;
                    set new.room='C';

elseif f='C' then
set new.flat=r;
                    set new.room='D';

elseif f='D' then
set new.flat=r;
                    set new.room='E';

else
set new.flat=((r/100)+1)*100 + 1;
                    set new.room='A';

end if;

            else

if f='A' then
set new.flat=r;
                    set new.room='B';

elseif f='B' then
set new.flat=r;
                    set new.room='C';

elseif f='C' then
set new.flat=r;
                    set new.room='D';

elseif f='D' then
set new.flat=r;
                    set new.room='E';

else
set new.flat=r + 1;
                    set new.room='A';
end if;

            end if;

else
set new.flat=NULL;
            set new.room=NULL;

        end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `uupdateHostel` AFTER UPDATE ON `student` FOR EACH ROW begin
     update hostel
     set no_rooms_available=availableRooms(hostel_id);
     update hostel
     set no_students=capacity-no_rooms_available;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'hosteldb'
--

--
-- Dumping routines for database 'hosteldb'
--
/*!50003 DROP FUNCTION IF EXISTS `availableRooms` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `availableRooms`(h_id int) RETURNS int
    READS SQL DATA
    DETERMINISTIC
begin
declare no_of_available_rooms int;
set no_of_available_rooms=(select(select capacity from hostel where hostel_id=h_id)-count(roll_no) from student where hostel_id=h_id and year!=0);
return no_of_available_rooms;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `complaint_res` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `complaint_res`(roll_no1 int,complaint_id1 int,add_des varchar(191))
begin
     update complaint
     set resolved_date=curdate(), description=concat(description,"  RESOLVED REMARK:" ,add_des)
     where roll_no=roll_no1 and isnull(resolved_date) and complaint_id=complaint_id1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fail`(in roll_no1 int)
begin

DECLARE exit handler for sqlexception
  BEGIN
    
  ROLLBACK;
END;

DECLARE exit handler for sqlwarning
 BEGIN
    
 ROLLBACK;
END;

START TRANSACTION;
insert into failed_student select * from student where roll_no=roll_no1;
delete from student where roll_no=roll_no1;
COMMIT;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `forward` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `forward`()
begin
DECLARE exit handler for sqlexception
  BEGIN
    
  ROLLBACK;
END;

DECLARE exit handler for sqlwarning
 BEGIN
    
 ROLLBACK;
END;

START TRANSACTION;

update student set flat=NULL,room=NULL where year!='0' and year!='4';

update student set year='0' where year='4';

update student set year='4' where year='3';

update student set year='3' where year='2';

update student set year='2' where year='1';
 
insert into student select * from failed_student;

delete from failed_student;

COMMIT;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `gate_record_in` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `gate_record_in`(roll_no1 int)
begin
     update gate_record
     set entry_time=now()
     where roll_no=roll_no1 and isnull(entry_time);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `current_students`
--

/*!50001 DROP VIEW IF EXISTS `current_students`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `current_students` AS select `student`.`name` AS `name`,`student`.`roll_no` AS `roll_no`,`student`.`dob` AS `dob`,`student`.`gender` AS `gender`,`student`.`address` AS `address`,`student`.`contact_no` AS `contact_no`,`student`.`year` AS `year`,`student`.`branch` AS `branch`,`student`.`hostel_id` AS `hostel_id`,`student`.`flat` AS `flat`,`student`.`room` AS `room` from `student` where (`student`.`year` <> '0') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-29 22:14:38
