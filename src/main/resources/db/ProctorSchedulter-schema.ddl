-- --------------------------------------------------------
--
-- 1.) Table structure for table `account_type`
--
-- --------------------------------------------------------
CREATE TABLE `account_type` (
  `AccountTypeID` TINYINT NOT NULL,
  `AcountTypeName` VARCHAR(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `account_type`
--
ALTER TABLE `account_type`
  ADD PRIMARY KEY (`AccountTypeID`);



-- --------------------------------------------------------
--
-- 2.) Table structure for table `users`
--
-- --------------------------------------------------------
CREATE TABLE `users` (
  `UserID` INT(11) NOT NULL,
  `Email` VARCHAR(255) CHARACTER SET utf8 NOT NULL,
  `Password` CHAR(64) CHARACTER SET utf8 NOT NULL,
  `FirstName` VARCHAR(35) CHARACTER SET utf8 NOT NULL,
  `LastName` VARCHAR(35) CHARACTER SET utf8 NOT NULL,
  `PhoneNumber` char(20) CHARACTER SET utf8 NOT NULL,
  `PhoneExt` char(10) CHARACTER SET utf8 DEFAULT NULL,
  `AccountTypeID` TINYINT DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD KEY `fk_role` (`AccountTypeID`);

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_role` FOREIGN KEY (`AccountTypeID`) REFERENCES `account_type` (`AccountTypeID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- --------------------------------------------------------
--
-- 3.) sha256 salt (shaker) table
--
-- --------------------------------------------------------
CREATE TABLE `shaker` (  
  `SID` INT(11) NOT NULL,
  `UID` INT(11) NOT NULL,
  `Salt` VARCHAR(20) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `users`
--
ALTER TABLE `shaker`
  ADD PRIMARY KEY (`SID`),
  ADD KEY `fk_user` (`UID`);

-- 
-- AUTO_INCREMENT for table `users`
-- 
ALTER TABLE `shaker`
  MODIFY `SID` INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

ALTER TABLE `shaker`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`UID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE;



-- --------------------------------------------------------
--
-- 4.) Table structure for table `program`
--
-- --------------------------------------------------------
CREATE TABLE `program` (
  `ProgramID` TINYINT NOT NULL,
  `ProgramName` VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `program`
--
ALTER TABLE `program`
  ADD PRIMARY KEY (`ProgramID`);



-- --------------------------------------------------------
--
-- 5.) Table structure for table `course`
--
-- --------------------------------------------------------
CREATE TABLE `course` (
  `CourseID` INT(11) NOT NULL,
  `CourseName` VARCHAR(35) NOT NULL,
  `CourseStart` DATE NOT NULL,
  `CourseEnd` DATE NOT NULL,
  `Location` VARCHAR(100) NOT NULL,
  `RoomNum` VARCHAR(20) NOT NULL,
  `Instructor` VARCHAR(70) NOT NULL,
  `ProgramID` TINYINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`CourseID`),
  ADD KEY `fk_programID` (`ProgramID`);

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `fk_programID` FOREIGN KEY (`ProgramID`) REFERENCES `program` (`ProgramID`) ON DELETE CASCADE ON UPDATE CASCADE;



-- --------------------------------------------------------
--
-- 6.) Table structure for table `appointment_type`
--
CREATE TABLE `appointment_type` (
  `TypeID` TINYINT NOT NULL,
  `TypeName` VARCHAR(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for table `appointment_type`
--
ALTER TABLE `appointment_type`
  ADD PRIMARY KEY (`TypeID`);




-- --------------------------------------------------------
-- 
-- 7.) Table structure for table `appointment`
-- 
CREATE TABLE `appointment` (
  `AppointmentID` INT(11) NOT NULL,
  `StartTime` DATETIME NOT NULL,
  `EndTime` DATETIME NOT NULL,
  `Title` VARCHAR(50) NOT NULL,
  `Description` TEXT,
  `Location` VARCHAR(100) NOT NULL,
  `StudentCount` TINYINT NOT NULL,
  `ProctorID` INT(11) NOT NULL,
  `CourseID` INT(11) NOT NULL DEFAULT 2,
  `AppointmentTypeID` TINYINT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 
-- Indexes for table `appointment`
-- 
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`AppointmentID`),
  ADD KEY `fk_proctorID` (`ProctorID`),
  ADD KEY `fk_courseID` (`CourseID`),
  ADD KEY `fk_appointmentTypeID` (`AppointmentTypeID`);

-- 
-- AUTO_INCREMENT for table `appointment`
-- 
ALTER TABLE `appointment` 
  MODIFY `AppointmentID` INT(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

-- 
-- Constraints for table `appointment`
-- 
ALTER TABLE `appointment` 
  ADD CONSTRAINT `fk_proctorID` FOREIGN KEY (`ProctorID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_courseID` FOREIGN KEY (`CourseID`) REFERENCES `course` (`CourseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_appointmentTypeID` FOREIGN KEY (`AppointmentTypeID`) REFERENCES `appointment_type` (`TypeID`) ON DELETE CASCADE ON UPDATE CASCADE;
