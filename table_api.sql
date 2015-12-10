-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 07, 2015 at 05:02 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `log_tm_api`
--

CREATE TABLE IF NOT EXISTS `log_tm_api` (
  `log_tm_api_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tm_api_api_id` int(11) DEFAULT '0',
  `log_tm_api_activity` varchar(45) NOT NULL COMMENT 'nama module yang di akses',
  `log_tm_api_parameter_sent` text,
  `log_tm_api_status` varchar(10) NOT NULL,
  `log_tm_api_message` varchar(50) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip_address` varchar(45) NOT NULL,
  PRIMARY KEY (`log_tm_api_id`,`create_date`),
  KEY `fk_log_tm_api_tm_api1_idx` (`tm_api_api_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `log_tm_api`
--

INSERT INTO `log_tm_api` (`log_tm_api_id`, `tm_api_api_id`, `log_tm_api_activity`, `log_tm_api_parameter_sent`, `log_tm_api_status`, `log_tm_api_message`, `create_date`, `ip_address`) VALUES
(1, 0, 'API Auth', '', '5', 'Auth Param not send completely', '2015-10-07 07:48:14', '::1'),
(2, 0, 'API Auth', '', '5', 'Auth Param not send completely', '2015-10-07 07:49:31', '::1'),
(3, 0, 'API Auth', '', '5', 'Auth Param not send completely', '2015-10-07 07:50:32', '::1'),
(4, 0, 'API Auth', '', '5', 'Auth Param not send completely', '2015-10-07 08:18:32', '::1'),
(5, 0, 'API Auth', '', '5', 'Auth Param not send completely', '2015-10-07 08:21:39', '::1'),
(6, 0, 'API Auth', '', '5', 'Auth Param not send completely', '2015-10-07 08:27:02', '::1'),
(7, 0, 'API Auth', '', '5', 'Auth Param not send completely', '2015-10-07 08:29:18', '::1'),
(8, 0, 'API Auth', '', '5', 'Auth Param not send completely', '2015-10-07 08:29:35', '::1');

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
(1, 'qubicle back end', 'Y2FlTFdVVVNDdnloMHYycEQ2b2Fvb1FwY3FVRHpyTytNN1pIeHBleGQ4MD0=', '34bbc814aebed6a77062885c966809b8c5fa711a8f4ee86cbb51055638af49e1', NULL, '1', '0', '2015-10-07 00:00:00', '2015-10-07 07:24:52');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
