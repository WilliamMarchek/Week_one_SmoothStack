-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `library` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `library` ;

-- -----------------------------------------------------
-- Table `library`.`tbl_author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_author` (
  `authorId` INT NOT NULL,
  `authorName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`authorId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library`.`tbl_publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_publisher` (
  `publisherId` INT NOT NULL,
  `publisherName` VARCHAR(45) NOT NULL,
  `publisherAddress` VARCHAR(45) NULL DEFAULT NULL,
  `publisherPhone` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`publisherId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library`.`tbl_book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_book` (
  `bookId` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `pubId` INT NULL DEFAULT NULL,
  PRIMARY KEY (`bookId`),
  INDEX `fk_publisher` (`pubId` ASC) VISIBLE,
  CONSTRAINT `fk_publisher`
    FOREIGN KEY (`pubId`)
    REFERENCES `library`.`tbl_publisher` (`publisherId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library`.`tbl_book_authors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_book_authors` (
  `bookId` INT NOT NULL,
  `authorId` INT NOT NULL,
  PRIMARY KEY (`bookId`, `authorId`),
  INDEX `fk_tbl_book_authors_tbl_author1_idx` (`authorId` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_book_authors_tbl_author1`
    FOREIGN KEY (`authorId`)
    REFERENCES `library`.`tbl_author` (`authorId`),
  CONSTRAINT `fk_tbl_book_authors_tbl_book1`
    FOREIGN KEY (`bookId`)
    REFERENCES `library`.`tbl_book` (`bookId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `library`.`tbl_library_branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_library_branch` (
  `branchId` INT NOT NULL,
  `branchName` VARCHAR(45) NULL DEFAULT NULL,
  `branchAddress` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`branchId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library`.`tbl_book_copies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_book_copies` (
  `bookId` INT NOT NULL,
  `branchId` INT NOT NULL,
  `noOfCopies` INT NULL DEFAULT NULL,
  PRIMARY KEY (`bookId`, `branchId`),
  INDEX `fk_bc_book` (`bookId` ASC) VISIBLE,
  INDEX `fk_bc_branch` (`branchId` ASC) VISIBLE,
  CONSTRAINT `fk_bc_book`
    FOREIGN KEY (`bookId`)
    REFERENCES `library`.`tbl_book` (`bookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bc_branch`
    FOREIGN KEY (`branchId`)
    REFERENCES `library`.`tbl_library_branch` (`branchId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library`.`tbl_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_genre` (
  `genre_id` INT NOT NULL,
  `genre_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `library`.`tbl_book_genres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_book_genres` (
  `genre_id` INT NOT NULL,
  `bookId` INT NOT NULL,
  PRIMARY KEY (`genre_id`, `bookId`),
  INDEX `fk_tbl_book_genres_tbl_book1_idx` (`bookId` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_book_genres_tbl_book1`
    FOREIGN KEY (`bookId`)
    REFERENCES `library`.`tbl_book` (`bookId`),
  CONSTRAINT `fk_tbl_book_genres_tbl_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `library`.`tbl_genre` (`genre_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `library`.`tbl_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_role` (
  `roleID` INT NOT NULL,
  `roleName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`roleID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library`.`tbl_borrower`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_borrower` (
  `cardNo` INT NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  `roleID` INT NOT NULL,
  PRIMARY KEY (`cardNo`),
  INDEX `fk_role` (`roleID` ASC) VISIBLE,
  CONSTRAINT `fk_role`
    FOREIGN KEY (`roleID`)
    REFERENCES `library`.`tbl_role` (`roleID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `library`.`tbl_book_loans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`tbl_book_loans` (
  `bookId` INT NOT NULL,
  `branchId` INT NOT NULL,
  `cardNo` INT NOT NULL,
  `dateOut` DATETIME NULL DEFAULT NULL,
  `dueDate` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`bookId`, `branchId`, `cardNo`),
  INDEX `fk_bl_book` (`bookId` ASC) VISIBLE,
  INDEX `fk_bl_branch` (`branchId` ASC) VISIBLE,
  INDEX `fk_bl_borrower` (`cardNo` ASC) VISIBLE,
  CONSTRAINT `fk_bl_book`
    FOREIGN KEY (`bookId`)
    REFERENCES `library`.`tbl_book` (`bookId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bl_borrower`
    FOREIGN KEY (`cardNo`)
    REFERENCES `library`.`tbl_borrower` (`cardNo`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bl_branch`
    FOREIGN KEY (`branchId`)
    REFERENCES `library`.`tbl_library_branch` (`branchId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `library` ;

-- -----------------------------------------------------
-- procedure A_addAuthor
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_addAuthor`(IN authorNameInput varchar(45))
BEGIN
    INSERT INTO tbl_author ( authorName )
        VALUES (authorNameInput);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure A_addBook
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_addBook`(IN bookTitleInput varchar(45),
                            IN pubIdInput int)
BEGIN
    -- Since primary keys are AUTO_INCREMENT, there's no assignment.
    INSERT INTO tbl_book ( title, pubId )
        VALUES (bookTitleInput, pubIdInput);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure A_addBorrower
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_addBorrower`(IN nameInput varchar(45),
                IN addressInput varchar(45),
                IN phoneInput varchar(45))
BEGIN
    -- Since primary keys are AUTO_INCREMENT, there's no assignment.
    INSERT INTO tbl_borrower ( name, address, phone )
      VALUES (nameInput, addressInput, phoneInput);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure A_addBranch
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_addBranch`(IN branchNameInput varchar(45),
                IN branchAddressInput varchar(45))
BEGIN
  INSERT INTO tbl_library_branch ( branchName, branchAddress)
        VALUES (branchNameInput, branchAddressInput);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure A_addPublisher
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_addPublisher`(IN publisherNameInput varchar(45),
                IN publisherAddressInput varchar(45),
                IN publisherPhoneInput varchar(45))
BEGIN
    -- Since primary keys are AUTO_INCREMENT, there's no assignment.
    INSERT INTO tbl_publisher ( publisherName, publisherAddress, publisherPhone )
        VALUES (publisherNameInput, publisherAddressInput, publisherPhoneInput);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure A_changeDueDate
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_changeDueDate`(IN inputBranchId int,
                    IN inputBookId int,
                                        IN inputCardNo int,
                    IN newDueDate DATETIME)
BEGIN
  UPDATE tbl_book_loans bl
    INNER JOIN tbl_book b ON b.bookId = inputBookId
        INNER JOIN tbl_borrower bo ON bo.cardNo = inputCardNo
        INNER JOIN tbl_library_branch lb ON lb.branchId = inputBranchId
    SET dueDate = newDueDate
    WHERE bl.bookId = inputBookId
    AND bl.cardNo = inputCardNo
    AND bl.branchId = inputBranchId;    
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure A_updateAuthor
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_updateAuthor`(IN inputAuthorId int,
                  IN newAuthorName varchar(45))
BEGIN
  UPDATE tbl_author
    SET authorName = newAuthorName
    WHERE authorId = inputAuthorId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure A_updateBook
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_updateBook`(IN inputBookId int,
                    IN newtitle varchar(45),
                    IN newPubId int)
BEGIN
  UPDATE tbl_book
    SET title = newTitle, pubId = newPubId
    WHERE bookId=inputBookId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure A_updateBorrower
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_updateBorrower`(IN inputCardNo int,
                  IN newName varchar(45),
                  IN newAddress varchar(45),
                                    IN newPhone varchar(45))
BEGIN
  UPDATE tbl_borrower b
    SET b.name = newName, b.address = newAddress, b.phone = newPhone
    WHERE b.cardNo = inputCardNo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure A_updatePublisher
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `A_updatePublisher`(IN inputPublisherId int,
                    IN newPublisherName varchar(45),
                    IN newPublisherAddress varchar(45),
                                        IN newPublisherPhone varchar(45))
BEGIN
  UPDATE tbl_publisher p
    SET p.publisherName = newPublisherName, p.publisherAddress = newPublisherAddress, p.publisherPhone = newPublisherPhone
    WHERE p.publisherId=inputPublisherId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure L_updateBranchAddress
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `L_updateBranchAddress`(IN inputBranchId int, IN newBranchAddress varchar(45))
BEGIN
  UPDATE tbl_library_branch
    SET branchAddress=newBranchAddress
    WHERE branchId=inputBranchId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure fetchAuthors
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchAuthors`()
BEGIN
SELECT authorName, authorId
FROM tbl_author;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure fetchBooks
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchBooks`()
BEGIN
SELECT title, bookId
FROM tbl_books;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure fetchLibraries
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchLibraries`()
BEGIN
SELECT branchName, branchId
FROM tbl_library_branch;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure fetchPublishers
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `fetchPublishers`()
BEGIN
SELECT publisherName, publisherId
FROM tbl_publisher;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getBorrowedBooks
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBorrowedBooks`(IN borrower_id varchar(30))
BEGIN
SELECT title 
FROM tbl_book JOIN tbl_book_loans
ON tbl_book.bookId = tbl_book_loans.bookId
AND tbl_book_loans.cardNo = borrower_id
GROUP BY title;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure getBranchBooks
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBranchBooks`(IN branchId varchar(30))
BEGIN
SELECT title
FROM tbl_book JOIN tbl_book_copies
ON tbl_book.bookId = tbl_book_copies.bookId
AND tbl_book_copies.branchId = branchId
GROUP BY title;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_deleteAuthor
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteAuthor`(IN authorIdInput int)
BEGIN
DELETE FROM tbl_author
WHERE authorId=authorIdinput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_deleteBook
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteBook`(IN bookIdInput INT)
BEGIN
DELETE FROM tbl_book
WHERE bookId=bookIdInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_deleteBorrower
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteBorrower`(IN cardNoInput int)
BEGIN
DELETE FROM tbl_borrower b
WHERE b.cardNo=cardNoInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_deleteLibraryBranch
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deleteLibraryBranch`(IN branchIdInput INT)
BEGIN
DELETE FROM tbl_library_branch
WHERE branchId=branchIdInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_deletePublisher
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_deletePublisher`(IN pubIdInput int)
BEGIN
DELETE FROM tbl_publisher
WHERE publisherId=pubIdInput;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchAuthorIdByName
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchAuthorIdByName`(IN authorNameInput varchar(45))
BEGIN
SELECT a.authorId
FROM tbl_author a
WHERE a.authorName=authorNameInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchAuthors
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchAuthors`()
BEGIN
SELECT authorName
FROM tbl_author;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchBookCopiesByBookId
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchBookCopiesByBookId`(IN inptBranchId int, IN inptBookId int)
BEGIN
SELECT noOfCopies
FROM tbl_book  NATURAL JOIN tbl_book_copies
WHERE branchId=inptBranchId
AND bookId=inptBookId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchBookIdByBkName
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchBookIdByBkName`(IN inptBranchId int, IN inptBook varchar(45))
BEGIN
SELECT bookId
FROM tbl_book  NATURAL JOIN tbl_book_copies
WHERE branchId=inptBranchId
AND title=inptbook;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchBookIdByBookName
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchBookIdByBookName`(IN titleInput VARCHAR(45))
BEGIN
SELECT b.bookId
FROM tbl_book b
WHERE b.title=titleInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchBooks
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchBooks`()
BEGIN
SELECT title from tbl_book;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchBooksAndPub
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchBooksAndPub`()
BEGIN
SELECT title, pubId FROM tbl_book;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchBooksByBranch
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchBooksByBranch`(IN branchIdInput INT)
BEGIN
SELECT DISTINCT b.title
FROM tbl_library_branch lb, tbl_book_copies bc, tbl_book b
WHERE lb.branchId=branchIdInput
AND lb.branchId=bc.branchId
AND bc.bookId=b.bookId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchBorrowerBooks
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchBorrowerBooks`(IN cardNoInput int)
BEGIN
SELECT b.title, bl.dueDate
FROM tbl_borrower br, tbl_book_loans bl, tbl_book b
WHERE br.cardNo=cardNoInput
AND bl.bookId=b.bookId
AND br.cardNo=bl.cardNo;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchBorrowers
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchBorrowers`()
BEGIN
SELECT b.cardNo, b.name
FROM tbl_borrower b;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchBranchIdByName
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchBranchIdByName`(IN branchNameInput VARCHAR(45))
BEGIN
SELECT lb.branchId
FROM tbl_library_branch lb
WHERE lb.branchName=branchNameInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchCopiesByIds
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchCopiesByIds`(IN branchIdInput INT, IN bookIdInput INT)
BEGIN
SELECT bc.noOfCopies
FROM tbl_book_copies bc
WHERE bc.bookId=bookIdInput
AND bc.branchId=branchIdInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchPubIdByName
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchPubIdByName`(IN pubNameInput VARCHAR(45))
BEGIN
SELECT p.publisherId
FROM tbl_publisher p
WHERE p.publisherName=pubNameInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_fetchPublishers
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fetchPublishers`()
BEGIN
SELECT publisherName FROM tbl_publisher;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_showAllBranch
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_showAllBranch`()
BEGIN
SELECT lb.branchName FROM tbl_library_branch lb;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_updateBookCopies
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateBookCopies`(IN copiesInput INT, IN branchIdInput INT, IN bookIdInput INT)
BEGIN
UPDATE tbl_book_copies bc
SET bc.noOfCopies=copiesInput
WHERE bc.bookId=bookIdInput
AND bc.branchId=branchIdInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_updateBookCopiesById
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateBookCopiesById`(IN inptBranchId int, IN inptBookId int, IN inptCopies int)
BEGIN
UPDATE tbl_book_copies 
SET noOfCopies=(noOfCopies + inptCopies)
Where bookid=inptBookId
AND branchid=inptBranchId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_updateBranchAddress
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateBranchAddress`(IN inptBranchId int, IN newBranchAddress varchar(45))
BEGIN
  UPDATE tbl_library_branch lb
    SET branchAddress=newBranchAddress
    WHERE inptBranchId=lb.branchId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_updateBranchName
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateBranchName`(IN branchId int, IN curBranchName varchar(50), IN newBranchName varchar(50))
BEGIN
  UPDATE tbl_library_branch lb
    SET branchName=newBranchName
    WHERE curBranchName=lb.branchName
    AND branchId=lb.branchId;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_updateLibraryBranch
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateLibraryBranch`(IN branchNameInput VARCHAR(45), IN branchAddressInput VARCHAR(45), IN branchIdInput INT)
BEGIN
UPDATE tbl_library_branch lb
SET lb.branchName=branchNameInput, lb.branchAddress=branchAddressInput
WHERE lb.branchId=branchIdInput;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure sp_validateCardNo
-- -----------------------------------------------------

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validateCardNo`(IN cardNoInput int)
BEGIN
SELECT cardNo, if (cardNo=cardNoInput,true,false) as res
FROM tbl_borrower 
where cardNo=cardNoInput;
END$$

DELIMITER ;
USE `library`;

DELIMITER $$
USE `library`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `library`.`tbl_author_BEFORE_INSERT`
BEFORE INSERT ON `library`.`tbl_author`
FOR EACH ROW
BEGIN
IF NEW.authorName LIKE '%0%' OR NEW.authorName LIKE '%1%'
    OR NEW.authorName LIKE '%2%' OR NEW.authorName LIKE '%3%'
    OR NEW.authorName LIKE '%4%' OR NEW.authorName LIKE '%5%'
    OR NEW.authorName LIKE '%6%' OR NEW.authorName LIKE '%7%'
    OR NEW.authorName LIKE '%8%' OR NEW.authorName LIKE '%9%'
      THEN
          SIGNAL SQLSTATE '45000'
             SET MESSAGE_TEXT= 'Invalid author name.';
      END IF;
SET NEW.authorId= ((SELECT MAX(authorId) FROM tbl_author)+1);
END$$

USE `library`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `library`.`tbl_publisher_BEFORE_INSERT`
BEFORE INSERT ON `library`.`tbl_publisher`
FOR EACH ROW
BEGIN
IF NEW.publisherName LIKE '%0%' OR NEW.publisherName LIKE '%1%'
      OR NEW.publisherName LIKE '%2%' OR NEW.publisherName LIKE '%3%'
      OR NEW.publisherName LIKE '%4%' OR NEW.publisherName LIKE '%5%'
      OR NEW.publisherName LIKE '%6%' OR NEW.publisherName LIKE '%7%'
      OR NEW.publisherName LIKE '%8%' OR NEW.publisherName LIKE '%9%'
      THEN
          SIGNAL SQLSTATE '45000'
             SET MESSAGE_TEXT= 'Invalid borrower name.';
      END IF;
      IF LEN(NEW.publisherPhone) != 10
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT= 'Cannot add invalid phone number';
        END IF;
SET NEW.publisherId=((SELECT MAX(publisherId) FROM tbl_publisher)+1);
END$$

USE `library`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `library`.`tbl_book_BEFORE_INSERT`
BEFORE INSERT ON `library`.`tbl_book`
FOR EACH ROW
BEGIN
SET NEW.bookId= ((SELECT MAX(bookId) FROM tbl_book)+1);
END$$

USE `library`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `library`.`tbl_library_branch_BEFORE_INSERT`
BEFORE INSERT ON `library`.`tbl_library_branch`
FOR EACH ROW
BEGIN
IF NEW.branchName regexp 'd'
      THEN
          SIGNAL SQLSTATE '45000'
             SET MESSAGE_TEXT= 'Invalid library branch name.';
      END IF;
SET NEW.branchId= ((SELECT MAX(branchId) FROM tbl_library_branch)+1);
END$$

USE `library`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `library`.`tbl_borrower_BEFORE_INSERT`
BEFORE INSERT ON `library`.`tbl_borrower`
FOR EACH ROW
BEGIN
IF NEW.name LIKE '%0%' OR NEW.name LIKE '%1%'
      OR NEW.name LIKE '%2%' OR NEW.name LIKE '%3%'
      OR NEW.name LIKE '%4%' OR NEW.name LIKE '%5%'
      OR NEW.name LIKE '%6%' OR NEW.name LIKE '%7%'
      OR NEW.name LIKE '%8%' OR NEW.name LIKE '%9%'
      THEN
          SIGNAL SQLSTATE '45000'
             SET MESSAGE_TEXT= 'Invalid borrower name.';
      END IF;
SET NEW.cardNo= ((SELECT MAX(cardNo) FROM tbl_borrower)+1);
SET NEW.roleID=2;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
