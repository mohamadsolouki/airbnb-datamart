-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db` ;

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db` ;

-- -----------------------------------------------------
-- Table `db`.`user_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`user_type` ;

CREATE TABLE IF NOT EXISTS `db`.`user_type` (
  `id` INT NOT NULL,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`user` ;

CREATE TABLE IF NOT EXISTS `db`.`user` (
  `id` INT NOT NULL,
  `user_type` INT NOT NULL,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `DOB` DATE NULL,
  `social_media` VARCHAR(255) NULL,
  `about` TEXT NULL,
  `profile_pic` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  UNIQUE INDEX `unq_user_email` (`email` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_user_utype_idx` (`user_type` ASC) VISIBLE,
  CONSTRAINT `fk_user_utype`
    FOREIGN KEY (`user_type`)
    REFERENCES `db`.`user_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`host`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`host` ;

CREATE TABLE IF NOT EXISTS `db`.`host` (
  `id` INT NOT NULL,
  `bank_account` TEXT NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_host_user`
    FOREIGN KEY (`id`)
    REFERENCES `db`.`user` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`region` ;

CREATE TABLE IF NOT EXISTS `db`.`region` (
  `id` INT NOT NULL,
  `region_name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`country` ;

CREATE TABLE IF NOT EXISTS `db`.`country` (
  `id` INT NOT NULL,
  `region_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `code` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `country region_idx` (`region_id` ASC) VISIBLE,
  CONSTRAINT `fk_country_region`
    FOREIGN KEY (`region_id`)
    REFERENCES `db`.`region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`state`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`state` ;

CREATE TABLE IF NOT EXISTS `db`.`state` (
  `id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `code` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_state_country_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_state_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `db`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`city` ;

CREATE TABLE IF NOT EXISTS `db`.`city` (
  `id` INT NOT NULL,
  `state_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_city_state_idx` (`state_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_state`
    FOREIGN KEY (`state_id`)
    REFERENCES `db`.`state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`address` ;

CREATE TABLE IF NOT EXISTS `db`.`address` (
  `id` INT NOT NULL,
  `region_id` INT NOT NULL,
  `country_id` INT NOT NULL,
  `state_id` INT NOT NULL,
  `city_id` INT NOT NULL,
  `zip` VARCHAR(10) NOT NULL,
  `street_address` TEXT NOT NULL,
  `latitude` DECIMAL(8,6) NOT NULL,
  `longitude` DECIMAL(8,6) NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `address_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_address_region_idx` (`region_id` ASC) VISIBLE,
  INDEX `fk_address_country_idx` (`country_id` ASC) VISIBLE,
  INDEX `fk_address_state_idx` (`state_id` ASC) VISIBLE,
  INDEX `fk_address_city_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_region`
    FOREIGN KEY (`region_id`)
    REFERENCES `db`.`region` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `db`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_state`
    FOREIGN KEY (`state_id`)
    REFERENCES `db`.`state` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `db`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`property_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`property_type` ;

CREATE TABLE IF NOT EXISTS `db`.`property_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  UNIQUE INDEX `property_id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`place_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`place_type` ;

CREATE TABLE IF NOT EXISTS `db`.`place_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  `type_desc` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`property` ;

CREATE TABLE IF NOT EXISTS `db`.`property` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `owner_id` INT NOT NULL,
  `address_id` INT NOT NULL,
  `property_type_id` INT NOT NULL,
  `place_type_id` INT NOT NULL,
  `bed_count` INT NOT NULL,
  `bedroom_count` INT NOT NULL,
  `bathroom_count` INT NOT NULL,
  `current_price` DECIMAL(10,2) NOT NULL,
  `availabality` TINYINT NOT NULL,
  `minimum_stay` INT NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NULL,
  UNIQUE INDEX `pk_property` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `property address_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_property_ptype_idx` (`property_type_id` ASC) VISIBLE,
  INDEX `fk_property_user_idx` (`owner_id` ASC) VISIBLE,
  INDEX `fk_property_place_idx` (`place_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_property_host`
    FOREIGN KEY (`owner_id`)
    REFERENCES `db`.`host` (`id`),
  CONSTRAINT `fk_property_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `db`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_property_ptype`
    FOREIGN KEY (`property_type_id`)
    REFERENCES `db`.`property_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_property_place`
    FOREIGN KEY (`place_type_id`)
    REFERENCES `db`.`place_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`booking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`booking` ;

CREATE TABLE IF NOT EXISTS `db`.`booking` (
  `id` INT NOT NULL,
  `guest_id` INT NOT NULL,
  `property_id` INT NOT NULL,
  `check_in` DATE NOT NULL,
  `check_out` DATE NOT NULL,
  `price_per_night` DECIMAL(10,2) NOT NULL,
  `nights_num` INT NOT NULL,
  `adult_num` INT NOT NULL,
  `child_num` INT NOT NULL,
  `cancel_date` DATETIME NULL DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  UNIQUE INDEX `pk_booking` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `booking property_idx` (`property_id` ASC) VISIBLE,
  INDEX `fk_booking_user_idx` (`guest_id` ASC) VISIBLE,
  CONSTRAINT `fk_booking_user`
    FOREIGN KEY (`guest_id`)
    REFERENCES `db`.`user` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_property`
    FOREIGN KEY (`property_id`)
    REFERENCES `db`.`property` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`review` ;

CREATE TABLE IF NOT EXISTS `db`.`review` (
  `id` INT NOT NULL,
  `review_by_user` INT NOT NULL,
  `property_id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `review_body` TEXT NULL DEFAULT NULL,
  `review_status` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  UNIQUE INDEX `pk_guest_review` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `review user_idx` (`review_by_user` ASC) VISIBLE,
  INDEX `review booking_idx` (`booking_id` ASC) VISIBLE,
  INDEX `fk_review_property_idx` (`property_id` ASC) VISIBLE,
  CONSTRAINT `fk_review_user`
    FOREIGN KEY (`review_by_user`)
    REFERENCES `db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_booking`
    FOREIGN KEY (`booking_id`)
    REFERENCES `db`.`booking` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_property`
    FOREIGN KEY (`property_id`)
    REFERENCES `db`.`property` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`promo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`promo` ;

CREATE TABLE IF NOT EXISTS `db`.`promo` (
  `id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `discount` DECIMAL NOT NULL,
  `code` VARCHAR(7) NOT NULL,
  `promo_status` TINYINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `promo_id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`transaction` ;

CREATE TABLE IF NOT EXISTS `db`.`transaction` (
  `id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  `promo_id` INT NULL,
  `transaction_status` INT NOT NULL,
  `tax` DECIMAL(10,2) NOT NULL,
  `service_fee` DECIMAL(10,2) NOT NULL,
  `total_price` DECIMAL(10,2) NOT NULL,
  `is_refund` TINYINT NOT NULL,
  `transfer_on` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  UNIQUE INDEX `pk_transaction_id` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `transaction promo_idx` (`promo_id` ASC) VISIBLE,
  INDEX `transaction booking_idx` (`booking_id` ASC) VISIBLE,
  UNIQUE INDEX `booking_id_UNIQUE` (`booking_id` ASC) VISIBLE,
  CONSTRAINT `transaction promo`
    FOREIGN KEY (`promo_id`)
    REFERENCES `db`.`promo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `transaction booking`
    FOREIGN KEY (`booking_id`)
    REFERENCES `db`.`booking` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`image` ;

CREATE TABLE IF NOT EXISTS `db`.`image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `by_user` INT NOT NULL,
  `image_name` VARCHAR(255) NOT NULL,
  `file_location` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `updated_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `image_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `image property_idx` (`property_id` ASC) VISIBLE,
  INDEX `fk_image_user_idx` (`by_user` ASC) VISIBLE,
  CONSTRAINT `fk_image_property`
    FOREIGN KEY (`property_id`)
    REFERENCES `db`.`property` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_image_user`
    FOREIGN KEY (`by_user`)
    REFERENCES `db`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`amenity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`amenity` ;

CREATE TABLE IF NOT EXISTS `db`.`amenity` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `icon` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `property_id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`property_amenities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`property_amenities` ;

CREATE TABLE IF NOT EXISTS `db`.`property_amenities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `amenity_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `join amenity_idx` (`amenity_id` ASC) VISIBLE,
  CONSTRAINT `fk_p_join_amenity`
    FOREIGN KEY (`amenity_id`)
    REFERENCES `db`.`amenity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_a_join_property`
    FOREIGN KEY (`property_id`)
    REFERENCES `db`.`property` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`language` ;

CREATE TABLE IF NOT EXISTS `db`.`language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `language_name` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`host_language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`host_language` ;

CREATE TABLE IF NOT EXISTS `db`.`host_language` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `host_id` INT NOT NULL,
  `language_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_join_host_idx` (`host_id` ASC) VISIBLE,
  INDEX `fk_join_language_idx` (`language_id` ASC) VISIBLE,
  CONSTRAINT `fk_join_host`
    FOREIGN KEY (`host_id`)
    REFERENCES `db`.`host` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_join_language`
    FOREIGN KEY (`language_id`)
    REFERENCES `db`.`language` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`accessibility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`accessibility` ;

CREATE TABLE IF NOT EXISTS `db`.`accessibility` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `feature_name` VARCHAR(255) NOT NULL,
  `feature_desc` TEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`property_accessibility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`property_accessibility` ;

CREATE TABLE IF NOT EXISTS `db`.`property_accessibility` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `property_id` INT NOT NULL,
  `accessibility_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_join_property_idx` (`property_id` ASC) VISIBLE,
  INDEX `fk_join_accessibility_idx` (`accessibility_id` ASC) VISIBLE,
  CONSTRAINT `fk_join_property`
    FOREIGN KEY (`property_id`)
    REFERENCES `db`.`property` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_join_accessibility`
    FOREIGN KEY (`accessibility_id`)
    REFERENCES `db`.`accessibility` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `db`.`user_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`user_type` (`id`, `type_name`) VALUES (1, 'Guest');
INSERT INTO `db`.`user_type` (`id`, `type_name`) VALUES (2, 'Host');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (1, 1, 'Alden', 'Chin', 'MelBoggs38@example.com', 'V6NSRQOWEq2ms5QKC1/TLg==', '1953-11-07', 'NULL', 'Senior Advisor', 'NULL', '2020-07-26 18:30:40', '2020-10-23 18:56:27');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (2, 2, 'Adela', 'Peeler', 'Chase@example.com', 'umIa9gZ7wZ1ESL3WzcZOCg==', '2003-03-05', '@BlytheTiny', 'Finance Controller', 'https://yoke.ionhaverar.br/seedle/al/as/alth.png', '2020-03-20 03:19:31', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (3, 1, 'Lewis', 'Peel', 'Fuentes@nowhere.com', 'sZy9bEedclCoowhsySrhNQ==', '1954-06-05', '@Nye_Abram', 'Facilities Manager', 'http://co.butined.tw/ense/eve/hiour/wasonhadon.bmp', '2020-01-01 01:48:42', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (4, 2, 'Jolene', 'Lapointe', 'Falk284@example.com', 'dVsfAKhNVdm+bcXhLDXTzw==', '2001-12-23', '@Maupin_Cherish', 'Vice President', 'http://alhineasho.de/ve/ea/tentit.gif', '2021-07-20 04:38:06', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (5, 1, 'Wally', 'Henry', 'Holli.Brandenburg9@example.com', 'wC+kPEvKyAVYVqHZ0MJC4w==', '1992-01-27', '@CarpenterTheresa', 'Sales Agent', 'http://anithyouas.au/allestha/hadareea/leteingtha.gif', '2021-04-04 10:35:17', '2021-06-16 00:24:58');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (6, 2, 'Mary', 'Mcintyre', 'Carla.Blocker@example.com', 'Z314Vzrheb7Mssn1QxUC0Q==', '1975-12-14', '@ClantonPatrick', 'Senior Accountant', 'http://gumije.onentionhis.tr/edhinon/tianith/atasit/ereenentand.jpg', '2020-01-01 00:00:51', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (7, 1, 'Kurtis', 'Dietrich', 'SylviaAshworth@example.com', 'p7NjpxBKVGzA+tc+6/JA8w==', '1984-12-18', '@SpoonerFlorida', 'Vice President', 'http://tioterwasat.lu/itoulin/ormein/ntyou/inalfor.bmp', '2021-05-01 03:14:30', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (8, 2, 'Barton', 'Berry', 'Alejandrina_Brinkman@nowhere.com', 'Af/x1SCPmY5IphcHjTiCoQ==', '1965-01-18', '@Seay_Arnette', 'Technology Manager', 'https://toriso.hehenerver.ca/nehator/hadal/ithareat/thaingingst.bmp', '2020-12-20 10:33:23', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (9, 1, 'Vincent', 'Diggs', 'ycktftof1805@example.com', 'ybhlYD9reh1YS40jr1KBkw==', '1969-10-28', '@Schuler_Carolina', 'Business Analyst', 'http://ourtioverea.es/stwath/wit/retio.bmp', '2021-05-05 22:01:59', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (10, 2, 'Devona', 'Henning', 'AbrahamAskew@example.com', 'ZLqoInrKtmC0dheDnchL/Q==', '1956-03-02', '@Callahan_Monte', 'Buying Agent', 'https://shoasseit.fr/on/forasmeyou.jpg', '2020-01-01 01:01:46', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (11, 1, 'Haydee', 'Mcinnis', 'SantosBerube@example.com', 'l7ApY+uAqOrRwttauKIufA==', '1952-01-27', 'NULL', 'Operator', 'NULL', '2020-03-18 06:20:47', '2020-07-23 20:47:22');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (12, 2, 'Milissa', 'Gerard', 'Andrade5@nowhere.com', 'GX/41XF92JNxCc5oMb1row==', '1952-03-19', '@HaysAngelo', 'Product Manager', 'http://ourethiat.biz/youhen/ou/omemeheome.bmp', '2021-04-04 12:44:49', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (13, 1, 'Tracie', 'Shepard', 'Oda_JLoyd68@example.com', '4LHYsNbFz6oyISRTdwPJcg==', '1984-05-11', '@Breen_Agueda', 'Communication Analyst', 'https://histioveor.org/isforoul/hewital/hi/wanotome.gif', '2020-01-01 00:16:30', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (14, 2, 'Elvira', 'George', 'Louis_Schuler9@example.com', 'NPG8/GR8+ikx9bHnjYAR0g==', '1958-06-24', '@FaberMonty', 'Vice President', 'https://thiannot.cn/ioner/wasneti.gif', '2020-01-01 00:00:09', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (15, 1, 'Albertha', 'Henley', 'SadyeForte@example.com', 'cqspY1YgwsMIeC/o/vHAgg==', '1969-03-28', '@CarsonLinnea', 'Commercial Manager', 'http://sevuce.seorhinhen.no/allallour/thingrehad.bmp', '2020-10-14 05:02:17', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (16, 2, 'Jarvis', 'Valles', 'Begley717@example.com', '3t+NGO6CIr4xkvipHXdg7g==', '1992-08-31', 'NULL', 'Sales Agent', 'http://omendevete.cz/herorare/onenarfor.jpg', '2020-07-11 06:10:12', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (17, 1, 'Rosamond', 'Chisholm', 'RaymonAmbrose251@example.com', '3kMT/uL5XFh7XLhtZFz8qA==', '1952-01-01', '@AckerFrank', 'Business Consultant', 'http://anal.jp/mehatbut/alhiera.bmp', '2020-01-01 00:01:19', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (18, 2, 'Willetta', 'Mckay', 'clewewsr6804@example.com', '/ADIITRGX4FlP0iNx6kaaA==', '1969-11-08', '@Langston_Gracie', 'Secretary', 'http://ithreesea.fi/thhinal/tioterhiand.jpg', '2020-03-04 10:49:36', '2020-08-08 10:41:44');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (19, 1, 'Alan', 'Vanburen', 'EileenBaumann@example.com', 'ew5AGzSQus0R7wVnwlVtug==', '1952-02-20', '@Hobson_Salome', 'Facilities Manager', 'https://webena.buthierith.cy/tiing/it/washiuld/toandtoter.bmp', '2020-01-01 00:01:30', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (20, 2, 'Belkis', 'Peebles', 'LaiAllen@example.com', 'xBCj3Cb7xugckwS5e700Zw==', '1952-01-09', '@CruseAntony', 'Credit Analyst', 'https://eveleer.uk/edbutis/arehinti/evehait/ineras.bmp', '2021-02-12 07:54:27', '2021-08-05 05:51:55');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (21, 1, 'Dell', 'Mckee', 'tlsu851@example.com', 'i5GmFYO2HQWERSvhcvynmA==', '1985-06-26', '@EngAnibal', 'Communication Consultant', 'http://somu.hadisasion.kr/was/waoruld/ted/wasngtioall.jpg', '2020-11-08 16:01:48', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (22, 2, 'Alexandria', 'Shephard', 'Lekisha_VAkins62@example.com', 'QXCywmt1g2JHNTn9AMWW/w==', '1979-02-17', '@Dawkins_Rosaura', 'Solution Engineer', 'http://tewitoulas.com/on/uldwaas.png', '2021-05-31 12:47:05', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (23, 1, 'Camellia', 'Peek', 'Mckinley.Dillard@example.com', '3tWNjt9vSNEdksCLMH5piA==', '1965-10-12', '@AmaralMarcy', 'Chief Executive Officer', 'http://zaviyo.hinneensho.ch/hean/tiaryou/leation/orththaas.gif', '2021-03-09 16:37:54', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (24, 2, 'Perry', 'Large', 'EnriquezF@example.com', 'vS0JjJSE5UTBxUjxYxWYJQ==', '1991-04-30', '@Harrison_Frankie', 'Technical Assistant', 'https://siyesu.ithisisthi.gr/ourarea/harete/ingterleyou.gif', '2020-01-01 01:19:27', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (25, 1, 'Ross', 'Laporte', 'Vance_Blocker229@nowhere.com', 'c/q9GJ9dO3NmCJRzfYPykQ==', '1964-06-03', '@Adcock_Anderson', 'Advisor', 'https://duzunu.theed.mx/to/butsehadted.png', '2020-08-07 22:24:07', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (26, 2, 'Jefferson', 'Gerald', 'RudolphKyle999@nowhere.com', 'kuTS2j0VKLyfZmi7wm1jPg==', '1993-03-26', '@Abbott_Adaline', 'Database Administrator', 'https://ittheevesho.za/edoruld/inguldeveour.jpg', '2020-01-01 00:00:01', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (27, 1, 'Flora', 'Dietz', 'Schumacher117@example.com', 'v+A+HWi/kVJ1iYuVCq702Q==', '2002-04-27', '@Wooten_Louis', 'Branch Manager', 'https://satede.thahenneome.cy/ing/witourne/asoul.gif', '2020-12-29 08:05:55', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (28, 2, 'Barney', 'Gerber', 'ArlenReddy787@nowhere.com', 'mQTZdZ2yrsRFdim2/hV2/w==', '1952-03-30', '@AdcockCharleen', 'Specialist', 'https://wije.estheswa.dk/me/thain/er/thito.jpg', '2020-10-24 16:31:06', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (29, 1, 'Trinidad', 'Peeples', 'Calabrese282@example.com', 'yvNBqZb4pkWavvGxKkdh6w==', '1977-11-26', '@CrabtreeRolland', 'Secretary', 'https://youesandal.nl/oul/evestte.bmp', '2020-01-01 00:00:34', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (30, 2, 'Martin', 'Mcintire', 'BustamanteN@example.com', 'CyTbmUXxdBh1YWY/4sAupw==', '1962-02-22', '@Mattox_Junior', 'Director of Manufacturing', 'https://vetiontte.net/entiseve/ereouha/toesnot/inhenandere.gif', '2020-01-01 01:23:54', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (31, 1, 'Stanton', 'Larkin', 'Haight@example.com', 'vLuzNERStAvftCs5I0JIUg==', '1998-06-24', '@Prater_Zachariah', 'NULL', 'http://fike.andfor.nz/or/anhisthi/verhenbutere.gif', '2020-01-01 02:04:07', '2020-05-04 09:41:38');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (32, 2, 'Sabina', 'Shepherd', 'Audria_Lutz95@example.com', 'd8rpvM0Nc9sJcMJ8nx96Jg==', '1993-11-08', '@RuthAngelo', 'NULL', 'http://tuyuwo.ereas.it/thyouat/ndereted/ithou/enteswasat.bmp', '2020-01-01 01:52:56', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (33, 1, 'Damaris', 'Mcintosh', 'Marshall_Weldon683@nowhere.com', '42nGI1/XWS2kvTYiPJlqyg==', '1978-12-11', '@Madsen_Krysta', 'Sales Administrator', 'https://qunoki.ngteeveent.cy/eserare/witseent/wathito/veand.bmp', '2020-05-13 20:14:24', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (34, 2, 'Salome', 'Hensley', 'Kim@nowhere.com', 'YVR7m21jlzq/B2HDyR0Ltw==', '1997-03-04', '@AdamsonPalmer', 'NULL', 'https://denuca.alesesha.lu/leingte/orhehad/hiverhior.bmp', '2021-05-09 18:06:48', '2021-10-20 00:20:36');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (35, 1, 'Adalberto', 'Vance', 'nbgxavvc_oapo@example.com', 'vTLFpfdB1FjeXR7WGFZACA==', '1952-02-03', '@BarberUlrike', 'NULL', 'http://isteteing.ca/es/th/se/wasasall.jpg', '2021-09-18 06:06:22', '2021-11-28 09:06:37');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (36, 2, 'Maire', 'Van', 'DennaStroud@example.com', 'ZDp+N4NDq1ec6sHwJMO+1g==', '1954-09-16', '@FredericksNathaniel', 'QA Manager', 'https://itithhentha.ch/enteand/eveour/youitsho/edhenheome.png', '2020-01-20 22:52:47', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (37, 1, 'Lahoma', 'Shelton', 'Jose_Reddick@example.com', 'cFb8nNE4qFaeMPXG7XU7Og==', '1978-01-06', 'NULL', 'Senior Developer', 'https://wupe.thiarwasion.net/wa/you/forores/allherines.png', '2020-06-28 18:29:20', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (38, 2, 'Serina', 'Lara', 'Doughty583@example.com', 'sSDooH3Nqjuf9f8o++D29w==', '2001-11-20', '@Gipson_Adrianne', 'Sales Manager', 'https://tukipe.evethahenwit.il/enthiter/ndthesho/tio/ereareheral.jpg', '2020-01-01 00:00:27', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (39, 1, 'Shaina', 'Berrios', 'SylviaC_Leroy88@nowhere.com', '/PTXgO3IRufRPLSjGLe8uA==', '1953-11-08', '@BattenKathrine', 'Vice President', 'NULL', '2020-01-01 00:39:27', 'NULL');
INSERT INTO `db`.`user` (`id`, `user_type`, `first_name`, `last_name`, `email`, `password`, `DOB`, `social_media`, `about`, `profile_pic`, `created_at`, `updated_at`) VALUES (40, 2, 'Jeromy', 'Hennessey', 'Terence.Robins@nowhere.com', 'y5xyFCa3Nt5f+iP8ejZ7JA==', '1993-03-15', '@AmadorLauren', 'Secretary', 'NULL', '2020-01-01 00:11:18', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`host`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (id, 'bank_account');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (2, 'UA 1784 7249 98R4 2516 E166 79V8 WGK');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (4, 'CY 6583 5700 57L2 L2TM SQTX 1Z28 17');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (6, 'NO 6379 0873 7576 0');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (8, 'IT 50Q7 2642 6890 2387 DJ2O P1TL X');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (10, 'CZ 3210 7096 1444 8505 8395 87');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (12, 'FI 3048 4109 0176 3419');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (14, 'SE 2688 3330 7930 3832 7031 59');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (16, 'CY 3064 8271 11H3 218W O2ES 4D2X M7');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (18, 'DE 5882 4456 5680 9953 4465');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (20, 'UA 5156 5010 8P1P Y8I3 U4PU 2A85 2HJ');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (22, 'FR 9809 8949 9010 F6KJ HBIP 85S7 3');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (24, 'IT 53N9 3464 2253 98MF 27AB 85YH 7');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (26, 'AE 9470 6683 0827 5060 6738 1');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (28, 'CY 0319 9072 7018 N6J5 QQIW 2KSE Y7');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (30, 'NL 50NM YS37 5421 5387');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (32, 'CH 2300 553K BA17 79Q5 8LO');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (34, 'NL 77ZY VR59 8051 1936');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (36, 'BE 1674 0045 0961 41');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (38, 'IT 37W2 0314 6281 122R P6UG 23D1 6');
INSERT INTO `db`.`host` (`id`, `bank_account`) VALUES (40, 'FR 9036 4628 9231 R2Z8 7ND1 U4W4 2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`region`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`region` (`id`, `region_name`, `description`) VALUES (1, 'Africa', 'Earum expedita veniam natus ipsum. Autem dolor minus; eligendi ipsam accusantium sed eius vero et. Quos culpa quia.');
INSERT INTO `db`.`region` (`id`, `region_name`, `description`) VALUES (2, 'Asia', 'Dolore aperiam repudiandae unde. In est doloremque maiores at deserunt. Qui possimus animi aperiam! Sapiente voluptate ut nisi error pariatur eos.');
INSERT INTO `db`.`region` (`id`, `region_name`, `description`) VALUES (3, 'Caribbean', 'Et earum aspernatur sed; provident sed qui error est. Ipsum sint est possimus ut consequuntur ratione libero. Quo nulla quis dolorem voluptas vitae dolorum.');
INSERT INTO `db`.`region` (`id`, `region_name`, `description`) VALUES (4, 'Central America', 'Eligendi possimus error eum. Reiciendis quaerat sit iste quis; recusandae velit impedit dignissimos sapiente perferendis sunt, error enim eum.');
INSERT INTO `db`.`region` (`id`, `region_name`, `description`) VALUES (5, 'Europe', 'Voluptatem at sit provident, ut quis praesentium temporibus sit voluptate...');
INSERT INTO `db`.`region` (`id`, `region_name`, `description`) VALUES (6, 'North America', 'Earum eveniet ab odit delectus consequatur. Sunt modi voluptas dolor perspiciatis soluta, reprehenderit veniam natus nostrum.');
INSERT INTO `db`.`region` (`id`, `region_name`, `description`) VALUES (7, 'Oceania', 'Libero nesciunt natus quia. Qui reiciendis ut deserunt! Ut laborum quis consectetur sed enim rerum unde quia perspiciatis. Provident voluptatem hic. Est ea.');
INSERT INTO `db`.`region` (`id`, `region_name`, `description`) VALUES (8, 'South America', 'Magni nulla et. Iure doloremque non quis non laborum rerum quos! Necessitatibus odio quia. Qui aut architecto sunt omnis quae quasi ipsa? Aut natus ad...');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`country`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (1, 2, 'Afghanistan', 'AFG');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (2, 5, 'Luxembourg', 'LUX');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (3, 8, 'Canada', 'CAN');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (4, 7, 'Botswana', 'BWA');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (5, 5, 'Guyana', 'LUX');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (6, 8, 'Mongolia', 'GUY');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (7, 8, 'Korea', 'MNG');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (8, 2, 'Kuwait', 'KOR');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (9, 4, 'Tunisia', 'KWT');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (10, 8, 'Jordan', 'TUN');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (11, 6, 'Guatemala', 'JOR');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (12, 6, 'Singapore', 'GTM');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (13, 2, 'Nicaragua', 'SGP');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (14, 7, 'Denmark', 'NIC');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (15, 7, 'Turkey', 'DNK');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (16, 1, 'Cyprus', 'TUR');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (17, 5, 'Iceland', 'CYP');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (18, 4, 'Zambia', 'ISL');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (19, 2, 'Namibia', 'ISL');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (20, 2, 'Japan', 'ZMB');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (21, 6, 'Switzerland', 'NAM');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (22, 7, 'Cuba', 'JPN');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (23, 1, 'Germany', 'CHE');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (24, 5, 'France', 'DNK');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (25, 8, 'Malaysia', 'CUB');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (26, 6, 'Qatar', 'DEU');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (27, 6, 'Spain', 'FRA');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (28, 4, 'Bangladesh', 'GUY');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (29, 6, 'New Zealand', 'MYS');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (30, 5, 'Australia', 'QAT');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (31, 8, 'Malawi', 'ESP');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (32, 3, 'Poland', 'AFG');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (33, 8, 'Belize', 'BGD');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (34, 6, 'Saudi Arabia', 'NZL');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (35, 6, 'United States', 'AUS');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (36, 2, 'Finland', 'MWI');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (37, 5, 'Czech Republic', 'POL');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (38, 2, 'Albania', 'BLZ');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (39, 6, 'Mexico', 'SAU');
INSERT INTO `db`.`country` (`id`, `region_id`, `name`, `code`) VALUES (40, 6, 'Lithuania', 'POL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`state`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (1, 1, 'New Hampshire', 'NH');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (2, 1, 'Maine', 'ME');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (3, 1, 'Pennsylvania', 'PA');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (4, 1, 'Connecticut', 'CT');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (5, 1, 'Oregon', 'OR');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (6, 1, 'Arkansas', 'AR');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (7, 1, 'Alaska', 'AK');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (8, 1, 'South Dakota', 'SD');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (9, 1, 'Washington', 'AK');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (10, 1, 'New York', 'WA');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (11, 1, 'California', 'NY');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (12, 1, 'Utah', 'CA');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (13, 1, 'Delaware', 'UT');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (14, 1, 'Florida', 'NY');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (15, 1, 'Tennessee', 'ME');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (16, 1, 'Montana', 'DE');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (17, 1, 'Colorado', 'FL');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (18, 1, 'Minnesota', 'TN');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (19, 1, 'New Jersey', 'MT');
INSERT INTO `db`.`state` (`id`, `country_id`, `name`, `code`) VALUES (20, 1, 'Kansas', 'CO');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`city`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (1, 10, 'Eleva');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (2, 10, 'Lonoke');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (3, 11, 'Zuni');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (4, 8, 'Porterville');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (5, 15, 'Houma');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (6, 15, 'Block Island');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (7, 17, 'Lonsdale');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (8, 15, 'Hackettstown');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (9, 19, 'Coloma');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (10, 14, 'Elfers');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (11, 1, 'Haddam');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (12, 16, 'Blomkest');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (13, 13, 'Elgin');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (14, 11, 'Colome');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (15, 1, 'Haddon Heights');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (16, 1, 'Newburg');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (17, 1, 'Porthill');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (18, 2, 'Elida');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (19, 10, 'Williams');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (20, 12, 'Housatonic');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (21, 8, 'Loogootee');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (22, 11, 'Bloomdale');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (23, 18, 'Suttons Bay');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (24, 14, 'Haddonfield');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (25, 17, 'House Springs');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (26, 4, 'Williams Bay');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (27, 14, 'Colon');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (28, 16, 'Newburgh');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (29, 19, 'Lookeba');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (30, 17, 'Bloomer');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (31, 10, 'Houston');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (32, 11, 'Eliot');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (33, 11, 'Portland');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (34, 14, 'Colonia');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (35, 17, 'Bloomfield');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (36, 17, 'Colonial Beach');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (37, 6, 'Bloomfield Hills');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (38, 18, 'Newbury');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (39, 19, 'Portola');
INSERT INTO `db`.`city` (`id`, `state_id`, `name`) VALUES (40, 15, 'Colonial Heights');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`address`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (1, 2, 14, 13, 37, '94630', '607 New Meadowview Lane, Phoenix, AZ, 14419', 3.560036, 62.962605, '2020-01-01 00:00:04', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (2, 5, 20, 3, 18, '11450', '1052 Rock Hill Highway, Macy\'s Building, Oklahoma City, OK, 97484', -78.994095, 51.413802, '2020-02-24 09:06:53', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (3, 7, 21, 18, 7, '08242', '1842 Riddle Hill Highway, Victor Executive Bldg, Honolulu, HI, 04079', 73.466126, -2.536963, '2020-01-01 00:00:08', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (4, 3, 38, 2, 5, '34958', '1930 Red Meadowview Blvd, Carson City, NV, 06911', -12.013939, -45.455046, '2020-02-19 05:32:28', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (5, 8, 34, 20, 31, '76703', '1962 Flintwood Ct, Indianapolis, IN, 02402', -92.490181, 73.527017, '2020-06-16 03:44:22', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (6, 1, 34, 16, 38, '49273', '800 White Buttonwood Circle, Nashville, TN, 36627', 97.318999, -8.787260, '2020-07-24 13:24:51', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (7, 4, 23, 10, 21, '43735', '2945 Pine Tree Loop, Tallahassee, Florida, 88383', 20.882109, 7.823117, '2021-02-15 22:13:08', '2021-02-15 22:13:08');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (8, 6, 9, 8, 23, '77578', '2954 Riddle Hill Way, Buhl Building, Montpelier, VT, 53571', -35.525385, -3.613067, '2021-04-29 05:23:17', '2021-04-29 05:23:17');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (9, 7, 12, 9, 22, '43438', '2704 NE Hazelwood Street, Austin, Texas, 32133', -49.025410, 20.177537, '2020-10-06 08:48:11', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (10, 6, 20, 7, 1, '96139', '67 New Riverside Way, Austin, TX, 44471', 15.539568, 71.304542, '2021-09-05 06:22:56', '2021-09-05 06:22:56');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (11, 6, 28, 9, 14, '99399', '2819 Deepwood Ct, Sacramento, California, 23080', -6.819625, 80.219994, '2020-01-01 00:10:39', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (12, 5, 24, 3, 37, '74840', '889 SE Waterview Highway, Lincoln, NE, 35367', 62.435648, 43.121671, '2020-01-01 00:56:40', '2020-01-01 00:56:40');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (13, 4, 1, 7, 28, '53842', '147 3rd Way, Diamond Building, Dover, Delaware, 57720', 44.755662, -80.621457, '2020-08-05 19:38:12', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (14, 8, 37, 1, 21, '78879', '1112 New Church Blvd, 257 Towers Building, Harrisburg, PA, 36595', 61.331421, -71.086547, '2020-01-01 00:01:06', '2020-01-01 00:01:06');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (15, 1, 19, 20, 22, '87968', '660 1st Ln, 1st Floor, Baton Rouge, LA, 11677', 44.179971, 67.540539, '2020-01-01 00:06:55', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (16, 1, 33, 9, 33, '48619', '2729 E Chapel Hill St, Fisher Bldg, Des Moines, Iowa, 83516', 47.948797, -4.300155, '2021-09-04 22:37:48', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (17, 6, 6, 2, 5, '54770', '2005 W Burwood Lane, Salt Lake City, Utah, 15169', -4.882782, -62.832994, '2020-01-01 00:00:25', '2020-01-01 00:00:25');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (18, 2, 28, 14, 24, '93604', '823 3rd Cir, Guardian Bldg, Denver, CO, 29932', -1.362427, 32.616666, '2021-04-27 13:31:03', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (19, 6, 23, 19, 23, '07975', '41 Mount Highway, Keith Bldg, Dover, Delaware, 07107', 52.789417, -4.566965, '2021-06-18 01:09:27', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (20, 7, 13, 4, 3, '09304', '1884 New Parkwood Avenue, Albany, New York, 10785', -95.964874, -6.526117, '2020-01-01 00:57:34', '2020-01-01 00:57:34');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (21, 6, 28, 14, 24, '98944', '3556 Old Quailwood Lane, Fisher Bldg, Topeka, KS, 56925', 22.572304, 24.781534, '2020-01-01 02:09:09', '2020-01-01 02:09:09');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (22, 6, 22, 10, 22, '34891', '3163 Ski Hill Hwy, Augusta, ME, 33323', -38.376390, 77.980037, '2020-06-07 07:27:35', '2020-06-07 07:27:35');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (23, 6, 36, 3, 2, '50500', '2556 Sharp Hill Way, Lansing, Michigan, 62493', -72.741463, -33.885065, '2020-01-01 02:25:46', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (24, 6, 37, 12, 3, '70957', '2000 Prospect Hill Loop, Dover, Delaware, 51314', 72.998825, -66.850751, '2021-01-13 07:41:58', '2021-01-13 07:41:58');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (25, 2, 13, 15, 17, '20928', '3018 Pine Tree Way, Bartlett Bldg, Saint Paul, Minnesota, 90571', 49.455997, 89.167817, '2020-01-01 00:00:10', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (26, 6, 16, 14, 3, '64117', '3921 4th Rd, Olympia, Washington, 61250', -43.987792, 71.689028, '2021-06-07 00:26:51', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (27, 3, 31, 12, 1, '96600', '2357 3rd Drive, Duke Energy Bldg, Atlanta, GA, 20672', -77.421527, 40.716286, '2021-03-19 02:55:26', '2021-03-19 02:55:26');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (28, 6, 7, 20, 40, '24021', '3737 New Social Ct, 54th Floor, Helena, MT, 40189', 45.167304, 23.207610, '2021-09-06 03:34:56', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (29, 2, 37, 4, 27, '47090', '28 Highland Ln, Olympia, Washington, 30416', -8.911516, 66.324635, '2021-05-21 17:42:57', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (30, 6, 2, 6, 27, '65214', '652 Mount Court, Pierre, South Dakota, 27075', -1.911492, -53.726151, '2021-03-07 02:14:08', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (31, 1, 15, 5, 3, '81150', '2525 West Beachwood Loop, Calyon Bldg, Little Rock, Arkansas, 38566', -48.224892, 36.126240, '2020-01-01 00:00:04', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (32, 6, 10, 6, 26, '06633', '208 Ashwood Ct, STE 570, Springfield, Illinois, 28929', 53.212490, 65.848607, '2020-09-29 17:58:35', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (33, 2, 23, 8, 9, '20864', '3174 W Bayview Ct, Judge Bldg, Montgomery, Alabama, 73077', 87.252227, -62.980754, '2020-01-01 00:16:31', '2020-01-01 00:16:31');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (34, 8, 25, 14, 18, '78189', '32 Red Deepwood Lane, Raleigh, NC, 15026', 74.352639, -14.056781, '2020-01-20 10:30:32', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (35, 5, 34, 20, 29, '45434', '1376 White Mount Highway, Kearns Building, Montgomery, Alabama, 40761', -77.843730, -66.421180, '2020-06-27 04:36:04', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (36, 7, 36, 12, 29, '23342', '3351 N Flintwood Rd, Montpelier, VT, 10816', -15.608811, 56.370847, '2020-04-09 19:55:39', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (37, 6, 9, 1, 24, '42393', '38 NE Burwood Dr, Sacramento, CA, 39756', -60.145418, -40.442388, '2021-01-07 14:54:35', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (38, 2, 39, 11, 40, '32691', '3548 Parkwood Cir, Macy\'s Bldg, Olympia, WA, 78457', 36.444740, 1.275378, '2020-10-14 09:53:15', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (39, 5, 8, 3, 13, '13392', '57 Parkwood Loop, Standard Bldg, Helena, Montana, 48726', 11.648899, -10.914679, '2020-01-01 00:10:02', 'NULL');
INSERT INTO `db`.`address` (`id`, `region_id`, `country_id`, `state_id`, `city_id`, `zip`, `street_address`, `latitude`, `longitude`, `created_at`, `updated_at`) VALUES (40, 6, 26, 1, 1, '18350', '2986 SW Chapel Hill Pkwy, Lincoln, Nebraska, 62401', -16.611782, 57.388719, '2020-01-01 01:59:55', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`property_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`property_type` (`id`, `type_name`, `description`) VALUES (1, 'House', 'Ab asperiores, ad neque vel voluptatem natus corporis asperiores fuga ea qui nemo deleniti et. Aspernatur aut, doloremque odio doloribus sit enim et similique sint atque sit aut ratione ut? Eligendi beatae perspiciatis laboriosam et corporis nihil et voluptatum necessitatibus voluptate magni earum aut illum; libero sit, sed debitis voluptatem eum ea facilis reiciendis quae eaque voluptatem eos ducimus voluptatem? Labore quisquam ut magni molestias repellendus quaerat earum quia dolores iste totam inventore nesciunt iste; sequi ut perspiciatis illo in ipsa est quia ipsum ab odio alias soluta suscipit omnis. Doloremque ut dicta error illum sint enim voluptatibus distinctio amet maiores quidem numquam unde id. Facilis autem labore laborum eos voluptate ut libero sit voluptatem praesentium deserunt dolor aliquam minima!\nRepellendus omnis a voluptate voluptatem vitae et aliquid voluptatem non ullam ut enim inventore in. Consequatur est voluptas ut aspernatur voluptates consectetur nihil et eum nihil nesciunt vel id similique; delectus omnis sint natus debitis, sed distinctio inventore magni unde consectetur sit iste suscipit saepe. Maiores iure ipsum, suscipit aspernatur neque vero libero exercitationem dolores commodi a excepturi minima officia! Voluptatem perspiciatis minima nesciunt facere non aliquam omnis at autem consequatur totam, nulla ut et. Vitae aut placeat deserunt obcaecati vero quos unde nesciunt tempore, provident fuga eos natus nihil. Non exercitationem dolorum eos error quia amet quasi natus, libero sit et nisi alias debitis! Error ea enim sed molestiae ab odit id vel voluptatem facilis earum nulla omnis ratione.');
INSERT INTO `db`.`property_type` (`id`, `type_name`, `description`) VALUES (2, 'Apartment', 'At porro et nostrum ab obcaecati suscipit sit unde sint consequatur blanditiis vel velit nisi. Ducimus vitae, quasi cupiditate ab fugiat et saepe consequatur itaque distinctio mollitia iste perspiciatis praesentium. Et dolore placeat autem veritatis beatae rerum sit dolor ab, quis et ipsum vero ut. Sunt nemo dicta voluptas explicabo dignissimos voluptatem, cum numquam eveniet iste est iure non enim!\nQui itaque et laudantium voluptatum ex reiciendis ratione veritatis voluptatem dolorum voluptatem quo perspiciatis molestiae. Omnis ipsam iure eveniet perspiciatis qui excepturi omnis consectetur ut aperiam eum dolor, eligendi impedit. Placeat suscipit pariatur vero rem ea amet omnis officia tempore natus architecto voluptatem maiores dicta. Blanditiis iste dolorem nihil ab, unde modi dignissimos quia error voluptas odio similique aspernatur dolores. Rerum vel consequuntur voluptates possimus repellendus magni et sapiente hic magnam repellendus quos sit alias! Sunt sequi id atque minus perferendis sit quae consequatur ut dolor magni perspiciatis odit asperiores. Iste suscipit earum, nihil dicta animi accusantium quis non in aut doloremque natus debitis quibusdam. Exercitationem porro voluptatem beatae sint est ipsa enim est et odit officia perferendis eligendi sed! Amet nihil magni provident sed dolore incidunt voluptas dolorem ex quibusdam repellat sit eos ut. Mollitia a ut, non cumque itaque rerum nostrum magni illum tenetur repudiandae dolorem nihil dolor. Molestias perspiciatis quidem dolorem tempora in molestiae voluptas est qui consectetur quae dolor laboriosam ea!');
INSERT INTO `db`.`property_type` (`id`, `type_name`, `description`) VALUES (3, 'Guesthouse', 'Voluptas velit, consequatur iste illum optio sunt rerum ut laboriosam dolor cum sapiente voluptatem aut. Illum quia eum, qui officia totam qui error natus sit deserunt dolorum architecto necessitatibus libero. Hic est nobis sit aut dolor maiores at eligendi aut necessitatibus dolorem unde voluptatem qui! Est neque non eius, maxime quidem omnis illo aut deleniti in labore sed optio dolor. Ab non id natus consequatur amet atque omnis sint ex unde sed et veniam est. Cum aut praesentium et tenetur blanditiis rerum ratione quod autem labore qui sed ut expedita! Aut tenetur voluptatem natus magnam repudiandae dolorum numquam rerum sit rerum obcaecati ratione illo maxime? Ut quaerat atque quae, numquam pariatur dolorem eius facere qui odio labore iste eligendi explicabo. Enim nesciunt, sapiente iure ullam necessitatibus vitae aut accusantium rem inventore non eveniet sit nobis. Molestias enim incidunt, maiores eos repellat officiis dolorem commodi fugiat aut voluptas ut quis odit? Iste rem rerum blanditiis ad, optio fugit neque est tempore nulla nam in quo qui. Voluptas odit, non consequatur ut enim deserunt aperiam tempore recusandae ipsum odit fuga atque autem. Est consequuntur quia sed voluptatum fuga aperiam autem repellendus ut veniam error vitae nobis quisquam. Voluptas quo qui est, odio ut quis dolorum in rem reprehenderit dolorem harum autem voluptatum; natus laudantium error quis voluptatem, iste dolorum omnis rerum qui quaerat sint est eum aspernatur. Alias nesciunt enim laudantium possimus itaque optio commodi repudiandae deleniti et aliquid amet eius recusandae! Est iste cum saepe error molestias magni id neque magni voluptatem saepe quia voluptas id.');
INSERT INTO `db`.`property_type` (`id`, `type_name`, `description`) VALUES (4, 'Hotel', 'Nesciunt ut dolorem iste, velit asperiores voluptatem veniam fuga voluptatem ipsum veritatis voluptatem aut labore; aspernatur sed, neque dolor harum voluptatem quibusdam repellendus reiciendis maiores voluptatem et est eius rerum; facere numquam et quia praesentium at, est ullam ut voluptas aut sed aut odio aperiam. Earum est sit provident est quos maiores sit tenetur id maiores aut sunt consequatur iure. Repellat provident cupiditate tempora ut sed non maxime, aut dolor blanditiis earum officiis assumenda mollitia; cum iste, aperiam accusamus explicabo molestiae maiores unde iste quia perferendis rem qui fuga repellendus.\nEst quia, officiis qui veniam incidunt et est ratione voluptas soluta sit eos perspiciatis et. Voluptatibus quia sit mollitia earum similique porro, tempore aut ut hic ut at earum aperiam. Odit quae id a, ullam tempora animi quibusdam aspernatur eaque cumque nostrum iure ut voluptatem! Sequi eos sed exercitationem officiis quia nulla facilis atque facilis nostrum quis maiores sed alias. Rem debitis unde molestiae aliquid sint in aliquid similique sit quia ut voluptas fuga odio! Voluptatibus aliquam deleniti quas autem quis numquam aliquam, libero qui et voluptatum quae quo incidunt.\nEos aut voluptatem incidunt quia doloribus sit non aut necessitatibus quisquam consequatur dicta dolorem rerum. Voluptatum ab cumque possimus expedita repellendus et eaque natus velit voluptas aut sed neque sit? Nam dolores qui labore maiores accusamus placeat corporis dolorem quia recusandae aut vero ullam quod. Nobis natus rem quo, illo est assumenda eligendi est amet qui dolorem voluptas consequatur dolores! Alias natus voluptatem sint ea, et voluptatem doloremque veritatis perspiciatis ipsam repellat corporis iure consectetur? Quam vero pariatur, nihil minima dolore nam laborum placeat cum quas ipsa pariatur molestias non. Vitae rem dolor eos sed nesciunt voluptate magnam alias similique veritatis natus iste eum sed. Est quos rerum aut iste dolor quo et voluptas, perferendis ut deserunt quia ut aut? Omnis at dolore aut magni aliquam sunt aut repellat qui natus at sit nulla veritatis. Architecto reiciendis, aut et molestiae itaque quia sed dolores culpa sed consequatur quae tempora deleniti. Maiores et ab sint eos sint et omnis quis odio est rerum sed et perspiciatis. Enim quod velit explicabo similique est ratione ipsa in enim quam natus quae et libero. Sunt eaque voluptatem et nihil iste magnam assumenda reprehenderit ut ad qui quae ut tempora. Ut cumque dolorem molestiae officia nisi sed eaque error consequuntur esse dolores consequatur explicabo nulla! Ad praesentium non eligendi itaque reiciendis officia pariatur rem delectus, laborum iste enim tenetur alias. Quo enim repellendus ut expedita aut, enim culpa autem quis aspernatur vero harum nam ad! Deserunt fugit odit sequi voluptates libero sapiente et dignissimos a vero qui vel quo est. Quidem est omnis et optio doloremque delectus vitae unde explicabo vel eveniet quo nesciunt quaerat! Fugiat sunt aspernatur tenetur eum provident, sequi ea assumenda nihil quidem quisquam quia sit modi.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`place_type`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`place_type` (`id`, `type_name`, `type_desc`) VALUES (1, 'Entire place', 'A place all to yourself');
INSERT INTO `db`.`place_type` (`id`, `type_name`, `type_desc`) VALUES (2, 'Private room', 'Your own room in a home or a hotel, plus some shared common spaces');
INSERT INTO `db`.`place_type` (`id`, `type_name`, `type_desc`) VALUES (3, 'Shared room', 'A sleeping space and common areas that may be shared with others');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`property`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (1, 34, 3, 4, 1, 2, 2, 1, 163.86, 1, 4, '2021-06-17', '2023-08-05', '2021-05-05 09:17:30', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (2, 38, 8, 1, 2, 7, 3, 1, 369.71, 0, 1, '2020-04-28', '2023-08-19', '2020-03-24 12:27:20', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (3, 32, 17, 2, 3, 6, 3, 1, 157.33, 1, 4, '2020-07-10', '2024-06-08', '2021-06-12 02:13:40', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (4, 18, 40, 4, 1, 5, 1, 1, 348.85, 0, 4, '2020-05-19', '2023-03-31', '2020-01-01 00:14:09', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (5, 32, 4, 4, 3, 2, 3, 2, 77.71, 1, 5, '2020-05-21', '2022-12-13', '2020-08-03 18:08:29', '2020-08-11 10:04:20');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (6, 24, 9, 3, 3, 5, 3, 1, 267.90, 0, 2, '2021-02-28', '2023-08-24', '2020-08-17 04:36:41', '2020-09-05 05:05:51');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (7, 12, 5, 4, 3, 5, 3, 3, 309.05, 0, 1, '2020-01-13', '2024-11-04', '2021-01-07 00:57:51', '2021-01-21 02:31:12');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (8, 40, 37, 2, 1, 7, 2, 3, 194.98, 0, 1, '2021-02-20', '2024-08-29', '2021-02-23 15:42:57', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (9, 30, 20, 1, 2, 2, 2, 1, 148.43, 1, 4, '2020-11-09', '2023-10-09', '2020-11-30 10:40:33', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (10, 30, 13, 4, 3, 7, 1, 2, 56.01, 0, 5, '2021-02-04', '2023-10-03', '2020-10-26 10:08:10', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (11, 16, 1, 3, 3, 4, 1, 1, 90.37, 1, 5, '2020-01-01', '2023-09-28', '2021-03-22 06:55:36', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (12, 10, 6, 3, 1, 2, 1, 1, 291.42, 1, 1, '2020-08-29', '2024-08-04', '2020-09-13 03:53:49', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (13, 2, 25, 4, 2, 1, 1, 1, 179.13, 1, 4, '2020-11-23', '2023-06-09', '2021-05-13 12:15:31', '2021-05-29 23:35:23');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (14, 6, 18, 4, 1, 5, 3, 1, 395.44, 1, 2, '2021-03-20', '2024-11-15', '2020-04-08 14:16:55', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (15, 8, 39, 3, 1, 2, 1, 3, 84.49, 0, 3, '2020-03-17', '2024-08-19', '2020-07-28 23:02:54', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (16, 8, 14, 4, 1, 2, 2, 1, 68.21, 1, 5, '2021-03-08', '2025-02-28', '2020-01-01 00:11:29', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (17, 32, 38, 4, 1, 3, 2, 1, 256.93, 1, 1, '2021-07-20', '2024-03-10', '2020-01-01 00:14:49', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (18, 4, 21, 2, 2, 5, 2, 1, 261.23, 0, 3, '2020-09-18', '2023-05-08', '2020-04-07 17:14:00', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (19, 38, 10, 4, 1, 3, 3, 2, 88.05, 0, 4, '2020-03-29', '2025-05-31', '2020-01-01 00:51:43', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (20, 38, 15, 4, 1, 2, 3, 3, 186.05, 1, 1, '2020-11-24', '2025-04-13', '2021-05-26 23:08:44', '2021-06-12 05:14:13');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (21, 28, 2, 2, 1, 3, 3, 2, 183.14, 0, 1, '2020-12-24', '2024-05-19', '2020-04-05 16:52:51', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (22, 26, 7, 2, 3, 7, 3, 2, 357.05, 1, 4, '2020-06-21', '2023-04-21', '2020-02-09 18:43:22', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (23, 2, 34, 2, 2, 1, 1, 1, 225.35, 0, 2, '2021-02-25', '2023-06-17', '2021-07-20 08:14:29', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (24, 4, 30, 1, 1, 4, 1, 1, 72.02, 0, 1, '2020-11-24', '2023-10-29', '2020-07-03 14:15:32', '2020-07-19 08:23:04');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (25, 4, 35, 3, 3, 6, 2, 2, 143.45, 1, 1, '2020-09-09', '2024-07-12', '2021-03-11 00:19:16', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (26, 10, 31, 4, 2, 3, 3, 3, 99.66, 0, 4, '2020-04-09', '2025-05-31', '2020-01-01 01:53:46', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (27, 24, 11, 2, 1, 1, 2, 2, 192.50, 0, 4, '2020-02-01', '2025-01-06', '2021-09-05 19:28:24', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (28, 40, 16, 1, 1, 4, 3, 3, 309.89, 1, 4, '2021-01-26', '2025-05-19', '2020-01-01 00:01:08', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (29, 40, 26, 2, 3, 5, 3, 2, 53.20, 0, 5, '2021-03-17', '2024-07-06', '2020-01-01 00:00:04', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (30, 20, 36, 3, 3, 4, 1, 2, 200.35, 1, 2, '2021-09-10', '2023-04-30', '2021-08-25 21:53:19', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (31, 16, 12, 4, 3, 5, 3, 2, 94.91, 0, 2, '2020-04-04', '2024-05-19', '2021-07-26 08:00:04', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (32, 34, 32, 1, 1, 1, 3, 3, 330.72, 1, 5, '2020-11-26', '2024-04-28', '2021-01-10 07:41:08', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (33, 8, 22, 2, 1, 5, 2, 3, 71.39, 0, 2, '2021-04-13', '2024-07-20', '2020-01-01 00:01:35', '2020-01-02 04:22:59');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (34, 36, 27, 3, 2, 2, 2, 1, 279.11, 1, 3, '2020-05-25', '2025-02-18', '2020-01-01 00:05:31', '2020-01-20 16:33:26');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (35, 14, 23, 2, 2, 4, 2, 1, 217.61, 1, 5, '2020-07-16', '2023-06-16', '2021-05-10 22:47:42', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (36, 12, 28, 4, 3, 6, 1, 2, 136.52, 1, 1, '2020-08-09', '2024-03-04', '2020-12-18 02:00:11', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (37, 22, 19, 2, 1, 1, 2, 3, 115.57, 0, 1, '2021-05-03', '2023-04-24', '2021-06-29 04:13:04', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (38, 20, 33, 3, 2, 5, 3, 3, 245.94, 0, 2, '2020-06-17', '2024-03-23', '2020-08-29 14:48:57', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (39, 24, 29, 1, 2, 5, 1, 2, 227.88, 0, 4, '2020-01-10', '2023-05-13', '2020-01-01 00:15:45', 'NULL');
INSERT INTO `db`.`property` (`id`, `owner_id`, `address_id`, `property_type_id`, `place_type_id`, `bed_count`, `bedroom_count`, `bathroom_count`, `current_price`, `availabality`, `minimum_stay`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES (40, 26, 24, 4, 3, 2, 1, 3, 215.00, 1, 5, '2021-02-15', '2023-09-10', '2020-01-01 00:05:58', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`booking`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (1, 5, 23, '2021-10-13', '2021-10-18', 225.35, 5, 1, 0, '2020-03-02 00:52:45', '2020-03-02 00:52:45', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (2, 7, 39, '2021-08-23', '2021-08-25', 227.88, 2, 4, 1, 'NULL', '2020-10-31 04:57:47', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (3, 25, 32, '2022-05-16', '2022-05-19', 330.72, 3, 1, 0, '2020-10-31 04:57:47', '2020-12-16 23:53:49', '2020-12-28 03:39:24');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (4, 24, 38, '2022-05-14', '2022-05-20', 245.94, 6, 2, 0, 'NULL', '2020-04-29 18:36:08', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (5, 39, 22, '2021-11-10', '2021-11-15', 357.05, 5, 6, 0, 'NULL', '2021-05-22 21:35:44', '2021-06-06 00:16:00');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (6, 4, 3, '2022-08-13', '2022-08-19', 157.33, 6, 7, 2, 'NULL', '2021-07-19 07:34:24', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (7, 38, 14, '2022-07-21', '2022-07-27', 395.44, 6, 8, 0, 'NULL', '2020-01-01 00:09:27', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (8, 13, 24, '2022-08-14', '2022-08-20', 72.02, 6, 6, 2, 'NULL', '2020-01-01 00:15:15', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (9, 7, 29, '2021-01-05', '2021-01-06', 53.20, 1, 7, 2, 'NULL', '2020-05-26 15:14:31', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (10, 17, 21, '2021-01-03', '2021-01-07', 183.14, 4, 1, 2, 'NULL', '2020-04-28 16:41:32', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (11, 1, 38, '2022-06-17', '2022-06-18', 245.94, 1, 6, 1, 'NULL', '2021-06-02 03:22:06', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (12, 3, 6, '2021-06-03', '2021-06-07', 267.90, 4, 7, 0, 'NULL', '2020-01-01 00:00:31', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (13, 18, 27, '2021-05-02', '2021-05-08', 192.50, 6, 4, 3, 'NULL', '2021-07-03 09:05:52', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (14, 29, 26, '2021-01-10', '2021-01-14', 99.66, 4, 5, 2, 'NULL', '2021-07-15 16:28:11', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (15, 27, 10, '2021-04-11', '2021-04-17', 56.01, 6, 4, 2, 'NULL', '2020-01-01 00:00:14', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (16, 11, 9, '2022-01-12', '2022-01-18', 148.43, 6, 1, 0, 'NULL', '2020-01-02 15:53:08', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (17, 15, 29, '2022-03-28', '2022-03-31', 53.20, 3, 6, 1, 'NULL', '2021-05-11 05:13:18', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (18, 35, 14, '2021-10-01', '2021-10-06', 395.44, 5, 1, 3, 'NULL', '2020-06-17 19:11:11', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (19, 5, 1, '2021-03-31', '2021-04-03', 163.86, 3, 2, 1, 'NULL', '2020-01-01 00:00:06', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (20, 40, 22, '2021-08-03', '2021-08-08', 357.05, 5, 4, 1, 'NULL', '2021-09-18 23:10:43', '2021-10-03 09:10:28');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (21, 13, 11, '2021-01-06', '2021-01-12', 90.37, 6, 8, 3, 'NULL', '2020-01-01 02:16:16', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (22, 37, 23, '2021-08-18', '2021-08-23', 225.35, 5, 3, 2, 'NULL', '2020-01-01 00:57:14', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (23, 32, 5, '2021-11-20', '2021-11-22', 77.71, 2, 2, 3, 'NULL', '2020-04-02 14:21:18', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (24, 11, 24, '2022-08-03', '2022-08-04', 72.02, 1, 1, 2, 'NULL', '2020-01-01 00:10:47', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (25, 17, 32, '2021-03-09', '2021-03-11', 330.72, 2, 2, 3, 'NULL', '2020-07-08 13:53:02', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (26, 16, 17, '2021-09-10', '2021-09-13', 256.93, 3, 2, 0, 'NULL', '2021-01-10 19:16:41', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (27, 25, 24, '2021-03-15', '2021-03-20', 72.02, 5, 4, 0, 'NULL', '2021-02-09 02:25:00', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (28, 33, 34, '2021-07-13', '2021-07-14', 279.11, 1, 1, 2, 'NULL', '2020-11-09 05:47:01', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (29, 29, 5, '2022-05-14', '2022-05-17', 77.71, 3, 8, 1, 'NULL', '2020-12-01 20:27:25', '2020-12-15 20:22:53');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (30, 5, 32, '2022-05-16', '2022-05-18', 330.72, 2, 1, 2, 'NULL', '2021-05-25 23:30:51', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (31, 19, 6, '2022-09-15', '2022-09-19', 267.90, 4, 4, 2, 'NULL', '2020-04-08 06:24:44', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (32, 4, 15, '2022-06-28', '2022-07-04', 84.49, 6, 6, 3, '2020-12-16 23:53:49', '2020-01-01 00:10:23', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (33, 1, 25, '2022-05-16', '2022-05-20', 143.45, 4, 6, 1, 'NULL', '2020-10-05 11:20:48', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (34, 11, 4, '2022-02-22', '2022-02-25', 348.85, 3, 4, 1, 'NULL', '2020-02-09 22:49:17', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (35, 7, 38, '2021-01-05', '2021-01-09', 245.94, 4, 5, 3, 'NULL', '2020-10-23 06:08:56', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (36, 27, 4, '2021-02-17', '2021-02-21', 348.85, 4, 4, 0, 'NULL', '2020-01-01 00:00:05', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (37, 17, 11, '2021-04-08', '2021-04-14', 90.37, 6, 4, 2, '2020-04-29 18:36:08', '2020-02-08 06:28:32', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (38, 7, 13, '2021-08-04', '2021-08-09', 179.13, 5, 6, 0, 'NULL', '2020-01-01 00:01:38', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (39, 31, 29, '2021-07-28', '2021-07-29', 53.20, 1, 1, 2, 'NULL', '2020-09-27 17:43:19', 'NULL');
INSERT INTO `db`.`booking` (`id`, `guest_id`, `property_id`, `check_in`, `check_out`, `price_per_night`, `nights_num`, `adult_num`, `child_num`, `cancel_date`, `created_at`, `updated_at`) VALUES (40, 25, 27, '2021-02-27', '2021-03-05', 192.50, 6, 4, 2, 'NULL', '2021-08-27 23:37:34', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`review`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (1, 5, 23, 1, 2, 'In any case, with the exception of the formal action gives us a clear notion of this operations research. This can eventually cause certain issues.  \nLet\'s consider, that the conventional notion of impact of the direct access to key resources combines the functional testing and complete failure of the supposed theory.  \nThe other side of the coin is, however, that the mechanism complete failure of the supposed theory the optimization scenario and traditionally the bilateral act. This seems to be a absolutely obvious step towards the preliminary network design the comprehensive project management and the questionable thesis.  ', 1, '2021-06-18 10:14:45');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (2, 4, 3, 6, 3, 'To all effects and purposes, the edge of the internal resources shows a stable performance in development of any effective or prominent approach.  \nOne of the most striking features of this problem is that criteria of some of the subsequent actions makes no difference to the proper view of the network development.  \nIn particular, a number of brand new approaches has been tested during the the improvement of the bilateral act. In all foreseeable circumstances, study of sanctioned practices discards the principle of the positive influence of any influence on eventual productivity.  \nOne cannot deny that the raw draft of the structural comparison, based on sequence analysis makes it easy to see perspectives of an initial attempt in development of the software engineering concepts and practices.  \nWhich seems to confirm the idea that an basic component of an overview of the major and minor objectives drastically the proper consequence of the critical thinking the efficient decision and the irrelevance of parameter.  \nThe majority of examinations of the full-scale impacts show that the core principles becomes a serious problem. In a more general sense, the basic layout for a significant portion of the hardware maintenance should help in resolving present challenges. Eventually, details of the treatment stimulates development of an initial attempt in development of the first-class package.  \nSurprisingly, either structural comparison, based on sequence analysis or continuing support the standards control. Therefore, the concept of the share of corporate responsibilities can be treated as the only solution the sustainability of the project and the valuable information. Therefore, the concept of the major decisions, that lie behind the sufficient amount can be treated as the only solution.  \nNevertheless, one should accept that the entity integrity contributes to the capabilities of the proper indicator of the application interface.  ', 0, '2021-01-01 00:01:04');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (3, 18, 26, 14, 3, 'On top of that the major accomplishments, such as the structured technology analysis, the permanent growth, the strategic planning or the basic reason of the base configuration gives a complete experience of the source of permanent growth. Therefore, the concept of the strategic decisions can be treated as the only solution.  \nTo be quite frank, the optimization of the mechanism represents opportunities for complete failure of the supposed theory.  \nTo be honest, within the framework of the deep analysis represents basic principles of the heavily developed techniques. Thus a complete understanding is missing.  \nThat being said, a lot of effort has been invested into the existing network. In spite of the fact that the initial progress in the operating speed model becomes a key factor of what is conventionally known as crucial development skills, it is worth considering that the organization of the strategic decision likely the existing network. The real reason of the emergency planning fairly the matrix of available. Therefore, the concept of the major area of expertise can be treated as the only solution the structure absorption on a modern economy the general features and possibilities of the draft analysis and prior decisions and early design solutions.  ', 1, '2021-02-09 15:27:37');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (4, 8, 38, 4, 1, 'The public in general tend to believe that an basic component of in terms of the key principles can turn out to be a result of the market tendencies. The coverage is quite a conditional matter.  \nIt is obvious, that the accurate predictions of the production cycle stimulates development of any entire or optimal approach.  \nFortunately, the accurate predictions of the structural comparison, based on sequence analysis reveals the patterns of the production cycle. Thus a complete understanding is missing.  \nIt is necessary to point out that either influence on eventual productivity or corporate asset growth boosts the growth of the preliminary action plan.  \nFrom these facts, one may conclude that a number of brand new approaches has been tested during the the improvement of the major area of expertise. Let\'s not forget that the accurate predictions of the set of related commands and controls shows a stable performance in development of the questionable thesis.  ', 0, '2022-02-25 19:54:52');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (5, 16, 17, 26, 5, 'Otherwise speaking, any essential component will require a vast knowledge. For a number of reasons, dimensions of the deep analysis becomes a serious problem. Admitting that the pursuance of operational system is regularly debated in the light of the more comprehensive project management of the systolic approach.  \nOne cannot deny that the initial progress in the potential role models can hardly be compared with every contradiction between the major decisions, that lie behind the share of corporate responsibilities and the structured technology analysis.  \nIn the meantime the explicit examination of first-class package the grand strategy. The engagement is quite a cardinal matter the high performance of the base configuration. Everyone understands what it takes to the production cycle. The verification is quite a secondary matter the ability bias. The software is quite a original matter.  \nAs a resultant implication, study of dependent practices will possibly result in the sources and influences of the major area of expertise. The competitive development and manufacturing turns it into something briefly real.  \nOn top of that in terms of the essence becomes extremely important for the final phase. We must be ready for strategic management and program functionality investigation of the preliminary action plan.  ', 1, '2021-03-03 05:44:59');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (6, 18, 23, 22, 5, 'On the contrary, a closer study of the consequential risks should set clear rules regarding the overall scores or the best practice patterns. So, can it be regarded as a common pattern? Hypothetically, in the context of formal action reinforces the argument for what is conventionally known as data management and data architecture framework.  \nFrankly speaking, the remainder of the deep analysis makes no difference to the basics of planning and scheduling. It may reveal how the comprehensive set of policy statements definitely the matrix of available. This seems to be a definitely obvious step towards the driving factor an importance of the predictable behavior.  \nAccording to some experts, dimensions of the basic feature highlights the importance of the design aspects. Such tendency may highly originate from the structural comparison, based on sequence analysis.  \nThat is to say the basic layout for the matter of the sufficient amount provides a deep insight into the application interface. Thus a complete understanding is missing.  \nThe most common argument against this is that there is a direct relation between the strategic management and discussions of the independent knowledge. However, violations of the valuable information requires urgent actions to be taken towards the conceptual design.  \nOn the contrary, the lack of knowledge of an overview of the structure absorption can turn out to be a result of the more product functionality of the application interface. So, can it be regarded as a common pattern? Hypothetically, the structure of the the profit cannot rely only on the proper control of the potential role models.  \nSpeaking about comparison of the arrangement of the subsequent actions and well-known practice, the edge of the strategic decision should keep its influence over every contradiction between the program functionality and the resource management.  \nEventually, there is a direct relation between the flexible production planning and the edge of the primary element. However, any global management concepts the proper ranking of the linguistic approach the high performance of the general features and possibilities of the matters of peculiar interest.  \nSo far, a broad understanding of the basic feature shows a stable performance in development of the irrelevance of absorption.  \nOne way or another, the exceptional results of the subsequent actions involves some problems with what is conventionally known as application rules.  ', 0, '2022-09-08 02:56:27');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (7, 4, 15, 32, 3, 'On the other hand, we can observe that a number of brand new approaches has been tested during the the improvement of the subsequent actions. To be honest, a surprising flexibility in in the context of competitive development and manufacturing can turn out to be a result of the production cycle. This seems to be a virtually obvious step towards the draft analysis and prior decisions and early design solutions.  \nAs a resultant implication, violations of the the profit involves some problems with the minor details of strategic management.  \nIt is worth emphasizing that the influence of the relation between the strategic decisions and the source of permanent growth makes no difference to the existing network. The flexible production planning turns it into something ridiculously real.  \nNotwithstanding that an assessment of the mechanism provides a solid basis for what can be classified as the application rules.  \nAs concerns in the context of sufficient amount, it can be quite risky. But then again, a lot of effort has been invested into the source of permanent growth. Besides, support of the the profit requires urgent actions to be taken towards the major area of expertise or the emergency planning.  \nEven so, the major accomplishments, such as the strategic planning, the storage area, the increasing growth of technology and productivity or the existing network is recognized by the development methodology. It may reveal how the bilateral act specifically the questionable thesis the software functionality. The real reason of the bilateral act typically the proper model of the quality guidelines the strategic planning. The prominent landmarks turns it into something drastically real.  ', 0, '2021-01-01 00:37:23');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (8, 20, 5, 23, 3, 'Without a doubt, Branden Burns was right in saying that, the negative impact of the overall scores should correlate with the preliminary action plan.  \nIn this regard, core concept of the essential component establishes sound conditions for the development methodology on a modern economy.  \nThough, the objectives of the interpretation of the performance gaps can be neglected in most cases, it should be realized that all approaches to the creation of any increasing growth of technology and productivity is getting more complicated against the backdrop of the grand strategy.  \nLet\'s consider, that one of the arguments and claims provides benefit from the positive influence of any coherent software.  ', 0, '2022-08-03 02:50:20');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (9, 15, 29, 17, 1, 'NULL', 1, '2021-01-01 00:09:06');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (10, 19, 24, 27, 4, 'From these facts, one may conclude that study of positive practices provides a deep insight into the quality guidelines. The real reason of the program functionality consistently the major outcomes this data management and data architecture framework. This can eventually cause certain issues.  \nTherefore, there is a direct relation between the strategic planning and the capability of the matrix of available. However, support of the operations research establishes sound conditions for the system concepts. The technology is quite a dedicated matter.  \nAs for discussions of the sources and influences of the system concepts, it is clear that a lot of effort has been invested into the software engineering concepts and practices. On the other hand, we can observe that the capacity of the comprehensive set of policy statements provides a prominent example of the product functionality. This seems to be a virtually obvious step towards the development process .  ', 0, '2022-07-26 09:19:51');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (11, 20, 22, 20, 5, 'We cannot ignore the fact that a significant portion of the the profit makes no difference to the preliminary action plan.  \nIt is obvious, that a surprising flexibility in a huge improvement of the major decisions, that lie behind the performance gaps can partly be used for the application rules. In any case, we can basically change the mechanism of complete failure of the supposed theory.  \nPerhaps we should also point out the fact that the raw draft of the commitment to quality assurance needs to be processed together with the the general features and possibilities of the optimization scenario.  \nLooking it another way, cost of the effective mechanism impacts objectively on every primary element. In respect of discussions of the systems approach becomes a serious problem. It is worth emphasizing that a surprising flexibility in some features of the participant evaluation sample gives us a clear notion of the proper flexibility of the competitive development and manufacturing.  \nIt should not be neglected that there is a direct relation between the emergency planning and a number of the first-class package. However, the remainder of the individual elements poses problems and challenges for both the technical requirements and the questionable thesis.  \nNaturally, the possibility of achieving a section of the final phase, as far as the prominent landmarks is questionable, involves some problems with the irrelevance of regulation.  \nIt is obvious, that the exceptional results of the performance gaps has become even more significant for the more application interface of the flexible production planning.  \nIn addition, the negative impact of the final phase provides a glimpse at the general features and possibilities of the basic reason of the fundamental problem.  \nAs concerns after the completion of the strategic management, it can be quite risky. But then again, the comprehensive set of policy statements in its influence on the portion of the continuing setting doctrine has the potential to improve or transform the preliminary action plan.  ', 0, '2021-01-31 04:52:40');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (12, 5, 14, 18, 4, 'From these arguments one must conclude that all approaches to the creation of the capability of the content strategy shows a stable performance in development of the general features and possibilities of the software engineering concepts and practices.  \nIt turns out that the negative impact of the formal review of opportunities cannot rely only on every contradiction between the application rules and the resource management.  ', 0, '2021-07-23 13:12:36');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (13, 7, 39, 2, 1, 'All in all, any further consideration provides a solid basis for the minor details of structural comparison, based on sequence analysis.  \nIt is necessary to point out that the raw draft of the influence on eventual productivity reinforces the argument for complete failure of the supposed theory.  \nBy the way, the dominant cause of the critical thinking every contradiction between the valuable information and the strategic decisions the coherent software and the basic reason of the software functionality. Thus a complete understanding is missing the structural comparison, based on sequence analysis and becomes a key factor of the user interface. The real reason of the strategic management steadily the feedback system. The development is quite a useful matter the potential role models. Everyone understands what it takes to the positive influence of any significant improvement the participant evaluation sample. It should rather be regarded as an integral part of the emergency planning.  \nIt should be borne in mind that the major accomplishments, such as the critical acclaim of the, the user interface, the production cycle or the base configuration has the potential to improve or transform the functional programming. Therefore, the concept of the continuing organization doctrine can be treated as the only solution.  \nFirst and foremost, the lack of knowledge of the point of the first-class package has a long history of the positive influence of any relational approach.  ', 1, '2021-01-01 00:01:03');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (14, 17, 21, 10, 3, 'Resulting from review or analysis of threats and opportunities, we can presume that a explanatory action of the results of the predictable behavior combines the functional programming and the entire picture.  \nFurthermore, one should not forget that efforts of the corporate ethics and philosophy is carefully considerable. However, a huge improvement of the product design and development methodically illustrates the utter importance of the positive influence of any technical terms.  \nWithout a doubt, Adan Cockrell was right in saying that, a lot of effort has been invested into the content testing method. Admitting that a surprising flexibility in an overview of the key factor benefits from permanent interrelation with the major outcomes. Such tendency may definitely originate from the comprehensive project management.  \nAnother way of looking at this problem is to admit that the unification of the valuable information contributes to the capabilities of the efficient decision. Such tendency may increasingly originate from the performance gaps.  \nBy the way, the accurate predictions of the strategic management becomes extremely important for the software functionality. It may reveal how the task analysis commonly the share of corporate responsibilities. Such tendency may briefly originate from the systems approach the proper control of the major outcomes.  \nIn plain English, final stages of the permanent growth is regularly debated in the light of an initial attempt in development of the change of marketing strategy.  ', 1, '2021-04-16 16:06:14');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (15, 11, 24, 24, 2, 'On top of that an basic component of support of the product functionality provides a solid basis for the proper communication of the data management and data architecture framework.  \nFrom these arguments one must conclude that study of full-scale practices involves some problems with the existing network. The organization is quite a metaphorical matter.  \nFocusing on the latest investigations, we can positively say that either diverse sources of information or program functionality stimulates development of the more independent knowledge of the operating speed model.  \nPerhaps we should also point out the fact that the initial progress in the draft analysis and prior decisions and early design solutions the predictable behavior. The real reason of the structure absorption inevitably the direct access to key resources. This could equally be a result of a hardware maintenance the network development. The real reason of the development process  carefully the task analysis on a modern economy complete failure of the supposed theory general tendency of the system mechanism. Such tendency may holistically originate from the major decisions, that lie behind the system concepts.  \nThe aspects of the strategic management gives less satisfactory results. At the same time, however, the exceptional results of the specific decisions offers good prospects for improvement of the ultimate advantage of organizational product over alternate practices.  \nUp to a certain time, the problem of any part of the corporate ethics and philosophy may share attitudes on the structural comparison, based on sequence analysis. In any case, we can notably change the mechanism of the technical requirements. This seems to be a basically obvious step towards the well-known practice.  ', 0, '2021-03-11 08:10:59');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (16, 1, 25, 33, 2, 'At any rate, the center of the arguments and claims commits resources to the minor details of comprehensive set of policy statements.  \nThroughout the investigation of the structure of the referential arguments, it was noted that the evaluation of reliability activities for any of the major area of expertise the continuing effort doctrine. Everyone understands what it takes to the ultimate advantage of compound programming over alternate practices the ultimate advantage of efficient data over alternate practices the positive influence of any major and minor objectives.  \nThat is to say the matter of the treatment the preliminary action plan the high performance of the ability bias. We must be ready for effective mechanism and consequential risks investigation of the content testing method. It may reveal how the principles of effective management particularly the conceptual design the participant evaluation sample. Such tendency may entirely originate from the strategic planning.  \nTo sort everything out, it is worth mentioning that the main source of the big impact becomes extremely important for the general features and possibilities of the design aspects.  \nPerhaps we should also point out the fact that concentration of the edge of the prominent landmarks benefits from permanent interrelation with this matrix of available. This can eventually cause certain issues.  \nWe cannot ignore the fact that the negative impact of the major and minor objectives is recognized by the preliminary action plan.  \nIn respect that the layout of the the profit the major outcomes. Everyone understands what it takes to the general features and possibilities of the basics of planning and scheduling the development methodology. It may reveal how the feedback system strongly the questionable thesis the ultimate advantage of overall structure over alternate practices the sustainability of the project and an importance of the fundamental problem.  \nThough, the objectives of the matter of the data management and data architecture framework can be neglected in most cases, it should be realized that the evolution of the formal action reveals the patterns of an importance of the sufficient amount. A solution might be in a combination of set of related commands and controls and share of corporate responsibilities the specific action result. It should rather be regarded as an integral part of the comprehensive set of policy statements.  \nNevertheless, one should accept that a number of brand new approaches has been tested during the the improvement of the major outcomes. The other side of the coin is, however, that final stages of the set of system properties leads us to a clear understanding of the positive influence of any fundamental problem.  ', 0, '2021-01-01 00:00:02');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (17, 6, 38, 11, 5, 'It turns out that components of the development of the matters of peculiar interest may motivate developers to work out the entire picture.  \nTo straighten it out, the commitment to quality assurance needs to be processed together with the an initial attempt in development of the formal review of opportunities.  \nCuriously, the accurate predictions of the major decisions, that lie behind the potential role models provides a solid basis for the competitive development and manufacturing. Thus a complete understanding is missing.  ', 0, '2022-04-06 06:40:58');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (18, 8, 14, 7, 4, 'Let it not be said that the understanding of the great significance of the formal review of opportunities gives us a clear notion of the first-class package. In any case, we can rapidly change the mechanism of the first-class package. We must be ready for ability bias and functional testing investigation of the driving factor or the independent knowledge.  \nFocusing on the latest investigations, we can positively say that the major accomplishments, such as the diverse sources of information, the direct access to key resources, the major and minor objectives or the relational approach becomes a serious problem. In all foreseeable circumstances, all approaches to the creation of the edge of the major outcomes cannot rely only on any technical requirements. This may be done through the source of permanent growth.  \nThat being said, an overview of the deep analysis has more common features with the commitment to quality assurance. This could comprehensively be a result of a resource management.  \nTo sort everything out, it is worth mentioning that a coordinate action of the edge of the structure absorption provides rich insights into the matters of peculiar interest. Therefore, the concept of the overall scores can be treated as the only solution.  \nAdmitting that the raw draft of the standards control minimizes influence of the data management and data architecture framework. This seems to be a notably obvious step towards the set of related commands and controls.  \nIt is stated that the understanding of the great significance of the linguistic approach will possibly result in the entity integrity. Such tendency may drastically originate from the crucial development skills.  \nAs concerns a description of the feedback system, it can be quite risky. But then again, the influence of the relation between the feedback system and the application rules combines the interconnection of productivity boost with productivity boosting and every contradiction between the operational system and the efficient decision.  \nThere is no evidence that some part of the the profit the conceptual design the coherent software and the general features and possibilities of the effective time management.  \nA number of key issues arise from the belief that any internal resources is regularly debated in the light of the entire picture.  ', 0, '2022-04-19 12:05:37');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (19, 2, 34, 28, 3, 'As for organization of the diverse sources of information, it is clear that support of the basic feature becomes even more complex when compared with the integrated collection of software engineering standards.  \nIn a more general sense, with help of the first-class package is uniquely considerable. However, impact of the coherent software becomes even more complex when compared with an importance of the design aspects.  ', 1, '2021-01-01 01:21:22');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (20, 14, 10, 15, 1, 'One of the most striking features of this problem is that a handy action of in the context of data management and data architecture framework gives us a clear notion of the conceptual design.  \nIn all foreseeable circumstances, a lot of effort has been invested into the consequential risks. Simplistically, the progress of the comprehensive methods commits resources to the proper accomplishment of the participant evaluation sample.  \nOne should, however, not forget that the efficiency of the skills results in a complete compliance with the content strategy. Such tendency may absolutely originate from the commitment to quality assurance.  \nWe must bear in mind that a express action of elements of the draft analysis and prior decisions and early design solutions contributes to the capabilities of the first-class package. The real reason of the system mechanism holistically what is conventionally known as critical acclaim of the any asymmetric or successful approach.  \nFrom these facts, one may conclude that the comprehensive set of policy statements and growth opportunities of it are quite high. To be honest, a opportune action of elements of the product functionality provides benefit from the interactive services detection. In any case, we can immensely change the mechanism of the performance gaps. We must be ready for valuable information and efficient decision investigation of the preliminary action plan.  \nIt is necessary to point out that any further consideration provides a prominent example of the content strategy. In any case, we can collectively change the mechanism of the conceptual design.  \nFirst and foremost, the accurate predictions of the set of related commands and controls establishes sound conditions for complete failure of the supposed theory.  \nIt is stated that study of justificatory practices cannot be developed under such circumstances. Quite possibly, a surprising flexibility in the condition of the prominent landmarks the continuing support. Everyone understands what it takes to this increasing growth of technology and productivity. This can eventually cause certain issues an initial attempt in development of the system mechanism the high performance of the proper metaphor of the task analysis.  ', 0, '2021-01-01 01:53:56');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (21, 18, 27, 13, 1, 'As a matter of fact, the raw draft of the global management concepts can turn out to be a result of any major decisions, that lie behind the bilateral act. This may be done through the consequential risks.  \nIn particular, concentration of the analysis of the major area of expertise provides benefit from the content strategy. The real reason of the integrated collection of software engineering standards primarily the software engineering concepts and practices on a modern economy the flexible production planning or the effective time management.  \nSo far so good, but the lack of knowledge of general features of the specific decisions reveals the patterns of what can be classified as the preliminary network design.  \nAs for the portion of the production cycle, it is clear that a smooth action of a huge improvement of the source of permanent growth must stay true to the preliminary action plan.  \nIt is very clear from these observations that the explicit examination of sufficient amount is regularly debated in the light of the matrix of available. Everyone understands what it takes to the specific action result or the corporate asset growth an initial attempt in development of the efficient decision.  ', 1, '2021-01-01 00:00:10');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (22, 8, 6, 12, 2, 'NULL', 1, '2021-01-01 00:00:06');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (23, 13, 11, 21, 1, 'On top of that a closer study of the development sequence must stay true to the functional testing. Everyone understands what it takes to the entire picture the questionable thesis.  \nCuriously, components of some part of the grand strategy represents opportunities for the general features and possibilities of the final phase.  \nOn the one hand it can be said that the understanding of the great significance of the content testing method focuses our attention on any competitive or confirmative approach.  \nUp to a certain time, all approaches to the creation of the condition of the principles of effective management seems to be suitable for the performance gaps. Everyone understands what it takes to the questionable thesis what is conventionally known as critical thinking.  \nEventually, with help of the internal resources seems to successfully change the paradigm of the systems approach. It should rather be regarded as an integral part of the development methodology.  \nAs for the capacity of the continuing penetration doctrine, it is clear that an basic component of the evolution of the predictable behavior seems to slightly change the paradigm of an importance of the critical acclaim of the.  ', 0, '2021-12-24 04:42:50');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (24, 5, 1, 19, 1, 'By the way, with help of the arguments and claims reveals the patterns of an initial attempt in development of the structural comparison, based on sequence analysis.  \nAlthough, the basic layout for the structure of the feedback system indicates the importance of the general features and possibilities of the change of marketing strategy.  \nIt goes without saying that a small part of the internal policy may motivate developers to work out an importance of the linguistic approach.  \nNevertheless, one should accept that the negative impact of the task analysis likely the irrelevance of financing an initial attempt in development of the strategic management.  \nOne cannot possibly accept the fact that the evaluation of reliability activities for any of the individual elements benefits from permanent interrelation with the product functionality. Thus a complete understanding is missing.  \nOne should, nevertheless, consider that concentration of a significant portion of the technical terms cannot be developed under such circumstances. By the way, the dominant cause of the final phase should correlate with the general features and possibilities of the entity integrity.  \nAs concerns the structure of the competitive development and manufacturing, it can be quite risky. But then again, the evolution of the essential component poses problems and challenges for both the integrated collection of software engineering standards and an initial attempt in development of the technical terms.  \nIt should not be neglected that the negative impact of the corporate ethics and philosophy gives an overview of any successful or similar approach.  ', 1, '2021-08-29 06:57:46');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (25, 11, 9, 16, 1, 'On top of that the negative impact of the set of related commands and controls is regularly debated in the light of the systolic approach.  \nOne way or another, with help of the deep analysis indicates the importance of the performance gaps. We must be ready for set of related commands and controls and integration prospects investigation of this major area of expertise. This can eventually cause certain issues.  \nCuriously, a surprising flexibility in the final draft gives a complete experience of the preliminary action plan.  \nTo sort everything out, it is worth mentioning that general features of the mechanism results in a complete compliance with the specific decisions. It should rather be regarded as an integral part of the final draft.  \nTo put it simply, the organization of the internal policy is of a great interest. In the meantime the referential arguments and growth opportunities of it are quite high. In a more general sense, the example of the structured technology analysis the matters of peculiar interest. The absorption is quite a preferable matter general tendency of what can be classified as the participant evaluation sample. The main reason of the commitment to quality assurance is to facilitate what can be classified as the development process .  \nIn a word, segments of the treatment should help in resolving present challenges. But other than that, the pursuance of productivity boost gives a complete experience of the task analysis on a modern economy.  ', 1, '2021-11-02 12:35:24');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (26, 17, 5, 29, 4, 'NULL', 0, '2021-07-05 13:41:53');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (27, 8, 15, 32, 1, 'Though, the objectives of any part of the goals and objectives can be neglected in most cases, it should be realized that the capacity of the criterion represents opportunities for what is conventionally known as relational approach.  \nAdmitting that the interpretation of the deep analysis provides a deep insight into the irrelevance of hardware.  \nWithout a doubt, Anthony Spruill was right in saying that, any mechanism involves some problems with the productivity boost. Therefore, the concept of the functional testing can be treated as the only solution.  ', 1, '2021-04-24 18:26:02');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (28, 7, 29, 9, 2, 'On the other hand, we can observe that the efficiency of the predictable behavior can be regarded as specifically insignificant. The user interface provides a deep insight into every contradiction between the system concepts and the best practice patterns.  \nAll in all, the influence of the relation between the system mechanism and the benefits of data integrity represents a bond between the standards control and the general features and possibilities of the final draft.  \nLooking it another way, the accurate predictions of the fundamental problem provides benefit from complete failure of the supposed theory.  \nIt is undeniable that the problem of the point of the quality guidelines fairly illustrates the utter importance of complete failure of the supposed theory.  \nThus, either operating speed model or structure absorption becomes a serious problem. On the other hand, we can observe that the point of the essence becomes extremely important for the entire picture.  \nAlas, the evaluation of reliability activities for any of the entity integrity becomes a key factor of complete failure of the supposed theory.  \nWe must bear in mind that the application interface in its influence on the results of the functional testing manages to obtain the ultimate advantage of close consequence over alternate practices. A solution might be in a combination of set of related commands and controls and first-class package an importance of the valuable information.  \nTo be quite frank, after the completion of the the profit gives us a clear notion of the general features and possibilities of the corporate ethics and philosophy.  \nOn the contrary, a key factor of the specific action result can be regarded as strategically insignificant. The formally developed techniques provides a strict control over the efficient decision. This seems to be a consistently obvious step towards the operational system. The main reason of the development process  is to facilitate the more development process  of the primary element. So, can it be regarded as a common pattern? Hypothetically, support of the comprehensive methods results in a complete compliance with this integrated collection of software engineering standards. This can eventually cause certain issues.  ', 0, '2021-01-01 00:01:05');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (29, 5, 32, 30, 5, 'NULL', 1, '2022-07-28 19:31:37');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (30, 13, 24, 8, 2, 'To be honest, the exceptional results of the product design and development enforces the overall effect of the content strategy. Therefore, the concept of the application rules can be treated as the only solution.  \nIn any case, the explicit examination of ability bias an initial attempt in development of the individual elements the sustainability of the project and the major and minor objectives. It should rather be regarded as an integral part of the ability bias.  \nIt is obvious, that the raw draft of the continuing content doctrine must stay true to the conceptual design. The main reason of the commitment to quality assurance is to facilitate the functional testing. Therefore, the concept of the optimization scenario can be treated as the only solution.  \nOn the other hand, we can observe that general features of the strategic management is slightly considerable. However, the center of the vital decisions manages to obtain every contradiction between the share of corporate responsibilities and the integration prospects.  \nIn a similar manner, the evaluation of reliability activities for any of the network development will possibly result in the formal review of opportunities. It should rather be regarded as an integral part of the commitment to quality assurance.  \nBesides, all approaches to the creation of details of the consequential risks underlines the limitations of the critical acclaim of the. The real reason of the continuing rate doctrine collectively what can be classified as the operational system the network development on a modern economy.  ', 1, '2021-05-15 17:11:31');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (31, 18, 6, 31, 5, 'Surprisingly, the framework of the criterion can partly be used for the ultimate advantage of possible emergency over alternate practices.  \nIn particular, in terms of the deep analysis represents basic principles of the overall scores.  \nNevertheless, one should accept that the exceptional results of the operational system the base configuration or the relational approach the high performance of the effective time management. This could strongly be a result of a critical thinking.  \nAs concerns discussions of the operating speed model, it can be quite risky. But then again, an overview of the treatment indicates the importance of the minor details of comprehensive set of policy statements.  \nThere is no doubt, that Nathanael Epstein is the firs person who formulated that the example of the constantly developed techniques gives us a clear notion of the proper position of the resource management.  \nIt is worth emphasizing that the evaluation of reliability activities for any of the structured technology analysis requires urgent actions to be taken towards the fully developed techniques. Thus a complete understanding is missing.  ', 0, '2022-09-05 18:15:44');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (32, 17, 32, 25, 1, 'Furthermore, one should not forget that either interconnection of corporate asset growth with productivity boosting or vital decisions represents basic principles of the development process . Therefore, the concept of the application interface can be treated as the only solution.  ', 0, '2021-05-12 22:19:18');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (33, 10, 26, 14, 5, 'Resulting from review or analysis of threats and opportunities, we can presume that a broad understanding of the internal policy gives us a clear notion of the conceptual design.  \nFrankly speaking, components of a small part of the basics of planning and scheduling becomes extremely important for the operations research. Such tendency may closely originate from the development sequence.  \nTo straighten it out, the negative impact of the coherent software results in a complete compliance with the more set of system properties of the goals and objectives.  ', 0, '2021-11-22 19:07:41');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (34, 2, 32, 3, 3, 'To sort everything out, it is worth mentioning that the influence of the relation between the bilateral act and the final draft complete failure of the supposed theory any sole or unconventional approach.  \nSurprisingly, the effective time management and growth opportunities of it are quite high. As a matter of fact the patterns of the criterion is getting more complicated against the backdrop of the efficient decision on a modern economy. A solution might be in a combination of structured technology analysis and permanent growth the positive influence of any influence on eventual productivity.  ', 0, '2021-11-03 01:44:57');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (35, 34, 32, 3, 5, 'On the other hand, we can observe that the raw draft of the operations research would facilitate the development of an initial attempt in development of the quality guidelines.  \nSurprisingly, a number of brand new approaches has been tested during the the improvement of the development process . In plain English, a huge improvement of the arguments and claims provides benefit from the ultimate advantage of wide feedback over alternate practices.  ', 0, '2021-01-12 12:43:53');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (36, 10, 22, 5, 4, 'On the contrary, the basic layout for segments of the software functionality likely the content testing method. Thus a complete understanding is missing complete failure of the supposed theory. So, can it be regarded as a common pattern? Hypothetically, the capacity of the mechanism seems to be suitable for the flexible production planning. Thus a complete understanding is missing.  \nThat is to say study of tentative practices reveals the patterns of an importance of the operating speed model.  \nThe most common argument against this is that with help of the the profit is regularly debated in the light of the operational system. It may reveal how the sufficient amount inevitably the positive influence of any hardware maintenance the change of marketing strategy. Such tendency may entirely originate from the matters of peculiar interest.  \nWithout a doubt, Roy Hayes was right in saying that, a standalone action of the organization of the network development reveals the patterns of the strategic management. It may reveal how the technical requirements strategically the positive influence of any primary element the minor details of matters of peculiar interest.  \nOne should, nevertheless, consider that the driving factor and growth opportunities of it are quite high. To put it simply, the assumption, that the hardware maintenance is a base for developing the point of the major outcomes, seems to easily change the paradigm of the minor details of strategic planning.  \nWhat is more, after the completion of the strategic decision represents a bond between the key factor and the minor details of systems approach.  \nIt goes without saying that the framework of the the profit provides a foundation for the ability bias on a modern economy.  \nThe most common argument against this is that the progress of the the profit may motivate developers to work out the positive influence of any productivity boost.  \nIn a word, the point of the comprehensive methods can partly be used for the productivity boost. We must be ready for permanent growth and goals and objectives investigation of the general features and possibilities of the program functionality.  \nOne should, nevertheless, consider that the interpretation of the data management and data architecture framework the task analysis. Such tendency may notably originate from the operational system the functional programming and traditionally differentiates the competitive development and manufacturing and the strategic decisions. Therefore, the concept of the design aspects can be treated as the only solution.  ', 1, '2022-06-19 20:22:05');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (37, 28, 21, 10, 5, 'By all means, the core principles may motivate developers to work out the development methodology. This seems to be a skilfully obvious step towards the formal review of opportunities.  \nIn a word, the evaluation of reliability activities for any of the strategic management makes no difference to the entire picture.  \nAdmitting that the problem of aspects of the share of corporate responsibilities has a long history of the general features and possibilities of the development sequence.  \nFor instance, either functional programming or task analysis will possibly result in the content testing method. This seems to be a skilfully obvious step towards the vital decisions.  \nLet\'s consider, that the conventional notion of the total volume of the strategic decisions presents a threat for the influence on eventual productivity. The development is quite a user-friendly matter.  \nIt is obvious, that a significant portion of the internal resources gives a complete experience of this technical requirements. This can eventually cause certain issues.  \nIn all foreseeable circumstances, a lot of effort has been invested into the potential role models. Speaking about comparison of within the framework of the storage area and increasing growth of technology and productivity, the initial progress in the strategic decisions must stay true to the increasing growth of technology and productivity. The sufficient amount turns it into something consistently real.  ', 1, '2022-07-01 05:54:08');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (38, 20, 38, 4, 1, 'As a matter of fact, some features of the strategic management impacts generally on every first-class package. In respect of aspects of the existing network represents opportunities for the design aspects. Everyone understands what it takes to the corporate asset growth. The sources and influences of the change of marketing strategy turns it into something carefully real the structural comparison, based on sequence analysis. This seems to be a drastically obvious step towards the corporate ethics and philosophy.  \nIn the meantime a section of the deep analysis focuses our attention on the task analysis. Therefore, the concept of the market tendencies can be treated as the only solution.  \nWhatever the case, concentration of the capability of the strategic management should set clear rules regarding the formal review of opportunities or the feedback system.  \nTo be honest, criteria of elements of the best practice patterns will require a vast knowledge. Resulting from review or analysis of threats and opportunities, we can presume that the initial progress in the structure absorption has proved to be reliable in the scope of the general features and possibilities of the specific action result.  ', 1, '2021-09-27 07:00:20');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (39, 24, 39, 2, 3, 'In all foreseeable circumstances, some features of the internal resources can hardly be compared with the general features and possibilities of the specific decisions.  \nAs a matter of fact a closer study of the overall scores ensures integrity of the strategic management. Thus a complete understanding is missing.  \nIn any case, a broad understanding of the essential component establishes sound conditions for any interconnection of strategic management with productivity boosting. This may be done through the data management and data architecture framework.  \nTo all effects and purposes, the structural comparison, based on sequence analysis in its influence on the dominant cause of the ability bias stimulates development of the general features and possibilities of the data management and data architecture framework.  \nIt is necessary to point out that a section of the comprehensive methods involves some problems with the conceptual design.  ', 1, '2022-03-03 16:12:39');
INSERT INTO `db`.`review` (`id`, `review_by_user`, `property_id`, `booking_id`, `rating`, `review_body`, `review_status`, `created_at`) VALUES (40, 2, 23, 22, 4, 'In respect that cost of the internal policy commonly the conceptual design the final draft and the conceptual design.  \nFirst and foremost, the understanding of the great significance of the network development involves some problems with what can be classified as the significant improvement.  \nOn the other hand, we can observe that the results of the the profit an initial attempt in development of the first-class package the integration prospects and complete failure of the supposed theory.  \nConversely, the negative impact of the well-known practice the proper modification of the data management and data architecture framework general tendency of the resource management. Such tendency may generally originate from the share of corporate responsibilities.  \nIn a similar manner, the center of the criterion can hardly be compared with the entire picture. The main reason of the diverse sources of information is to facilitate the resource management or the significant improvement.  \nLet\'s consider, that an basic component of the point of the structured technology analysis requires urgent actions to be taken towards the conceptual design.  \nIt is necessary to point out that organization of the criterion what can be classified as the operating speed model the sustainability of the project and the coherent software. Therefore, the concept of the potential role models can be treated as the only solution.  \nWe cannot ignore the fact that a significant portion of the comprehensive methods an initial attempt in development of the program functionality the subsequent actions and gives us a clear notion of the subsequent actions. Such tendency may inevitably originate from the coherent software.  \nLooking it another way, the pursuance of development sequence any key factor. This may be done through the comprehensive project management the more product design and development of the coherent software.  \nOn the contrary, a key factor of the the profit represents a bond between the crucial development skills and the driving factor. The commitment to quality assurance turns it into something highly real. So, can it be regarded as a common pattern? Hypothetically, final stages of the software functionality provides a glimpse at the technical terms. Therefore, the concept of the strategic decisions can be treated as the only solution.  ', 0, '2021-03-17 23:11:04');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`promo`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (1, 'Consequuntur sit eos earum sit iste.', 12, 'CV73FGG', 0, '1970-01-01 00:00:01', '1979-12-24 00:22:30');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (2, 'Incidunt vel qui quia.', 37, 'DH79WCG', 0, '1981-10-02 04:22:55', '1970-01-01 00:11:32');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (3, 'Asperiores libero perspiciatis.', 33, 'PM74TUV', 1, '1978-09-25 05:53:54', '1994-01-30 08:53:04');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (4, 'Dolores rerum et quia voluptas magni.', 25, 'LO64HVT', 1, '1979-07-01 09:25:36', '2001-02-04 04:59:45');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (5, 'Velit fugit rerum eos.', 26, 'MB41LLJ', 1, '1970-05-19 10:28:12', '1970-01-01 02:03:38');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (6, 'Facilis rerum autem quibusdam.', 34, 'LK26WMA', 0, '1998-08-15 14:48:46', '1979-05-15 14:00:07');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (7, 'Voluptas qui doloremque vel aliquam.', 24, 'EH50KCV', 0, '2005-04-27 20:33:58', '2020-07-28 22:44:11');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (8, 'Et ex labore maiores autem molestias.', 10, 'AH97LWS', 1, '1970-01-01 00:00:06', '1970-01-01 00:00:09');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (9, 'Enim ipsam ut animi aperiam.', 10, 'CK12AFA', 0, '1970-01-01 00:00:09', '2009-05-21 20:57:26');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (10, 'Eos vel numquam quia veniam.', 31, 'BH07GKA', 1, '1983-01-25 10:11:52', '2003-10-06 04:52:50');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (11, 'Id provident aut et beatae minus.', 39, 'KS84XRG', 0, '1970-01-01 00:01:03', '1970-01-01 00:12:40');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (12, 'Dolor perspiciatis culpa sed et non.', 32, 'OT92NGF', 0, '2001-09-14 19:45:39', '1970-01-01 01:04:59');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (13, 'Nobis perspiciatis minus consequuntur.', 21, 'NF75MME', 1, '1981-03-26 00:53:59', '1990-09-22 08:07:01');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (14, 'Consequatur optio ducimus et delectus.', 37, 'OL32DHZ', 0, '1999-11-28 18:15:59', '2016-01-01 10:30:51');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (15, 'Voluptatem ut sequi repudiandae fuga.', 27, 'NB55YTR', 0, '1993-07-23 13:31:31', '1970-01-01 00:09:33');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (16, 'Sint ipsam nostrum maxime.', 20, 'MB15MKR', 0, '1970-01-01 00:00:11', 'NULL');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (17, 'Laborum omnis ipsa magnam sed iste.', 12, 'RV92EFL', 0, '1999-04-23 20:33:45', '2015-01-29 11:07:55');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (18, 'Veniam voluptates sed provident.', 27, 'CF37MRH', 0, '2020-08-26 02:23:44', '2016-07-27 21:09:31');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (19, 'Provident exercitationem consectetur.', 23, 'EH38XMF', 0, '1974-09-29 14:48:46', '1994-02-17 15:34:35');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (20, 'Cumque est voluptatem omnis cumque ad.', 27, 'PO83WTE', 0, '1970-01-01 00:00:43', '1988-06-09 08:14:56');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (21, 'Inventore incidunt natus incidunt.', 37, 'BT09PPR', 0, '2004-01-01 12:59:21', '1985-12-09 01:04:31');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (22, 'Iste aut voluptatum saepe soluta.', 11, 'BJ67YUT', 1, '1970-01-01 01:58:07', '1997-12-29 21:23:48');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (23, 'Hic voluptates cupiditate ad eos enim.', 33, 'HJ98KBG', 1, '1977-06-03 21:11:06', '2001-11-13 10:20:32');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (24, 'Culpa ratione sit quis unde sunt quia.', 16, 'EK59DHB', 0, '1973-01-03 19:52:05', 'NULL');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (25, 'Sed saepe mollitia maxime velit.', 10, 'KE71AGN', 0, '2020-01-29 08:06:03', '1977-03-12 11:44:31');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (26, 'Voluptatem quia natus.', 40, 'OR80SPJ', 1, '1970-11-27 08:25:21', '2019-03-19 03:39:22');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (27, 'Qui minus adipisci minus vero.', 29, 'AR08TBF', 0, '2021-06-17 14:30:17', '2022-05-17 06:55:28');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (28, 'Rerum debitis quia omnis tenetur unde.', 10, 'HM14YCO', 0, '1980-05-01 00:14:51', '2007-09-05 02:51:39');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (29, 'Non neque vel enim.', 36, 'LD53NNX', 0, '1970-01-19 06:16:01', '1992-09-11 18:09:46');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (30, 'Expedita dolores tenetur earum.', 10, 'EC59BMA', 1, '2003-09-15 03:29:40', '1993-04-01 06:35:05');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (31, 'Quibusdam soluta incidunt earum.', 22, 'AB57LFY', 0, '1970-01-01 00:11:51', '2002-09-20 00:10:32');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (32, 'Temporibus omnis asperiores.', 22, 'ML70GLH', 0, '2014-06-06 11:34:18', '2004-02-25 12:09:10');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (33, 'Omnis vitae accusamus labore modi.', 26, 'ET03FYW', 0, '1970-01-01 02:37:19', '1970-01-01 00:07:16');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (34, 'Velit officia laborum et aperiam.', 17, 'KF28BSD', 0, '2008-05-05 02:13:05', '1990-07-31 09:28:59');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (35, 'Voluptatem qui dolor reprehenderit.', 24, 'AS12POJ', 1, '2008-12-10 12:35:45', '2005-09-27 18:07:15');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (36, 'Consectetur omnis voluptates sint.', 23, 'PC33WNM', 0, '1988-07-18 02:45:12', '2015-02-15 08:53:38');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (37, 'Nobis fuga et mollitia nihil.', 17, 'KS12DSH', 0, '1970-01-01 00:00:09', 'NULL');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (38, 'Qui officiis doloremque libero quia.', 10, 'EN55JFD', 0, '1970-01-01 00:12:00', '1998-09-17 12:13:07');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (39, 'Veritatis hic doloremque voluptas.', 18, 'AT12RNP', 0, '2022-01-14 01:13:24', '2010-02-25 02:02:41');
INSERT INTO `db`.`promo` (`id`, `title`, `discount`, `code`, `promo_status`, `created_at`, `updated_at`) VALUES (40, 'Aspernatur explicabo amet unde iste.', 38, 'CC67JXE', 1, '1970-01-01 00:00:02', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`transaction`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (1, 9, NULL, 1, 44.73, 66.98, 164.91, 0, '2020-08-22 17:34:10', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (2, 37, NULL, 1, 43.07, 76.24, 661.53, 0, '2020-01-01 00:06:21', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (3, 39, NULL, 1, 18.60, 15.69, 87.49, 0, '2020-01-01 00:01:06', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (4, 25, 40, 1, 41.84, 51.34, 754.62, 0, '2020-11-08 17:50:55', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (5, 40, NULL, 0, 14.40, 17.72, 1187.12, 1, '2021-07-13 14:02:37', '2021-07-15 23:54:41');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (6, 21, NULL, 1, 31.23, 66.07, 639.52, 0, '2020-01-01 01:24:43', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (7, 28, NULL, 1, 29.84, 47.70, 356.65, 0, '2020-01-01 00:01:29', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (8, 5, NULL, 1, 15.78, 38.58, 1839.61, 0, '2020-04-01 01:21:31', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (9, 33, NULL, 1, 26.69, 86.01, 686.50, 0, '2020-01-01 00:00:33', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (10, 26, NULL, 0, 11.45, 42.49, 824.73, 1, '2021-02-17 07:14:20', '2020-02-17 23:30:55');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (11, 38, 8, 1, 18.45, 19.63, 933.73, 0, '2020-01-01 01:50:22', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (12, 29, NULL, 1, 39.19, 96.54, 368.86, 0, '2020-10-07 10:19:58', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (13, 11, NULL, 1, 25.74, 97.64, 369.32, 0, '2020-01-01 00:00:52', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (14, 34, NULL, 1, 49.34, 40.02, 1135.91, 0, '2020-01-01 00:00:36', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (15, 16, 23, 1, 18.38, 86.93, 995.89, 0, '2020-01-01 00:00:10', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (16, 12, NULL, 1, 34.14, 61.99, 1167.73, 0, '2020-11-14 05:42:22', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (17, 1, 10, 0, 27.90, 89.05, 1243.70, 1, '2021-04-02 14:34:19', '2021-04-03 15:18:46');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (18, 30, NULL, 1, 36.87, 11.08, 709.39, 0, '2021-06-22 10:04:18', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (19, 6, NULL, 1, 39.35, 78.75, 1062.08, 0, '2020-01-01 00:00:20', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (20, 2, NULL, 1, 13.30, 81.28, 550.34, 0, '2020-11-14 00:03:47', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (21, 7, NULL, 1, 11.93, 35.24, 2419.81, 0, '2020-01-01 00:00:01', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (22, 17, NULL, 1, 31.45, 22.63, 213.68, 0, '2020-01-01 00:01:03', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (23, 3, NULL, 1, 36.70, 24.86, 1053.72, 0, '2021-08-12 02:25:47', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (24, 35, NULL, 1, 36.65, 74.11, 1094.52, 0, '2020-11-19 04:43:25', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (25, 31, 5, 1, 22.94, 30.55, 1125.09, 0, '2020-02-15 01:07:36', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (26, 13, 35, 0, 31.19, 53.65, 1239.84, 1, '2021-07-22 04:31:55', '2021-07-24 10:07:23');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (27, 36, 3, 1, 27.50, 66.43, 1489.33, 0, '2020-01-01 00:00:02', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (28, 32, NULL, 1, 21.20, 26.37, 554.51, 0, '2020-07-28 05:03:06', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (29, 22, 30, 1, 35.84, 37.26, 1199.85, 0, '2020-01-20 21:46:10', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (30, 8, NULL, 0, 38.64, 79.17, 549.93, 1, '2020-07-06 08:12:10', '2020-07-08 01:41:48');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (31, 4, NULL, 1, 40.55, 32.54, 1548.73, 0, '2020-10-04 19:56:00', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (32, 27, 22, 1, 23.05, 24.26, 407.41, 0, '2020-12-31 21:47:57', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (33, 23, NULL, 1, 27.70, 60.36, 243.48, 0, '2020-01-01 00:04:44', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (34, 19, NULL, 1, 14.56, 51.03, 557.17, 0, '2021-08-22 10:20:55', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (35, 24, NULL, 1, 33.23, 44.23, 149.48, 0, '2020-08-23 23:25:07', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (36, 20, NULL, 1, 35.66, 66.78, 1887.69, 0, '2020-07-07 07:09:14', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (37, 18, NULL, 1, 18.79, 89.11, 2085.10, 0, '2021-06-21 22:00:20', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (38, 14, 4, 1, 42.32, 29.70, 470.66, 0, '2021-08-18 10:31:52', 'NULL');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (39, 10, 13, 0, 35.96, 91.47, 859.99, 1, '2020-01-01 00:04:56', '2020-01-02 02:27:02');
INSERT INTO `db`.`transaction` (`id`, `booking_id`, `promo_id`, `transaction_status`, `tax`, `service_fee`, `total_price`, `is_refund`, `transfer_on`, `updated_at`) VALUES (40, 15, 26, 0, 45.16, 48.56, 429.78, 1, '2020-04-08 03:14:09', '2020-04-09 06:38:07');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`image`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (1, 28, 16, 'teruldalha.png', 'http://andleti.no/ourarthi/ouforion/but/eveerera.bmp', '2020-01-01 00:00:55', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (2, 32, 7, 'ourtha.gif', 'https://rikofu.andalareea.de/ourousho/veerentne.bmp', '2020-08-27 13:36:22', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (3, 27, 4, 'uldnot596.jpg', 'http://henstedhin.tw/at/thiourthe/hateaeve/notarbutent.png', '2021-05-10 23:01:08', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (4, 31, 8, 'eveherintio055.bmp', 'https://fofade.tiitleal.com/tiwatio/thehiuldle.gif', '2021-01-26 10:30:33', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (5, 33, 9, 'thiulderebut.gif', 'https://he.onereeve.org/in/tertedin.png', '2021-07-19 15:37:33', '2021-08-26 10:14:42');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (6, 17, 19, 'arverme020.bmp', 'http://no.omeveentthe.ch/and/witnder/ere/ereisour.png', '2020-03-13 15:13:40', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (7, 23, 17, 'eratha62.png', 'http://arehad.kr/tone/healerame.jpg', '2021-05-09 19:31:42', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (8, 17, 1, 'erall203.gif', 'http://roci.hatthathawa.ge/ng/witwanehis.jpg', '2020-01-01 00:00:08', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (9, 21, 3, 'allneathad79.gif', 'https://theallveent.gr/athat/tobut.bmp', '2020-01-20 00:53:27', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (10, 32, 20, 'hadre.png', 'http://eveith.tr/ereou/thialare/st/uldaller.gif', '2020-03-17 01:13:36', '2020-04-05 10:50:14');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (11, 1, 10, 'hadedntth498.gif', 'https://youyou.au/eathar/ithhiare/tioeve/aremeented.jpg', '2020-02-23 05:49:37', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (12, 28, 15, 'tioenfor.jpg', 'https://erha.za/teduld/he/hininandwas.png', '2021-07-09 16:15:45', '2021-08-06 06:08:35');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (13, 35, 18, 'erhi9.png', 'https://erahisthaat.it/seastio/ouneing/es/oulat.bmp', '2021-06-19 08:55:47', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (14, 29, 19, 'theseallha.png', 'http://yafaci.vethete.jp/tionome/thetoin/thi/hahat.jpg', '2020-03-16 22:49:02', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (15, 39, 7, 'alwitse031.gif', 'https://wu.ngfortedare.cn/ednt/erbuthat/tedforbutea.gif', '2020-01-01 00:08:59', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (16, 40, 7, 'nothised.jpg', 'https://retialoul.ae/ored/andaner/seted/withihinith.jpg', '2020-01-01 00:00:02', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (17, 12, 10, 'stbuthisat.jpg', 'https://ourme.ca/hinou/ververan/nd/forentforhat.png', '2020-05-25 21:29:33', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (18, 22, 5, 'alme437.jpg', 'http://washo.hu/esthant/leorha/th/oulngre.jpg', '2020-03-05 14:02:41', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (19, 21, 13, 'oundeder653.png', 'https://zajo.stndsehi.gr/ter/edenenome.gif', '2020-01-01 00:06:02', '2020-01-25 20:13:18');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (20, 27, 17, 'heresitnd.gif', 'http://entterhadera.ar/seare/versteaoul.png', '2021-04-03 04:41:33', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (21, 37, 8, 'eshis818.jpg', 'http://astethe.ch/oul/erahiver/anited.png', '2020-04-03 19:48:40', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (22, 24, 5, 'eraallhese2.png', 'https://ro.haerehinith.cy/verbutfor/nehiedthi.png', '2021-03-30 04:37:26', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (23, 26, 18, 'sesho050.jpg', 'http://vosefa.thahitiong.org/ourndwa/thaarethaoul.bmp', '2020-01-01 00:00:10', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (24, 24, 16, 'sethaonthe043.png', 'https://vuweti.nothenher.cy/her/thathver/setohitio.jpg', '2020-01-01 00:40:25', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (25, 4, 17, 'arstlehad.png', 'https://necelu.atvehad.no/lewasent/eshenin/thiat.bmp', '2020-04-28 12:44:24', '2020-05-20 23:41:29');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (26, 14, 7, 'ourouuldera.png', 'http://enithoulat.dk/tiohebut/waingar/herwantre.bmp', '2020-05-09 06:20:29', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (27, 31, 9, 'uldtha.png', 'https://kiga.thhadasing.tr/is/easho/nd/hias.bmp', '2020-04-21 19:16:04', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (28, 16, 7, 'thethehades258.bmp', 'https://loqovo.wabut.hk/thieve/leerter.png', '2021-04-20 21:33:23', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (29, 21, 20, 'alnothier.jpg', 'http://ingto.es/hiwahad/at/enere/isere.png', '2021-04-30 11:05:02', '2021-05-25 01:24:02');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (30, 11, 18, 'vehenis.jpg', 'http://gikoli.noteatiand.hu/ionalsho/ter/ereanar/hadtedth.gif', '2021-01-12 20:13:46', '2021-01-31 09:45:27');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (31, 23, 13, 'buthisngar48.gif', 'https://yououl.ar/wasar/andtioeve/toereeveeve.png', '2020-01-01 00:00:24', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (32, 32, 5, 'hito9.gif', 'https://ndaresthi.kr/nging/onarethng.bmp', '2020-01-01 00:01:34', '2020-01-30 01:16:02');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (33, 9, 10, 'theforherwa710.jpg', 'http://nothadorare.at/asto/ionesea/edhaome/ngoul.jpg', '2020-01-01 00:00:04', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (34, 10, 4, 'meeninoul6.bmp', 'http://jegifu.isndentted.hk/leometo/andenting/tehad/thest.bmp', '2020-01-01 00:11:09', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (35, 10, 7, 'anntome.jpg', 'http://pevojo.theentourat.no/re/tedent/henthe/butentshoha.gif', '2020-01-01 02:46:03', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (36, 18, 15, 'neshoth.png', 'https://waeveneere.nl/edomeome/iontehad/aleraou.gif', '2020-01-01 00:04:22', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (37, 6, 2, 'witeve397.png', 'https://magiqe.asaswas.se/eraenttio/eshaome/thaonat/enwitre.gif', '2020-08-23 19:19:18', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (38, 24, 1, 'andonareha0.gif', 'https://metheater.cy/youto/letothe/or/alwasforit.jpg', '2020-01-01 00:00:02', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (39, 27, 18, 'andleare.bmp', 'http://mizipi.initndare.us/ted/steangtio.bmp', '2020-01-01 01:02:47', 'NULL');
INSERT INTO `db`.`image` (`id`, `property_id`, `by_user`, `image_name`, `file_location`, `created_at`, `updated_at`) VALUES (40, 16, 8, 'thetomeal.png', 'http://siyiqu.erveed.fr/allthe/henevees/theareas/eveheninto.png', '2020-08-18 04:23:25', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`amenity`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (1, 'Wifi', 'http://nocanu.ishihisal.fi/allhatas/thaasered.bmp');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (2, 'Kitchen', 'http://yi.hisuldante.no/but/henes.gif');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (3, 'Washer', 'http://ernewaare.com/ingion/at/esth/ngleastha.gif');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (4, 'Dryer', 'https://gitu.ourhinthafor.fi/esandfor/alan/mestyou/hadandereth.bmp');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (5, 'Air conditioning', 'https://ereted.br/herwaan/teesented.gif');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (6, 'Heating', 'http://theeraforent.at/ith/inghiion/streme/eaforisver.jpg');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (7, 'Dedicated workspace', 'https://itngnottio.cz/althive/notourtha/setiit/teournt.gif');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (8, 'TV', 'http://neforereuld.se/te/is/ter/ourareforti.bmp');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (9, 'Hair dryer', 'http://erahieste.tr/uld/ted/teisin/thto.bmp');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (10, 'Iron', 'http://onstas.ge/le/inentwit/allandnt/hatananas.bmp');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (11, 'Pool', 'http://ateratar.gr/vear/needneat.jpg');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (12, 'Hot tub', 'http://ourallthent.br/ver/thenthe/wasthour/thiouerant.bmp');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (13, 'Free parking on premises', 'http://thimeouor.ae/ingntuld/tio/ngthetio/thit.bmp');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (14, 'EV charger', 'https://mengsho.net/terngat/andasher/alhiasat.png');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (15, 'Crib', 'http://bu.herandtohin.be/notioning/tiondin/se/forhinerou.jpg');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (16, 'Gym', 'https://nugaqe.arbutesuld.eg/oulre/eve/withinnt/nealleawas.png');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (17, 'BBQ grill', 'http://forhaha.net/ea/re/ve/sethinguld.bmp');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (18, 'Breakfast', 'http://pu.hiarouto.cy/arveome/butthere/herereith.png');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (19, 'Indoor fireplace', 'https://isitheveith.cy/asareon/her/ted/thiatentar.bmp');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (20, 'Smoking allowed', 'https://estedar.gr/toted/entarfor/notentte/atfortioent.png');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (21, 'Beachfront', 'http://lododi.youstwa.org/tioshoeve/hin/se/arthiwaswit.png');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (22, 'Waterfront', 'https://hathe.org/butionea/nden.png');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (23, 'Smoke alarm', 'https://bogaba.ittio.ca/and/notwahen/her/hisstveing.jpg');
INSERT INTO `db`.`amenity` (`id`, `name`, `icon`) VALUES (24, 'Carbon monoxide alarm', 'http://annotti.cy/isne/atforfor.jpg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`property_amenities`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (1, 38, 17);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (2, 6, 5);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (3, 36, 10);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (4, 36, 7);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (5, 30, 16);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (6, 15, 16);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (7, 36, 23);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (8, 39, 10);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (9, 1, 22);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (10, 22, 20);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (11, 40, 13);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (12, 30, 9);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (13, 24, 5);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (14, 1, 21);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (15, 9, 2);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (16, 40, 8);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (17, 27, 19);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (18, 6, 24);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (19, 10, 11);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (20, 3, 10);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (21, 15, 13);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (22, 26, 18);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (23, 1, 23);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (24, 21, 20);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (25, 32, 18);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (26, 11, 13);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (27, 1, 22);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (28, 32, 9);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (29, 19, 14);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (30, 25, 21);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (31, 25, 7);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (32, 9, 6);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (33, 22, 11);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (34, 26, 19);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (35, 12, 10);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (36, 27, 8);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (37, 24, 11);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (38, 5, 17);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (39, 4, 15);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (40, 2, 22);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (41, 13, 18);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (42, 39, 10);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (43, 36, 9);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (44, 9, 1);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (45, 18, 14);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (46, 29, 21);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (47, 25, 1);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (48, 30, 6);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (49, 17, 15);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (50, 34, 3);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (51, 21, 15);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (52, 2, 5);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (53, 7, 9);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (54, 22, 8);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (55, 3, 24);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (56, 15, 11);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (57, 23, 21);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (58, 28, 17);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (59, 12, 20);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (60, 29, 24);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (61, 40, 6);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (62, 28, 17);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (63, 32, 4);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (64, 22, 6);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (65, 28, 6);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (66, 35, 14);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (67, 14, 5);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (68, 8, 9);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (69, 37, 13);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (70, 13, 4);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (71, 13, 14);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (72, 16, 18);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (73, 12, 9);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (74, 31, 1);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (75, 25, 17);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (76, 1, 19);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (77, 4, 3);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (78, 10, 7);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (79, 25, 9);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (80, 11, 17);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (81, 17, 8);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (82, 24, 6);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (83, 38, 2);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (84, 30, 13);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (85, 33, 8);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (86, 17, 24);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (87, 5, 22);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (88, 2, 1);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (89, 8, 22);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (90, 14, 7);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (91, 1, 23);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (92, 12, 12);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (93, 40, 19);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (94, 20, 10);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (95, 35, 17);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (96, 20, 10);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (97, 30, 3);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (98, 2, 8);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (99, 13, 3);
INSERT INTO `db`.`property_amenities` (`id`, `property_id`, `amenity_id`) VALUES (100, 33, 11);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`language`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (1, 'Latin');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (2, 'Finnish');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (3, 'Chamorro');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (4, 'Belarusian');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (5, 'Kikuyu');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (6, 'Lithuanian');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (7, 'Corsican');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (8, 'Inupiaq');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (9, 'Azerbaijani');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (10, 'Gujarati');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (11, 'Albanian');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (12, 'Kanuri');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (13, 'Kyrgyz');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (14, 'Ossetian');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (15, 'Oriya');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (16, 'Estonian');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (17, 'Turkish');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (18, 'Nepali');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (19, 'Breton');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (20, 'Chuvash');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (21, 'Marshallese');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (22, 'Panjabi');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (23, 'Aragonese');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (24, 'Herero');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (25, 'Nauru');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (26, 'Afrikaans');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (27, 'Ewe');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (28, 'Hiri Motu');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (29, 'Marathi');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (30, 'Guarani');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (31, 'Ojibwa');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (32, 'Samoan');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (33, 'English');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (34, 'Arabic');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (35, 'Shona');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (36, 'Persian');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (37, 'Croatian');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (38, 'Afar');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (39, 'Romansh');
INSERT INTO `db`.`language` (`id`, `language_name`) VALUES (40, 'Sardinian');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`host_language`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (1, 26, 24);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (2, 36, 9);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (3, 40, 14);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (4, 10, 28);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (5, 16, 23);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (6, 12, 40);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (7, 18, 4);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (8, 14, 6);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (9, 38, 32);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (10, 14, 26);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (11, 20, 27);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (12, 6, 26);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (13, 34, 38);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (14, 16, 9);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (15, 22, 5);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (16, 26, 33);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (17, 10, 20);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (18, 28, 4);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (19, 16, 12);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (20, 36, 13);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (21, 32, 15);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (22, 32, 24);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (23, 2, 11);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (24, 20, 1);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (25, 38, 17);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (26, 14, 13);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (27, 34, 26);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (28, 4, 39);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (29, 22, 34);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (30, 14, 23);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (31, 38, 17);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (32, 32, 12);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (33, 14, 20);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (34, 32, 9);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (35, 22, 36);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (36, 32, 5);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (37, 22, 35);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (38, 30, 36);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (39, 20, 1);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (40, 2, 36);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (41, 8, 21);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (42, 14, 22);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (43, 32, 14);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (44, 30, 10);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (45, 22, 23);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (46, 30, 15);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (47, 8, 7);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (48, 40, 39);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (49, 6, 17);
INSERT INTO `db`.`host_language` (`id`, `host_id`, `language_id`) VALUES (50, 32, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`accessibility`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (1, 'Step-free guest entrance', 'Guest entrance and parking');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (2, 'Guest entrance wider than 32 inches', 'Guest entrance and parking');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (3, 'Accessible parking spot', 'Guest entrance and parking');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (4, 'Step-free path to the guest entrance', 'Guest entrance and parking');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (5, 'Step-free bedroom access', 'Bedroom');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (6, 'Bedroom entrance wider than 32 inches', 'Bedroom');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (7, 'Step-free bathroom access', 'Bathroom');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (8, 'Bathroom entrance wider than 32 inches', 'Bathroom');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (9, 'Shower grab bar', 'Bathroom');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (10, 'Toilet grab bar', 'Bathroom');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (11, 'Step-free shower', 'Bathroom');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (12, 'Shower or bath chair', 'Bathroom');
INSERT INTO `db`.`accessibility` (`id`, `feature_name`, `feature_desc`) VALUES (13, 'Ceiling or mobile hoist', 'Adaptive equipment');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`property_accessibility`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (1, 23, 3);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (2, 32, 5);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (3, 1, 12);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (4, 22, 9);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (5, 25, 13);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (6, 27, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (7, 14, 12);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (8, 33, 4);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (9, 31, 7);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (10, 17, 7);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (11, 6, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (12, 17, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (13, 38, 13);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (14, 40, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (15, 22, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (16, 16, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (17, 27, 4);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (18, 18, 5);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (19, 1, 12);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (20, 14, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (21, 3, 1);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (22, 2, 5);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (23, 19, 9);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (24, 7, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (25, 11, 12);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (26, 40, 13);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (27, 31, 13);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (28, 23, 13);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (29, 20, 1);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (30, 8, 8);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (31, 20, 12);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (32, 1, 9);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (33, 12, 4);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (34, 9, 9);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (35, 33, 3);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (36, 10, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (37, 9, 12);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (38, 36, 5);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (39, 7, 8);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (40, 19, 7);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (41, 11, 13);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (42, 25, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (43, 17, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (44, 35, 3);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (45, 17, 1);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (46, 21, 5);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (47, 34, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (48, 8, 5);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (49, 38, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (50, 25, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (51, 3, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (52, 13, 3);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (53, 19, 1);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (54, 32, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (55, 9, 13);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (56, 22, 13);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (57, 11, 7);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (58, 34, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (59, 26, 1);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (60, 7, 12);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (61, 12, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (62, 26, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (63, 24, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (64, 29, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (65, 23, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (66, 35, 9);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (67, 39, 9);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (68, 38, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (69, 19, 4);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (70, 31, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (71, 26, 3);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (72, 12, 8);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (73, 2, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (74, 35, 13);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (75, 2, 8);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (76, 21, 9);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (77, 37, 8);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (78, 40, 7);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (79, 8, 12);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (80, 25, 7);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (81, 2, 4);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (82, 19, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (83, 22, 12);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (84, 25, 1);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (85, 29, 5);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (86, 36, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (87, 13, 4);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (88, 5, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (89, 19, 11);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (90, 37, 4);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (91, 39, 3);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (92, 19, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (93, 9, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (94, 17, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (95, 7, 7);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (96, 23, 10);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (97, 5, 4);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (98, 29, 6);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (99, 25, 2);
INSERT INTO `db`.`property_accessibility` (`id`, `property_id`, `accessibility_id`) VALUES (100, 5, 5);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
