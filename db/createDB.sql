START TRANSACTION;

DROP DATABASE `digintro`;

CREATE DATABASE IF NOT EXISTS `digintro`
CHARACTER SET = 'utf8mb4';

USE digintro;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `roleID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255),
  PRIMARY KEY (`roleID`)
);

INSERT INTO roles(description)
VALUES
  ('Student'),
  ('Teacher'),
  ('School manager');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `userID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userUUID` VARCHAR(20) UNIQUE NOT NULL,
  `firstName` VARCHAR(255),
  `lastName` VARCHAR(255),
  `emailAddress` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `createdAt` DATETIME DEFAULT CURRENT_TIMESTAMP(),
  `deletedAt` DATETIME DEFAULT NULL,
  `roleID` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`roleID`)
    REFERENCES `roles` (`roleID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  PRIMARY KEY (`userID`)
);

INSERT INTO users(userUUID, firstName, lastName, emailAddress, password, roleID) VALUES
  ('sahdf98yrirhewi', 'Stacey', 'Green', 's.green@gmail.com', 'ada123', 1),
  ('398rhfweishfsjk', 'Jake', 'Collier', 'j.collier@gmail.com', 'jake_Collier', 1),
  ('a9pe8urfkesdfjf', 'Billy', 'Pink', 'b.pink@gmail.com', 'pink_123sei', 1),
  ('zxnvmnbjhfai834', 'Jim', 'Turner', 'J.turner@gmail.com', 'jake_Collier', 2);

DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `classID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255),
  `classroomNumber` VARCHAR(10),
  PRIMARY KEY (`classID`)
);

INSERT INTO `classes`(name, classroomNumber)
VALUES
  ('A. Easley','102');

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

INSERT INTO `userClasses`(userID, classID) VALUES
  (1, 1),
  (2, 1),
  (3, 1),
  (4, 1);

DROP TABLE IF EXISTS `workshops`;
CREATE TABLE `workshops` (
  `workshopID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `videoLink` VARCHAR(255),
  `name` VARCHAR(255),
  `description` VARCHAR(255),
  `status` VARCHAR(255),
  PRIMARY KEY (`workshopID`)
);

INSERT INTO `workshops`(videoLink, name, description)
VALUES
  ('https://www.youtube.com/watch?v=hp1_KR_ZehQ', 'Future Pioneers in the Tech industry', 'This the carrer that you would like to join in the future'),
  ('https://www.youtube.com/watch?v=AWWIxVXXa98&t=6s', 'What it\'s like to be a software engineer', 'This is an interview from a software engineer');

DROP TABLE IF EXISTS `workshopQuestions`;
CREATE TABLE `workshopQuestions` (
  `workshopQuestionID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `workshopID` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`workshopID`)
    REFERENCES `workshops` (`workshopID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  `description` VARCHAR(255),
  PRIMARY KEY (`workshopQuestionID`)
);

INSERT INTO `workshopQuestions`(workshopID, description)
VALUES
  (1, 'What paths would you like to pursue?'),
  (2, 'What strenghts does the person in the video have?'),
  (2, 'Do you have those same strenghts?');

DROP TABLE IF EXISTS `studentWorkshops`;
CREATE TABLE `studentWorkshops` (
  `userID` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`userID`)
    REFERENCES `users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  `workshopQuestionID` INT UNSIGNED NOT NULL,
  FOREIGN KEY (`workshopQuestionID`)
    REFERENCES `workshopQuestions` (`workshopQuestionID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  `description` VARCHAR(255),
  PRIMARY KEY (`userID`, `workshopQuestionID`)
);

INSERT INTO studentWorkshops(userID, workshopQuestionID, description)
VALUES
  (1, 1, 'I would like this video, it inspires me to join the Tech industry'),
  (1, 2, 'They seem smart, innovative and logical.'),
  (2, 2, 'They have strong arms! Just kidding, intelligence, creativity, people managment.'),
  (4, 1, 'I would like to be a developer. This video inspires me to join the tech industry'),
  (1, 3, 'I am also super smart. Maybe this is a path for me.');

SET FOREIGN_KEY_CHECKS = 1;

COMMIT;
