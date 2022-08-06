-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Portfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Portfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Portfolio` DEFAULT CHARACTER SET utf8 ;
USE `Portfolio` ;

-- -----------------------------------------------------
-- Table `Portfolio`.`Domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Portfolio`.`Domicilio` (
  `id` INT NOT NULL,
  `calle` VARCHAR(45) NULL,
  `pisoNumero` INT NULL,
  `codigo postal` INT NULL,
  `barrio` VARCHAR(45) NULL,
  `depto` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Portfolio`.`Tecnologias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Portfolio`.`Tecnologias` (
  `id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Portfolio`.`Persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Portfolio`.`Persona` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `domicilio` VARCHAR(45) NULL,
  `fechaNac` DATE NULL,
  `telefono` VARCHAR(12) NULL,
  `correo` VARCHAR(45) NULL,
  `sobre_mi` VARCHAR(200) NULL,
  `url_foto` VARCHAR(100) NULL,
  `Domicilio_id` INT NOT NULL,
  `Tecnologias_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Domicilio_id`, `Tecnologias_id`),
  INDEX `fk_Persona_Domicilio1_idx` (`Domicilio_id` ASC) VISIBLE,
  INDEX `fk_Persona_Tecnologias1_idx` (`Tecnologias_id` ASC) VISIBLE,
  CONSTRAINT `fk_Persona_Domicilio1`
    FOREIGN KEY (`Domicilio_id`)
    REFERENCES `Portfolio`.`Domicilio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persona_Tecnologias1`
    FOREIGN KEY (`Tecnologias_id`)
    REFERENCES `Portfolio`.`Tecnologias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Portfolio`.`tipo_empleo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Portfolio`.`tipo_empleo` (
  `id` INT NOT NULL,
  `nombre_tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Portfolio`.`Experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Portfolio`.`Experiencia_laboral` (
  `id` INT NOT NULL,
  `nombreEmpresa` VARCHAR(45) NULL,
  `esTrabajoActual` TINYINT NULL,
  `fechaInicio` DATE NULL,
  `fechaFin` DATE NULL,
  `descripcion` VARCHAR(200) NULL,
  `Persona_id` INT NOT NULL,
  `tipo_empleo_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Persona_id`, `tipo_empleo_id`),
  INDEX `fk_Experiencia_laboral_Persona1_idx` (`Persona_id` ASC) VISIBLE,
  INDEX `fk_Experiencia_laboral_tipo_empleo1_idx` (`tipo_empleo_id` ASC) VISIBLE,
  CONSTRAINT `fk_Experiencia_laboral_Persona1`
    FOREIGN KEY (`Persona_id`)
    REFERENCES `Portfolio`.`Persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Experiencia_laboral_tipo_empleo1`
    FOREIGN KEY (`tipo_empleo_id`)
    REFERENCES `Portfolio`.`tipo_empleo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Portfolio`.`Educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Portfolio`.`Educacion` (
  `id` INT NOT NULL,
  `nombreInstitucion` VARCHAR(45) NULL,
  `fechaInicio` DATE NULL,
  `fechaFin` DATE NULL,
  `Persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Persona_id`),
  INDEX `fk_Educacion_Persona1_idx` (`Persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_Educacion_Persona1`
    FOREIGN KEY (`Persona_id`)
    REFERENCES `Portfolio`.`Persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Portfolio`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Portfolio`.`Usuarios` (
  `id` INT NOT NULL,
  `usuario` VARCHAR(15) NULL,
  `contraseña` VARCHAR(15) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Portfolio`.`Proyectos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Portfolio`.`Proyectos` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `Persona_id` INT NOT NULL,
  `Persona_Domicilio_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Persona_id`, `Persona_Domicilio_id`),
  INDEX `fk_Proyectos_Persona1_idx` (`Persona_id` ASC, `Persona_Domicilio_id` ASC) VISIBLE,
  CONSTRAINT `fk_Proyectos_Persona1`
    FOREIGN KEY (`Persona_id` , `Persona_Domicilio_id`)
    REFERENCES `Portfolio`.`Persona` (`id` , `Domicilio_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
