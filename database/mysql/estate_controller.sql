-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: estate_controller
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Current Database: `estate_controller`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `estate_controller` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `estate_controller`;

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

--
-- Dumping routines for database 'estate_controller'
--
/*!50003 DROP PROCEDURE IF EXISTS `get_database_config` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_database_config`(IN dbName varchar(200))
BEGIN
#     3.trả về toàn bộ thông tin của config_databases đó
    SELECT config_databases.*
#         1.Thực hiện liên kết bảng type_databases và config_databases
    FROM type_databases
             JOIN config_databases
                  ON type_databases.id = config_databases.type_database_id
#         2.thực hiện tìm kiếm loại database phù hợp với tham số truyền vào
    WHERE type_databases.type_name = dbName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_log_crawler` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_log_crawler`()
BEGIN
    #     1.1 tạo biến _id và _config_id để lưu lại log id và config id của log đó
    DECLARE _id INT DEFAULT 0;
    DECLARE _config_id INT DEFAULT 0;
#     1.2 thực hiện kiểm tra trong log có tồn tại ít nhất 1 dòng là FILE_PROCESSING
    IF !EXISTS(SELECT 'FILE_PROCESSING'
               FROM logs
               WHERE status = 'FILE_PROCESSING'
                 AND is_delete = 0
               LIMIT 1) THEN
        SELECT logs.id, logs.config_id
        #         1.4.1 không thay đổi giá trị 2 biến
#        1.4.2 thực hiện việc gán giá trị log.id và log.config_id vào biến _id, _config_id
        INTO _id, _config_id
#         1.3 thực hiện join bảng logs và bảng config
        FROM logs
                 join configs on logs.config_id = configs.id
#         1.4 tìm kiếm 1 dòng log có status là FILE_PENDING hay FILE_ERROR chưa bị xóa của ngày hôm đó và của thông tin còn hoạt động
        WHERE (logs.status = 'FILE_PENDING' OR logs.status = 'FILE_ERROR')
          AND is_delete = 0
          AND DATE(logs.create_at) = CURRENT_DATE
          And configs.active = 1
        #     GROUP BY logs.id, logs.config_id
        ORDER BY CASE
                     WHEN logs.status = 'FILE_PENDING' THEN 1
                     WHEN logs.status = 'FILE_ERROR' THEN 2
                     END
        LIMIT 1;
#         1.5 Kiểm tra nếu config_id lấy được khác không(tức tìm được dòng có trạng thái hợp lệ)
        IF _config_id != 0 THEN
#             1.6 thiết lập trạng thái bị xóa cho dòng log đó
            UPDATE logs
            SET logs.is_delete = 1
            WHERE logs.id = _id;
            #               AND (logs.status = 'FILE_PENDING' OR logs.status = 'FILE_ERROR')
#               AND DATE(logs.create_at) = CURRENT_DATE;
# 1.7 thêm 1 dòng log mới có config_id, thời gian bắt đầu và thời giang tạo ngay lúc thêm và có trạng thái "FILE_PROCESSING"
            INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                              create_at)
            VALUES (_config_id, NOW(), NULL, ' ', ' ', 0, 'FILE_PROCESSING', NOW());
        END IF;
#         1.8 Trả về các thông tin cần thiết cho việc crawl của _config_id lấy được
        SELECT configs.id,
               configs.email,
               configs.data_dir_path,
               configs.error_dir_path,
               configs.file_extension,
               configs.file_format,
               configs.prefix,
               resources.scenario,
               resources.base_url,
               resources.limit_page,
               resources.paging_pattern,
               resources.source_page,
               resources.purpose,
               resources.navigate_scenario
        FROM resources
                 JOIN configs ON resources.id = configs.resource_id
                 JOIN logs ON logs.config_id = configs.id
        WHERE configs.id = _config_id
          AND logs.id = _id
          AND active = 1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_log_staging` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_log_staging`()
BEGIN
    #     1.1 tạo biến _id và _config_id để lưu lại log id và config id của log đó
    DECLARE _id INT DEFAULT 0;
    DECLARE _config_id INT DEFAULT 0;
#     1.2 thực hiện kiểm tra trong log có tồn tại ít nhất 1 dòng là STAGING_PROCESSING
    IF !EXISTS(SELECT 'STAGING_PROCESSING'
               FROM logs
               WHERE status = 'STAGING_PROCESSING'
                 AND is_delete = 0
               LIMIT 1) THEN
        SELECT logs.id, logs.config_id
        #         1.4.1 không thay đổi giá trị 2 biến
#        1.4.2 thực hiện việc gán giá trị log.id và log.config_id vào biến _id, _config_id
        INTO _id, _config_id
#         1.3 thực hiện join bảng logs và bảng config
        FROM logs
                 join configs on logs.config_id = configs.id
#         1.4 tìm kiếm 1 dòng log có status là STAGING_PENDING hay STAGING_ERROR chưa bị xóa của ngày hôm đó và của thông tin còn hoạt động
        WHERE (logs.status = 'STAGING_PENDING' OR logs.status = 'STAGING_ERROR')
          AND is_delete = 0
          AND DATE(logs.create_at) = CURRENT_DATE
          And configs.active = 1
#     GROUP BY logs.id, logs.config_id
        ORDER BY CASE
                     WHEN logs.status = 'STAGING_PENDING' THEN 1
                     WHEN logs.status = 'STAGING_ERROR' THEN 2
                     END,
                 logs.create_at ASC
        LIMIT 1;
#         1.5 Kiểm tra nếu config_id lấy được khác không(tức tìm được dòng có trạng thái hợp lệ)
        IF _config_id != 0 THEN
#             1.6 thiết lập trạng thái bị xóa cho dòng log đó
            UPDATE logs
            SET logs.is_delete = 1
            WHERE logs.id = _id;
            #               AND (logs.status = 'FILE_PENDING' OR logs.status = 'STAGING_ERROR')
#               AND DATE(logs.create_at) = CURRENT_DATE;
# 1.7 thêm 1 dòng log mới có config_id, thời gian bắt đầu và thời giang tạo ngay lúc thêm và có trạng thái "STAGING_PROCESSING"
            INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                              create_at)
            VALUES (_config_id, NOW(), NULL, '', ' ', 0, 'STAGING_PROCESSING', NOW());
        END IF;
#         1.8 Trả về các thông tin cần thiết cho việc load của _config_id lấy được
        SELECT configs.id,
               configs.email,
#        he dieu hanh khac thi sua
               logs.file_name as file_path,
               resources.id as resource_id,
               resources.name,
               configs.error_dir_path,
               configs.file_format,
               configs.prefix
        FROM resources
                 JOIN configs ON resources.id = configs.resource_id
                 JOIN logs ON logs.config_id = configs.id

        WHERE configs.id = _config_id
          AND logs.id = _id
          AND active = 1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_log_to_loadfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_log_to_loadfile`()
BEGIN
    SELECT *
    FROM logs
    INNER JOIN configs ON logs.config_id = configs.id
    WHERE DATE(logs.create_at) = CURRENT_DATE
      AND (logs.status = 'STAGING_PENDING' OR logs.status = 'STAGING_ERROR') AND logs.is_delete = 0
    ORDER BY logs.create_at DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_log_transform` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_log_transform`()
BEGIN
    # 1.1 tạo biến _id và _config_id để lưu lại log id và config id của log đó
    DECLARE _id INT DEFAULT 0;
    DECLARE _config_id INT DEFAULT 0;
    # 1.2 thực hiện kiểm tra trong log có tồn tại ít nhất 1 dòng là TRANSFORM_PROCESSING
    IF !EXISTS(SELECT 'TRANSFORM_PROCESSING'
               FROM logs
               WHERE status = 'TRANSFORM_PROCESSING'
                 AND is_delete = 0
               LIMIT 1) THEN
        # Không tồn tại dòng nào có status là TRANSFORM_PROCESSING
        SELECT logs.id, logs.config_id
        # 1.4.1 không thay đổi giá trị 2 biến
        # 1.4.2 thực hiện việc gán giá trị log.id và log.config_id vào biến _id, _config_id
        INTO _id, _config_id
        # 1.3 thực hiện join bảng logs và bảng config
        FROM logs
                 join configs on logs.config_id = configs.id
        # 1.4 tìm kiếm 1 dòng log có status là TRANSFORM_PENDING hay TRANSFORM_ERROR chưa bị xóa của ngày hôm đó và của thông tin còn hoạt động
        WHERE (logs.status = 'TRANSFORM_PENDING' OR logs.status = 'TRANSFORM_ERROR')
          AND is_delete = 0
          AND DATE(logs.create_at) = CURRENT_DATE
          And configs.active = 1
        #  Sắp xếp ưu tiên dòng có status là TRANSFORM_PENDING trước
        ORDER BY CASE
                     WHEN logs.status = 'TRANSFORM_PENDING' THEN 1
                     WHEN logs.status = 'TRANSFORM_ERROR' THEN 2
                     END
        LIMIT 1;
        # 1.5 Kiểm tra nếu config_id lấy được khác không(tức tìm được dòng có trạng thái hợp lệ)
        IF _config_id != 0 THEN
            # 1.6 thiết lập trạng thái bị xóa cho dòng log đó
            UPDATE logs
            SET logs.is_delete = 1
            WHERE logs.id = _id;
            # 1.7 thêm 1 dòng log mới có config_id, thời gian bắt đầu và thời giang tạo ngay lúc thêm và có trạng thái "TRANSFORM_PROCESSING"
            INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                              create_at)
            VALUES (_config_id, NOW(), NULL, ' ', ' ', 0, 'TRANSFORM_PROCESSING', NOW());
        END IF;
        # 1.8 Trả về các thông tin cần thiết cho việc crawl của _config_id lấy được
        SELECT configs.id,
               configs.error_dir_path,
               configs.file_format,
               configs.prefix,
               resources.name as source_name
        FROM resources
                 JOIN configs ON resources.id = configs.resource_id
                 JOIN logs ON logs.config_id = configs.id
        WHERE configs.id = _config_id
          AND logs.id = _id
          AND active = 1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_log_warehouse` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_log_warehouse`()
BEGIN
#     1.1 tạo biến _id và _config_id để lưu lại log id và config id của log đó
    DECLARE _id INT DEFAULT 0;
DECLARE _config_id INT DEFAULT 0;
#     1.2 thực hiện kiểm tra trong log có tồn tại ít nhất 1 dòng là WAREHOUSE_PROCESSING
IF !EXISTS(SELECT 'WAREHOUSE_PROCESSING'
               FROM logs
               WHERE status = 'WAREHOUSE_PROCESSING'
                 AND is_delete = 0
               LIMIT 1) THEN
SELECT logs.id, logs.config_id
#         1.4.1 không thay đổi giá trị 2 biến
#        1.4.2 thực hiện việc gán giá trị log.id và log.config_id vào biến _id, _config_id
INTO _id, _config_id
#         1.3 thực hiện join bảng logs và bảng config
FROM logs
         join configs on logs.config_id = configs.id
#         1.4 tìm kiếm 1 dòng log có status là WAREHOUSE_PENDING hay WAREHOUSE_ERROR chưa bị xóa của ngày hôm đó và của thông tin còn hoạt động
WHERE (logs.status = 'WAREHOUSE_PENDING' OR logs.status = 'WAREHOUSE_ERROR')
  AND is_delete = 0
  AND DATE(logs.create_at) = CURRENT_DATE
  And configs.active = 1
#     GROUP BY logs.id, logs.config_id
ORDER BY
    CASE
             WHEN logs.status = 'WAREHOUSE_PENDING' THEN 1
             WHEN logs.status = 'WAREHOUSE_ERROR' THEN 2
    END,
         logs.create_at ASC
LIMIT 1;
#         1.5 Kiểm tra nếu config_id lấy được khác không(tức tìm được dòng có trạng thái hợp lệ)
IF _config_id != 0 THEN
#             1.6 thiết lập trạng thái bị xóa cho dòng log đó
UPDATE logs
SET logs.is_delete = 1
WHERE logs.id = _id;
#               AND (logs.status = 'FILE_PENDING' OR logs.status = 'WAREHOUSE_ERROR')
#               AND DATE(logs.create_at) = CURRENT_DATE;
# 1.7 thêm 1 dòng log mới có config_id, thời gian bắt đầu và thời giang tạo ngay lúc thêm và có trạng thái "WAREHOUSE_PROCESSING"
INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                  create_at)
VALUES (_config_id, NOW(), NULL, '', ' ', 0, 'WAREHOUSE_PROCESSING', NOW());
END IF;
#         1.8 Trả về các thông tin cần thiết cho việc load của _config_id lấy được
SELECT configs.id,
       configs.email,
#        he dieu hanh khac thi sua
       CONCAT( configs.data_dir_path,'/',logs.file_name) as file_part,
       resources.name,
       configs.error_dir_path,
       configs.file_format,
       configs.prefix
FROM resources
         JOIN configs ON resources.id = configs.resource_id
         JOIN logs ON logs.config_id = configs.id

WHERE configs.id = _config_id
  AND logs.id = _id
  AND active = 1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_script_load_file_by_source` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `get_script_load_file_by_source`(
    IN source ENUM ('muaban.net/bat-dong-san', 'batdongsan.com.vn'),
    IN file_path VARCHAR(255)
)
BEGIN
    -- Declare variables for the SQL statements
    DECLARE truncate_sql TEXT;
    DECLARE truncate_sql_daily TEXT;
    DECLARE set_infile_on_sql TEXT;
    DECLARE load_file_sql TEXT;
    DECLARE set_infile_off_sql TEXT;

    -- Construct the SQL statements based on the source
    IF source = 'batdongsan.com.vn' THEN
        SET truncate_sql = 'TRUNCATE estate_daily_temp_batdongsan_com_vn;';
        SET truncate_sql_daily = 'TRUNCATE estate_daily_batdongsan_com_vn;';
        SET set_infile_on_sql = 'SET GLOBAL local_infile = TRUE;';
        SET load_file_sql = CONCAT(
                'LOAD DATA LOCAL INFILE \'', file_path,
                '\' INTO TABLE estate_daily_temp_batdongsan_com_vn ',
                'FIELDS TERMINATED BY \',\' OPTIONALLY ENCLOSED BY \'"\' ',
                'LINES TERMINATED BY \'\n\' IGNORE 1 LINES ',
                '(nk, url, area, email, legal, price, floors, images, address, bedroom, subject, bathroom, end_date, ',
                'create_at, full_name, start_date, description, orientation);'
                            );
        SET set_infile_off_sql = 'SET GLOBAL local_infile = FALSE;';
    ELSEIF source = 'muaban.net/bat-dong-san' THEN
        SET truncate_sql = 'TRUNCATE estate_daily_temp_muaban_net;';
        SET truncate_sql_daily = 'TRUNCATE estate_daily_muaban_net;';
        SET set_infile_on_sql = 'SET GLOBAL local_infile = TRUE;';
        SET load_file_sql = CONCAT(
                'LOAD DATA LOCAL INFILE \'', file_path,
                '\' INTO TABLE estate_daily_temp_muaban_net ',
                'FIELDS TERMINATED BY \',\' OPTIONALLY ENCLOSED BY \'"\' ',
                'LINES TERMINATED BY \'\n\' IGNORE 1 LINES ',
                '(nk, url, area, legal, phone, price, floors, images, address, bedroom, subject, bathroom, create_at, ',
                'full_name, description, orientation);'
                            );
        SET set_infile_off_sql = 'SET GLOBAL local_infile = FALSE;';
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid source provided. Supported sources are: "batdongsan.com.vn", "muaban.net".';
    END IF;

    -- Return the list of SQL statements as separate rows
    SELECT 'TRUNCATE' AS step, truncate_sql AS sql_statement
    UNION ALL
    SELECT 'TRUNCATE' AS step, truncate_sql_daily AS sql_statement
    UNION ALL
    SELECT 'SET_LOCAL_INFILE_ON', set_infile_on_sql
    UNION ALL
    SELECT 'LOAD_FILE', load_file_sql
    UNION ALL
    SELECT 'SET_LOCAL_INFILE_OFF', set_infile_off_sql;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_log_crawler` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insert_log_crawler`(_config_id INT,
                                    _file_name VARCHAR(200),
                                    _error_file_name VARCHAR(200), _count_row INT,
                                    _status VARCHAR(200)
)
BEGIN
    UPDATE logs
    SET time_end        = NOW(),
        file_name       = _file_name,
        error_file_name = _error_file_name,
        count_row       = _count_row,
        is_delete       = 1
    WHERE status = 'FILE_PROCESSING'
      AND config_id = _config_id;

    if _status = 'FILE_ERROR' THEN
        INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                          create_at)
        VALUES (_config_id, NOW(), NULL, ' ', ' ', 0, _status, NOW());
    ELSEIF _status = 'STAGING_PENDING' THEN
        INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                          create_at)
        VALUES (_config_id, NOW(), NULL, file_name, ' ', 0, _status, NOW());
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_log_staging` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insert_log_staging`(_config_id INT,
                                      _count_row INT,
                                      _error_file_name VARCHAR(200),
                                      _status VARCHAR(200)
)
BEGIN
    UPDATE logs
    SET time_end        = NOW(),
        file_name       = NULL,
        error_file_name = _error_file_name,
        count_row       = _count_row,
        is_delete       = 1
    WHERE status = 'STAGING_PROCESSING'
      AND config_id = _config_id;

    if _status = 'STAGING_ERROR' THEN
        INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                          create_at)
        VALUES (_config_id, NOW(), NULL, ' ', _error_file_name, 0, _status, NOW());
    ELSEIF _status = 'TRANSFORM_PENDING' THEN
        INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                          create_at)
        VALUES (_config_id, NOW(), NULL, ' ', ' ', _count_row, _status, NOW());
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_log_transform` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insert_log_transform`(_config_id INT,
                                      _count_row INT,
                                      _error_file_name VARCHAR(200),
                                      _status VARCHAR(200)
)
BEGIN
    UPDATE logs
    SET time_end        = NOW(),
        file_name       = NULL,
        error_file_name = _error_file_name,
        count_row       = _count_row,
        is_delete       = 1
    WHERE status = 'TRANSFORM_PROCESSING'
      AND config_id = _config_id;

    if _status = 'TRANSFORM_ERROR' THEN
        INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                          create_at)
        VALUES (_config_id, NOW(), NULL, ' ', _error_file_name, 0, _status, NOW());
    ELSEIF _status = 'TRANSFORM_PENDING' THEN
        INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status,
                          create_at)
        VALUES (_config_id, NOW(), NULL, ' ', ' ', _count_row, _status, NOW());
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_log_crawler` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `insert_new_log_crawler`()
BEGIN
    INSERT INTO logs (config_id, time_start, time_end, file_name, error_file_name, count_row, status, create_at)
    VALUES (1, NOW(), NULL, ' ', ' ', 0, 'FILE_PENDING', NOW()),
           (2, NOW(), NULL, ' ', ' ', 0, 'FILE_PENDING', NOW());
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

-- Dump completed on 2025-01-31 13:36:44
