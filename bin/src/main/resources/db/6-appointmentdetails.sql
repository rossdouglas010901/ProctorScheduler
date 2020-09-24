-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 19, 2019 at 04:46 PM
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


INSERT INTO `appointmentdetails` (`AppointmentID`, `Student`, `CourseID`, `StartTime`, `EndTime`, `Title`, `Description`, `Location`, `Proctor`, `AppointmentTypeID`) VALUES 
(1,2,1,'2020-01-29 8:00:00', '2020-01-29 11:00:00', 'Some Meeting', 'Description text', 'Cameron Campus - The Hub (room 204)', 1, 3), 
(1,2,1,'2020-01-29 16:00:00', '2020-01-29 17:00:00', 'Some Meeting', 'Description text', 'Flanders Campus - Vet Clinic (room 117)', 1, 2);


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
