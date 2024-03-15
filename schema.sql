CREATE DATABASE  IF NOT EXISTS `onlineauctionsystem` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `onlineauctionsystem`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: onlineauctionsystem
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `adminID` char(5) NOT NULL,
  PRIMARY KEY (`adminID`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`adminID`) REFERENCES `user` (`memberID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('12121');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `auctionID` int NOT NULL AUTO_INCREMENT,
  `sellerID` char(5) NOT NULL,
  `itemID` int NOT NULL,
  `initialPrice` float NOT NULL,
  `hiddenMinimumPrice` float DEFAULT NULL,
  `standardBiddingIncrement` int NOT NULL,
  `openingDate` datetime DEFAULT NULL,
  `closingDate` datetime DEFAULT NULL,
  `HighestBid` float DEFAULT '0',
  `highestBidderID` char(5) DEFAULT NULL,
  `isWinner` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`auctionID`),
  KEY `sellerID` (`sellerID`),
  KEY `itemID` (`itemID`),
  CONSTRAINT `auction_ibfk_1` FOREIGN KEY (`sellerID`) REFERENCES `enduser` (`userID`),
  CONSTRAINT `auction_ibfk_2` FOREIGN KEY (`itemID`) REFERENCES `electronicdevices` (`eID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid` (
  `bidID` int NOT NULL AUTO_INCREMENT,
  `buyerID` char(5) NOT NULL,
  `auctionID` int NOT NULL,
  `currentBidAmount` float DEFAULT NULL,
  `type` varchar(9) NOT NULL,
  `placedDate` datetime NOT NULL,
  `isAutoBid` tinyint(1) NOT NULL,
  `bidIncrement` float DEFAULT NULL,
  `upperLimit` float DEFAULT NULL,
  PRIMARY KEY (`bidID`),
  KEY `auctionID` (`auctionID`),
  KEY `bid_ibfk_1` (`buyerID`),
  CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`buyerID`) REFERENCES `enduser` (`userID`),
  CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`auctionID`) REFERENCES `auction` (`auctionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerrepresentative`
--

DROP TABLE IF EXISTS `customerrepresentative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerrepresentative` (
  `repID` char(5) NOT NULL,
  PRIMARY KEY (`repID`),
  CONSTRAINT `customerrepresentative_ibfk_1` FOREIGN KEY (`repID`) REFERENCES `user` (`memberID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerrepresentative`
--

LOCK TABLES `customerrepresentative` WRITE;
/*!40000 ALTER TABLE `customerrepresentative` DISABLE KEYS */;
INSERT INTO `customerrepresentative` VALUES ('22222');
/*!40000 ALTER TABLE `customerrepresentative` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electronicdevices`
--

DROP TABLE IF EXISTS `electronicdevices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electronicdevices` (
  `eID` int NOT NULL AUTO_INCREMENT,
  `isLaptop` tinyint(1) NOT NULL,
  `isSmartPhone` tinyint(1) NOT NULL,
  `isTV` tinyint(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `height` float DEFAULT NULL,
  `width` float DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `companyOrBrand` varchar(50) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL,
  `chargingPort` varchar(50) DEFAULT NULL,
  `storage` float DEFAULT NULL,
  `yearOfMake` int NOT NULL,
  `memory` float DEFAULT NULL,
  `quality` varchar(100) NOT NULL,
  `displayTechnology` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`eID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electronicdevices`
--

LOCK TABLES `electronicdevices` WRITE;
/*!40000 ALTER TABLE `electronicdevices` DISABLE KEYS */;
/*!40000 ALTER TABLE `electronicdevices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enduser`
--

DROP TABLE IF EXISTS `enduser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enduser` (
  `userID` char(5) NOT NULL,
  PRIMARY KEY (`userID`),
  CONSTRAINT `enduser_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`memberID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enduser`
--

LOCK TABLES `enduser` WRITE;
/*!40000 ALTER TABLE `enduser` DISABLE KEYS */;
INSERT INTO `enduser` VALUES ('12334'),('12345'),('91245'),('99999');
/*!40000 ALTER TABLE `enduser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hasanalert`
--

DROP TABLE IF EXISTS `hasanalert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hasanalert` (
  `alertID` int NOT NULL AUTO_INCREMENT,
  `userID` char(5) NOT NULL,
  `auctionID` int NOT NULL,
  `eID` int NOT NULL,
  `alertMessage` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`alertID`),
  KEY `eID` (`eID`),
  KEY `hasanalert_ibfk_1` (`userID`),
  KEY `hasanalert_ibfk_3` (`auctionID`),
  CONSTRAINT `hasanalert_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `enduser` (`userID`),
  CONSTRAINT `hasanalert_ibfk_2` FOREIGN KEY (`eID`) REFERENCES `auction` (`itemID`),
  CONSTRAINT `hasanalert_ibfk_3` FOREIGN KEY (`auctionID`) REFERENCES `auction` (`auctionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hasanalert`
--

LOCK TABLES `hasanalert` WRITE;
/*!40000 ALTER TABLE `hasanalert` DISABLE KEYS */;
/*!40000 ALTER TABLE `hasanalert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question` (
  `qID` int NOT NULL AUTO_INCREMENT,
  `userID` char(5) NOT NULL,
  `repID` char(5) DEFAULT NULL,
  `questionText` varchar(1000) DEFAULT NULL,
  `answerText` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`qID`),
  KEY `userID` (`userID`),
  KEY `repID` (`repID`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `enduser` (`userID`),
  CONSTRAINT `question_ibfk_2` FOREIGN KEY (`repID`) REFERENCES `customerrepresentative` (`repID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `memberID` char(5) NOT NULL,
  `password` char(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phoneNumber` varchar(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`memberID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('12121','king','Jessica','9701715366','jessie@gmail.com','New Jersey, USA'),('12334','disney','Arunima Bhowmik','9999899997','ab@gmail.com','New Jersey, USA'),('12345','SweetCake','Ishitha Bhagwati','9999899999','ishi@gmail.com','New Jersey, USA'),('22222','worker','Rocky','7329102493','yash@gmail.com','New Jersey, USA'),('91245','cookie','Sneha Balaji','7329102495','sneha@gmail.com','New Jersey, USA'),('99999','Hyndavi831','Seershika Kakuru','9083409363','kseershika@gmail.com','5502 Hana Road');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishesfor`
--

DROP TABLE IF EXISTS `wishesfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishesfor` (
  `userID` char(5) NOT NULL,
  `eID` int NOT NULL,
  PRIMARY KEY (`userID`,`eID`),
  KEY `eID` (`eID`),
  CONSTRAINT `wishesfor_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `enduser` (`userID`),
  CONSTRAINT `wishesfor_ibfk_2` FOREIGN KEY (`eID`) REFERENCES `electronicdevices` (`eID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishesfor`
--

LOCK TABLES `wishesfor` WRITE;
/*!40000 ALTER TABLE `wishesfor` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishesfor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-08 15:43:06
