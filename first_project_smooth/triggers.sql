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

DROP TRIGGER IF EXISTS `library`.`tbl_book_copies_BEFORE_UPDATE`;

DELIMITER $$
USE `library`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `tbl_book_copies_BEFORE_UPDATE` BEFORE UPDATE ON `tbl_book_copies` FOR EACH ROW BEGIN
    DECLARE errorMessage VARCHAR(255);
    SET errorMessage = CONCAT('The quantity ',
                        NEW.noOfCopies,
                        ' cannot be greater than 100 ');
                        
    IF new.noOfCopies > 100 THEN
        SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END$$
DELIMITER ;