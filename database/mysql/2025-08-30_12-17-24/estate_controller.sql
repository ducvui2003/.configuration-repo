-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: estate_controller
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `config_databases`
--

DROP TABLE IF EXISTS `config_databases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_databases` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `type_database_id` bigint DEFAULT NULL,
  `host` varchar(100) DEFAULT NULL,
  `port` int DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `rdbms_type` enum('MYSQL','MONGODB','POSTGRESQL') DEFAULT NULL,
  `add_ons` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `config_databases_type_databases_id_fk` (`type_database_id`),
  CONSTRAINT `config_databases_type_databases_id_fk` FOREIGN KEY (`type_database_id`) REFERENCES `type_databases` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_databases`
--

LOCK TABLES `config_databases` WRITE;
/*!40000 ALTER TABLE `config_databases` DISABLE KEYS */;
INSERT INTO `config_databases` VALUES (1,'estate_staging',1,'127.0.0.1',3306,'estate_root','1234','MYSQL',NULL),(2,'estate_warehouse',2,'127.0.0.1',3306,'estate_root','1234','MYSQL',NULL);
/*!40000 ALTER TABLE `config_databases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configs`
--

DROP TABLE IF EXISTS `configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `prefix` varchar(100) DEFAULT NULL,
  `file_format` varchar(100) DEFAULT NULL,
  `file_extension` varchar(100) DEFAULT NULL,
  `data_dir_path` varchar(255) DEFAULT NULL,
  `error_dir_path` varchar(200) DEFAULT NULL,
  `active` bit(1) DEFAULT b'0',
  `config_database_id` bigint DEFAULT NULL,
  `resource_id` bigint DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `configs_config_databases_id_fk` (`config_database_id`),
  KEY `resource_id` (`resource_id`),
  CONSTRAINT `configs_config_databases_id_fk` FOREIGN KEY (`config_database_id`) REFERENCES `config_databases` (`id`),
  CONSTRAINT `configs_ibfk_1` FOREIGN KEY (`resource_id`) REFERENCES `resources` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configs`
--

LOCK TABLES `configs` WRITE;
/*!40000 ALTER TABLE `configs` DISABLE KEYS */;
INSERT INTO `configs` VALUES (1,'source_1_','%Y_%m_%d__%H_%M','csv','D:\\university\\data_warehouse\\host\\data','D:\\university\\data_warehouse\\host\\error',_binary '',1,1,'21130320@st.hcmuef.edu.vn'),(2,'source_2_','%Y_%m_%d__%H_%M','csv','D:\\university\\data_warehouse\\host\\data','D:\\university\\data_warehouse\\host\\error',_binary '',1,2,'21130320@st.hcmuef.edu.vn');
/*!40000 ALTER TABLE `configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `config_id` bigint DEFAULT NULL,
  `status` enum('FILE_PENDING','FILE_PROCESSING','FILE_ERROR','STAGING_PENDING','STAGING_PROCESSING','STAGING_ERROR','TRANSFORM_PENDING','TRANSFORM_PROCESSING','TRANSFORM_ERROR','WAREHOUSE_PENDING','WAREHOUSE_PROCESSING','WAREHOUSE_ERROR','DATAMART_PENDING','DATAMART_PROCESSING','DATAMART_ERROR') NOT NULL,
  `time_start` datetime DEFAULT NULL,
  `time_end` datetime DEFAULT NULL,
  `file_name` varchar(200) DEFAULT NULL,
  `error_file_name` longtext,
  `count_row` int DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `config_id_idx` (`config_id`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`config_id`) REFERENCES `configs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (11,1,'FILE_PENDING','2024-12-09 17:59:08',NULL,' ',' ',0,'2024-12-09 17:59:08',1),(12,2,'FILE_PENDING','2024-12-09 17:59:08',NULL,' ',' ',0,'2024-12-09 17:59:08',1),(13,1,'FILE_PROCESSING','2024-12-09 17:59:46','2024-12-09 18:08:04','D:\\university\\data_warehouse\\host\\data\\source_1_2024_12_10__01_08.csv',NULL,40,'2024-12-09 17:59:46',1),(14,1,'STAGING_PENDING','2024-12-09 18:08:04',NULL,'D:\\university\\data_warehouse\\host\\data\\source_1_2024_12_10__01_08.csv',' ',0,'2024-12-09 18:08:04',1),(15,2,'FILE_PROCESSING','2024-12-09 18:27:07','2024-12-09 18:34:51','D:\\university\\data_warehouse\\host\\data\\source_2_2024_12_10__01_34.csv',NULL,40,'2024-12-09 18:27:07',1),(16,2,'STAGING_PENDING','2024-12-09 18:34:51',NULL,'D:\\university\\data_warehouse\\host\\data\\source_2_2024_12_10__01_34.csv',' ',0,'2024-12-09 18:34:51',0),(41,1,'STAGING_PROCESSING','2024-12-09 19:42:05',NULL,'',' ',0,'2024-12-09 19:42:05',0),(42,1,'TRANSFORM_PENDING',NULL,NULL,NULL,NULL,NULL,'2024-12-10 02:46:26',1),(48,2,'TRANSFORM_PENDING',NULL,NULL,NULL,NULL,NULL,'2024-12-10 03:11:54',1),(49,1,'TRANSFORM_PROCESSING','2024-12-10 03:12:35','2024-12-10 03:12:39',NULL,NULL,0,'2024-12-10 03:12:35',1),(50,2,'TRANSFORM_PROCESSING','2024-12-10 03:12:54','2024-12-10 03:12:59',NULL,NULL,17,'2024-12-10 03:12:54',1);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resources` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `base_url` varchar(255) DEFAULT NULL,
  `source_page` varchar(255) DEFAULT NULL,
  `paging_pattern` varchar(100) DEFAULT NULL,
  `limit_page` int DEFAULT NULL,
  `scenario` json DEFAULT NULL,
  `purpose` enum('BAN','CHO THUE') DEFAULT NULL,
  `navigate_scenario` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
INSERT INTO `resources` VALUES (1,'batdongsan.com.vn','https://batdongsan.com.vn','nha-dat-ban','/p',2,'{\"nk\": {\"method\": \"get_attribute\", \"quantity\": 1, \"selector\": \"//*[@id=\'product-detail-web\']\", \"attribute\": \"prid\"}, \"url\": {\"method\": \"url\"}, \"area\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'js__pr-short-info-item\')]/*[text()=\'Diện tích\']/following-sibling::*[1]\"}, \"email\": {\"method\": \"get_attribute\", \"quantity\": 1, \"selector\": \"//*[@id=\'email\']\", \"attribute\": \"data-email\"}, \"legal\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'re__pr-specs-content-item\')]/*[text()=\'Pháp lý\']/following-sibling::*[1]\"}, \"price\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'js__pr-short-info-item\')]/*[text()=\'Mức giá\']/following-sibling::*[1]\"}, \"avatar\": {\"method\": \"get_attribute\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'js__agent-contact-avatar\')]\", \"attribute\": \"src\"}, \"floors\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'re__pr-specs-content-item\')]/*[text()=\'Số tầng\']/following-sibling::*[1]\"}, \"images\": {\"method\": \"get_attribute\", \"quantity\": null, \"selector\": \"//*[contains(@class, \'slick-track\')]//img\", \"attribute\": \"src\"}, \"address\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'js__pr-address\')]\"}, \"bedroom\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'re__pr-specs-content-item\')]/*[text()=\'Số phòng ngủ\']/following-sibling::*[1]\"}, \"subject\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'pr-title\')]\"}, \"bathroom\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'re__pr-specs-content-item\')]/*[text()=\'Số toilet\']/following-sibling::*[1]\"}, \"end_date\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'js__pr-config-item\')]/*[text()=\'Ngày hết hạn\']/following-sibling::*[1]\"}, \"create_at\": {\"method\": \"time\"}, \"full_name\": {\"method\": \"get_attribute\", \"quantity\": 1, \"selector\": \"(//*[contains(@class, \'js_contact-name\')])[1]\", \"attribute\": \"title\"}, \"start_date\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'js__pr-config-item\')]/*[text()=\'Ngày đăng\']/following-sibling::*[1]\"}, \"description\": {\"method\": \"description\", \"selector\": \"//*[contains(@class, \'re__detail-content\')]\"}, \"orientation\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'re__pr-specs-content-item\')]/*[text()=\'Hướng nhà\']/following-sibling::*[1]\"}}','BAN','{\"item\": \".js__product-link-for-product-id\", \"list\": \".js__card\"}'),(2,'muaban.net/bat-dong-san','https://muaban.net','ban-nha-dat-chung-cu','?page=',2,'{\"nk\": {\"regex\": \"Mã tin:\\\\s*(\\\\d+)\", \"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'sc-6orc5o-15 jiDXp\')]//*[@class=\'date\']\"}, \"url\": {\"method\": \"url\"}, \"area\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[(text()=\'Diện tích đất\')]/following-sibling::*[1]\"}, \"legal\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[(text()=\'Giấy tờ pháp lý\')]/following-sibling::*[1]\"}, \"phone\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'sc-lohvv8-15 fyGvhT\')]\"}, \"price\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'sc-6orc5o-15 jiDXp\')]//*[@class=\'price\']\"}, \"floors\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[(text()=\'Tổng số tầng\')]/following-sibling::*[1]\"}, \"images\": {\"method\": \"get_attribute\", \"quantity\": null, \"selector\": \"//*[contains(@class, \'sc-6orc5o-3 ljaVcC\')]//img\", \"attribute\": \"src\"}, \"address\": {\"method\": \"description\", \"selector\": \"//*[contains(@class, \'sc-6orc5o-15 jiDXp\')]/div[contains(@class, \'address\')]\"}, \"bedroom\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[(text()=\'Số phòng ngủ\')]/following-sibling::*[1]\"}, \"subject\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[contains(@class, \'sc-6orc5o-15 jiDXp\')]/h1\"}, \"bathroom\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[(text()=\'Số phòng vệ sinh\')]/following-sibling::*[1]\"}, \"create_at\": {\"method\": \"time\"}, \"full_name\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//span[contains(@class, \'title\')]\"}, \"description\": {\"method\": \"description\", \"selector\": \"//*[contains(@class, \'sc-6orc5o-18 gdAVnx\')]\"}, \"orientation\": {\"method\": \"text\", \"quantity\": 1, \"selector\": \"//*[(text()=\'Hướng cửa chính\')]/following-sibling::*[1]\"}}','BAN','{\"item\": \"a.title\", \"list\": \".sc-q9qagu-4.iZrvBN\"}');
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_databases`
--

DROP TABLE IF EXISTS `type_databases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_databases` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_databases`
--

LOCK TABLES `type_databases` WRITE;
/*!40000 ALTER TABLE `type_databases` DISABLE KEYS */;
INSERT INTO `type_databases` VALUES (1,'staging'),(2,'warehouse');
/*!40000 ALTER TABLE `type_databases` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-30 12:17:28
