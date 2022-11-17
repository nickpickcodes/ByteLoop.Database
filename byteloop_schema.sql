-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema byteloop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema byteloop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `byteloop` ;
USE `byteloop` ;

-- -----------------------------------------------------
-- Table `byteloop`.`Answer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byteloop`.`Answer` (
  `AnswerID` INT NOT NULL AUTO_INCREMENT,
  `AnswerText` VARCHAR(255) NOT NULL,
  `Upvotes` INT NULL,
  `Downvotes` INT NULL,
  `DateCreated` DATE NOT NULL,
  `LastUpdated` DATE NOT NULL,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`AnswerID`),
  UNIQUE INDEX `QuestionID_UNIQUE` (`AnswerID` ASC) VISIBLE,
  INDEX `UserID_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `UserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `byteloop`.`User` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `byteloop`.`Question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byteloop`.`Question` (
  `QuestionID` INT NOT NULL AUTO_INCREMENT,
  `QuestionText` VARCHAR(255) NOT NULL,
  `Upvotes` INT NULL,
  `Downvotes` INT NULL,
  `DateCreated` DATE NOT NULL,
  `LastUpdated` DATE NOT NULL,
  `AnswerID` INT NOT NULL,
  PRIMARY KEY (`QuestionID`),
  UNIQUE INDEX `QuestionID_UNIQUE` (`QuestionID` ASC) VISIBLE,
  INDEX `AnswerID_idx` (`AnswerID` ASC) VISIBLE,
  CONSTRAINT `AnswerID`
    FOREIGN KEY (`AnswerID`)
    REFERENCES `byteloop`.`Answer` (`AnswerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `byteloop`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byteloop`.`User` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `Username` VARCHAR(255) NOT NULL,
  `Password` VARCHAR(64) NOT NULL,
  `DateJoined` DATE NOT NULL,
  `LastLogin` DATE NOT NULL,
  `QuestionID` INT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `UserID_UNIQUE` (`UserID` ASC) VISIBLE,
  INDEX `QuestionID_idx` (`QuestionID` ASC) VISIBLE,
  CONSTRAINT `QuestionID`
    FOREIGN KEY (`QuestionID`)
    REFERENCES `byteloop`.`Question` (`QuestionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
