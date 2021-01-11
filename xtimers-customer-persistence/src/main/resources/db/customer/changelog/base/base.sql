
CREATE SCHEMA IF NOT EXISTS `xtimers-customer`;
USE `xtimers-customer` ;


CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_app_info` (
    `app_info_id` INT(11) NOT NULL AUTO_INCREMENT,
    `app_name` VARCHAR(50) NULL DEFAULT NULL,
    `desc` VARCHAR(45) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`app_info_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_customer` (
    `country_id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
    `code_alpha2` VARCHAR(45) NOT NULL,
    `country_name` VARCHAR(255) NOT NULL,
    `code_alpha3` VARCHAR(45) NOT NULL,
    `code_numeric3` VARCHAR(45) NULL DEFAULT NULL,
    `active` TINYINT(1) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`country_id`),
    UNIQUE INDEX `code_alpha2_unique` (`code_alpha2` ASC),
    UNIQUE INDEX `code_alpha3_unique` (`code_alpha3` ASC),
    UNIQUE INDEX `country_id_unique` (`country_id` ASC))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `xpectofy`.`xt_country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_country` (
    `country_id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
    `code_alpha2` VARCHAR(45) NOT NULL,
    `country_name` VARCHAR(255) NOT NULL,
    `code_alpha3` VARCHAR(45) NOT NULL,
    `code_numeric3` VARCHAR(45) NULL DEFAULT NULL,
    `active` TINYINT(1) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`country_id`),
    UNIQUE INDEX `xt_country_code_alpha2_unique` (`code_alpha2` ASC),
    UNIQUE INDEX `xt_country_code_alpha3_unique` (`code_alpha3` ASC),
    UNIQUE INDEX `xt_country_code_country_id_unique` (`country_id` ASC))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;
-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_customer_currency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_customer_currency` (
    `currency_id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
    `code_alpha3` VARCHAR(45) NULL DEFAULT NULL,
    `code_numeric` SMALLINT(6) NULL DEFAULT NULL,
    `display_symbole` VARCHAR(45) NULL DEFAULT NULL,
    `description` VARCHAR(100) NULL DEFAULT NULL,
    `active` TINYINT(1) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`currency_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_states`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_states` (
    `state_id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
    `fk_country_id` SMALLINT(6) NOT NULL,
    `state_name` VARCHAR(255) NOT NULL,
    `code_alpha2` VARCHAR(45) NOT NULL,
    `code_alpha3` VARCHAR(45) NULL DEFAULT NULL,
    `code_numeric3` VARCHAR(45) NOT NULL,
    `active` TINYINT(1) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`state_id`),
    CONSTRAINT `fk_xt_state_xt_country1`
    FOREIGN KEY (`fk_country_id`)
    REFERENCES `xtimers-customer`.`xt_country` (`country_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_customer_auth_mgmt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_customer_auth_mgmt` (
    `customer_auth_mgmt_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `user_name` VARCHAR(255) NULL DEFAULT NULL,
    `password` VARCHAR(255) NULL DEFAULT NULL,
    `change_pwd_receive_email` VARCHAR(255) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`customer_auth_mgmt_id`),
    UNIQUE INDEX `xt_customer_auth_mgmt_user_name_unique` (`user_name` ASC))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_customer_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_customer_info` (
    `customer_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `payment_provider_cust_id` VARCHAR(255) NULL DEFAULT NULL,
    `user_name` VARCHAR(255) NOT NULL,
    `fk_customer_auth_mgmt_id` BIGINT(20) NULL,
    `email_address` VARCHAR(255) NULL DEFAULT NULL,
    `first_name` VARCHAR(255) NULL DEFAULT NULL,
    `last_name` VARCHAR(255) NULL DEFAULT NULL,
    `is_registered` TINYINT(1) NULL DEFAULT NULL,
    `receive_sms` TINYINT(1) NULL DEFAULT '0',
    `locale_code_id` VARCHAR(45) NULL DEFAULT NULL,
    `is_preview` TINYINT(1) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`customer_id`),
    UNIQUE INDEX `payment_provider_cust_id_unique` (`payment_provider_cust_id` ASC),
    UNIQUE INDEX `email_address_unique` (`email_address` ASC),
    UNIQUE INDEX `xt_customer_info_user_name_UNIQUE` (`user_name` ASC),
    CONSTRAINT `fk_xt_customer_info_xt_customer_auth_mgmt1`
    FOREIGN KEY (`fk_customer_auth_mgmt_id`)
    REFERENCES `xtimers-customer`.`xt_customer_auth_mgmt` (`customer_auth_mgmt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_customer_billing_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_customer_billing_address` (
    `billing_add_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(255) NULL DEFAULT NULL,
    `last_name` VARCHAR(255) NULL DEFAULT NULL,
    `fk_state_id` SMALLINT(6) NOT NULL,
    `fk_country_id` SMALLINT(6) NOT NULL,
    `fk_customer_id` BIGINT(20) NOT NULL,
    `is_active` TINYINT(1) NULL DEFAULT NULL,
    `address_line1` VARCHAR(255) NOT NULL,
    `address_line2` VARCHAR(100) NULL DEFAULT NULL,
    `address_line3` VARCHAR(100) NULL DEFAULT NULL,
    `city` VARCHAR(100) NOT NULL,
    `postal_code` VARCHAR(45) NOT NULL,
    `is_default` TINYINT(1) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`billing_add_id`),
    CONSTRAINT `fk_xt_billing_address_xt_country1`
    FOREIGN KEY (`fk_country_id`)
    REFERENCES `xtimers-customer`.`xt_country` (`country_id`),
    CONSTRAINT `fk_xt_billing_address_xt_state1`
    FOREIGN KEY (`fk_state_id`)
    REFERENCES `xtimers-customer`.`xt_states` (`state_id`),
    CONSTRAINT `fk_xt_customer_billing_addressxt_customer_info1`
    FOREIGN KEY (`fk_customer_id`)
    REFERENCES `xtimers-customer`.`xt_customer_info` (`customer_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_customer_shipping_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_customer_shipping_address` (
    `shipping_address_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(255) NULL DEFAULT NULL,
    `last_name` VARCHAR(255) NULL DEFAULT NULL,
    `phone` VARCHAR(15) NULL DEFAULT NULL,
    `email` VARCHAR(255) NULL DEFAULT NULL,
    `fk_state_id` SMALLINT(6) NOT NULL,
    `fk_country_id` SMALLINT(6) NOT NULL,
    `address_line1` VARCHAR(255) NOT NULL,
    `address_line2` VARCHAR(100) NULL DEFAULT NULL,
    `address_line3` VARCHAR(100) NULL DEFAULT NULL,
    `city` VARCHAR(100) NULL DEFAULT NULL,
    `company_name` VARCHAR(100) NULL DEFAULT NULL,
    `county` VARCHAR(100) NULL DEFAULT NULL,
    `fk_customer_id` BIGINT(20) NOT NULL,
    `is_active` TINYINT(1) NULL DEFAULT NULL,
    `postal_code` VARCHAR(45) NULL DEFAULT NULL,
    `is_default` TINYINT(1) NULL DEFAULT NULL,
    `lat` DECIMAL(10,8) NOT NULL,
    `lng` DECIMAL(11,8) NOT NULL,
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`shipping_address_id`),
    CONSTRAINT `fk_customer_shipping_address_xt_customer_info1`
    FOREIGN KEY (`fk_customer_id`)
    REFERENCES `xtimers-customer`.`xt_customer_info` (`customer_id`),
    CONSTRAINT `fk_xt_customer_address_xt_country1`
    FOREIGN KEY (`fk_country_id`)
    REFERENCES `xtimers-customer`.`xt_country` (`country_id`),
    CONSTRAINT `fk_xt_customer_address_xt_state1`
    FOREIGN KEY (`fk_state_id`)
    REFERENCES `xtimers-customer`.`xt_states` (`state_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_cust_address_xref`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_cust_address_xref` (
    `cust_add_xref_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `fk_customer_info_id` BIGINT(20) NOT NULL,
    `fk_shippng_address_id` BIGINT(20) NULL DEFAULT NULL,
    `fk_billing_id` BIGINT(20) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`cust_add_xref_id`),
    CONSTRAINT `fk_xt_customer_address_xref_xt_cart_billing_address1`
    FOREIGN KEY (`fk_billing_id`)
    REFERENCES `xtimers-customer`.`xt_customer_billing_address` (`billing_add_id`),
    CONSTRAINT `fk_xt_customer_address_xref_xt_customer_address1`
    FOREIGN KEY (`fk_shippng_address_id`)
    REFERENCES `xtimers-customer`.`xt_customer_shipping_address` (`shipping_address_id`),
    CONSTRAINT `fk_xt_customer_address_xref_xt_customer_info1`
    FOREIGN KEY (`fk_customer_info_id`)
    REFERENCES `xtimers-customer`.`xt_customer_info` (`customer_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_customer_attribute`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_customer_attribute` (
    `customer_attr_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NULL DEFAULT NULL,
    `value` VARCHAR(100) NULL DEFAULT NULL,
    `fk_customer_contact_id` BIGINT(20) NOT NULL,
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`customer_attr_id`),
    CONSTRAINT `fk_xt_customer_attribute_xt_customer1`
    FOREIGN KEY (`fk_customer_contact_id`)
    REFERENCES `xtimers-customer`.`xt_customer_info` (`customer_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_customer_device`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_customer_device` (
    `customer_device_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `device_id` VARCHAR(50) NULL DEFAULT NULL,
    `device_name` VARCHAR(50) NULL DEFAULT NULL,
    `device_app_ntf_id` VARCHAR(200) NULL DEFAULT NULL,
    `device_os` VARCHAR(50) NULL DEFAULT NULL,
    `app_version` VARCHAR(10) NULL DEFAULT NULL,
    `fk_customer_id` BIGINT(20) NOT NULL,
    `is_active` TINYINT(1) NULL DEFAULT NULL,
    `fk_app_info_id` INT(11) NOT NULL,
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`customer_device_id`),
    CONSTRAINT `fk_xt_customer_device_xt_app_info1`
    FOREIGN KEY (`fk_app_info_id`)
    REFERENCES `xtimers-customer`.`xt_app_info` (`app_info_id`),
    CONSTRAINT `fk_xt_customer_device_xt_customer_info1`
    FOREIGN KEY (`fk_customer_id`)
    REFERENCES `xtimers-customer`.`xt_customer_info` (`customer_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;




-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_customer_phone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_customer_phone` (
    `customer_phone_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `phone_type` VARCHAR(15) NULL DEFAULT NULL,
    `is_active` TINYINT(1) NULL DEFAULT NULL,
    `phone_number` VARCHAR(45) NULL DEFAULT NULL,
    `fk_customer_contact_id` BIGINT(20) NOT NULL,
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`customer_phone_id`),
    CONSTRAINT `fk_xt_customer_phone_xt_customer_contact_info1`
    FOREIGN KEY (`fk_customer_contact_id`)
    REFERENCES `xtimers-customer`.`xt_customer_info` (`customer_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_password_reset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_password_reset` (
    `password_reset_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `fk_customer_auth_mgmt_id` BIGINT(20) NOT NULL,
    `reset_key` LONGTEXT NULL DEFAULT NULL,
    `url_key` LONGTEXT NULL DEFAULT NULL,
    `is_active` TINYINT(4) NULL DEFAULT '1',
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`password_reset_id`),
    CONSTRAINT `fk_xt_password_reset_xt_customer_auth_mgmt1`
    FOREIGN KEY (`fk_customer_auth_mgmt_id`)
    REFERENCES `xtimers-customer`.`xt_customer_auth_mgmt` (`customer_auth_mgmt_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_payment_credit_card_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_payment_credit_card_type` (
    `credit_card_type_id` INT(11) NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(45) NOT NULL,
    `description` VARCHAR(45) NULL DEFAULT NULL,
    `is_active` TINYINT(1) NOT NULL DEFAULT '1',
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`credit_card_type_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_payment_customer_credit_card`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_payment_customer_credit_card` (
    `credit_card_id` INT(11) NOT NULL AUTO_INCREMENT,
    `fk_customer_id` BIGINT(20) NOT NULL,
    `fk_credit_card_type_id` INT(11) NOT NULL,
    `card_finger_print` VARCHAR(255) NOT NULL,
    `fk_billing_add_id` BIGINT(20) NULL DEFAULT NULL,
    `card_holder_name` VARCHAR(45) NOT NULL,
    `credit_card_number` VARCHAR(45) NOT NULL,
    `expiry_month` VARCHAR(45) NOT NULL,
    `expiry_year` VARCHAR(45) NOT NULL,
    `is_active` TINYINT(1) NOT NULL DEFAULT '1',
    `is_default` TINYINT(1) NOT NULL,
    `last_four` VARCHAR(45) NOT NULL,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`credit_card_id`),
    CONSTRAINT `fk_payment_credit_card_type_paymentsubtypeid1`
    FOREIGN KEY (`fk_credit_card_type_id`)
    REFERENCES `xtimers-customer`.`xt_payment_credit_card_type` (`credit_card_type_id`),
    CONSTRAINT `fk_payment_customer_credit_address_billingaddressid1`
    FOREIGN KEY (`fk_billing_add_id`)
    REFERENCES `xtimers-customer`.`xt_customer_billing_address` (`billing_add_id`),
    CONSTRAINT `fk_payment_customer_customer_info_customeid1`
    FOREIGN KEY (`fk_customer_id`)
    REFERENCES `xtimers-customer`.`xt_customer_info` (`customer_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_payment_customer_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_payment_customer_info` (
    `xt_customer_payment_info` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `fk_customer_id` BIGINT(20) NOT NULL,
    `fk_credit_card_id` INT(11) NOT NULL,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`xt_customer_payment_info`),
    CONSTRAINT `fk_xt_customer_payment_info_payment_customer_credit_card1`
    FOREIGN KEY (`fk_credit_card_id`)
    REFERENCES `xtimers-customer`.`xt_payment_customer_credit_card` (`credit_card_id`),
    CONSTRAINT `fk_xt_customer_payment_info_xt_customer_info1`
    FOREIGN KEY (`fk_customer_id`)
    REFERENCES `xtimers-customer`.`xt_customer_info` (`customer_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_provider` (
    `payment_provider_id` INT(11) NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(45) NOT NULL,
    `description` VARCHAR(45) NULL DEFAULT NULL,
    `is_active` TINYINT(1) NULL DEFAULT NULL,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`payment_provider_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_request_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_request_type` (
    `xt_request_type_id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(45) NULL DEFAULT NULL,
    `description` VARCHAR(255) NULL DEFAULT NULL,
    `active` TINYINT(1) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`xt_request_type_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_request_originator_system`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_request_originator_system` (
    `req_origi_id` SMALLINT(6) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL DEFAULT 'desktop',
    `descriptions` VARCHAR(255) NULL DEFAULT 'by desktop',
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`req_origi_id`),
    UNIQUE INDEX `name_unique` (`name` ASC))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_roles` (
    `role_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `role_name` VARCHAR(45) NULL DEFAULT NULL,
    `role_desc` VARCHAR(100) NULL DEFAULT NULL,
    `is_active` TINYINT(4) NULL DEFAULT '0',
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`role_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_sequence`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_sequence` (
    `xt_sequence_id` INT(11) NOT NULL AUTO_INCREMENT,
    `sequence_name` VARCHAR(100) NOT NULL,
    `sequence_increment` INT(11) UNSIGNED NULL DEFAULT '1',
    `sequence_min_value` INT(11) UNSIGNED NULL DEFAULT '1',
    `sequence_max_value` BIGINT(20) UNSIGNED NULL DEFAULT '18446744073709551615',
    `sequence_cur_value` BIGINT(20) UNSIGNED NULL DEFAULT '1000',
    `sequence_cycle` TINYINT(1) NULL DEFAULT '0',
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`xt_sequence_id`),
    UNIQUE INDEX `sequence_name_unique` (`sequence_name` ASC))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_user_roles` (
    `user_role_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `fk_roles_role_id` BIGINT(20) NOT NULL,
    `fk_customer_id` BIGINT(20) NOT NULL,
    `created_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NULL DEFAULT NULL,
    `date_modified` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`user_role_id`, `fk_roles_role_id`, `fk_customer_id`),
    CONSTRAINT `fk_xt_user_roles_xt_customer_info1`
    FOREIGN KEY (`fk_customer_id`)
    REFERENCES `xtimers-customer`.`xt_customer_info` (`customer_id`),
    CONSTRAINT `fk_xt_user_roles_xt_roles1`
    FOREIGN KEY (`fk_roles_role_id`)
    REFERENCES `xtimers-customer`.`xt_roles` (`role_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `xtimers-customer`.`xt_zipcode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `xtimers-customer`.`xt_zipcode` (
    `xt_zipcode_id` INT(11) NOT NULL AUTO_INCREMENT,
    `zipcode` VARCHAR(45) NOT NULL,
    `city` VARCHAR(45) NULL DEFAULT NULL,
    `county` VARCHAR(45) NULL DEFAULT NULL,
    `fk_state_id` SMALLINT(6) NOT NULL,
    `fk_country_id` SMALLINT(6) NOT NULL,
    `created_by` VARCHAR(45) NOT NULL,
    `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `modified_by` VARCHAR(45) NOT NULL,
    `date_modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`xt_zipcode_id`),
    CONSTRAINT `fk_xt_zipcode_xt_country1`
    FOREIGN KEY (`fk_country_id`)
    REFERENCES `xtimers-customer`.`xt_country` (`country_id`),
    CONSTRAINT `fk_xt_zipcode_xt_state!`
    FOREIGN KEY (`fk_state_id`)
    REFERENCES `xtimers-customer`.`xt_states` (`state_id`))
    ENGINE = InnoDB
    DEFAULT CHARACTER SET = utf8;