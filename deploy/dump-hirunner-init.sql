-- MySQL dump 10.13  Distrib 8.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: hirunner
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `user_user_permissions`
--

DROP TABLE IF EXISTS `user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_user_permissions_user_id_permission_id_7dc6e2e0_uniq` (`user_id`,`permission_id`),
  KEY `user_user_permission_permission_id_9deb68a3_fk_auth_perm` (`permission_id`),
  CONSTRAINT `user_user_permission_permission_id_9deb68a3_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_user_permissions_user_id_ed4a47ea_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user_permissions`
--

LOCK TABLES `user_user_permissions` WRITE;
/*!40000 ALTER TABLE `user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_groups_user_id_group_id_40beef00_uniq` (`user_id`,`group_id`),
  KEY `user_groups_group_id_b76f8aba_fk_auth_group_id` (`group_id`),
  CONSTRAINT `user_groups_group_id_b76f8aba_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_groups_user_id_abaea130_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_bin NOT NULL,
  `session_data` longtext COLLATE utf8mb4_bin NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add role',6,'add_role'),(22,'Can change role',6,'change_role'),(23,'Can delete role',6,'delete_role'),(24,'Can view role',6,'view_role'),(25,'Can add user role',7,'add_userrole'),(26,'Can change user role',7,'change_userrole'),(27,'Can delete user role',7,'delete_userrole'),(28,'Can view user role',7,'view_userrole'),(29,'Can add user',8,'add_user'),(30,'Can change user',8,'change_user'),(31,'Can delete user',8,'delete_user'),(32,'Can view user',8,'view_user'),(33,'Can add case',9,'add_case'),(34,'Can change case',9,'change_case'),(35,'Can delete case',9,'delete_case'),(36,'Can view case',9,'view_case'),(37,'Can add case result',10,'add_caseresult'),(38,'Can change case result',10,'change_caseresult'),(39,'Can delete case result',10,'delete_caseresult'),(40,'Can view case result',10,'view_caseresult'),(41,'Can add fixture',11,'add_fixture'),(42,'Can change fixture',11,'change_fixture'),(43,'Can delete fixture',11,'delete_fixture'),(44,'Can view fixture',11,'view_fixture'),(45,'Can add plan',12,'add_plan'),(46,'Can change plan',12,'change_plan'),(47,'Can delete plan',12,'delete_plan'),(48,'Can view plan',12,'view_plan'),(49,'Can add plan case',13,'add_plancase'),(50,'Can change plan case',13,'change_plancase'),(51,'Can delete plan case',13,'delete_plancase'),(52,'Can view plan case',13,'view_plancase'),(53,'Can add plan result',14,'add_planresult'),(54,'Can change plan result',14,'change_planresult'),(55,'Can delete plan result',14,'delete_planresult'),(56,'Can view plan result',14,'view_planresult'),(57,'Can add project',15,'add_project'),(58,'Can change project',15,'change_project'),(59,'Can delete project',15,'delete_project'),(60,'Can view project',15,'view_project'),(61,'Can add env var',16,'add_envvar'),(62,'Can change env var',16,'change_envvar'),(63,'Can delete env var',16,'delete_envvar'),(64,'Can view env var',16,'view_envvar'),(65,'Can add django job',17,'add_djangojob'),(66,'Can change django job',17,'change_djangojob'),(67,'Can delete django job',17,'delete_djangojob'),(68,'Can view django job',17,'view_djangojob'),(69,'Can add django job execution',18,'add_djangojobexecution'),(70,'Can change django job execution',18,'change_djangojobexecution'),(71,'Can delete django job execution',18,'delete_djangojobexecution'),(72,'Can view django job execution',18,'view_djangojobexecution');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_plan_run_history`
--

DROP TABLE IF EXISTS `test_plan_run_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_plan_run_history` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'èµ„æºid',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `test_plan_id` int NOT NULL,
  `result` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `elapsed` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `output` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `case_num_all` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `case_num_success` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `report_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `run_user_nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `run_time` datetime(6) DEFAULT NULL,
  `jenkins_log_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_plan_run_history`
--

LOCK TABLES `test_plan_run_history` WRITE;
/*!40000 ALTER TABLE `test_plan_run_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_plan_run_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_bin NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nickname` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'pbkdf2_sha256$216000$8r42gNv7a4gS$CpRKRbg3EjJsaNCke4/b7r2HrdK9XhoPp0KvvoH/j8o=',NULL,0,'admin','','','',1,1,'2023-11-04 07:28:26.372473','ç®¡ç†å‘˜');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,'2010-07-01 10:20:30.000000','2010-07-01 10:20:30.000000',1,1);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_apscheduler_djangojob`
--

DROP TABLE IF EXISTS `django_apscheduler_djangojob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_apscheduler_djangojob` (
  `id` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `next_run_time` datetime(6) DEFAULT NULL,
  `job_state` longblob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_apscheduler_djangojob_next_run_time_2f022619` (`next_run_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_apscheduler_djangojob`
--

LOCK TABLES `django_apscheduler_djangojob` WRITE;
/*!40000 ALTER TABLE `django_apscheduler_djangojob` DISABLE KEYS */;
INSERT INTO `django_apscheduler_djangojob` VALUES ('delete_old_job_executions','2024-01-29 00:00:00.000000',_binary '€•E\0\0\0\0\0\0}”(Œversion”KŒid”Œdelete_old_job_executions”Œfunc”Œ-hirunner.views.task:delete_old_job_executions”Œtrigger”Œapscheduler.triggers.cron”ŒCronTrigger”“”)”}”(hKŒtimezone”Œbuiltins”Œgetattr”“”Œzoneinfo”ŒZoneInfo”“”Œ	_unpickle”†”R”Œ\rAsia/Shanghai”K†”R”Œ\nstart_date”NŒend_date”NŒfields”]”(Œ apscheduler.triggers.cron.fields”Œ	BaseField”“”)”}”(Œname”Œyear”Œ\nis_default”ˆŒexpressions”]”Œ%apscheduler.triggers.cron.expressions”Œ\rAllExpression”“”)”}”Œstep”NsbaubhŒ\nMonthField”“”)”}”(h\"Œmonth”h$ˆh%]”h))”}”h,NsbaubhŒDayOfMonthField”“”)”}”(h\"Œday”h$ˆh%]”h))”}”h,NsbaubhŒ	WeekField”“”)”}”(h\"Œweek”h$ˆh%]”h))”}”h,NsbaubhŒDayOfWeekField”“”)”}”(h\"Œday_of_week”h$‰h%]”h\'ŒWeekdayRangeExpression”“”)”}”(h,NŒfirst”K\0Œlast”K\0ubaubh)”}”(h\"Œhour”h$‰h%]”h\'ŒRangeExpression”“”)”}”(h,NhOK\0hPK\0ubaubh)”}”(h\"Œminute”h$‰h%]”hV)”}”(h,NhOK\0hPK\0ubaubh)”}”(h\"Œsecond”h$ˆh%]”hV)”}”(h,NhOK\0hPK\0ubaubeŒjitter”NubŒexecutor”Œdefault”Œargs”)Œkwargs”}”h\"hŒmisfire_grace_time”KŒcoalesce”ˆŒ\rmax_instances”KŒ\rnext_run_time”Œdatetime”Œdatetime”“”C\n\è\0\0\0\0\0\0”h†”R”u.'),('product_100760','2024-01-28 14:00:00.000000',_binary '€•;\0\0\0\0\0\0}”(Œversion”KŒid”Œproduct_100760”Œfunc”Œ\'hirunner.views.run:pull_release_version”Œtrigger”Œapscheduler.triggers.cron”ŒCronTrigger”“”)”}”(hKŒtimezone”Œbuiltins”Œgetattr”“”Œzoneinfo”ŒZoneInfo”“”Œ	_unpickle”†”R”Œ\rAsia/Shanghai”K†”R”Œ\nstart_date”NŒend_date”NŒfields”]”(Œ apscheduler.triggers.cron.fields”Œ	BaseField”“”)”}”(Œname”Œyear”Œ\nis_default”ˆŒexpressions”]”Œ%apscheduler.triggers.cron.expressions”Œ\rAllExpression”“”)”}”Œstep”NsbaubhŒ\nMonthField”“”)”}”(h\"Œmonth”h$‰h%]”h))”}”h,NsbaubhŒDayOfMonthField”“”)”}”(h\"Œday”h$‰h%]”h))”}”h,NsbaubhŒ	WeekField”“”)”}”(h\"Œweek”h$ˆh%]”h))”}”h,NsbaubhŒDayOfWeekField”“”)”}”(h\"Œday_of_week”h$‰h%]”h))”}”h,Nsbaubh)”}”(h\"Œhour”h$‰h%]”h))”}”h,Ksbaubh)”}”(h\"Œminute”h$‰h%]”h\'ŒRangeExpression”“”)”}”(h,NŒfirst”K\0Œlast”K\0ubaubh)”}”(h\"Œsecond”h$ˆh%]”hX)”}”(h,Nh[K\0h\\K\0ubaubeŒjitter”NubŒexecutor”Œdefault”Œargs”Œ100243”Œäº§å“1”Œäº§å“1”‡”Œkwargs”}”h\"Œpull_release_version”Œmisfire_grace_time”KŒcoalesce”ˆŒ\rmax_instances”KŒ\rnext_run_time”Œdatetime”Œdatetime”“”C\n\è\0\0\0\0\0”h†”R”u.'),('product_100761','2024-01-28 14:00:00.000000',_binary '€•4\0\0\0\0\0\0}”(Œversion”KŒid”Œproduct_100761”Œfunc”Œ\'hirunner.views.run:pull_release_version”Œtrigger”Œapscheduler.triggers.cron”ŒCronTrigger”“”)”}”(hKŒtimezone”Œbuiltins”Œgetattr”“”Œzoneinfo”ŒZoneInfo”“”Œ	_unpickle”†”R”Œ\rAsia/Shanghai”K†”R”Œ\nstart_date”NŒend_date”NŒfields”]”(Œ apscheduler.triggers.cron.fields”Œ	BaseField”“”)”}”(Œname”Œyear”Œ\nis_default”ˆŒexpressions”]”Œ%apscheduler.triggers.cron.expressions”Œ\rAllExpression”“”)”}”Œstep”NsbaubhŒ\nMonthField”“”)”}”(h\"Œmonth”h$‰h%]”h))”}”h,NsbaubhŒDayOfMonthField”“”)”}”(h\"Œday”h$‰h%]”h))”}”h,NsbaubhŒ	WeekField”“”)”}”(h\"Œweek”h$ˆh%]”h))”}”h,NsbaubhŒDayOfWeekField”“”)”}”(h\"Œday_of_week”h$‰h%]”h))”}”h,Nsbaubh)”}”(h\"Œhour”h$‰h%]”h))”}”h,Ksbaubh)”}”(h\"Œminute”h$‰h%]”h\'ŒRangeExpression”“”)”}”(h,NŒfirst”K\0Œlast”K\0ubaubh)”}”(h\"Œsecond”h$ˆh%]”hX)”}”(h,Nh[K\0h\\K\0ubaubeŒjitter”NubŒexecutor”Œdefault”Œargs”Œ100244”Œäº§å“2”Œ\0”‡”Œkwargs”}”h\"Œpull_release_version”Œmisfire_grace_time”KŒcoalesce”ˆŒ\rmax_instances”KŒ\rnext_run_time”Œdatetime”Œdatetime”“”C\n\è\0\0\0\0\0”h†”R”u.');
/*!40000 ALTER TABLE `django_apscheduler_djangojob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'DPMSäº§å“id',
  `release_plan_name_kw` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'å‘å¸ƒè®¡åˆ’åç§°å…³é”®å­—',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `dev_users` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `test_users` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `git_repository` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `git_branch` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `product_id` int NOT NULL COMMENT 'äº§å“id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_un` (`product_id`,`release_plan_name_kw`)
) ENGINE=InnoDB AUTO_INCREMENT=100762 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (100760,'äº§å“1','2024-01-24 23:39:45.811927','2024-01-24 23:39:45.811927','äº§å“1','lisi(æå››)','zhangsan(å¼ ä¸‰)',NULL,NULL,1,100243),(100761,'','2024-01-27 18:59:13.288502','2024-01-27 18:59:13.288502','äº§å“2','lisi(æå››)','zhangshan(å¼ ä¸‰)',NULL,NULL,1,100244);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `release_plan`
--

DROP TABLE IF EXISTS `release_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `release_plan` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'èµ„æºid',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `release_plan_id` int NOT NULL,
  `product_id` int NOT NULL COMMENT 'äº§å“id',
  `release_plan_name_kw` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'å‘å¸ƒè®¡åˆ’åç§°å…³é”®å­—',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `start_date` date DEFAULT NULL COMMENT 'å¼€å§‹æ—¶é—´',
  `end_date` date DEFAULT NULL COMMENT 'ç»“æŸæ—¶é—´',
  `uat_end_date` date DEFAULT NULL COMMENT 'UATè®¡åˆ’ç»“æŸæ—¶é—´',
  `start_release_date` date DEFAULT NULL COMMENT 'å¼€å§‹å‘å¸ƒæ—¥æœŸ',
  `actual_end_date` date DEFAULT NULL COMMENT 'å®é™…ç»“æŸæ—¶é—´',
  `start_test_date` date DEFAULT NULL COMMENT 'æµ‹è¯•å¼€å§‹æ—¶é—´',
  `start_uat_test_date` date DEFAULT NULL COMMENT 'uatæµ‹è¯•å¼€å§‹æ—¶é—´',
  `status` int NOT NULL,
  `version_no` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `release_plan_id` (`release_plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100763 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `release_plan`
--

LOCK TABLES `release_plan` WRITE;
/*!40000 ALTER TABLE `release_plan` DISABLE KEYS */;
INSERT INTO `release_plan` VALUES (100760,'2024-01-19 05:00:00.000000','2024-01-23 05:00:00.000000',147359,100243,'äº§å“1','ã€äº§å“1ã€‘24.01.24éœ€æ±‚',NULL,'2024-01-30',NULL,'2024-01-24',NULL,'2024-01-19','2024-01-19',3,'ã€äº§å“1ã€‘24.01.24éœ€æ±‚'),(100762,'2024-01-19 05:00:00.000000','2024-01-27 05:00:00.000000',147360,100243,'äº§å“1','ã€äº§å“1ã€‘24.03.30éœ€æ±‚',NULL,'2024-03-30',NULL,'2024-02-26',NULL,'2024-03-30','2024-03-30',3,'ã€äº§å“1ã€‘24.03.30éœ€æ±‚');
/*!40000 ALTER TABLE `release_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_bin,
  `object_repr` varchar(200) COLLATE utf8mb4_bin NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_bin NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_plan`
--

DROP TABLE IF EXISTS `test_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_plan` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'èµ„æºid',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `release_plan_id` int NOT NULL,
  `stage` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `dev_users` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `test_users` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `git_repository` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `git_branch` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `run_cmd` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `crontab_switch` int NOT NULL DEFAULT '0',
  `crontab_expression` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `email_switch` int NOT NULL DEFAULT '0',
  `email_sendto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `jenkins_node` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'node-172.21.0.1' COMMENT 'jenkinsnodeèŠ‚ç‚¹åç§°',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `version_no` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `product_id` int NOT NULL COMMENT 'äº§å“id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100762 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_plan`
--

LOCK TABLES `test_plan` WRITE;
/*!40000 ALTER TABLE `test_plan` DISABLE KEYS */;
INSERT INTO `test_plan` VALUES (100760,'2024-01-25 00:29:46.210292','2024-01-25 00:30:12.453754',147359,'regress','','','git@github.com:darrenWang0827/hitest.git','master','python3 run_example_with_submodule.py',0,'',0,'',0,'node-192.168.1.4','æµ‹è¯•è®¡åˆ’12','ã€äº§å“1ã€‘24.01.24éœ€æ±‚',100243),(100761,'2024-01-25 00:29:51.963077','2024-01-25 00:29:51.963077',147359,'regress','','','git@github.com:darrenWang0827/hitest.git','master','python3 run_example_with_submodule.py',0,'',0,'',0,'node-192.168.1.4','æµ‹è¯•è®¡åˆ’1_copy','ã€äº§å“1ã€‘24.01.24éœ€æ±‚',100243);
/*!40000 ALTER TABLE `test_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-11-04 15:27:13.799696'),(2,'contenttypes','0002_remove_content_type_name','2023-11-04 15:27:13.876265'),(3,'auth','0001_initial','2023-11-04 15:27:13.970775'),(4,'auth','0002_alter_permission_name_max_length','2023-11-04 15:27:14.236040'),(5,'auth','0003_alter_user_email_max_length','2023-11-04 15:27:14.244037'),(6,'auth','0004_alter_user_username_opts','2023-11-04 15:27:14.252222'),(7,'auth','0005_alter_user_last_login_null','2023-11-04 15:27:14.260223'),(8,'auth','0006_require_contenttypes_0002','2023-11-04 15:27:14.264265'),(9,'auth','0007_alter_validators_add_error_messages','2023-11-04 15:27:14.273257'),(10,'auth','0008_alter_user_username_max_length','2023-11-04 15:27:14.281256'),(11,'auth','0009_alter_user_last_name_max_length','2023-11-04 15:27:14.289256'),(12,'auth','0010_alter_group_name_max_length','2023-11-04 15:27:14.307220'),(13,'auth','0011_update_proxy_permissions','2023-11-04 15:27:14.316223'),(14,'auth','0012_alter_user_first_name_max_length','2023-11-04 15:27:14.323254'),(15,'user','0001_initial','2023-11-04 15:27:14.477143'),(16,'admin','0001_initial','2023-11-04 15:27:14.846726'),(17,'admin','0002_logentry_remove_auto_add','2023-11-04 15:27:14.976261'),(18,'admin','0003_logentry_add_action_flag_choices','2023-11-04 15:27:14.985251'),(19,'django_apscheduler','0001_initial','2023-11-04 15:27:15.056206'),(20,'django_apscheduler','0002_auto_20180412_0758','2023-11-04 15:27:15.207408'),(21,'django_apscheduler','0003_auto_20200716_1632','2023-11-04 15:27:15.333118'),(22,'django_apscheduler','0004_auto_20200717_1043','2023-11-04 15:27:15.534545'),(23,'django_apscheduler','0005_migrate_name_to_id','2023-11-04 15:27:15.550625'),(24,'django_apscheduler','0006_remove_djangojob_name','2023-11-04 15:27:15.604136'),(25,'django_apscheduler','0007_auto_20200717_1404','2023-11-04 15:27:15.676543'),(26,'django_apscheduler','0008_remove_djangojobexecution_started','2023-11-04 15:27:15.717186'),(27,'sessions','0001_initial','2023-11-04 15:27:15.749336'),(28,'teprunner','0001_initial','2023-11-04 15:27:16.011987');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(17,'django_apscheduler','djangojob'),(18,'django_apscheduler','djangojobexecution'),(5,'sessions','session'),(9,'teprunner','case'),(10,'teprunner','caseresult'),(16,'teprunner','envvar'),(11,'teprunner','fixture'),(12,'teprunner','plan'),(13,'teprunner','plancase'),(14,'teprunner','planresult'),(15,'teprunner','project'),(6,'user','role'),(8,'user','user'),(7,'user','userrole');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_apscheduler_djangojobexecution`
--

DROP TABLE IF EXISTS `django_apscheduler_djangojobexecution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_apscheduler_djangojobexecution` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `run_time` datetime(6) NOT NULL,
  `duration` decimal(15,2) DEFAULT NULL,
  `finished` decimal(15,2) DEFAULT NULL,
  `exception` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL,
  `traceback` longtext COLLATE utf8mb4_bin,
  `job_id` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_apscheduler_djangojobexecution_run_time_16edd96b` (`run_time`),
  KEY `django_apscheduler_djangojobexecution_job_id_daf5090a_fk` (`job_id`),
  CONSTRAINT `django_apscheduler_djangojobexecution_job_id_daf5090a_fk` FOREIGN KEY (`job_id`) REFERENCES `django_apscheduler_djangojob` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_apscheduler_djangojobexecution`
--

LOCK TABLES `django_apscheduler_djangojobexecution` WRITE;
/*!40000 ALTER TABLE `django_apscheduler_djangojobexecution` DISABLE KEYS */;
INSERT INTO `django_apscheduler_djangojobexecution` VALUES (1,'Error!','2024-01-25 00:00:00.000000',0.05,1706112000.05,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100760'),(2,'Missed!','2024-01-27 17:00:00.000000',3220.18,1706349220.18,'Run time of job \'product_100760\' was missed!',NULL,'product_100760'),(3,'Error!','2024-01-27 18:00:00.000000',0.03,1706349600.03,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100760'),(4,'Error!','2024-01-27 19:00:00.000000',0.03,1706353200.03,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100760'),(5,'Error!','2024-01-27 19:00:00.000000',0.07,1706353200.07,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100761'),(6,'Error!','2024-01-27 20:00:00.000000',0.03,1706356800.03,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100760'),(7,'Error!','2024-01-27 20:00:00.000000',0.05,1706356800.05,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100761'),(8,'Error!','2024-01-27 21:00:00.000000',0.21,1706360400.21,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100760'),(9,'Error!','2024-01-27 21:00:00.000000',0.23,1706360400.23,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100761'),(10,'Error!','2024-01-27 22:00:00.000000',0.24,1706364000.24,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100760'),(11,'Error!','2024-01-27 22:00:00.000000',0.26,1706364000.26,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100761'),(12,'Error!','2024-01-27 23:00:00.000000',0.09,1706367600.09,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100760'),(13,'Error!','2024-01-27 23:00:00.000000',0.10,1706367600.10,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100761'),(14,'Error!','2024-01-28 00:00:00.000000',0.05,1706371200.05,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100760'),(15,'Error!','2024-01-28 00:00:00.000000',0.06,1706371200.06,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100761'),(16,'Missed!','2024-01-28 12:00:00.000000',2762.87,1706417162.87,'Run time of job \'product_100760\' was missed!',NULL,'product_100760'),(17,'Missed!','2024-01-28 12:00:00.000000',2762.90,1706417162.90,'Run time of job \'product_100761\' was missed!',NULL,'product_100761'),(18,'Error!','2024-01-28 13:00:00.000000',0.06,1706418000.06,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100760'),(19,'Error!','2024-01-28 13:00:00.000000',0.05,1706418000.05,'{\'releasePLanNameKw\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'planAlasName\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')], \'crontabSwitch\': [ErrorDetail(string=\'è¯¥å­—æ®µæ˜¯å¿…å¡«é¡¹ã€‚\', code=\'required\')]}','  File \"D:\\Python\\Python310\\lib\\site-packages\\apscheduler\\executors\\base.py\", line 125, in run_job\n    retval = job.func(*job.args, **job.kwargs)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 63, in pull_release_version\n    create_product_default_plan_config(product_id, product_name, release_plan_name_kw)\n  File \"D:\\gitProjectsLearn\\hirunner-backend\\hirunner\\views\\run.py\", line 57, in create_product_default_plan_config\n    serializer.is_valid(raise_exception=True)\n  File \"D:\\Python\\Python310\\lib\\site-packages\\rest_framework\\serializers.py\", line 228, in is_valid\n    raise ValidationError(self.errors)\n','product_100761');
/*!40000 ALTER TABLE `django_apscheduler_djangojobexecution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_plan_config`
--

DROP TABLE IF EXISTS `product_plan_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_plan_config` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'èµ„æºid',
  `product_id` int NOT NULL COMMENT 'äº§å“id',
  `product_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'äº§å“åç§°',
  `release_plan_name_kw` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'å‘å¸ƒè®¡åˆ’åç§°å…³é”®å­—',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `stage` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `plan_alias_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `git_repository` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `git_branch` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `run_cmd` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `crontab_switch` int NOT NULL DEFAULT '0',
  `crontab_expression` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `email_switch` int NOT NULL DEFAULT '0',
  `email_sendto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0',
  `jenkins_node` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'node-172.21.0.1' COMMENT 'jenkinsnodeèŠ‚ç‚¹åç§°',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100760 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_plan_config`
--

LOCK TABLES `product_plan_config` WRITE;
/*!40000 ALTER TABLE `product_plan_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_plan_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL,
  `auth` json NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'2010-07-01 10:20:30.000000','2010-07-01 10:20:30.000000','ç®¡ç†å‘˜','[{\"id\": \"home\", \"name\": \"é¦–é¡µ\", \"access\": true}, {\"id\": \"dashboard\", \"name\": \"ä»ªè¡¨ç›˜\", \"access\": true}, {\"id\": \"config\", \"name\": \"é…ç½®ç®¡ç†\", \"access\": true}, {\"id\": \"userManagement\", \"name\": \"ç”¨æˆ·ç®¡ç†\", \"access\": true}, {\"id\": \"productManagement\", \"name\": \"äº§å“ç®¡ç†\", \"access\": true}, {\"id\": \"testplan\", \"name\": \"æµ‹è¯•è®¡åˆ’\", \"access\": true}, {\"id\": \"testPlanManagement\", \"name\": \"è®¡åˆ’æ‰§è¡Œ\", \"access\": true}]'),(2,'2010-07-01 10:20:30.000000','2010-07-01 10:20:30.000000','æµ‹è¯•','[{\"id\": \"home\", \"name\": \"é¦–é¡µ\", \"access\": true}, {\"id\": \"dashboard\", \"name\": \"ä»ªè¡¨ç›˜\", \"access\": true}, {\"id\": \"config\", \"name\": \"é…ç½®ç®¡ç†\", \"access\": true}, {\"id\": \"userManagement\", \"name\": \"ç”¨æˆ·ç®¡ç†\", \"access\": true}, {\"id\": \"productManagement\", \"name\": \"äº§å“ç®¡ç†\", \"access\": true}, {\"id\": \"testplan\", \"name\": \"æµ‹è¯•è®¡åˆ’\", \"access\": true}, {\"id\": \"testPlanManagement\", \"name\": \"è®¡åˆ’æ‰§è¡Œ\", \"access\": true}]'),(3,'2010-07-01 10:20:30.000000','2010-07-01 10:20:30.000000','å¼€å‘','[{\"id\": \"home\", \"name\": \"é¦–é¡µ\", \"access\": true}, {\"id\": \"dashboard\", \"name\": \"ä»ªè¡¨ç›˜\", \"access\": true}, {\"id\": \"config\", \"name\": \"é…ç½®ç®¡ç†\", \"access\": true}, {\"id\": \"userManagement\", \"name\": \"ç”¨æˆ·ç®¡ç†\", \"access\": true}, {\"id\": \"productManagement\", \"name\": \"äº§å“ç®¡ç†\", \"access\": true}, {\"id\": \"testplan\", \"name\": \"æµ‹è¯•è®¡åˆ’\", \"access\": true}, {\"id\": \"testPlanManagement\", \"name\": \"è®¡åˆ’æ‰§è¡Œ\", \"access\": true}]');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-28 13:12:30
