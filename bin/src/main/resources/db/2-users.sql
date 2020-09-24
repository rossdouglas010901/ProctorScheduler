-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 19, 2019 at 04:50 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `proctor`
--

-- --------------------------------------------------------



--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Email`, `Password`, `FirstName`, `LastName`, `PhoneNumber`, `Ext`, `AccountType`) VALUES
(1, '2019-0000@oultoncollege.com', '234567898765432345678987654323456787654321234567', 'Joe', 'Smith', '+1 (506) 686-7658', NULL, 1),
(2, '2018-0000@oultoncollege', '235788765432347865435678754324678543346', 'Johnney', 'Appleseed', '+1 (734) 686-8678', '5678', 2),
(3,'2019-0253@oultonCollege.com','Test123','Ross','Campbell','+1 (506) 555-0253','',3),
(4,'2019-1066@oultoncollege.com','123','Leo','Liu','+1 (506) 555-1066','',3),
(5,'2019-0692@oultoncollege.com','123','Anton','Chartovich','+1 (506) 555-8906','',3),
(6,'2019-0721@oultoncollege.com','12345','Joo','Hung','+1 (506) 555-0721','',4),
(7,'bcopeland@oultoncollege.com','Test123','Bryan','Copeland','+1 (506) 555-1111','',2);



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
