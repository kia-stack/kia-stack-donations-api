-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2024 at 03:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `donation`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admins`
--

CREATE TABLE `Admins` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Admins`
--

INSERT INTO `Admins` (`admin_id`, `username`, `password`, `email`) VALUES
(1, 'admin', 'SCHambRICoUl', 'admin@example.com');

-- --------------------------------------------------------

--
-- Table structure for table `Causes`
--

CREATE TABLE `Causes` (
  `cause_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `apiKey` varchar(512) DEFAULT NULL,
  `isDisabled` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Causes`
--

INSERT INTO `Causes` (`cause_id`, `name`, `apiKey`, `isDisabled`) VALUES
(1, 'Education', 'QAdKRe4TA6', 0),
(2, 'Healthcare', 'nBrwsjpP2L', 0),
(3, 'Environment', 'eGp5eK02Pf', 0),
(9, 'Forest Restoration', '8fQq2W2ynhBSUZbh', 0),
(10, 'Flood Relief', 'RUUBPMTrnI32qrxx', 0);

-- --------------------------------------------------------

--
-- Table structure for table `Donations`
--

CREATE TABLE `Donations` (
  `donation_id` int(11) NOT NULL,
  `cause_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Donations`
--

INSERT INTO `Donations` (`donation_id`, `cause_id`, `name`, `email`, `amount`) VALUES
(1, 1, 'John Doe', 'john@example.com', 100.00),
(2, 1, 'Jane Smith', 'jane@example.com', 50.00),
(3, 2, 'Michael Johnson', 'michael@example.com', 200.00),
(4, 3, 'Emily Brown', 'emily@example.com', 150.00),
(5, 2, 'Test', 'kiran.yk@ky.net', 123.00),
(6, 1, 'Test', 'sumit.mahajan@s.com', 555.00),
(7, 3, 'test', 'kiran.yk@ky.net', 123.00),
(8, 3, 'Test', 'kiran.gugwade@s.net', 123677.00),
(9, 1, 'Test', 'kiran.yk@ky.net', 5454.00),
(10, 1, 'HP', 'admin@hp.com', 999.00),
(11, 9, 'Suma', 'admin@abc.com', 9999.00),
(12, 9, 'SSPL', 'sspl@xy.in', 1.00),
(13, 9, 'Anonymous', 'anon@anon.anon', 100001.00),
(14, 9, 'Apple', 'apple@asd.com', 500.00),
(15, 1, 'Test', 'k@k.com', 12.00),
(16, 2, 'TR', 'tr@tr.com', 1.00),
(17, 1, 'Qwe', 'qwe@qwe.com', 501.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admins`
--
ALTER TABLE `Admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `Causes`
--
ALTER TABLE `Causes`
  ADD PRIMARY KEY (`cause_id`);

--
-- Indexes for table `Donations`
--
ALTER TABLE `Donations`
  ADD PRIMARY KEY (`donation_id`),
  ADD KEY `cause_id` (`cause_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admins`
--
ALTER TABLE `Admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Causes`
--
ALTER TABLE `Causes`
  MODIFY `cause_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Donations`
--
ALTER TABLE `Donations`
  MODIFY `donation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Donations`
--
ALTER TABLE `Donations`
  ADD CONSTRAINT `donations_ibfk_1` FOREIGN KEY (`cause_id`) REFERENCES `Causes` (`cause_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
