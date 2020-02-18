-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=1;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=1;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema covid19db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema covid19db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `covid19db` DEFAULT CHARACTER SET utf8 ;
USE `covid19db` ;

-- -----------------------------------------------------
-- Table `covid19db`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid19db`.`locations` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `RoomName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `covid19db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid19db`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `AdminNumber` VARCHAR(8) NULL DEFAULT NULL,
  `PasswordSalt` VARCHAR(255) NOT NULL,
  `PasswordHash` VARCHAR(255) NOT NULL,
  `Firstname` VARCHAR(255) NOT NULL,
  `MiddleName` VARCHAR(255) NULL DEFAULT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `Gender` TINYINT(4) NOT NULL,
  `Usercol` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `covid19db`.`travelhistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid19db`.`travelhistory` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `User_id` INT(11) NOT NULL,
  `Locations_id` INT(11) NOT NULL,
  `StartDate` DATETIME NOT NULL,
  `EndDate` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `User_id`, `Locations_id`),
  INDEX `fk_TravelHistory_Locations1_idx` (`Locations_id` ASC),
  INDEX `fk_TravelHistory_User` (`User_id` ASC),
  CONSTRAINT `fk_TravelHistory_Locations1`
    FOREIGN KEY (`Locations_id`)
    REFERENCES `covid19db`.`locations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TravelHistory_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `covid19db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `covid19db`.`temperatures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid19db`.`temperatures` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `temperature` INT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_temperatures_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_temperatures_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `covid19db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
