-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 02, 2020 at 05:48 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `resort_management`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAvailableroom` (IN `param_type` VARCHAR(20))  NO SQL
SELECT
    room.room_no
FROM
    room
WHERE
  room_type = param_type AND
  room.room_no not in 
  (
    SELECT
      room_date.room_no
    FROM
      room_date
    WHERE
      (room_date.check_in<='2019-06-13' and room_date.check_out>='2019-06-13')
      OR
      (room_date.check_in<'2019-06-19' and room_date.check_out>='2019-06-19')
      OR
      (room_date.check_in>='2019-06-13' and room_date.check_out<'2019-06-19')
   )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRoom` (IN `troom` VARCHAR(20))  NO SQL
SELECT room.room_no, room_date.cus_id, room_date.check_in, room_date.check_out FROM room INNER JOIN room_date ON room.room_no = room_date.room_no AND room_type = troom$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(3) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(1302, 'vaishnav@lt.com', '102030');

-- --------------------------------------------------------

--
-- Table structure for table `bill_generate`
--

CREATE TABLE `bill_generate` (
  `bill_no` int(11) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `customer_name` varchar(30) NOT NULL,
  `adult` int(3) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `total_price` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bill_generate`
--

INSERT INTO `bill_generate` (`bill_no`, `customer_id`, `customer_name`, `adult`, `check_in`, `check_out`, `total_price`) VALUES
(10, 91, 'Dr.  Ross  Galler', 2, '2020-12-03', '2020-12-13', 5750);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(10) NOT NULL,
  `title` varchar(10) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `nationality` varchar(30) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `room_type` varchar(20) NOT NULL,
  `adult` int(3) NOT NULL,
  `children` int(3) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `arrival_time` time NOT NULL,
  `status` varchar(20) NOT NULL,
  `room_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `title`, `first_name`, `last_name`, `email`, `nationality`, `phone`, `room_type`, `adult`, `children`, `check_in`, `check_out`, `arrival_time`, `status`, `room_no`) VALUES
(91, 'Dr.', 'Ross', 'Galler', 'ross.galler@friends.com', 'Indian', '8887878787', 'Deluxe Room', 2, 2, '2020-12-03', '2020-12-13', '00:00:00', 'Checked Out', 101),
(92, 'Ms.', 'Rachel', 'Green', 'rachel.g@friends.com', 'Indian', '9000000000', 'Premier Room', 2, 2, '2020-12-02', '2020-12-04', '18:24:00', 'Checked Out', 204),
(94, 'Mr.', 'Jake', 'Santiago', 'jake.p@brooklyn99.com', 'Indian', '2030201010', 'Club Room', 2, 0, '2020-12-02', '2020-12-16', '21:49:00', 'Checked In', 403),
(95, 'Mr.', 'Charls', 'Boyle', 'cb@brooklyn99.com', 'Indian', '505050505050', 'Club Room', 2, 2, '2020-12-03', '2020-12-11', '21:53:00', 'Checked In', 402),
(96, 'Mr.', 'Sahil', 'Suvarna', 'ss@ss.com', 'INDIAN', '2030302010', 'Orchid Suite', 2, 2, '2020-12-04', '2020-12-12', '22:11:00', 'Checked In', 304);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `fullname` varchar(40) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(15) NOT NULL,
  `startdate` date NOT NULL,
  `salary` varchar(20) NOT NULL,
  `emptype` varchar(30) NOT NULL,
  `resigndate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`id`, `fullname`, `address`, `phone`, `startdate`, `salary`, `emptype`, `resigndate`) VALUES
(1302, 'Vaishnav Anil Datir', 'Teen Takki, Koperkhairne', '9881339091', '2020-12-02', '20000', 'admin', '0000-00-00'),
(12139, 'Abhishek J', 'Turbhe', '8787878787', '2020-12-06', '102030', 'Admin', '0000-00-00');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_no` int(10) NOT NULL,
  `room_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`room_no`, `room_type`) VALUES
(101, 'Deluxe Room'),
(102, 'Deluxe Room'),
(103, 'Deluxe Room'),
(104, 'Deluxe Room'),
(105, 'Deluxe Room'),
(201, 'Premier Room'),
(202, 'Premier Room'),
(203, 'Premier Room'),
(204, 'Premier Room'),
(301, 'Orchid Suite'),
(302, 'Orchid Suite'),
(303, 'Orchid Suite'),
(304, 'Orchid Suite'),
(401, 'Club Room'),
(402, 'Club Room'),
(403, 'Club Room'),
(404, 'Club Room');

-- --------------------------------------------------------

--
-- Table structure for table `room_date`
--

CREATE TABLE `room_date` (
  `room_no` int(11) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `cus_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room_date`
--

INSERT INTO `room_date` (`room_no`, `check_in`, `check_out`, `cus_id`) VALUES
(102, '2019-06-13', '2019-06-17', 59),
(402, '2019-06-11', '2019-06-19', 53),
(402, '2019-06-11', '2019-06-19', 53),
(302, '2019-06-19', '2019-06-28', 60),
(403, '2019-06-17', '2019-06-21', 0),
(301, '2019-06-17', '2019-06-20', 62),
(303, '2019-06-25', '2019-06-28', 63),
(202, '2019-06-18', '2019-06-21', 64),
(401, '2019-06-18', '2019-06-20', 65),
(203, '2019-06-18', '2019-06-21', 64),
(103, '2020-12-04', '2020-12-15', 70),
(203, '2020-12-06', '2020-12-10', 0),
(102, '2020-12-03', '2020-12-13', 0),
(202, '2020-12-02', '2020-12-04', 0),
(203, '2020-12-02', '2020-12-04', 92),
(403, '2020-12-02', '2020-12-16', 0),
(402, '2020-12-03', '2020-12-11', 0),
(304, '2020-12-04', '2020-12-12', 96);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bill_generate`
--
ALTER TABLE `bill_generate`
  ADD PRIMARY KEY (`bill_no`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_no`);

--
-- Indexes for table `room_date`
--
ALTER TABLE `room_date`
  ADD KEY `room_no` (`room_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12136;

--
-- AUTO_INCREMENT for table `bill_generate`
--
ALTER TABLE `bill_generate`
  MODIFY `bill_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12140;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `room_no` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=405;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`id`) REFERENCES `employee` (`id`);

--
-- Constraints for table `room_date`
--
ALTER TABLE `room_date`
  ADD CONSTRAINT `room_date_ibfk_1` FOREIGN KEY (`room_no`) REFERENCES `room` (`room_no`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
