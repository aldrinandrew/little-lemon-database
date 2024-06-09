-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `littlelemondb` ;

-- -----------------------------------------------------
-- Table `littlelemondb`.`staffs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`staffs` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `StaffName` VARCHAR(150) NOT NULL,
  `StaffRole` VARCHAR(100) NOT NULL,
  `StaffEmail` VARCHAR(250) NOT NULL,
  `AnnualSalary` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `BookingDate` DATE NOT NULL,
  `TableNumber` INT NOT NULL,
  `StaffID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `Bookings_Staffs_fk` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `Bookings_Staffs_fk`
    FOREIGN KEY (`StaffID`)
    REFERENCES `littlelemondb`.`staffs` (`StaffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `CustomerName` VARCHAR(150) NOT NULL,
  `ContactNumber` VARCHAR(100) NOT NULL,
  `CustomerEmail` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menuitems` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `ItemName` VARCHAR(200) NOT NULL,
  `Type` VARCHAR(100) NOT NULL,
  `Price` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`ItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menus` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `ItemID` INT NOT NULL,
  `Cuisine` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `Menus_MenuItems_fk` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `Menus_MenuItems_fk`
    FOREIGN KEY (`ItemID`)
    REFERENCES `littlelemondb`.`menuitems` (`ItemID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NOT NULL,
  `TotalCost` DECIMAL(10,0) NOT NULL,
  `Quantity` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `Orders_Menus_fk` (`MenuID` ASC) VISIBLE,
  INDEX `Orders_Bookings_fk` (`BookingID` ASC) VISIBLE,
  INDEX `Orders_Customers_fk` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Orders_Bookings_fk`
    FOREIGN KEY (`BookingID`)
    REFERENCES `littlelemondb`.`bookings` (`BookingID`),
  CONSTRAINT `Orders_Customers_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemondb`.`customers` (`CustomerID`),
  CONSTRAINT `Orders_Menus_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondb`.`menus` (`MenuID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orderdeliverystatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orderdeliverystatus` (
  `DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `DeliveryDate` DATE NOT NULL,
  `Status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `OrderDeliveryStatus_Orders_fk` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `OrderDeliveryStatus_Orders_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `littlelemondb`.`orders` (`OrderID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
