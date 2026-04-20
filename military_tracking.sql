-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 10, 2026 at 11:44 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `military_tracking`
--

-- --------------------------------------------------------

--
-- Table structure for table `alerts`
--

CREATE TABLE `alerts` (
  `id` int(11) NOT NULL,
  `soldier_id` int(11) NOT NULL,
  `commander_id` int(11) NOT NULL,
  `alert_type` enum('location_mismatch','emergency','offline','battery_low') NOT NULL,
  `message` text DEFAULT NULL,
  `is_resolved` tinyint(1) DEFAULT 0,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `accuracy` decimal(8,2) DEFAULT NULL,
  `altitude` decimal(8,2) DEFAULT NULL,
  `speed` decimal(6,2) DEFAULT NULL,
  `heading` decimal(5,2) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_assigned_location` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_files`
--

CREATE TABLE `media_files` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `mission_id` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `file_type` enum('photo','video','audio') NOT NULL,
  `file_size` int(11) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `caption` text DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `content` text NOT NULL,
  `message_type` enum('normal','alert','emergency') DEFAULT 'normal',
  `is_read` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `missions`
--

CREATE TABLE `missions` (
  `id` int(11) NOT NULL,
  `mission_name` varchar(200) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL,
  `status` enum('planned','active','completed','cancelled') DEFAULT 'planned',
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `commander_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mission_reports`
--

CREATE TABLE `mission_reports` (
  `id` int(11) NOT NULL,
  `mission_id` int(11) NOT NULL,
  `commander_id` int(11) NOT NULL,
  `report_content` text DEFAULT NULL,
  `findings` text DEFAULT NULL,
  `challenges` text DEFAULT NULL,
  `recommendations` text DEFAULT NULL,
  `casualties` int(11) DEFAULT 0,
  `equipment_used` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(80) NOT NULL,
  `password_hash` varchar(120) NOT NULL,
  `role` enum('commander','soldier') NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `full_name` varchar(100) DEFAULT NULL,
  `rank` varchar(50) DEFAULT NULL,
  `service_number` varchar(50) DEFAULT NULL,
  `sex` enum('Male','Female') DEFAULT NULL,
  `marital_status` enum('Single','Married') DEFAULT NULL,
  `province` varchar(50) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_soldier_id` (`soldier_id`),
  ADD KEY `idx_commander_id` (`commander_id`),
  ADD KEY `idx_alert_type` (`alert_type`),
  ADD KEY `idx_is_resolved` (`is_resolved`),
  ADD KEY `idx_timestamp` (`timestamp`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_timestamp` (`timestamp`),
  ADD KEY `idx_coordinates` (`latitude`,`longitude`);

--
-- Indexes for table `media_files`
--
ALTER TABLE `media_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sender_id` (`sender_id`),
  ADD KEY `idx_receiver_id` (`receiver_id`),
  ADD KEY `idx_mission_id` (`mission_id`),
  ADD KEY `idx_file_type` (`file_type`),
  ADD KEY `idx_timestamp` (`timestamp`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sender_id` (`sender_id`),
  ADD KEY `idx_receiver_id` (`receiver_id`),
  ADD KEY `idx_timestamp` (`timestamp`),
  ADD KEY `idx_is_read` (`is_read`);

--
-- Indexes for table `missions`
--
ALTER TABLE `missions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_commander_id` (`commander_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_date` (`date`),
  ADD KEY `idx_coordinates` (`latitude`,`longitude`);

--
-- Indexes for table `mission_reports`
--
ALTER TABLE `mission_reports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_mission_report` (`mission_id`),
  ADD KEY `idx_commander_id` (`commander_id`),
  ADD KEY `idx_submitted_at` (`submitted_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idx_username` (`username`),
  ADD KEY `idx_role` (`role`),
  ADD KEY `idx_service_number` (`service_number`),
  ADD KEY `idx_is_active` (`is_active`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alerts`
--
ALTER TABLE `alerts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media_files`
--
ALTER TABLE `media_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `missions`
--
ALTER TABLE `missions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mission_reports`
--
ALTER TABLE `mission_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alerts`
--
ALTER TABLE `alerts`
  ADD CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`soldier_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `alerts_ibfk_2` FOREIGN KEY (`commander_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `media_files`
--
ALTER TABLE `media_files`
  ADD CONSTRAINT `media_files_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `media_files_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `media_files_ibfk_3` FOREIGN KEY (`mission_id`) REFERENCES `missions` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `missions`
--
ALTER TABLE `missions`
  ADD CONSTRAINT `missions_ibfk_1` FOREIGN KEY (`commander_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mission_reports`
--
ALTER TABLE `mission_reports`
  ADD CONSTRAINT `mission_reports_ibfk_1` FOREIGN KEY (`mission_id`) REFERENCES `missions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mission_reports_ibfk_2` FOREIGN KEY (`commander_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
