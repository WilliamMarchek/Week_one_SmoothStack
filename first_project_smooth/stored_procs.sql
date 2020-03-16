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

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

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
-- procedure sp_fetchBookIdByBkName`
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