-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 09, 2015 at 08:13 PM
-- Server version: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `qubicle`
--
CREATE DATABASE IF NOT EXISTS `qubicle` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `qubicle`;

-- --------------------------------------------------------

--
-- Table structure for table `log_tm_api`
--

CREATE TABLE IF NOT EXISTS `log_tm_api` (
  `log_tm_api_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_api_api_id` int(11) DEFAULT NULL,
  `log_tm_api_activity` varchar(45) NOT NULL COMMENT 'nama module yang di akses',
  `log_tm_api_parameter_sent` text,
  `log_tm_api_status` varchar(10) NOT NULL,
  `log_tm_api_message` varchar(50) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip_address` varchar(45) NOT NULL,
  PRIMARY KEY (`log_tm_api_id`,`create_date`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `log_tm_api`
--

INSERT INTO `log_tm_api` (`log_tm_api_id`, `tm_api_api_id`, `log_tm_api_activity`, `log_tm_api_parameter_sent`, `log_tm_api_status`, `log_tm_api_message`, `create_date`, `ip_address`) VALUES
(1, 1, 'API Auth', '', '5', 'Invalid Auth API', '2015-10-09 08:17:34', '::1'),
(2, 1, 'API Auth', '', '5', 'Invalid Auth API', '2015-10-09 08:17:56', '::1'),
(3, 1, 'API Auth', '', '5', 'Invalid Auth API', '2015-10-09 08:18:24', '::1'),
(4, 1, 'API Auth', '', '5', 'Invalid Auth API', '2015-10-09 08:18:35', '::1'),
(5, 1, 'API Auth', '', '5', 'Invalid Auth API', '2015-10-09 08:19:54', '::1');

-- --------------------------------------------------------

--
-- Table structure for table `log_user_activity`
--

CREATE TABLE IF NOT EXISTS `log_user_activity` (
  `log_user_activity_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_user_user_id` bigint(20) NOT NULL,
  `activity` varchar(45) NOT NULL,
  `status` varchar(50) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`log_user_activity_id`,`tm_user_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_api`
--

CREATE TABLE IF NOT EXISTS `tm_api` (
  `api_id` int(11) NOT NULL AUTO_INCREMENT,
  `api_user` varchar(45) NOT NULL,
  `api_key` varchar(80) NOT NULL,
  `api_secret` varchar(80) NOT NULL,
  `api_last_connect` datetime DEFAULT NULL,
  `api_active` enum('1','0') NOT NULL DEFAULT '1',
  `api_deleted` enum('1','0') NOT NULL DEFAULT '0',
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`api_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tm_api`
--

INSERT INTO `tm_api` (`api_id`, `api_user`, `api_key`, `api_secret`, `api_last_connect`, `api_active`, `api_deleted`, `create_date`, `last_update`) VALUES
(1, 'qubicle back end', 'Y2FlTFdVVVNDdnloMHYycEQ2b2Fvb1FwY3FVRHpyTytNN1pIeHBleGQ4MD0=', '34bbc814aebed6a77062885c966809b8c5fa711a8f4ee86cbb51055638af49e1', '2015-10-09 15:23:41', '1', '0', '0000-00-00 00:00:00', '2015-10-09 08:23:41');

-- --------------------------------------------------------

--
-- Table structure for table `tm_follow_person`
--

CREATE TABLE IF NOT EXISTS `tm_follow_person` (
  `follow_person_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_user_user_id` bigint(20) NOT NULL,
  `tm_user_user_id_following` bigint(20) NOT NULL COMMENT 'user id that followed',
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`follow_person_id`,`tm_user_user_id`,`tm_user_user_id_following`),
  KEY `fk_tblFollowPerson_following_idx` (`tm_user_user_id_following`),
  KEY `fk_tblFollowPerson_tblUser1` (`tm_user_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_follow_qube`
--

CREATE TABLE IF NOT EXISTS `tm_follow_qube` (
  `follow_qube_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_user_user_id` bigint(20) NOT NULL,
  `tm_qube_qube_id` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`follow_qube_id`,`tm_user_user_id`,`tm_qube_qube_id`),
  KEY `fk_tblFollowCube_tblUser1_idx` (`tm_user_user_id`),
  KEY `fk_tblFollowCube_tblCube1_idx` (`tm_qube_qube_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_interest`
--

CREATE TABLE IF NOT EXISTS `tm_interest` (
  `interest_id` int(11) NOT NULL AUTO_INCREMENT,
  `interest_name` varchar(45) NOT NULL,
  `interest_deleted` enum('0','1') NOT NULL,
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`interest_id`),
  UNIQUE KEY `interest_name_UNIQUE` (`interest_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_post`
--

CREATE TABLE IF NOT EXISTS `tm_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_qube_qube_id` bigint(20) NOT NULL,
  `tm_user_user_id` bigint(20) NOT NULL COMMENT 'user who create post on qube',
  `post_content_type` enum('article','video','audio','url','image') NOT NULL,
  `post_content_text` text,
  `post_reqube` enum('0','1') NOT NULL,
  `post_parent_qube_id` bigint(20) DEFAULT NULL COMMENT 'qube_id if post reqube',
  `post_publish` enum('1','0') NOT NULL,
  `post_publish_date` datetime NOT NULL,
  `post_deleted` enum('1','0') NOT NULL DEFAULT '0',
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`,`tm_qube_qube_id`,`tm_user_user_id`),
  KEY `fk_tblPost_tblCube1_idx` (`tm_qube_qube_id`),
  KEY `fk_tblPost_tblUser1_idx` (`tm_user_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_post_attachment`
--

CREATE TABLE IF NOT EXISTS `tm_post_attachment` (
  `post_attachment_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_post_post_id` bigint(20) NOT NULL,
  `post_attachment_type` enum('article','video','audio','url','image') NOT NULL,
  `post_attachment_path` varchar(100) DEFAULT NULL,
  `post_attachment_real_name` varchar(220) DEFAULT NULL,
  `post_attachment_enc_name` varchar(80) DEFAULT NULL,
  `post_attachment_deleted` enum('1','0') NOT NULL DEFAULT '0',
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_attachment_id`,`tm_post_post_id`),
  KEY `fk_tm_post_attachment_tm_post1_idx` (`tm_post_post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_post_moderation`
--

CREATE TABLE IF NOT EXISTS `tm_post_moderation` (
  `post_moderation_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This table can be expanded to multi approval for one post',
  `tm_post_post_id` bigint(20) NOT NULL,
  `post_moderation_approval` enum('0','1') NOT NULL COMMENT '1=approve 0=decline',
  `post_moderation_user_id` bigint(20) NOT NULL COMMENT 'user id that moderation post qube',
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`post_moderation_id`,`tm_post_post_id`,`post_moderation_user_id`),
  KEY `fk_tm_post_moderation_tm_user1_idx` (`post_moderation_user_id`),
  KEY `fk_tblPostModeration_tblPost1` (`tm_post_post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_privilege`
--

CREATE TABLE IF NOT EXISTS `tm_privilege` (
  `privilege_id` int(11) NOT NULL,
  `tm_user_type_user_type_id` int(11) NOT NULL,
  `privilege_name` varchar(45) NOT NULL,
  `privilege_value` enum('0','1') NOT NULL,
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`privilege_id`,`tm_user_type_user_type_id`),
  KEY `fk_tblPrivilege_tblUserType1_idx` (`tm_user_type_user_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tm_qube`
--

CREATE TABLE IF NOT EXISTS `tm_qube` (
  `qube_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_user_user_id` bigint(20) NOT NULL COMMENT 'alias qube owner id',
  `qube_name` varchar(45) NOT NULL,
  `qube_image_cover_path` varchar(100) DEFAULT NULL,
  `qube_image_cover_real_name` varchar(200) DEFAULT NULL,
  `qube_image_cover_enc_name` varchar(80) DEFAULT NULL,
  `qube_config_currate` enum('1','0') NOT NULL,
  `qube_config_reqube` enum('1','0') NOT NULL,
  `qube_deleted` enum('0','1') NOT NULL,
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`qube_id`,`tm_user_user_id`),
  KEY `fk_tblCube_tblUser1_idx` (`tm_user_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_qube_request_invite`
--

CREATE TABLE IF NOT EXISTS `tm_qube_request_invite` (
  `qube_request_invite_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `qube_request_invite_status` enum('invite','request') NOT NULL,
  `tm_qube_qube_id` bigint(20) NOT NULL,
  `qube_owner_id` bigint(20) NOT NULL COMMENT 'user id that action for qube id',
  `tm_user_user_id` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`qube_request_invite_id`,`tm_qube_qube_id`,`qube_owner_id`,`tm_user_user_id`),
  KEY `fk_tblRequestInviteUser_tblCube1_idx` (`tm_qube_qube_id`,`qube_owner_id`),
  KEY `fk_tblRequestInviteUser_tblUser1_idx` (`tm_user_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_report_category`
--

CREATE TABLE IF NOT EXISTS `tm_report_category` (
  `report_category_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_category_name` varchar(45) NOT NULL,
  `report_category_deleted` enum('0','1') NOT NULL,
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_category_id`),
  UNIQUE KEY `report_category_name_UNIQUE` (`report_category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_report_post`
--

CREATE TABLE IF NOT EXISTS `tm_report_post` (
  `report_post_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_post_post_id` bigint(20) NOT NULL,
  `tm_report_category_report_category_id` int(11) NOT NULL,
  `report_post_reason` text NOT NULL,
  `tm_user_user_id` bigint(20) NOT NULL COMMENT 'User who report\n',
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`report_post_id`,`tm_report_category_report_category_id`),
  KEY `fk_tblReportPost_tblReportCategory1_idx` (`tm_report_category_report_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_report_qube`
--

CREATE TABLE IF NOT EXISTS `tm_report_qube` (
  `report_qube_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_qube_qube_id` bigint(20) NOT NULL,
  `tm_report_category_report_category_id` int(11) NOT NULL,
  `report_qube_reason` text NOT NULL,
  `tm_user_user_id` bigint(20) NOT NULL COMMENT 'User who report\n',
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`report_qube_id`,`tm_qube_qube_id`,`tm_report_category_report_category_id`),
  KEY `fk_tblReportCube_tblCube1_idx` (`tm_qube_qube_id`),
  KEY `fk_tblReportCube_tblReportCategory1_idx` (`tm_report_category_report_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_user`
--

CREATE TABLE IF NOT EXISTS `tm_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_email` varchar(100) NOT NULL,
  `user_password` varchar(80) DEFAULT NULL,
  `user_phone` varchar(20) DEFAULT NULL,
  `user_fullname` varchar(150) DEFAULT NULL,
  `user_birthdate` date DEFAULT NULL,
  `user_gender` enum('1','2') DEFAULT NULL COMMENT '1=male 2=female',
  `user_image_profile_path` varchar(100) DEFAULT NULL,
  `user_image_profile_real_name` varchar(200) DEFAULT NULL,
  `user_image_profile_enc_name` varchar(80) DEFAULT NULL,
  `user_register_via` enum('1','2','99') NOT NULL COMMENT '1=fb 2=twitter 99=email',
  `user_fb_id` varchar(45) DEFAULT NULL,
  `user_tw_id` varchar(45) DEFAULT NULL,
  `user_active` enum('1','0') NOT NULL,
  `user_active_date` datetime DEFAULT NULL,
  `user_closed_account` enum('0','1') NOT NULL DEFAULT '0',
  `user_closed_account_date` datetime DEFAULT NULL,
  `user_deleted` enum('0','1') NOT NULL DEFAULT '0',
  `user_last_login` datetime DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_access_token` varchar(40) DEFAULT NULL,
  `user_access_token_expired` datetime DEFAULT NULL,
  `user_refresh_token` varchar(40) DEFAULT NULL,
  `user_token_reset_password` varchar(70) DEFAULT NULL,
  `user_token_reset_password_sent_date` datetime DEFAULT NULL,
  `user_token_activation` varchar(70) DEFAULT NULL,
  `user_token_activation_sent_date` datetime DEFAULT NULL,
  `tm_api_api_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email_UNIQUE` (`user_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tm_user_fb`
--

CREATE TABLE IF NOT EXISTS `tm_user_fb` (
  `tm_user_user_id` bigint(20) NOT NULL,
  `fb_id` bigint(20) NOT NULL,
  `fb_access_token` varchar(300) NOT NULL,
  `fb_email` varchar(100) NOT NULL,
  `fb_name` varchar(150) NOT NULL,
  `fb_first_name` varchar(75) DEFAULT NULL,
  `fb_last_name` varchar(75) DEFAULT NULL,
  `fb_gender` enum('1','2') DEFAULT NULL,
  `fb_birth_date` date DEFAULT NULL,
  `fb_pitcure_url` varchar(300) DEFAULT NULL,
  `fb_link` varchar(300) DEFAULT NULL,
  `fb_verified` varchar(2) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tm_user_user_id`,`fb_id`),
  KEY `fk_tm_user_fb_tm_user1_idx` (`tm_user_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tm_user_tw`
--

CREATE TABLE IF NOT EXISTS `tm_user_tw` (
  `tm_user_user_id` bigint(20) NOT NULL,
  `tw_id` bigint(20) NOT NULL,
  `tw_email` varchar(100) NOT NULL,
  `tw_name` varchar(50) NOT NULL,
  `tw_screen_name` varchar(30) NOT NULL,
  `tw_profile_image_url` varchar(300) DEFAULT NULL,
  `tw_token` varchar(60) NOT NULL,
  `tw_token_secret` varchar(60) NOT NULL,
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tm_user_user_id`,`tw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tm_user_type`
--

CREATE TABLE IF NOT EXISTS `tm_user_type` (
  `user_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type_name` varchar(45) NOT NULL,
  `user_type_deleted` enum('0','1') NOT NULL,
  `create_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_type_id`),
  UNIQUE KEY `user_type_name_UNIQUE` (`user_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tp_post_interest`
--

CREATE TABLE IF NOT EXISTS `tp_post_interest` (
  `tp_post_interest_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_post_post_id` bigint(20) NOT NULL,
  `tm_interest_interest_id` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`tp_post_interest_id`,`tm_post_post_id`,`tm_interest_interest_id`),
  KEY `fk_m_tblPost_tblInterest_tblPost1_idx` (`tm_post_post_id`),
  KEY `fk_m_tblPost_tblInterest_tblInterest1_idx` (`tm_interest_interest_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tp_qube_interest`
--

CREATE TABLE IF NOT EXISTS `tp_qube_interest` (
  `tp_qube_interest_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_interest_interest_id` int(11) NOT NULL,
  `tm_qube_qube_id` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`tp_qube_interest_id`,`tm_interest_interest_id`,`tm_qube_qube_id`),
  KEY `fk_m_tblUserInterest_tblInterest_idx` (`tm_interest_interest_id`),
  KEY `fk_m_tblCubeInterest_tblCube1_idx` (`tm_qube_qube_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tp_user_interest`
--

CREATE TABLE IF NOT EXISTS `tp_user_interest` (
  `tp_user_interest_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_interest_interest_id` int(11) NOT NULL,
  `tm_user_user_id` bigint(20) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`tp_user_interest_id`,`tm_interest_interest_id`,`tm_user_user_id`),
  KEY `fk_m_tblUserInterest_tblInterest_idx` (`tm_interest_interest_id`),
  KEY `fk_m_tblUserInterest_tblUser1_idx` (`tm_user_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tp_user_user_type_qube`
--

CREATE TABLE IF NOT EXISTS `tp_user_user_type_qube` (
  `tp_user_user_type_qube_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_qube_qube_id` bigint(20) NOT NULL,
  `qube_owner_id` bigint(20) NOT NULL COMMENT 'qube owner that do action',
  `tm_user_user_id` bigint(20) NOT NULL COMMENT 'user id that given privilege from owner qube',
  `tm_user_type_user_type_id` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`tp_user_user_type_qube_id`,`tm_qube_qube_id`,`qube_owner_id`,`tm_user_user_id`,`tm_user_type_user_type_id`),
  KEY `fk_m_tblUser_tblUserType_tblUser1_idx` (`tm_user_user_id`),
  KEY `fk_m_tblUser_tblUserType_tblUserType1_idx` (`tm_user_type_user_type_id`),
  KEY `fk_m_tblUser_tblUserType_tblCube_tblCube1_idx` (`tm_qube_qube_id`,`qube_owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tm_follow_person`
--
ALTER TABLE `tm_follow_person`
  ADD CONSTRAINT `fk_tblFollowPerson_tblUser1` FOREIGN KEY (`tm_user_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblFollowPerson_following` FOREIGN KEY (`tm_user_user_id_following`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_follow_qube`
--
ALTER TABLE `tm_follow_qube`
  ADD CONSTRAINT `fk_tblFollowCube_tblUser1` FOREIGN KEY (`tm_user_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblFollowCube_tblCube1` FOREIGN KEY (`tm_qube_qube_id`) REFERENCES `tm_qube` (`qube_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_post`
--
ALTER TABLE `tm_post`
  ADD CONSTRAINT `fk_tblPost_tblCube1` FOREIGN KEY (`tm_qube_qube_id`) REFERENCES `tm_qube` (`qube_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblPost_tblUser1` FOREIGN KEY (`tm_user_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_post_attachment`
--
ALTER TABLE `tm_post_attachment`
  ADD CONSTRAINT `fk_tm_post_attachment_tm_post1` FOREIGN KEY (`tm_post_post_id`) REFERENCES `tm_post` (`post_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_post_moderation`
--
ALTER TABLE `tm_post_moderation`
  ADD CONSTRAINT `fk_tblPostModeration_tblPost1` FOREIGN KEY (`tm_post_post_id`) REFERENCES `tm_post` (`post_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tm_post_moderation_tm_user1` FOREIGN KEY (`post_moderation_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_privilege`
--
ALTER TABLE `tm_privilege`
  ADD CONSTRAINT `fk_tblPrivilege_tblUserType1` FOREIGN KEY (`tm_user_type_user_type_id`) REFERENCES `tm_user_type` (`user_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_qube`
--
ALTER TABLE `tm_qube`
  ADD CONSTRAINT `fk_tblCube_tblUser1` FOREIGN KEY (`tm_user_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_qube_request_invite`
--
ALTER TABLE `tm_qube_request_invite`
  ADD CONSTRAINT `fk_tblRequestInviteUser_tblCube1` FOREIGN KEY (`tm_qube_qube_id`, `qube_owner_id`) REFERENCES `tm_qube` (`qube_id`, `tm_user_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblRequestInviteUser_tblUser1` FOREIGN KEY (`tm_user_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_report_post`
--
ALTER TABLE `tm_report_post`
  ADD CONSTRAINT `fk_tblReportPost_tblReportCategory1` FOREIGN KEY (`tm_report_category_report_category_id`) REFERENCES `tm_report_category` (`report_category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_report_qube`
--
ALTER TABLE `tm_report_qube`
  ADD CONSTRAINT `fk_tblReportCube_tblCube1` FOREIGN KEY (`tm_qube_qube_id`) REFERENCES `tm_qube` (`qube_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tblReportCube_tblReportCategory1` FOREIGN KEY (`tm_report_category_report_category_id`) REFERENCES `tm_report_category` (`report_category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_user_fb`
--
ALTER TABLE `tm_user_fb`
  ADD CONSTRAINT `fk_tm_user_fb_tm_user1` FOREIGN KEY (`tm_user_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tm_user_tw`
--
ALTER TABLE `tm_user_tw`
  ADD CONSTRAINT `fk_tm_user_tw_tm_user1` FOREIGN KEY (`tm_user_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tp_post_interest`
--
ALTER TABLE `tp_post_interest`
  ADD CONSTRAINT `fk_m_tblPost_tblInterest_tblPost1` FOREIGN KEY (`tm_post_post_id`) REFERENCES `tm_post` (`post_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_m_tblPost_tblInterest_tblInterest1` FOREIGN KEY (`tm_interest_interest_id`) REFERENCES `tm_interest` (`interest_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tp_qube_interest`
--
ALTER TABLE `tp_qube_interest`
  ADD CONSTRAINT `fk_m_tblUserInterest_tblInterest0` FOREIGN KEY (`tm_interest_interest_id`) REFERENCES `tm_interest` (`interest_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_m_tblCubeInterest_tblCube1` FOREIGN KEY (`tm_qube_qube_id`) REFERENCES `tm_qube` (`qube_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tp_user_interest`
--
ALTER TABLE `tp_user_interest`
  ADD CONSTRAINT `fk_m_tblUserInterest_tblInterest` FOREIGN KEY (`tm_interest_interest_id`) REFERENCES `tm_interest` (`interest_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_m_tblUserInterest_tblUser1` FOREIGN KEY (`tm_user_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tp_user_user_type_qube`
--
ALTER TABLE `tp_user_user_type_qube`
  ADD CONSTRAINT `fk_m_tblUser_tblUserType_tblUser1` FOREIGN KEY (`tm_user_user_id`) REFERENCES `tm_user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_m_tblUser_tblUserType_tblUserType1` FOREIGN KEY (`tm_user_type_user_type_id`) REFERENCES `tm_user_type` (`user_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_m_tblUser_tblUserType_tblCube_tblCube1` FOREIGN KEY (`tm_qube_qube_id`, `qube_owner_id`) REFERENCES `tm_qube` (`qube_id`, `tm_user_user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
