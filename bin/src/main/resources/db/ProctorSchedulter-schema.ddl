-- --------------------------------------------------------
--
-- 1.) Table structure for table `accounttype`
--
-- --------------------------------------------------------
CREATE TABLE `accounttype` (
  `AccountTypeID` int(11) NOT NULL,
  `AcountTypeName` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `accounttype`
--
ALTER TABLE `accounttype`
  ADD PRIMARY KEY (`AccountTypeID`);



-- -----------------------------------------------------------------------------------------------
--
-- 2.) Table structure for table `users`
--
-- --------------------------------------------------------
CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Email` varchar(255) CHARACTER SET utf8 NOT NULL,
  `Password` varchar(50) CHARACTER SET utf8 NOT NULL,
  `FirstName` varchar(35) CHARACTER SET utf8 NOT NULL,
  `LastName` varchar(35) CHARACTER SET utf8 NOT NULL,
  `PhoneNumber` char(20) CHARACTER SET utf8 NOT NULL,
  `Ext` char(10) CHARACTER SET utf8 DEFAULT NULL,
  `AccountType` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD KEY `fk_AccountType` (`AccountType`);

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_AccountType` FOREIGN KEY (`AccountType`) REFERENCES `accounttype` (`AccountTypeID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;


-- ---------------------------------------------------------------------------------------------
--
-- 3.) Table structure for table `programs`
--
-- --------------------------------------------------------
CREATE TABLE `programs` (
  `ProgramID` int(11) NOT NULL,
  `ProgramName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`ProgramID`);



-- --------------------------------------------------------
--
-- 4.) Table structure for table `coursetype`
--
-- --------------------------------------------------------
CREATE TABLE `coursetype` (
  `CourseID` int(11) NOT NULL,
  `ProgramID` int(11) NOT NULL,
  `CourseName` varchar(35) NOT NULL,
  `CourseStart` date NOT NULL,
  `CourseEnd` date NOT NULL,
  `Location` varchar(100) NOT NULL,
  `RoomNum` varchar(20) NOT NULL,
  `Instructor` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `coursetype`
--
ALTER TABLE `coursetype`
  ADD PRIMARY KEY (`CourseID`),
  ADD KEY `fk_ProgramID` (`ProgramID`);

--
-- Constraints for table `coursetype`
--
ALTER TABLE `coursetype`
  ADD CONSTRAINT `fk_ProgramID` FOREIGN KEY (`ProgramID`) REFERENCES `programs` (`ProgramID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;


-- --------------------------------------------------------
--
-- 5.) Table structure for table `appointmenttype`
--
CREATE TABLE `appointmenttype` (
  `TypeID` int(2) NOT NULL,
  `TypeName` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `appointmenttype`
--
ALTER TABLE `appointmenttype`
  ADD PRIMARY KEY (`TypeID`);




-- --------------------------------------------------------
--
-- 6.) Table structure for table `appointmentdetails`
--
CREATE TABLE `appointmentdetails` (
  `AppointmentID` int(11) NOT NULL,
  `Student` int(11) NOT NULL,
  `CourseID` int(11) NOT NULL,
  `StartTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `Title` varchar(50) NOT NULL,
  `Description` text,
  `Location` varchar(100) NOT NULL,
  `Proctor` int(11) NOT NULL,
  `AppointmentTypeID` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
--
-- Indexes for table `appointmentdetails`
--
-- --------------------------------------------------------
ALTER TABLE `appointmentdetails`
  ADD PRIMARY KEY (`AppointmentID`),
  ADD KEY `fk_student` (`Student`),
  ADD KEY `fk_proctor` (`Proctor`),
  ADD KEY `fk_courseID` (`CourseID`),
  ADD KEY `fk_appointmentTypeID` (`AppointmentTypeID`);

--
-- AUTO_INCREMENT for table `appointmentdetails`
--
ALTER TABLE `appointmentdetails`
  MODIFY `AppointmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;


--
-- Constraints for table `appointmentdetails`
--
ALTER TABLE `appointmentdetails`
  ADD CONSTRAINT `fk_courseID` FOREIGN KEY (`CourseID`) REFERENCES `coursetype` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_proctor` FOREIGN KEY (`Proctor`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_student` FOREIGN KEY (`Student`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_appointmentTypeID` FOREIGN KEY (`AppointmentTypeID`) REFERENCES `appointmenttype` (`TypeID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;
