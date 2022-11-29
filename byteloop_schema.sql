-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema byteloop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `byteloop` ;
USE `byteloop` ;


-- -----------------------------------------------------
-- Table `byteloop`.`Post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byteloop`.`Post` (
  `PostID` INT NOT NULL AUTO_INCREMENT,
  `PostTypeID` INT NOT NULL, 
  `ParentID` INT,
  `PostText` TEXT NOT NULL,
  `Title` VARCHAR(255),
  `DateCreated` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `LastUpdated` DATETIME,
  `UserID` INT NOT NULL,
  PRIMARY KEY (`PostID`),
  INDEX `UserID_idx` (`UserID` ASC) VISIBLE,
  INDEX `PostTypeID_idx` (`PostTypeID` ASC) VISIBLE,
  FOREIGN KEY (`UserID`)
	REFERENCES `byteloop`.`User` (`UserID`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
  FOREIGN KEY (`ParentID`)
	REFERENCES `byteloop`.`Post` (`PostID`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
  CONSTRAINT CHK_QuestionHasTitle CHECK (`PostTypeID` <> 1 OR `Title` IS NOT NULL), 
  CONSTRAINT CHK_AnswerHasQuestion CHECK (`PostTypeID` <> 2 OR `ParentID` IS NOT NULL),
  CONSTRAINT CHK_CommentHasParent CHECK (`PostTypeID` <> 3 OR `ParentID` IS NOT NULL))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `byteloop`.`PostType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byteloop`.`PostType` (
  `PostTypeID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`PostTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `byteloop`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byteloop`.`User` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255),
  `LastName` VARCHAR(255),
  `Username` VARCHAR(255) NOT NULL,
  `Password` VARCHAR(64) NOT NULL,
  `DateJoined` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `ProfilePictureUrl` VARCHAR(255),
  `LastLogin` DATE,
  `Active` BOOLEAN DEFAULT 1, 
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `byteloop`.`Vote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `byteloop`.`Vote` (
  `VoteID` INT NOT NULL AUTO_INCREMENT,
  `UserID` INT NOT NULL,
  `PostID` INT NOT NULL,
  `DateCreated` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`VoteID`),
  INDEX `PostID_idx` (`PostID` ASC) VISIBLE,
  INDEX `UserID_idx` (`UserID` ASC) VISIBLE,
  FOREIGN KEY (`PostID`)
	REFERENCES `byteloop`.`Post` (`PostID`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
  FOREIGN KEY (`UserID`)
	REFERENCES `byteloop`.`User` (`UserID`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- Populate initial PostTypes
INSERT INTO `byteloop`.`PostType` (`PostTypeID`, `Name`) VALUES (1, 'Question'), (2, 'Answer'), (3, 'Comment');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
