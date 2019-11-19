START TRANSACTION;

DROP DATABASE `digintro`;

CREATE DATABASE IF NOT EXISTS `digintro`;

USE digintro;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `roleID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255),
  PRIMARY KEY (`roleID`)
);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userUUID` VARCHAR(31) UNIQUE NOT NULL,
  `firstName` VARCHAR(255),
  `lastName` VARCHAR(255),
  `emailAddress` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `roleID` INT UNSIGNED NOT NULL,
  `createdAt` DATETIME DEFAULT CURRENT_TIMESTAMP(),
  `deletedAt` DATETIME DEFAULT NULL,
  FOREIGN KEY (`roleID`)
    REFERENCES `roles` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  PRIMARY KEY (`userID`)
);

INSERT INTO users(userUUID, firstName, lastName, emailAddress, password) VALUES
  ('MEMTYP-2', 'Jason', 'Wong', 'J.Wong@gmaail.com', 'ada123'),
  ('MEMTYP-2', 'Karen', 'Thomas', 'KarenThomas@btinteernet.com', 'nyc911'),
  ('MEMTYP-1', 'Mohammed', 'Wahed', 'Mo_Wahed@yahooo.co.uk', 'glow123'),
  ('MEMTYP-1', 'Julie', 'Ahmed', 'JAhmed@mns.com', '123ererer');

DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `classID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255),
  `classroomNumber` VARCHAR(10),
  PRIMARY KEY (`classID`)
);

INSERT INTO `classes`(description)
VALUES
();

DROP TABLE IF EXISTS `userClasses`;
CREATE TABLE `userClasses` (
  `userID` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`userID`)
    REFERENCES `users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  `classID` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`classID`)
    REFERENCES `classes` (`classID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  PRIMARY KEY (`userID`, `classID`)
);

INSERT INTO `userClasses`(``) VALUES
();

DROP TABLE IF EXISTS `workshops`;
CREATE TABLE `workshops` (
  `workshopID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `videoLink` VARCHAR(255),
  `name` VARCHAR(255),
  `description` VARCHAR(255),
  PRIMARY KEY (`workshopID`)
);

INSERT INTO workshops ()
VALUES
  ();

DROP TABLE IF EXISTS `workshopQuestions`;
CREATE TABLE `workshopQuestions` (
  `workshopQuestionID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `workshopID` VARCHAR(255),
  FOREIGN KEY (`workshopID`)
    REFERENCES `workshops` (`workshopID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  `description` VARCHAR(255),
  PRIMARY KEY (`workshopQuestionsID`)
);

DROP TABLE IF EXISTS `studentWorkshops`;
CREATE TABLE `studentWorkshops` (
  `userID` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`userID`)
    REFERENCES `users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  `workshopQuestionsID` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`workshopQuestionsID`)
    REFERENCES `workshopQuestions` (`workshopQuestionsID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  `description` VARCHAR(255),
  PRIMARY KEY (`userID`, `workshopQuestionsID`)
);

SET FOREIGN_KEY_CHECKS = 1;

COMMIT;
