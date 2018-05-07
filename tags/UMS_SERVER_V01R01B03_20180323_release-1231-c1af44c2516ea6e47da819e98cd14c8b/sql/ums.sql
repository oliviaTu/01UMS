-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: ums
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `t_conf`
--

DROP TABLE IF EXISTS `t_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `conf_key` varchar(255) NOT NULL,
  `conf_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_conf_conf_key` (`conf_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_dictionary`
--

DROP TABLE IF EXISTS `t_dictionary`;
CREATE TABLE `t_dictionary` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `dict_type` tinyint(4) COLLATE utf8_bin NOT NULL,
  `dict_name` varchar(128) COLLATE utf8_bin NOT NULL,
  `dict_value` varchar(128) COLLATE utf8_bin NOT NULL,
  `isfixed` tinyint(4) COLLATE utf8_bin DEFAULT 1,
  `creater` varchar(128) COLLATE utf8_bin NOT NULL,
  `updater` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `create_time` datetime COLLATE utf8_bin NOT NULL,
  `update_time` datetime COLLATE utf8_bin DEFAULT NULL,
  `note` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `t_dict_type_name_key` (`dict_type`,`dict_name`),
  UNIQUE KEY `t_dict_type_value_key` (`dict_type`,`dict_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


--
-- Table structure for table `t_divide_policy`
--

DROP TABLE IF EXISTS `t_divide_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_divide_policy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_name` varchar(255) DEFAULT NULL,
  `divide_day` int(11) DEFAULT NULL,
  `policy_code` varchar(32) NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime DEFAULT NULL,
  `creater` varchar(32) DEFAULT NULL,
  `updater` varchar(32) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_dividePolicy_policy_code` (`policy_code`),
  KEY `Index_dividePolicy_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_divide_policy_ref_type`
--

DROP TABLE IF EXISTS `t_divide_policy_ref_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_divide_policy_ref_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_code` varchar(32) DEFAULT NULL,
  `equ_type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `equ_type` (`equ_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_operation_log`
--

DROP TABLE IF EXISTS `t_operation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_operation_log` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `user_name` char(32) COLLATE utf8_bin NOT NULL,
  `operation` char(2) COLLATE utf8_bin NOT NULL,
  `operation_ip` char(32) COLLATE utf8_bin NOT NULL,
  `operation_service` longtext COLLATE utf8_bin NOT NULL,
  `request_body` text COLLATE utf8_bin,
  `request_args` longtext COLLATE utf8_bin,
  `operation_result` char(1) COLLATE utf8_bin NOT NULL,
  `operation_message` longtext COLLATE utf8_bin,
  `execute_time` int(32) NOT NULL,
  `operation_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_usr_name` (`user_name`),
  KEY `idx_operation_time` (`operation_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_package`
--

DROP TABLE IF EXISTS `t_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_package` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `policy_code` varchar(32) DEFAULT NULL,
  `package_code` varchar(32) NOT NULL,
  `package_name` varchar(255) DEFAULT NULL,
  `package_day` int(11) DEFAULT NULL,
  `money` decimal(10,0) DEFAULT NULL,
  `package_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_Package_package_code` (`package_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-10 11:34:03
