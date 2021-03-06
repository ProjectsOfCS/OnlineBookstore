CREATE SCHEMA if not exists `onlinebookstore` ;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE if exists `onlinebookstore`.`userinfo`;
DROP TABLE if exists `onlinebookstore`.`books`;
DROP TABLE if exists `onlinebookstore`.`category`;
DROP TABLE if exists `onlinebookstore`.`subcategory`;
DROP TABLE if exists `onlinebookstore`.`shoppingcart`;
DROP TABLE if exists `onlinebookstore`.`purchasedorders`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE if not exists `userinfo` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `UserRole` int DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Address` varchar(45) DEFAULT NULL,
  `Newsletter` int default 0,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE if not exists `books` (
  `ISBN` int(11) NOT NULL,
  `SubCategoryID` int(11) not NULL,  
  `Title` varchar(500) DEFAULT NULL,
  `Author` varchar(45) DEFAULT NULL,
  `Language` varchar(45) DEFAULT NULL,
  `Price` float DEFAULT NULL,
  `Paperback` varchar(45) DEFAULT NULL,
  `Publisher` varchar(100) DEFAULT NULL,
  `ProductDimensions` varchar(45) DEFAULT NULL,
  `ShippingWeight` varchar(45) DEFAULT NULL,
  `Rating` int(11) DEFAULT NULL,
  `StockQuantity` int(11) DEFAULT NULL,
  `Description_P1` varchar(1000) DEFAULT NULL,
  `Description_P2` varchar(1000) DEFAULT NULL,
  `Description_P3` varchar(1000) DEFAULT NULL,
  `Description_P4` varchar(1000) DEFAULT NULL,
  `Description_P5` varchar(1000) DEFAULT NULL,
  `ProductImage` varchar(100) DEFAULT NULL,
  `Image1Large` varchar(100) DEFAULT NULL,
  `Image1Thumb` varchar(100) DEFAULT NULL,
  `Image2Large` varchar(100) DEFAULT NULL,
  `Image2Thumb` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ISBN`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE if not exists `category` (
  `CategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE  if not exists `subcategory` (
  `SubCategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `CategoryID` int(11) NOT NULL,
  `SubCategoryName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`SubCategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

Create table  if not exists `shoppingcart`(
 `CartNo` int(11) NOT NULL AUTO_INCREMENT,
 `UserID` int(11) NOT NULL,
 `ISBN` int(11) NOT NULL,
 `Quantity` int(11) NOT NULL,
  PRIMARY KEY (`CartNo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

Create table  if not exists `purchasedorders`(
 `OrderNo` int(11) NOT NULL AUTO_INCREMENT,
 `UserID` int(11) NOT NULL,
 `ISBN` int(11) NOT NULL,
 `Quantity` int(11) NOT NULL,
 `Price` float NOT NULL,
  PRIMARY KEY (`OrderNo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

ALTER TABLE `onlinebookstore`.`books` 
ADD INDEX `fk_book_category_idx` (`SubCategoryID` ASC);
ALTER TABLE `onlinebookstore`.`books` 
ADD CONSTRAINT `fk_book_subcategory`
  FOREIGN KEY (`SubCategoryID`)
  REFERENCES `onlinebookstore`.`subcategory` (`SubCategoryID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `onlinebookstore`.`subcategory` 
ADD INDEX `FK_subcategory_category_idx` (`CategoryID` ASC);
ALTER TABLE `onlinebookstore`.`subcategory` 
ADD CONSTRAINT `FK_subcategory_category`
  FOREIGN KEY (`CategoryID`)
  REFERENCES `onlinebookstore`.`category` (`CategoryID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
  ALTER TABLE `onlinebookstore`.`shoppingcart` 
ADD INDEX `FK_shoppingcart_userinfo_idx` (`UserID` ASC),
ADD INDEX `FK_shoppingcart_books_idx` (`ISBN` ASC);
ALTER TABLE `onlinebookstore`.`shoppingcart` 
ADD CONSTRAINT `FK_shoppingcart_userinfo`
  FOREIGN KEY (`UserID`)
  REFERENCES `onlinebookstore`.`userinfo` (`UserID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `FK_shoppingcart_books`
  FOREIGN KEY (`ISBN`)
  REFERENCES `onlinebookstore`.`books` (`ISBN`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;
  
 ALTER TABLE `onlinebookstore`.`purchasedorders` 
  ADD INDEX `FK_purchasedorders_userinfo_idx` (`UserID` ASC),
ADD INDEX `FK_purchasedorders_books_idx` (`ISBN` ASC);
ALTER TABLE `onlinebookstore`.`purchasedorders` 
ADD CONSTRAINT `FK_purchasedorders_userinfo`
  FOREIGN KEY (`UserID`)
  REFERENCES `onlinebookstore`.`userinfo` (`UserID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
ADD CONSTRAINT `FK_purchasedorders_books`
  FOREIGN KEY (`ISBN`)
  REFERENCES `onlinebookstore`.`books` (`ISBN`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

