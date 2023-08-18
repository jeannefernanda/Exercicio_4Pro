-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: escola
-- ------------------------------------------------------
-- Server version	5.7.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aluno` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `codigopessoa` int(11) NOT NULL,
  `numeromatricula` varchar(9) NOT NULL,
  `datamatricula` date DEFAULT NULL,
  `alunoespecial` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `aluno_FK` (`codigopessoa`),
  CONSTRAINT `aluno_FK` FOREIGN KEY (`codigopessoa`) REFERENCES `pessoa` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno`
--

LOCK TABLES `aluno` WRITE;
/*!40000 ALTER TABLE `aluno` DISABLE KEYS */;
INSERT INTO `aluno` VALUES (11,25,'10006','2023-08-01',1),(12,26,'10007','2023-08-02',1),(13,27,'10008','2023-08-03',0),(14,28,'10009','2023-08-04',0),(15,29,'10010','2023-08-04',0),(16,30,'10011','2023-08-17',0),(17,31,'10012','2023-08-17',1),(18,32,'10013','2023-08-17',1),(19,37,'10015','2023-10-10',0);
/*!40000 ALTER TABLE `aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `categoria` enum('Aperfeiçoamento','Capacitação','Oficina','Treinamento') DEFAULT NULL,
  `datacriacao` date NOT NULL,
  `status` enum('Ativo','Inativo') DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (3,'Web Design','Aperfeiçoamento','2023-01-01','Ativo'),(4,'Fotografia','Aperfeiçoamento','2023-01-02','Ativo'),(5,'Marketing Digital','Capacitação','2023-01-03','Ativo'),(6,'Gestão de Projetos','Aperfeiçoamento','2023-01-04','Ativo'),(7,'Inglês Avançado','Capacitação','2023-01-05','Ativo');
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disciplina`
--

DROP TABLE IF EXISTS `disciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disciplina` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `ementa` varchar(120) NOT NULL,
  `cargahoraria` decimal(6,2) NOT NULL,
  `porcentagemteoria` decimal(5,2) NOT NULL,
  `porcentagempratica` decimal(6,2) NOT NULL,
  `status` enum('Ativo','Inativo') DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplina`
--

LOCK TABLES `disciplina` WRITE;
/*!40000 ALTER TABLE `disciplina` DISABLE KEYS */;
INSERT INTO `disciplina` VALUES (1,'Introdução à Programação','Fundamentos de programação',60.00,40.00,60.00,'Ativo'),(2,'Cálculo I','Cálculos diferenciais e integrais',80.00,60.00,40.00,'Ativo'),(3,'Redes de Computadores','Fundamentos de redes',70.00,50.00,50.00,'Ativo'),(4,'Design Gráfico','Princípios do design digital',50.00,30.00,70.00,'Ativo'),(5,'Gestão Financeira','Práticas de administração financeira',75.00,40.00,60.00,'Ativo');
/*!40000 ALTER TABLE `disciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grade`
--

DROP TABLE IF EXISTS `grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grade` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `codigoturma` int(11) DEFAULT NULL,
  `codigoministrante` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `grade_FK` (`codigoministrante`),
  CONSTRAINT `grade_FK` FOREIGN KEY (`codigoministrante`) REFERENCES `ministrante` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grade`
--

LOCK TABLES `grade` WRITE;
/*!40000 ALTER TABLE `grade` DISABLE KEYS */;
INSERT INTO `grade` VALUES (1,1,1),(2,2,2),(3,3,3),(4,1,4),(5,2,5);
/*!40000 ALTER TABLE `grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matricula`
--

DROP TABLE IF EXISTS `matricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matricula` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `codigoaluno` int(11) DEFAULT NULL,
  `codigoturma` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `matricula_FK` (`codigoaluno`),
  KEY `matricula_FK_1` (`codigoturma`),
  CONSTRAINT `matricula_FK` FOREIGN KEY (`codigoaluno`) REFERENCES `aluno` (`codigo`),
  CONSTRAINT `matricula_FK_1` FOREIGN KEY (`codigoturma`) REFERENCES `turma` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matricula`
--

LOCK TABLES `matricula` WRITE;
/*!40000 ALTER TABLE `matricula` DISABLE KEYS */;
INSERT INTO `matricula` VALUES (13,11,3),(14,12,3),(15,13,3),(16,14,3),(17,15,11),(18,16,NULL),(19,17,NULL);
/*!40000 ALTER TABLE `matricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ministrante`
--

DROP TABLE IF EXISTS `ministrante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ministrante` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `codigoprofessor` int(11) DEFAULT NULL,
  `codigodisciplina` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `ministrante_FK` (`codigoprofessor`),
  CONSTRAINT `ministrante_FK` FOREIGN KEY (`codigoprofessor`) REFERENCES `disciplina` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ministrante`
--

LOCK TABLES `ministrante` WRITE;
/*!40000 ALTER TABLE `ministrante` DISABLE KEYS */;
INSERT INTO `ministrante` VALUES (1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5);
/*!40000 ALTER TABLE `ministrante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cpf` varchar(11) DEFAULT NULL,
  `datanascimento` date DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `endereco` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (20,'João da Silva','85746366600','1995-08-15','69948583727','Av 04'),(21,'Maria Santos','34523526536','1998-03-20','23435797879','Rua L'),(22,'André Oliveira','63456456745','2000-11-05','23894579237','Rua P'),(23,'Juliana Pereira','34523534566','1997-07-02','34563456346','Av C'),(24,'Pedro Carvalho','65345634666','1999-01-25','43563409868','Av K'),(25,'Larissa Silva Moreira','34451567754','1996-09-10','34436346345','Rua 06'),(26,'Carlos Oliveira','35634645677','1994-05-08','23452345355','Av 01'),(27,'Fernanda Santos','34934983289','2001-12-30','23452345677','Rua B'),(28,'Rafaela Almeida','38753745775','1993-04-15','35774332333','Av D'),(29,'Fabricio Guedes','24577557575','1994-08-08','34563645778','Rua L'),(30,'Manuela Oliveira','95438248533','2001-10-08','69483725555','Rua X'),(31,'Gabriel Monteiro','95847382788','1999-04-23','68574837777','Av. 07'),(32,'Barbara Santos','86747382734','1999-05-02','57948374544','Av.70'),(37,'Barbara Lima','85768444422','1998-10-10','68444453422','R. M');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professor` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `codigopessoa` int(11) NOT NULL,
  `numerofuncionario` varchar(9) DEFAULT NULL,
  `datacontratacao` date DEFAULT NULL,
  `dedicacaoexclusiva` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `professor_FK` (`codigopessoa`),
  CONSTRAINT `professor_FK` FOREIGN KEY (`codigopessoa`) REFERENCES `pessoa` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES (11,20,'10001','2020-03-15',1),(12,21,'10002','2018-08-10',0),(13,22,'10003','2019-01-20',1),(14,23,'10004','2022-02-05',0),(15,24,'10005','2021-06-30',1);
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turma`
--

DROP TABLE IF EXISTS `turma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turma` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `codigocurso` int(11) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `datainicio` date DEFAULT NULL,
  `datafim` date DEFAULT NULL,
  `horario` varchar(50) DEFAULT NULL,
  `local` varchar(100) DEFAULT NULL,
  `status` enum('ativo','inativo') DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turma`
--

LOCK TABLES `turma` WRITE;
/*!40000 ALTER TABLE `turma` DISABLE KEYS */;
INSERT INTO `turma` VALUES (3,3,'Matutina','2023-02-01','2023-06-30','8:00 as 12:00','Sala 101','ativo'),(4,3,'Noturna','2023-02-01','2023-06-30','18:00 as 22:00','Sala 201','ativo'),(5,3,'Vespertina','2023-02-01','2023-06-30','14:00 as 18:00','Sala 301','ativo'),(6,3,'Matutina','2023-02-01','2023-06-30','8:00 as 12:00','Sala 102','ativo'),(11,7,'Matutina','2023-02-01','2023-06-30','8:00 as 12:00','Sala 103','ativo');
/*!40000 ALTER TABLE `turma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'escola'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-18 12:26:51
