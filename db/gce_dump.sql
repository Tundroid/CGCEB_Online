-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: web-01.moleculesoft.tech    Database: gce
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.20.04.1

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
-- Current Database: `gce`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `gce`;

--
-- Table structure for table `candidate`
--

DROP TABLE IF EXISTS `candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate` (
  `gce_id` varchar(50) NOT NULL DEFAULT 'UUID()',
  `first_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  PRIMARY KEY (`gce_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate`
--

LOCK TABLES `candidate` WRITE;
/*!40000 ALTER TABLE `candidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `center`
--

DROP TABLE IF EXISTS `center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `center` (
  `center_no` varchar(5) NOT NULL,
  `center_name` varchar(50) NOT NULL,
  PRIMARY KEY (`center_no`),
  UNIQUE KEY `center_name_UNIQUE` (`center_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `center`
--

LOCK TABLES `center` WRITE;
/*!40000 ALTER TABLE `center` DISABLE KEYS */;
/*!40000 ALTER TABLE `center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam` (
  `exam_id` varchar(50) NOT NULL DEFAULT 'UUID()',
  `exam_name` varchar(50) NOT NULL,
  `exam_abbrev` varchar(50) NOT NULL,
  PRIMARY KEY (`exam_id`),
  UNIQUE KEY `exam_name_UNIQUE` (`exam_name`),
  UNIQUE KEY `exam_abbrev_UNIQUE` (`exam_abbrev`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_center`
--

DROP TABLE IF EXISTS `exam_center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_center` (
  `center` varchar(5) NOT NULL,
  `exam` varchar(50) NOT NULL,
  PRIMARY KEY (`center`,`exam`),
  KEY `exam` (`exam`),
  CONSTRAINT `exam_center_ibfk_1` FOREIGN KEY (`center`) REFERENCES `center` (`center_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `exam_center_ibfk_2` FOREIGN KEY (`exam`) REFERENCES `exam` (`exam_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_center`
--

LOCK TABLES `exam_center` WRITE;
/*!40000 ALTER TABLE `exam_center` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_registration`
--

DROP TABLE IF EXISTS `exam_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_registration` (
  `reg_id` varchar(50) NOT NULL DEFAULT 'UUID()',
  `candidate` varchar(50) NOT NULL,
  `center` varchar(5) NOT NULL,
  `exam_session` varchar(50) NOT NULL,
  `can_no` int GENERATED ALWAYS AS (0) VIRTUAL,
  `is_complete` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`candidate`,`exam_session`),
  UNIQUE KEY `reg_id_UNIQUE` (`reg_id`),
  KEY `s_idx` (`center`),
  KEY `exam_session` (`exam_session`),
  CONSTRAINT `exam_registration_ibfk_1` FOREIGN KEY (`candidate`) REFERENCES `candidate` (`gce_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `exam_registration_ibfk_2` FOREIGN KEY (`center`) REFERENCES `center` (`center_no`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `exam_registration_ibfk_3` FOREIGN KEY (`exam_session`) REFERENCES `exam_session` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_registration`
--

LOCK TABLES `exam_registration` WRITE;
/*!40000 ALTER TABLE `exam_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_session`
--

DROP TABLE IF EXISTS `exam_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_session` (
  `id` varchar(50) NOT NULL DEFAULT 'UUID()',
  `session` varchar(50) NOT NULL,
  `exam` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_UNIQUE` (`exam`),
  UNIQUE KEY `session_UNIQUE` (`session`),
  CONSTRAINT `exam_session_ibfk_1` FOREIGN KEY (`session`) REFERENCES `session` (`ses_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `exam_session_ibfk_2` FOREIGN KEY (`exam`) REFERENCES `exam` (`exam_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_session`
--

LOCK TABLES `exam_session` WRITE;
/*!40000 ALTER TABLE `exam_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_subject`
--

DROP TABLE IF EXISTS `exam_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_subject` (
  `code` varchar(5) NOT NULL,
  `subject` varchar(50) NOT NULL,
  `exam` varchar(50) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `subject_UNIQUE` (`subject`),
  UNIQUE KEY `exam_UNIQUE` (`exam`),
  CONSTRAINT `exam_subject_ibfk_1` FOREIGN KEY (`subject`) REFERENCES `subject` (`subj_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `exam_subject_ibfk_2` FOREIGN KEY (`exam`) REFERENCES `exam` (`exam_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_subject`
--

LOCK TABLES `exam_subject` WRITE;
/*!40000 ALTER TABLE `exam_subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `session` (
  `ses_id` varchar(50) NOT NULL DEFAULT 'UUID()',
  `year` year NOT NULL,
  `is_open` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ses_id`),
  UNIQUE KEY `year_UNIQUE` (`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `subj_id` varchar(50) NOT NULL DEFAULT 'UUID()',
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`subj_id`),
  UNIQUE KEY `title_UNIQUE` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject_registration`
--

DROP TABLE IF EXISTS `subject_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject_registration` (
  `exam_reg` varchar(50) NOT NULL,
  `exam_subj` varchar(5) NOT NULL,
  PRIMARY KEY (`exam_reg`,`exam_subj`),
  KEY `exam_subj` (`exam_subj`),
  CONSTRAINT `subject_registration_ibfk_1` FOREIGN KEY (`exam_subj`) REFERENCES `exam_subject` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `subject_registration_ibfk_2` FOREIGN KEY (`exam_reg`) REFERENCES `exam_registration` (`reg_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject_registration`
--

LOCK TABLES `subject_registration` WRITE;
/*!40000 ALTER TABLE `subject_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject_registration` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-30 15:27:03
