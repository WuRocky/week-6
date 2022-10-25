-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: website
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `website`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `website` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `website`;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `follower_count` int unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'test2','test','test',52,'2022-10-18 09:03:36'),(2,'Rocky','rocky','rocky',10,'2022-10-18 09:03:43'),(3,'Leo','leo','leo',0,'2022-10-18 09:03:50'),(4,'John','john','john',25,'2022-10-18 09:03:56'),(5,'David','david','david',0,'2022-10-18 09:04:01'),(6,'Allen','Allen','Allen',0,'2022-10-25 10:30:44'),(7,'Cary','Cary','Cary',0,'2022-10-25 11:09:41'),(8,'哈哈','111','111',0,'2022-10-25 11:35:07'),(10,'chin','chin','chin',0,'2022-10-25 20:19:29'),(11,'Ava','Ava','ava',0,'2022-10-25 20:23:00');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `member_id` bigint NOT NULL,
  `content` varchar(255) NOT NULL,
  `like_count` int unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,1,'好喜歡Wehelp喔',70,'2022-10-18 09:12:22'),(2,1,'大家加油!!!',45,'2022-10-18 09:12:28'),(3,1,'每天都要學習!!!',50,'2022-10-18 09:12:33'),(4,2,'加油喔',3,'2022-10-18 09:12:38'),(5,2,'腳傷快點好~',2,'2022-10-18 09:12:45'),(6,2,'辛苦了',1,'2022-10-18 09:12:52'),(7,3,'哈哈',0,'2022-10-18 09:13:01'),(8,3,'大家好',0,'2022-10-18 09:13:10'),(9,4,'天氣好差',0,'2022-10-18 09:13:15'),(10,5,'希望明天有太陽',10,'2022-10-18 09:13:22'),(11,5,'希望明天不要下雨',20,'2022-10-18 09:13:31'),(23,1,'測試',0,'2022-10-25 16:35:23'),(24,1,'哈哈',0,'2022-10-25 20:26:09');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record_like`
--

DROP TABLE IF EXISTS `record_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `record_like` (
  `user_id` bigint NOT NULL,
  `user_like` bigint NOT NULL,
  `click_like` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`,`user_like`),
  KEY `user_like` (`user_like`),
  CONSTRAINT `record_like_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `member` (`id`),
  CONSTRAINT `record_like_ibfk_2` FOREIGN KEY (`user_like`) REFERENCES `message` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record_like`
--

LOCK TABLES `record_like` WRITE;
/*!40000 ALTER TABLE `record_like` DISABLE KEYS */;
INSERT INTO `record_like` VALUES (1,1,'+1'),(1,10,'+1'),(1,11,'+1'),(2,1,'+1'),(2,8,'+1'),(2,9,'+1'),(3,2,'+1'),(3,6,'+1'),(3,7,'+1'),(4,3,'+1'),(4,4,'+1'),(4,5,'+1'),(5,2,'+1'),(5,3,'+1'),(5,4,'+1'),(5,5,'+1');
/*!40000 ALTER TABLE `record_like` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-25 20:37:18
