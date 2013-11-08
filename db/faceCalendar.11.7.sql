-- MySQL dump 10.13  Distrib 5.5.34, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: facecalendar
-- ------------------------------------------------------
-- Server version	5.5.34-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adminname` varchar(45) DEFAULT NULL,
  `adminpassword` varchar(45) DEFAULT NULL,
  `level` varchar(45) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'admin','admin','1',NULL);
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `starttime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `repeat` varchar(50) DEFAULT NULL,
  `eventname` varchar(500) DEFAULT NULL,
  `decription` varchar(1000) DEFAULT NULL,
  `place` varchar(500) DEFAULT NULL,
  `weekday` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_userid_idx` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,1,'2013-10-23 00:00:00','2013-10-24 00:00:00','none','havefun',NULL,NULL,NULL),(2,3,'2013-10-31 00:00:00','2013-10-31 23:00:00','week','halloween!',NULL,NULL,NULL),(7,3,'2013-11-01 00:00:00','2013-11-01 00:00:00','none','','','',-1),(8,3,'2013-11-01 00:00:00','2013-11-01 00:00:00','none','','','',-1),(9,3,'2013-11-01 00:00:00','2013-11-01 00:00:00','none','','','',-1),(13,3,'2013-11-01 00:00:00','2013-11-01 00:00:00','none','xxxx','xxx','xxxx',-1),(14,3,'2013-11-01 00:00:00','2013-11-01 00:00:00','none','','','',-1),(15,4,'2013-11-03 00:00:00','2013-11-03 00:00:00','test','eventname','for csil','csil',1),(16,4,'2013-11-03 00:00:00','2013-11-03 00:00:00','test','eventname','for csil','csil',1),(17,4,'2013-11-03 00:00:00','2013-11-03 00:00:00','test','eventname','for csil','csil',1);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupevent`
--

DROP TABLE IF EXISTS `groupevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupid` int(11) DEFAULT NULL,
  `eventid` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `groupevent_groupid_idx` (`groupid`),
  KEY `groupevent_eventid_idx` (`eventid`),
  CONSTRAINT `groupevent_eventid` FOREIGN KEY (`eventid`) REFERENCES `event` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `groupevent_groupid` FOREIGN KEY (`groupid`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupevent`
--

LOCK TABLES `groupevent` WRITE;
/*!40000 ALTER TABLE `groupevent` DISABLE KEYS */;
INSERT INTO `groupevent` VALUES (1,3,2,'halloween'),(2,2,7,NULL),(3,2,8,NULL),(4,2,9,NULL),(5,5,15,NULL),(6,5,16,NULL),(7,5,17,NULL);
/*!40000 ALTER TABLE `groupevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupmember`
--

DROP TABLE IF EXISTS `groupmember`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupmember` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `groupid` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `groupmember_groupid_idx` (`groupid`),
  KEY `groupmember_userid_idx` (`userid`),
  CONSTRAINT `groupmember_groupid` FOREIGN KEY (`groupid`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `groupmember_userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupmember`
--

LOCK TABLES `groupmember` WRITE;
/*!40000 ALTER TABLE `groupmember` DISABLE KEYS */;
INSERT INTO `groupmember` VALUES (1,1,1,'2013-10-23 00:00:00',NULL),(2,1,2,NULL,NULL),(3,1,3,NULL,NULL),(4,2,3,NULL,NULL),(5,2,4,NULL,NULL);
/*!40000 ALTER TABLE `groupmember` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `categroy` varchar(45) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_groups_1_idx` (`userid`),
  CONSTRAINT `fk_groups_1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'group1','1',NULL,NULL),(2,'group2','2',NULL,NULL),(3,'group3','a','a',NULL),(4,'group3','b','b',NULL),(5,'UCSB CS','2','For csil',NULL),(6,'UCSB CS','2','For csil',NULL),(7,'UCSB CS','2','For csil',NULL),(8,'UCSB CS','2','For csil',NULL),(9,'UCSB CS','2','For csil',NULL),(10,'UCSB CS','2','For csil',NULL),(11,'UCSB CS','2','For csil',NULL),(12,'UCSB CS','2','For csil',NULL),(13,'UCSB CS','2','For csil',NULL),(14,'UCSB CS','2','For csil',NULL),(15,'UCSB CS','2','For csil',NULL),(16,'UCSB CS','2','For csil',NULL),(17,'UCSB CS','2','For csil',NULL),(18,'UCSB CS','2','For csil',NULL),(19,'UCSB CS','2','For csil',NULL),(20,'UCSB CS','2','For csil',NULL),(21,'UCSB CS','2','For csil',NULL),(22,'UCSB CS','2','For csil',NULL),(23,'UCSB CS','2','For csil',NULL),(24,'UCSB CS','2','For csil',NULL),(25,'UCSB CS','2','For csil',NULL),(26,'UCSB CS','2','For csil',NULL),(27,'UCSB CS','2','For csil',NULL),(28,'UCSB CS','2','For csil',NULL),(29,'UCSB CS','2','For csil',NULL),(30,'UCSB CS','2','For csil',NULL),(31,'UCSB CS','2','For csil',NULL),(32,'UCSB CS','2','For csil',NULL);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `ip` varchar(25) DEFAULT NULL,
  `detail` varchar(1000) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid_idx` (`userid`),
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` VALUES (1,'2013-11-01 00:00:00','127.0.0.1','test',NULL);
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid_idx` (`userid`),
  CONSTRAINT `login_userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login`
--

LOCK TABLES `login` WRITE;
/*!40000 ALTER TABLE `login` DISABLE KEYS */;
INSERT INTO `login` VALUES (1,'user1','user1',1),(2,'user2','user2',2),(4,'Jon','Jon',5),(5,'Jon','Jon',6),(6,'Jon','Jon',7);
/*!40000 ALTER TABLE `login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privateevent`
--

DROP TABLE IF EXISTS `privateevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privateevent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `eventid` int(11) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `privateevent_userid_idx` (`userid`),
  KEY `privateevent_eventid_idx` (`eventid`),
  CONSTRAINT `privateevent_eventid` FOREIGN KEY (`eventid`) REFERENCES `event` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `privateevent_userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privateevent`
--

LOCK TABLES `privateevent` WRITE;
/*!40000 ALTER TABLE `privateevent` DISABLE KEYS */;
INSERT INTO `privateevent` VALUES (1,1,1,NULL),(2,3,13,NULL),(3,3,14,NULL);
/*!40000 ALTER TABLE `privateevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sex` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `occupation` varchar(50) DEFAULT NULL,
  `skills` varchar(500) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `relationship` varchar(50) DEFAULT NULL,
  `orientation` varchar(50) DEFAULT NULL,
  `introduction` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'male','test@test.com','test.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(2,'female','test@dd.com','nnn',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(3,'unknown',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(5,'M','M@M.M','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(6,'M','M@M.M','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(7,'M','M@M.M','NO','First','Last','occup','skills','2013-11-03','NO','NO','intro');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'facecalendar'
--
/*!50003 DROP PROCEDURE IF EXISTS `event_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `event_create`(
 in uid int,
 in starttime datetime,
 in endtime datetime,
 in erepeat varchar(50),
 in groupid int,
 in eventname varchar(500),
 in description varchar(1000),
 in place varchar(500),
 in weekday int,
 out eid int
)
BEGIN

start transaction;
INSERT INTO `facecalendar`.`event`
(
`userid`,
`starttime`,
`endtime`,
`repeat`,
`eventname`,
`decription`,
`place`,
 `weekday`)
VALUES
(
uid,
starttime,
endtime,
erepeat,
eventname,
description,
place,
weekday
);
select max(id) into eid from event;

if(groupid is null) then
	INSERT INTO `facecalendar`.`privateevent`
	(
	`userid`,
	`eventid`)
	VALUES
	(
	uid,
	eid
	);
else
	INSERT INTO `facecalendar`.`groupevent`
	(
	`groupid`,
	`eventid`)
	VALUES
	(groupid,
	eid);
end if;

IF (row_count() > 0) THEN
    COMMIT;
ELSE
    ROLLBACK;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `event_editOthers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `event_editOthers`(in eid int, in erepeat varchar(50),in eventname varchar(500),
 in edesc varchar(1000),in place varchar(500),
 in weekday int, out ack boolean)
BEGIN
set ack=false;

start transaction;
	
	if(erepeat is not null) then
		UPDATE `facecalendar`.`event`
		SET
			`repeat` = erepeat
		WHERE `id` = eid;
	end if;

	if(eventname is not null) then
		UPDATE `facecalendar`.`event`
		SET
			`eventname` = eventname
		WHERE `id` = eid;
	end if;

	if(edesc is not null) then
		UPDATE `facecalendar`.`event`
		SET
			`decription` = edesc
		WHERE `id` = eid;
	end if;
	
	if(place is not null) then
		UPDATE `facecalendar`.`event`
		SET
			`place` = place
		WHERE `id` = eid;
	end if;

	if(weekday is not null) then
		UPDATE `facecalendar`.`event`
		SET
			`weekday` = weekday
		WHERE `id` = eid;
	end if;

	set ack=true;
	commit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `event_editTime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `event_editTime`(in eid int , in starttime datetime, in endtime datetime,out ack boolean)
BEGIN
	set ack=false;
	start transaction;
	UPDATE `facecalendar`.`event`
		SET
		`starttime` = starttime,
		`endtime` = endtime
	WHERE `id` = eid;
	if(row_count()=1) then
		commit;
		set ack=true;
	else
		rollback;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `event_getAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `event_getAll`(in uid int, in stime datetime,in etime datetime)
BEGIN
(
SELECT 
	`event`.`id`,
    `event`.`starttime`,
    `event`.`endtime`,
    `event`.`repeat`,
    `event`.`eventname`,
    `event`.`decription`,
	`event`.`place`
FROM `facecalendar`.`event`
	 where 
		(`event`.`starttime`<=etime
			and
		  `event`.`endtime`>=stime)
		 and `event`.`id` in
		(
			select eventid from privateevent where `id`=uid
		)
)
union

(
SELECT 
	`event`.`id`,
    `event`.`starttime`,
    `event`.`endtime`,
    `event`.`repeat`,
    `event`.`eventname`,
    `event`.`decription`,
    `event`.`place`
FROM `facecalendar`.`event`
	where
	(`event`.`starttime`<=etime
			and
		  `event`.`endtime`>=stime)
		 and 
	`event`.`id` in
	(
		select groupevent.eventid from groupevent
		where groupid in
		(
			select groupid from groupmember where groupmember.userid=uid
		)
	)
);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `event_getById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `event_getById`(in eid int)
BEGIN
SELECT 
    `event`.`userid`,
    `event`.`starttime`,
    `event`.`endtime`,
    `event`.`repeat`,
    `event`.`eventname`,
    `event`.`decription`,
    `event`.`place`,
    `event`.`weekday`
FROM `facecalendar`.`event`
	where `event`.`id`=eid;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `event_getGroup` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `event_getGroup`(in uid int,in stime datetime, in etime datetime)
BEGIN
	SELECT 
	`event`.`id`,
    `event`.`starttime`,
    `event`.`endtime`,
    `event`.`repeat`,
    `event`.`eventname`,
    `event`.`decription`,
    `event`.`place`
FROM `facecalendar`.`event`
	where
	(`event`.`starttime`<=etime
			and
		  `event`.`endtime`>=stime)
		 and 
	`event`.`id` in
	(
		select groupevent.eventid from groupevent
		where groupid in
		(
			select groupid from groupmember where groupmember.userid=uid
		)
	);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `event_getPrivate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `event_getPrivate`(in uid int,in stime datetime, in etime datetime)
BEGIN
	SELECT 
	`event`.`id`,
    `event`.`starttime`,
    `event`.`endtime`,
    `event`.`repeat`,
    `event`.`eventname`,
    `event`.`decription`,
	`event`.`place`
FROM `facecalendar`.`event`
	 where 
		(`event`.`starttime`<=etime
			and
		  `event`.`endtime`>=stime)
		 and `event`.`id` in
		(
			select eventid from privateevent where `id`=uid
		)
	;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `groups_AddMember` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `groups_AddMember`(in gid int, in uid int,in description varchar(1000),out ack bool)
BEGIN
	set ack=false;
	start transaction;
	INSERT INTO `facecalendar`.`groupmember`
	(
	`userid`,
	`groupid`,
	`time`,
	`description`)
	VALUES
	(
	uid,
	gid,
	now(),
	description
	);
	if(row_count()>0) then
		set ack=true;
		commit;
	else
		rollback;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `groups_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `groups_create`(in gname varchar(100) ,in category varchar(45), in description varchar(1000), out gid int)
BEGIN
	
	start transaction;
		INSERT INTO `facecalendar`.`groups`
			(
			`name`,
			`categroy`,
			`description`)
			VALUES
			(gname, 
			category,
			description);

		select max(id) into gid from groups;
	commit;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `groups_deleteMember` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `groups_deleteMember`(in gid int,in uid int, out ack bool)
BEGIN
set ack=false;

start transaction;
	DELETE FROM `facecalendar`.`groupmember`
	WHERE groupid=gid and userid=uid;
	
	if(row_count()>0) then
		set ack=true;
		commit;
	else
		rollback;
	end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `groups_findAllGroups` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `groups_findAllGroups`(in uid int)
BEGIN
	select b.id,b.name from groups b,groupmember c
	where c.userid=uid and b.id=c.groupid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `groups_findGroupWithName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `groups_findGroupWithName`(in uid int)
BEGIN
	SELECT `groups`.`id`,
    `groups`.`name`
FROM `facecalendar`.`groups`
	where `groups`.`id` in
	(
		SELECT `groupmember`.`id`
		FROM `facecalendar`.`groupmember`
		where `groupmember`.`userid`=uid 
	);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `groups_getCreatedById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `groups_getCreatedById`(in uid int)
BEGIN

	SELECT 
    `groups`.`id`
FROM `facecalendar`.`groups`
	where  `groups`.`userid`=uid;
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `groups_getMembersById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `groups_getMembersById`(in gid int)
BEGIN

SELECT 
    `groupmember`.`userid`
FROM `facecalendar`.`groupmember`
where `groupmember`.`groupid`=gid;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `groups_searchByName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `groups_searchByName`(in gname varchar(100))
BEGIN
	SELECT
	`groups`.`id`,
    `groups`.`name`,
    `groups`.`categroy`,
    `groups`.`description`
FROM `facecalendar`.`groups`
	where `groups`.`name` like concat('%',gname,'%')
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `groups_viewall` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `groups_viewall`()
BEGIN
	select * from groups;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `login_check` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `login_check`(in uname varchar(50) , in upass varchar(20), out uid int)
BEGIN
	set uid=-1;
	select 	(userid) into uid from login where username=uname AND `password`=upass limit 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_create` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_create`(
in username varchar(50),
in upass varchar(50),
in sex varchar(50),
in email varchar(1000),
in picture varchar(1000),
in firstname varchar(50),
in lastname varchar(50),
in occupation varchar(50),
in skills varchar (500),
in birthday date,
in relationship varchar(50),
in orientation varchar(50),
in introduction varchar(5000),
out uid int
)
BEGIN
	set uid=-1;
	start transaction;
	INSERT INTO `facecalendar`.`user`
	(
		`sex`,
		`email`,
		`picture`,
		`firstname`,
		`lastname`,
		`occupation`,
		`skills`,
		`birthday`,
		`relationship`,
		`orientation`,
		`introduction`
	)
	VALUES
	(
		sex,
		email,
		picture,
		firstname,
		lastname,
		occupation,
		skills,
		birthday,
		relationship,
		orientation,
		introduction
	);

	
	select max(id) into uid from user;
	
	INSERT INTO `facecalendar`.`login`
		(
		`username`,
		`password`,
		`userid`)
		VALUES
		(
		username,
		upass,
		uid);

	if(row_count()>0) then
		commit;
	else
		set uid=-1;
		rollback;
	end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_get` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `user_get`(in uid int)
BEGIN
	SELECT 
    `user`.`sex`,
    `user`.`email`,
    `user`.`picture`,
    `user`.`firstname`,
    `user`.`lastname`,
    `user`.`occupation`,
    `user`.`skills`,
    `user`.`birthday`,
    `user`.`relationship`,
    `user`.`orientation`,
    `user`.`introduction`
FROM `facecalendar`.`user`
where `user`.`id`=uid;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-11-07 13:25:55
