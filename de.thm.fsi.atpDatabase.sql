-- Generated: 2022-02-08 10:54
-- Model: de.thm.fsi.atpDatabase
-- Version: 1.1
-- Project: Attendance+

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `atp` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `atp`.`Student` (
  `matrikelnummer` INT(11) NOT NULL,
  `nachname` VARCHAR(45) NOT NULL,
  `vorname` VARCHAR(45) NOT NULL,
  `anrede` VARCHAR(45) NULL DEFAULT NULL,
  `titel` VARCHAR(45) NULL DEFAULT NULL,
  `akademischerGrad` VARCHAR(45) NULL DEFAULT NULL,
  `beginndatumPerson` DATE NOT NULL,
  `chipkartennummer` VARCHAR(45) NULL DEFAULT NULL,
  `Studiengruppe_idStudiengruppe` INT(11) NOT NULL,
  PRIMARY KEY (`matrikelnummer`, `Studiengruppe_idStudiengruppe`),
  INDEX `fk_Student_Studiengruppe1_idx` (`Studiengruppe_idStudiengruppe` ASC) VISIBLE,
  CONSTRAINT `fk_Student_Studiengruppe1`
    FOREIGN KEY (`Studiengruppe_idStudiengruppe`)
    REFERENCES `atp`.`Studiengruppe` (`idStudiengruppe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Raum` (
  `idRaum` INT(11) NOT NULL AUTO_INCREMENT,
  `kurzbezeichnung` VARCHAR(45) NOT NULL,
  `bezeichnung` VARCHAR(45) NULL DEFAULT NULL,
  `inventarnummer` INT(11) NOT NULL,
  PRIMARY KEY (`idRaum`, `inventarnummer`),
  INDEX `fk_Raum_Lesegeraet1_idx` (`inventarnummer` ASC) VISIBLE,
  CONSTRAINT `fk_Raum_Lesegeraet1`
    FOREIGN KEY (`inventarnummer`)
    REFERENCES `atp`.`Lesegeraet` (`inventarnummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Lesegeraet` (
  `inventarnummer` INT(11) NOT NULL,
  `ipAdresse` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`inventarnummer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Lehrveranstaltung` (
  `idLehrveranstaltung` INT(11) NOT NULL AUTO_INCREMENT,
  `bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idLehrveranstaltung`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Lehrveranstaltungstermin` (
  `idLehrveranstaltungstermin` INT(11) NOT NULL AUTO_INCREMENT,
  `datum` DATE NOT NULL,
  `zeitVon` TIME NOT NULL,
  `zeitBis` TIME NOT NULL,
  `idStudiengruppe` INT(11) NOT NULL,
  `idLehrveranstaltung` INT(11) NOT NULL,
  PRIMARY KEY (`idLehrveranstaltungstermin`, `idStudiengruppe`, `idLehrveranstaltung`),
  INDEX `fk_Lehrveranstaltungstermin_Studiengruppe_has_Lehrveranstal_idx` (`idStudiengruppe` ASC, `idLehrveranstaltung` ASC) VISIBLE,
  CONSTRAINT `fk_Lehrveranstaltungstermin_Studiengruppe_has_Lehrveranstaltu1`
    FOREIGN KEY (`idStudiengruppe` , `idLehrveranstaltung`)
    REFERENCES `atp`.`Studiengruppe_has_Lehrveranstaltung` (`idStudiengruppe` , `idLehrveranstaltung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Dozent` (
  `dozentennummer` INT(11) NOT NULL,
  `nachname` VARCHAR(45) NOT NULL,
  `vorname` VARCHAR(45) NOT NULL,
  `anrede` VARCHAR(45) NULL DEFAULT NULL,
  `titel` VARCHAR(45) NULL DEFAULT NULL,
  `akademischerGrad` VARCHAR(45) NULL DEFAULT NULL,
  `beginndatumPerson` DATE NOT NULL,
  `chipkartennummer` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`dozentennummer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Dozent_has_Lehrveranstaltung` (
  `dozentennummer` INT(11) NOT NULL,
  `idLehrveranstaltung` INT(11) NOT NULL,
  PRIMARY KEY (`dozentennummer`, `idLehrveranstaltung`),
  INDEX `fk_Dozent_has_Lehrveranstaltung_Lehrveranstaltung1_idx` (`idLehrveranstaltung` ASC) VISIBLE,
  INDEX `fk_Dozent_has_Lehrveranstaltung_Dozent1_idx` (`dozentennummer` ASC) VISIBLE,
  CONSTRAINT `fk_Dozent_has_Lehrveranstaltung_Dozent1`
    FOREIGN KEY (`dozentennummer`)
    REFERENCES `atp`.`Dozent` (`dozentennummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dozent_has_Lehrveranstaltung_Lehrveranstaltung1`
    FOREIGN KEY (`idLehrveranstaltung`)
    REFERENCES `atp`.`Lehrveranstaltung` (`idLehrveranstaltung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Studiengruppe` (
  `idStudiengruppe` INT(11) NOT NULL AUTO_INCREMENT,
  `nameStudiengruppe` VARCHAR(45) NOT NULL,
  `gruppe` INT(11) NOT NULL,
  `abschlussart` VARCHAR(45) NULL DEFAULT NULL,
  `fachrichtungKurz` VARCHAR(45) NULL DEFAULT NULL,
  `fachrichtungLang` VARCHAR(45) NULL DEFAULT NULL,
  `studiengangKurz` VARCHAR(45) NULL DEFAULT NULL,
  `studiengangLang` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idStudiengruppe`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Studiengruppe_has_Lehrveranstaltung` (
  `idStudiengruppe` INT(11) NOT NULL,
  `idLehrveranstaltung` INT(11) NOT NULL,
  PRIMARY KEY (`idStudiengruppe`, `idLehrveranstaltung`),
  INDEX `fk_Studiengruppe_has_Lehrveranstaltung_Lehrveranstaltung1_idx` (`idLehrveranstaltung` ASC) VISIBLE,
  INDEX `fk_Studiengruppe_has_Lehrveranstaltung_Studiengruppe1_idx` (`idStudiengruppe` ASC) VISIBLE,
  CONSTRAINT `fk_Studiengruppe_has_Lehrveranstaltung_Studiengruppe1`
    FOREIGN KEY (`idStudiengruppe`)
    REFERENCES `atp`.`Studiengruppe` (`idStudiengruppe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Studiengruppe_has_Lehrveranstaltung_Lehrveranstaltung1`
    FOREIGN KEY (`idLehrveranstaltung`)
    REFERENCES `atp`.`Lehrveranstaltung` (`idLehrveranstaltung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Lehrveranstaltungstermin_has_Raum` (
  `idRaum` INT(11) NOT NULL,
  `inventarnummer` INT(11) NOT NULL,
  `idLehrveranstaltungstermin` INT(11) NOT NULL,
  `idStudiengruppe` INT(11) NOT NULL,
  `idLehrveranstaltung` INT(11) NOT NULL,
  PRIMARY KEY (`idRaum`, `inventarnummer`, `idLehrveranstaltungstermin`, `idStudiengruppe`, `idLehrveranstaltung`),
  INDEX `fk_Lehrveranstaltungstermin_has_Raum_Raum1_idx` (`idRaum` ASC, `inventarnummer` ASC) VISIBLE,
  INDEX `fk_Lehrveranstaltungstermin_has_Raum_Lehrveranstaltungsterm_idx` (`idLehrveranstaltungstermin` ASC, `idStudiengruppe` ASC, `idLehrveranstaltung` ASC) VISIBLE,
  CONSTRAINT `fk_Lehrveranstaltungstermin_has_Raum_Raum1`
    FOREIGN KEY (`idRaum` , `inventarnummer`)
    REFERENCES `atp`.`Raum` (`idRaum` , `inventarnummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Lehrveranstaltungstermin_has_Raum_Lehrveranstaltungstermin1`
    FOREIGN KEY (`idLehrveranstaltungstermin` , `idStudiengruppe` , `idLehrveranstaltung`)
    REFERENCES `atp`.`Lehrveranstaltungstermin` (`idLehrveranstaltungstermin` , `idStudiengruppe` , `idLehrveranstaltung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `atp`.`Student_has_Lehrveranstaltungstermin_has_Raum` (
  `matrikelnummer` INT(11) NOT NULL,
  `idStudiengruppe` INT(11) NOT NULL,
  `idRaum` INT(11) NOT NULL,
  `inventarnummer` INT(11) NOT NULL,
  `idLehrveranstaltungstermin` INT(11) NOT NULL,
  `idStudiengruppe` INT(11) NOT NULL,
  `idLehrveranstaltung` INT(11) NOT NULL,
  PRIMARY KEY (`matrikelnummer`, `idStudiengruppe`, `idRaum`, `inventarnummer`, `idLehrveranstaltungstermin`, `idStudiengruppe`, `idLehrveranstaltung`),
  INDEX `fk_Student_has_Lehrveranstaltungstermin_has_Raum_Lehrverans_idx` (`idRaum` ASC, `inventarnummer` ASC, `idLehrveranstaltungstermin` ASC, `idStudiengruppe` ASC, `idLehrveranstaltung` ASC) VISIBLE,
  INDEX `fk_Student_has_Lehrveranstaltungstermin_has_Raum_Student1_idx` (`matrikelnummer` ASC, `idStudiengruppe` ASC) VISIBLE,
  CONSTRAINT `fk_Student_has_Lehrveranstaltungstermin_has_Raum_Student1`
    FOREIGN KEY (`matrikelnummer` , `idStudiengruppe`)
    REFERENCES `atp`.`Student` (`matrikelnummer` , `Studiengruppe_idStudiengruppe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Student_has_Lehrveranstaltungstermin_has_Raum_Lehrveransta1`
    FOREIGN KEY (`idRaum` , `inventarnummer` , `idLehrveranstaltungstermin` , `idStudiengruppe` , `idLehrveranstaltung`)
    REFERENCES `atp`.`Lehrveranstaltungstermin_has_Raum` (`idRaum` , `inventarnummer` , `idLehrveranstaltungstermin` , `idStudiengruppe` , `idLehrveranstaltung`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
