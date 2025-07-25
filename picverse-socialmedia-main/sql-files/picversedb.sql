-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 03, 2025 at 07:46 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `picversedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `account_type` varchar(50) NOT NULL,
  `time_balance` time NOT NULL,
  `interest_rate` float DEFAULT '0',
  `transaction_limit` int DEFAULT '1000',
  `notifications` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
CREATE TABLE IF NOT EXISTS `admins` (
  `admin_id` int NOT NULL AUTO_INCREMENT,
  `admin_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `admin_username`, `admin_password`, `created_at`) VALUES
(27, 'kaival', 'scrypt:32768:8:1$YgYGDJ0sgvRAEeSr$0a67d3c9fd61ee11bc993970b2b392336293769ca54b74d538fe111fa1cc44a8779e218f1a6ffd82432a3ba7cdb5fbc4791d5d5cb033b42e9edcea052b38ce8d', '2025-04-12 17:11:15'),
(28, 'Dhruv', 'scrypt:32768:8:1$YDlB15ahCpa2nVX0$096ca50470b281f0dd5183d6431ceb357ee616dbbf712f145e2adc696db0fb28f7493eebf52ccc824bd72841003fba63820c4239bd8a6ed70932024fd5139ca1', '2025-05-03 13:19:30');

-- --------------------------------------------------------

--
-- Table structure for table `badges`
--

DROP TABLE IF EXISTS `badges`;
CREATE TABLE IF NOT EXISTS `badges` (
  `badge_id` int NOT NULL AUTO_INCREMENT,
  `badge_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `badge_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `badge_desc` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`badge_id`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `badges`
--

INSERT INTO `badges` (`badge_id`, `badge_name`, `badge_url`, `badge_desc`) VALUES
(1, 'new', '../static/storage/badges/new.png', 'New Member'),
(3, 'verified', '../static/storage/badges/verified.png', 'Verified Member'),
(4, 'guitar', '../static/storage/badges/guitar.png', 'Guitarist'),
(5, 'piano', '../static/storage/badges/piano.png', 'Pianist'),
(6, 'flute', '../static/storage/badges/flute.png', 'Flautist '),
(7, 'listen', '../static/storage/badges/listen.png', 'Music Enjoyer'),
(8, 'drum', '../static/storage/badges/drum.png', 'Drummer'),
(19, 'nhj', '../static/storage/badges\\Screenshot 2021-05-25 160900.png', 'hhhh');

-- --------------------------------------------------------

--
-- Table structure for table `banned_users`
--

DROP TABLE IF EXISTS `banned_users`;
CREATE TABLE IF NOT EXISTS `banned_users` (
  `ban_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `banTimestamp` timestamp NOT NULL,
  `banReason` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ban_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `comment_text` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `comment_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deleted_posts`
--

DROP TABLE IF EXISTS `deleted_posts`;
CREATE TABLE IF NOT EXISTS `deleted_posts` (
  `dlt_post_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `caption` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tags` varchar(50) DEFAULT NULL,
  `media_url` varchar(255) DEFAULT NULL,
  `media_type` enum('photo','video') DEFAULT NULL,
  `timestamp` timestamp NOT NULL,
  `deleted_by` varchar(255) NOT NULL,
  PRIMARY KEY (`dlt_post_id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discussion_forums`
--

DROP TABLE IF EXISTS `discussion_forums`;
CREATE TABLE IF NOT EXISTS `discussion_forums` (
  `df_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `creation_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`df_id`),
  KEY `creater` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `discussion_forums`
--

INSERT INTO `discussion_forums` (`df_id`, `user_id`, `title`, `creation_timestamp`) VALUES
(3, 1, 'Hello Guys! This is a demo Forum!', '2024-03-27 16:20:40');

-- --------------------------------------------------------

--
-- Table structure for table `discussion_forums_comments`
--

DROP TABLE IF EXISTS `discussion_forums_comments`;
CREATE TABLE IF NOT EXISTS `discussion_forums_comments` (
  `df_cmnt_id` int NOT NULL AUTO_INCREMENT,
  `df_id` int NOT NULL,
  `user_id` int NOT NULL,
  `comment` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `comment_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`df_cmnt_id`),
  KEY `df_id` (`df_id`),
  KEY `userid` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
CREATE TABLE IF NOT EXISTS `followers` (
  `follow_id` int NOT NULL AUTO_INCREMENT,
  `source_user_id` int NOT NULL,
  `target_user_id` int NOT NULL,
  `follow_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`follow_id`),
  KEY `source_user_id` (`source_user_id`),
  KEY `target_user_id` (`target_user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `followers`
--

INSERT INTO `followers` (`follow_id`, `source_user_id`, `target_user_id`, `follow_timestamp`) VALUES
(10, 8, 7, '2025-05-03 10:49:26');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
CREATE TABLE IF NOT EXISTS `likes` (
  `like_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  `like_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`like_id`),
  KEY `user_id` (`user_id`),
  KEY `post_id` (`post_id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `msg_id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `content` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`msg_id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `caption` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tags` varchar(50) DEFAULT NULL,
  `media_url` varchar(255) DEFAULT NULL,
  `media_type` enum('photo','video') DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`post_id`, `user_id`, `caption`, `tags`, `media_url`, `media_type`, `timestamp`) VALUES
(11, 1, 'Classic!', NULL, '../static/storage/posts/photos\\gJrEtha99H0eewihlPDYi7lDT932M078YRaUK8VVKny6nH9d8ffQ4UK6UWIHs0tHNanIqsTzkwNQQu7L.jpg', 'photo', '2024-03-27 16:19:32');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_pass` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `display_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_dob` date DEFAULT NULL,
  `user_bio` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_pfp` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '../static/storage/pfps/default_pfp.png',
  `user_badges` json DEFAULT NULL,
  `user_interests` json DEFAULT NULL,
  `user_creation_timestamp` timestamp NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_name`, `user_pass`, `display_name`, `user_email`, `user_dob`, `user_bio`, `user_pfp`, `user_badges`, `user_interests`, `user_creation_timestamp`) VALUES
(1, 'user', 'scrypt:32768:8:1$5HCbdQ8K4oC509mm$e3c5c9e0dc01081e303457d3a5abe2da9fce7c355fc29f2ba1894029da4b14393dfa7b45d0013db4f98eb732817e788c5d38b9c7e20dc338ed01d8fcb0044ff5', 'Test User', 'example@gmail.com', '2004-01-22', 'Github - x0tic0p', '../static/storage/pfps\\default_pfp.png', '[{\"new\": \"equipped\", \"drum\": \"notequipped\", \"flute\": \"notequipped\", \"piano\": \"notequipped\", \"guitar\": \"notequipped\", \"listen\": \"notequipped\"}]', NULL, '2024-03-04 13:27:26'),
(7, 'kaival', 'scrypt:32768:8:1$Uuf1LlvJSflIs21q$d9451b69228ad826ac62ac56db98f8e62f8e79bc62a86aa78c49df455cb34e172d4263873db9356dc99a5c1139ab6e6d31ada8f1c15834936ff009f76acb9d3c', 'kaival shah', 'shahkaival2004@gmail.com', '2025-05-01', 'cricketer', '../static/storage/pfps/default_pfp.png', '[{\"new\": \"notequipped\", \"drum\": \"equipped\", \"flute\": \"notequipped\", \"piano\": \"notequipped\", \"guitar\": \"notequipped\", \"listen\": \"notequipped\"}]', NULL, '2025-03-29 11:31:35'),
(8, '123', 'scrypt:32768:8:1$KkYGQQjHW9plFYd1$6dbab8d74c48402bafd9e2a705108c107cd6cdf25d2f8122193f06eaf91091d8068da7b2e33914a10675df94a29b00d80a9110e32594ff9393eb75e2d7b6d7e7', 'Vishwa shah', 'jaintisha880@gmail.com', NULL, NULL, '../static/storage/pfps/default_pfp.png', '[{\"new\": \"equipped\", \"drum\": \"notequipped\", \"flute\": \"notequipped\", \"piano\": \"notequipped\", \"guitar\": \"notequipped\", \"listen\": \"notequipped\"}]', NULL, '2025-05-03 10:48:50');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
