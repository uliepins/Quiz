-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 10, 2018 at 10:35 PM
-- Server version: 10.0.36-MariaDB-0ubuntu0.16.04.1
-- PHP Version: 7.0.30-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `c1Quiz`
--

-- --------------------------------------------------------

--
-- Table structure for table `Answers`
--

CREATE TABLE `Answers` (
  `QuestionID` int(10) NOT NULL,
  `AnswerLetter` varchar(10) CHARACTER SET utf8 COLLATE utf8_latvian_ci NOT NULL,
  `Answer` varchar(100) CHARACTER SET utf8 COLLATE utf8_latvian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Answers`
--

INSERT INTO `Answers` (`QuestionID`, `AnswerLetter`, `Answer`) VALUES
(1, 'A', 'Daugava'),
(1, 'B', 'Lielupe'),
(1, 'C', 'Gauja'),
(1, 'C', 'Irbe'),
(2, 'A', 'Valmiera'),
(2, 'B', 'Daugavpils'),
(2, 'C', 'Rīga'),
(2, 'D', 'Liepāja'),
(2, 'E', 'Smiltene'),
(2, 'F', 'Cēsis'),
(3, 'A', 'Kārlis Zāle'),
(3, 'B', 'Jāzeps Vītols'),
(3, 'C', 'Baumaņu Kārlis'),
(3, 'D', 'Krišjānis Barons'),
(4, 'A', 'Mākoņkalns'),
(4, 'B', 'Gaiziņkalns'),
(4, 'C', 'Zilaiskalns'),
(5, 'A', 'Latvijas dzimšanas dienu'),
(5, 'B', 'Neatkarības deklarācijas pasludināšanas dienu'),
(5, 'C', 'Mātes dienu'),
(5, 'D', 'Vasaras sākumu'),
(6, 'A', 'Kārlis Zāle'),
(6, 'B', 'Baumaņu Kārlis'),
(6, 'C', 'Krišjānis Barons'),
(6, 'D', 'Rainis'),
(7, 'A', 'Lielupe'),
(7, 'B', 'Ogre'),
(7, 'C', 'Gauja'),
(7, 'D', 'Daugava'),
(7, 'E', 'Amata'),
(7, 'F', 'Abuls'),
(8, 'A', 'Jānis Čakste'),
(8, 'B', 'Guntis Ulmanis'),
(8, 'C', 'Andris Bērziņš'),
(9, 'A', 'Baltā jūra'),
(9, 'B', 'Sarkanā jūra'),
(9, 'C', 'Baltijas jūra'),
(9, 'D', 'Melnā jūra'),
(10, 'A', '1920. gadā'),
(10, 'B', '1918. gadā'),
(10, 'C', '1919. gadā'),
(10, 'D', '1921. gadā'),
(10, 'E', '1922. gadā'),
(10, 'F', '1923. gadā'),
(11, 'A', 'Ernests Gulbis'),
(11, 'B', 'Mairis Briedis'),
(11, 'C', 'Martins Dukurs'),
(11, 'D', 'Kristaps Porziņģis'),
(12, 'A', 'Līgo svētkus'),
(12, 'B', 'Latvijas dzimšanas dienu'),
(12, 'C', 'Lāčplēša dienu'),
(13, 'A', 'Alūksnes ezers'),
(13, 'B', 'Burtnieku ezers'),
(13, 'C', 'Drīdzis'),
(13, 'D', 'Alauksts'),
(13, 'E', 'Lubānas ezers');

-- --------------------------------------------------------

--
-- Table structure for table `CompletedTests`
--

CREATE TABLE `CompletedTests` (
  `UserName` varchar(30) CHARACTER SET utf8 COLLATE utf8_latvian_ci NOT NULL,
  `TestID` int(10) NOT NULL,
  `CorrectAnswers` int(10) NOT NULL,
  `TotalQuestions` int(10) NOT NULL,
  `DateCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Questions`
--

CREATE TABLE `Questions` (
  `QuestionID` int(10) NOT NULL,
  `TestID` int(10) NOT NULL,
  `Question` varchar(100) CHARACTER SET utf8 COLLATE utf8_latvian_ci NOT NULL,
  `CorrectAnswerLetter` varchar(10) CHARACTER SET utf8 COLLATE utf8_latvian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Questions`
--

INSERT INTO `Questions` (`QuestionID`, `TestID`, `Question`, `CorrectAnswerLetter`) VALUES
(1, 1, 'Kā sauc Latvijas lielāko upi?', 'A'),
(2, 1, 'Kā sauc Latvijas galvaspilsētu?', 'C'),
(3, 1, 'Kas ir Latvijas himnas autors?', 'C'),
(4, 1, 'Kā sauc Latvijas augstāko kalnu?', 'B'),
(5, 1, 'Ko svin 4. Maijā?', 'B'),
(6, 2, 'Nosauc Brīvības pieminekļa autoru!', 'A'),
(7, 2, 'Kā sauc Latvijas garāko upi?', 'C'),
(8, 2, 'Nosauc Latvijas pirmo prezidentu!', 'A'),
(9, 2, 'Kā sauc jūru, pie kuras atrodas Latvija?', 'C'),
(10, 3, 'Kurā gadā dibināta Latvijas valsts?', 'B'),
(11, 3, 'Nosauc Latvijas labāko skeletonistu!', 'C'),
(12, 3, 'Ko atzīmē 11. Novembrī?', 'C'),
(13, 3, 'Nosauc Latvijas dziļāko ezeru!', 'C');

-- --------------------------------------------------------

--
-- Table structure for table `Tests`
--

CREATE TABLE `Tests` (
  `TestID` int(10) NOT NULL,
  `TestName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Tests`
--

INSERT INTO `Tests` (`TestID`, `TestName`) VALUES
(1, 'Pirmais tests'),
(2, 'Otrais tests'),
(3, 'Trešais tests');

-- --------------------------------------------------------

--
-- Table structure for table `UserProgress`
--

CREATE TABLE `UserProgress` (
  `UserName` varchar(30) CHARACTER SET utf8 COLLATE utf8_latvian_ci NOT NULL,
  `TestID` int(10) NOT NULL,
  `QuestionID` int(10) NOT NULL,
  `UserAnswer` varchar(10) CHARACTER SET utf8 COLLATE utf8_latvian_ci NOT NULL,
  `DateCreated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Answers`
--
ALTER TABLE `Answers`
  ADD KEY `QuestionID` (`QuestionID`);

--
-- Indexes for table `CompletedTests`
--
ALTER TABLE `CompletedTests`
  ADD KEY `UserName` (`UserName`),
  ADD KEY `TestID` (`TestID`);

--
-- Indexes for table `Questions`
--
ALTER TABLE `Questions`
  ADD PRIMARY KEY (`QuestionID`),
  ADD UNIQUE KEY `QuestionID` (`QuestionID`),
  ADD KEY `TestID` (`TestID`);

--
-- Indexes for table `Tests`
--
ALTER TABLE `Tests`
  ADD PRIMARY KEY (`TestID`),
  ADD UNIQUE KEY `TestID` (`TestID`);

--
-- Indexes for table `UserProgress`
--
ALTER TABLE `UserProgress`
  ADD KEY `UserName` (`UserName`),
  ADD KEY `QuestionID` (`QuestionID`),
  ADD KEY `TestID` (`TestID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Questions`
--
ALTER TABLE `Questions`
  MODIFY `QuestionID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `Tests`
--
ALTER TABLE `Tests`
  MODIFY `TestID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Answers`
--
ALTER TABLE `Answers`
  ADD CONSTRAINT `Answers_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `Questions` (`QuestionID`);

--
-- Constraints for table `CompletedTests`
--
ALTER TABLE `CompletedTests`
  ADD CONSTRAINT `CompletedTests_ibfk_1` FOREIGN KEY (`TestID`) REFERENCES `Tests` (`TestID`);

--
-- Constraints for table `Questions`
--
ALTER TABLE `Questions`
  ADD CONSTRAINT `Questions_ibfk_1` FOREIGN KEY (`TestID`) REFERENCES `Tests` (`TestID`);

--
-- Constraints for table `UserProgress`
--
ALTER TABLE `UserProgress`
  ADD CONSTRAINT `UserProgress_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `Questions` (`QuestionID`),
  ADD CONSTRAINT `UserProgress_ibfk_2` FOREIGN KEY (`TestID`) REFERENCES `Tests` (`TestID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
