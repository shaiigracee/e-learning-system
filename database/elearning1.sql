-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 10, 2023 at 05:22 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elearning`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `managaAcademic_update` (IN `p_id` INT(30), IN `p_AC_id` INT(11), IN `p_sy` INT(150), IN `p_status` INT(5))   BEGIN
    DECLARE v_id INT;
    
    -- Update operation
    IF p_sy IS NOT NULL AND p_status IS NOT NULL  and p_AC_id IS NOT NULL THEN
        -- Check if the course exists
        SELECT ID INTO v_id FROM academic_year WHERE id = p_id;
        
        IF v_id IS NOT NULL THEN
            -- Update the existing course
            UPDATE academic_year SET sy = p_sy, status = p_status ,academic_year_id= p_AC_id WHERE id = p_id;
            SELECT 'Academic Year Updated Successfully' AS msg;
        ELSE
            SELECT 'Academic Year does not exist. Use INSERT for new courses.' AS msg;
        END IF;
    END IF;
    
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageAcademic_delete` (IN `p_id` INT(30))   BEGIN

DELETE FROM academic_year
WHERE id = p_id;

SELECT "Deleted Successfully" AS message;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageAcademic_insert` (IN `p_id` INT(30), IN `p_sy` VARCHAR(150), IN `p_status` INT(5))   BEGIN
    DECLARE v_id INT;
    
 
-- Insert operation
    IF p_sy IS NOT NULL AND p_status IS NOT NULL THEN
        IF v_id IS NULL THEN
            -- Insert the new course
            INSERT INTO academic_year (id,sy,status) VALUES (p_id, p_sy, p_status);
            SELECT 'Academic Year Added Successfully' AS msg;
        END IF;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageClass_delete` (IN `p_id` INT(11))   BEGIN

DELETE FROM class
WHERE id = p_id;

SELECT "Deleted Successfully" AS message;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageClass_insert` (IN `p_id` INT(11), IN `p_class_id` INT(11), IN `p_course` VARCHAR(255), IN `p_department` VARCHAR(255), IN `p_level` VARCHAR(255), IN `p_section` VARCHAR(50))   BEGIN
    DECLARE v_id INT;
    
 
-- Insert operation
    IF p_course IS NOT NULL AND p_department IS NOT NULL AND p_level IS NOT NULL AND p_section IS NOT NULL THEN
        IF v_id IS NULL THEN
            -- Insert the new class
            INSERT INTO class (id,class_id,course_id,department_id, level, section)
            VALUES (p_id, p_class_id, p_course, p_department, p_level, p_section);
            SELECT 'Class Added Successfully' AS msg;
        END IF;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageClass_update` (IN `p_id` INT(11), IN `p_class_id` INT(11), IN `p_course` INT(255), IN `p_department` INT(255), IN `p_level` INT(255), IN `p_section` VARCHAR(50))   BEGIN
    DECLARE v_id INT;
    
    -- Update operation
    IF p_course IS NOT NULL AND p_department IS NOT NULL AND p_level IS NOT NULL AND p_section IS NOT NULL THEN
        
        -- Check if the course exists
        SELECT ID INTO v_id FROM class WHERE id = p_id;
        
        IF v_id IS NOT NULL THEN
            -- Update the existing course
            UPDATE class SET course_id= p_course, department_id = p_department ,class_id= p_id , level = p_level , section= p_section WHERE id = p_id;
            SELECT 'Class Updated Successfully' AS msg;
        ELSE
            SELECT 'Class does not exist. Use INSERT for new courses.' AS msg;
        END IF;
    END IF;
    
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageCourse_delete` (IN `p_id` INT(11))   BEGIN

DELETE FROM course
WHERE id = p_id;

SELECT "Deleted Successfully" AS message;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageCourse_insert` (IN `p_id` INT(11), IN `p_courseID` INT(11), IN `p_courseName` VARCHAR(255), IN `p_courseDescription` VARCHAR(255))   BEGIN
    DECLARE v_id INT;
    
 
-- Insert operation
    IF p_courseID IS NOT NULL AND p_courseName IS NOT NULL AND p_courseDescription IS NOT NULL THEN
        IF v_id IS NULL THEN
            -- Insert the new course
            INSERT INTO course (id, course_id, course, description) VALUES (p_id, p_courseID, p_courseName, p_courseDescription);
            SELECT 'Course Added Successfully' AS msg;
        END IF;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageCourse_update` (IN `p_id` INT(11), IN `p_courseID` INT(11), IN `p_courseName` VARCHAR(255), IN `p_courseDescription` VARCHAR(255))   BEGIN
    DECLARE v_id INT;
    
    -- Update operation
    IF p_courseID IS NOT NULL AND p_courseName IS NOT NULL AND p_courseDescription IS NOT NULL THEN
        -- Check if the course exists
        SELECT ID INTO v_id FROM course WHERE id = p_id;
        
        IF v_id IS NOT NULL THEN
            -- Update the existing course
            UPDATE course SET course_id = p_courseID, course = p_courseName, description = p_courseDescription WHERE id = p_id;
            SELECT 'Course Updated Successfully' AS msg;
        ELSE
            SELECT 'Course ID does not exist. Use INSERT for new courses.' AS msg;
        END IF;
    END IF;
    
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageDepartment_delete` (IN `p_id` INT(11))   BEGIN

DELETE FROM department
WHERE id = p_id;

SELECT "Deleted Successfully" AS message;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageDepartment_insert` (IN `p_id` INT(11), IN `p_DepartmentID` INT(11), IN `p_departmentName` VARCHAR(255), IN `p_departmentDescription` VARCHAR(255))   BEGIN
    DECLARE v_id INT;
    
 
-- Insert operation
    IF p_DepartmentID IS NOT NULL AND p_departmentName IS NOT NULL AND p_departmentDescription IS NOT NULL THEN
        IF v_id IS NULL THEN
            -- Insert the new course
            INSERT INTO department (id, department_id, department, description) VALUES (p_id, p_DepartmentID,p_departmentName, p_departmentDescription);
            SELECT 'Department Added Successfully' AS msg;
        END IF;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageDepartment_update` (IN `p_id` INT(11), IN `p_DepartmentID` INT(11), IN `p_departmentName` INT(250), IN `p_departmentDescription` VARCHAR(250))   BEGIN
DECLARE v_id int;

IF p_DepartmentID IS NOT NULL AND p_departmentName IS NOT NULL AND p_departmentDescription IS NOT NULL THEN
       
          SELECT ID INTO v_id FROM department WHERE id = p_id;
            IF v_id IS NOT NULL THEN
            -- Update the existing course
            UPDATE department SET department_id = p_DepartmentID, department = p_departmentName, 
            description = p_departmentDescription WHERE id = p_id;
            
            SELECT 'Department Updated Successfully' AS msg;
        ELSE
            SELECT 'Department ID does not exist. Use INSERT for new courses.' AS msg;
        END IF;
    END IF;   
   END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageSubject_delete` (IN `p_id` INT(11))   BEGIN

DELETE FROM subjects
WHERE id = p_id;

SELECT "Deleted Successfully" AS message;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageSubject_insert` (IN `p_id` INT(11), IN `p_subjectID` INT(11), IN `p_subject_code` VARCHAR(255), IN `p_subjectDescription` VARCHAR(255))   BEGIN
    DECLARE v_id INT;
    
 
-- Insert operation
    IF p_subjectID IS NOT NULL AND p_subject_code IS NOT NULL AND p_subjectDescription IS NOT NULL THEN
        IF v_id IS NULL THEN
            -- Insert the new course
            INSERT INTO subjects (id, subject_id, subject_code, description) VALUES (p_id, p_subjectID, 
                                 p_subject_code, p_subjectDescription);
            SELECT 'Subject Added Successfully' AS msg;
        END IF;
    END IF;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageSubject_update` (IN `p_id` INT(11), IN `p_subjectID` INT(11), IN `p_subject_code` VARCHAR(250), IN `p_subjectDescription` INT)   BEGIN
    DECLARE v_id INT;
    
 
-- Insert operation
    IF p_subjectID IS NOT NULL AND p_subject_code IS NOT NULL AND p_subjectDescription IS NOT NULL THEN
         SELECT ID INTO v_id FROM subjects WHERE id = p_id;
            IF v_id IS NOT NULL THEN
            -- Update the existing course
            UPDATE subjects SET subject_id = p_subjectID, subject_code = p_subject_code, 
            description = p_subjectDescription WHERE id = p_id;
            
            SELECT 'Subject Updated Successfully' AS msg;
        ELSE
            SELECT 'Subject ID does not exist. Use INSERT for new courses.' AS msg;
        END IF;
    END IF;   
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `academic_year`
--

CREATE TABLE `academic_year` (
  `id` int(30) NOT NULL,
  `academic_year_id` int(11) NOT NULL,
  `sy` varchar(150) NOT NULL,
  `status` tinyint(5) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `academic_year`
--

INSERT INTO `academic_year` (`id`, `academic_year_id`, `sy`, `status`) VALUES
(1, 1, '2021-2025', 1);

-- --------------------------------------------------------

--
-- Table structure for table `backup_class`
--

CREATE TABLE `backup_class` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `department_id` int(30) NOT NULL,
  `course_id` int(30) NOT NULL,
  `level` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_class`
--

INSERT INTO `backup_class` (`id`, `class_id`, `department_id`, `course_id`, `level`, `section`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '3', 'A', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(2, 2, 2, 1, '3', 'B', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(3, 3, 0, 0, '', '', '2023-12-08 07:28:47', '2023-12-08 07:28:47');

-- --------------------------------------------------------

--
-- Table structure for table `backup_course`
--

CREATE TABLE `backup_course` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `course` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_course`
--

INSERT INTO `backup_course` (`id`, `course_id`, `course`, `description`, `date_added`, `date_updated`) VALUES
(1, 1, 'BSIS', 'BS INFORMATION SYSTEM', '2023-12-03 08:08:50', '2023-12-03 08:45:14'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCE', '2023-12-03 06:23:11', '2023-12-03 06:21:44'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY', '2023-12-03 06:23:11', '2023-12-03 06:22:00'),
(4, 4, 'BSEMC', 'BS ENTERTAINMENT AND MULTIMEDIA COMPUTING', '2023-12-03 06:23:11', '2023-12-03 06:22:29'),
(5, 5, 'BSE', 'BS EDUCATION MAJOR IN ENGLISHS', '2023-12-08 07:25:53', '2023-12-08 07:26:11'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY1', '2023-12-03 06:23:11', '2023-12-08 08:08:49'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY2', '2023-12-03 06:23:11', '2023-12-08 08:09:10'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY', '2023-12-03 06:23:11', '2023-12-08 08:26:28'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCED', '2023-12-03 06:23:11', '2023-12-08 12:26:52'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCES', '2023-12-03 06:23:11', '2023-12-08 12:26:58'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCE', '2023-12-03 06:23:11', '2023-12-08 15:51:59'),
(0, 0, 'TEST2', 'HELLO WORLD1', '2023-12-09 02:21:18', '2023-12-09 02:22:18'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCES', '2023-12-03 06:23:11', '2023-12-09 12:32:10'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCE\r\n', '2023-12-03 06:23:11', '2023-12-09 12:32:20'),
(5, 5, 'BSE', 'BS EDUCATION MAJOR IN ENGLISH', '2023-12-08 07:25:53', '2023-12-09 13:01:58'),
(14, 0, 'PE', 'PHYSICAL EDUCATIONS', '2023-12-09 13:00:48', '2023-12-09 13:03:49'),
(15, 0, 'PE', 'PHYSICAL EDUCATIONSSSSSS', '2023-12-09 14:22:33', '2023-12-09 14:25:09'),
(15, 0, 'PE', 'PHYSICAL EDUCATION', '2023-12-09 14:22:33', '2023-12-09 14:32:53'),
(16, 0, 'GEE', 'CONTEMPORARY WORLDS', '2023-12-09 14:33:57', '2023-12-09 14:35:48'),
(15, 0, 'PEE', 'PHYSICAL EDUCATION', '2023-12-09 14:22:33', '2023-12-09 15:49:49'),
(15, 0, 'PEE', 'PHYSICAL EDUCATIONS', '2023-12-09 14:22:33', '2023-12-09 15:50:19'),
(18, 18, 'BSEE', 'TESTERS', '2023-12-10 15:08:36', '2023-12-10 15:08:55'),
(19, 0, 'BSIIT', 'TESTEReros', '2023-12-10 15:13:30', '2023-12-10 15:14:56');

-- --------------------------------------------------------

--
-- Table structure for table `backup_department`
--

CREATE TABLE `backup_department` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `department` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_department`
--

INSERT INTO `backup_department` (`id`, `department_id`, `department`, `description`, `date_added`, `date_updated`) VALUES
(1, 1, 'COE', 'COLLEGE OF EDUCATION', '2023-12-03 07:36:56', '2023-12-09 14:52:28'),
(2, 2, 'CSD', 'COMPUTER STUDIES DEPARTMENT\r\n', '2023-12-03 07:37:14', '2023-12-03 07:37:14'),
(6, 0, 'COCOMELON', 'TESTs\r\n', '2023-12-09 16:29:51', '2023-12-09 16:30:09');

-- --------------------------------------------------------

--
-- Table structure for table `backup_faculty`
--

CREATE TABLE `backup_faculty` (
  `id` int(11) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `department_id` int(30) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `middlename` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `email` varchar(250) NOT NULL,
  `contact` varchar(150) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `address` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `dob` int(11) NOT NULL,
  `avatar` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_faculty`
--

INSERT INTO `backup_faculty` (`id`, `faculty_id`, `department_id`, `firstname`, `middlename`, `lastname`, `email`, `contact`, `gender`, `address`, `password`, `dob`, `avatar`, `date_added`, `date_updated`) VALUES
(2, 'F1', 2, 'Andres', '', 'Bonifacio', 'bonifacioandres@abc.com', '09349318870', 'Male', 'Caloocan, Philippines', '3f3a08abc22c2dfa7bf283051c4b12aa', 1980, 'uploads/Favatar_2.png', '2023-12-03 06:28:10', '2023-12-03 06:28:10'),
(3, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', '6f49357f65f8d9add180c78720eb0cb6', 1970, 'uploads/Favatar_3.png', '2023-12-03 06:35:08', '2023-12-03 06:35:08'),
(1, 'F3', 1, 'Leonor', '', 'Rivera', 'leonor@rivera.abc', '09213391313', 'Female', 'Pasig, Philippines', 'password123', 1989, 'uploads/Favatar_1.png', '2023-12-03 06:25:48', '2023-12-03 06:25:48');

-- --------------------------------------------------------

--
-- Table structure for table `backup_students`
--

CREATE TABLE `backup_students` (
  `id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `middlename` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `email` varchar(250) NOT NULL,
  `contact` varchar(150) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `address` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `dob` int(11) NOT NULL,
  `avatar` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_students`
--

INSERT INTO `backup_students` (`id`, `student_id`, `firstname`, `middlename`, `lastname`, `email`, `contact`, `gender`, `address`, `password`, `dob`, `avatar`, `date_added`, `date_updated`) VALUES
(1, 'S2', 'Anya', '', 'Forger', 'spywars@xyz.com', '09338226692', 'Female', 'Makati, Philippines', 'password123', 1970, 'uploads/uvatar_1.jpg', '2023-12-03 11:32:13', '2023-12-03 11:31:54'),
(3, 'S3', 'Damian', '', 'Desmond', 'desmond@abc.com', '09123456894', 'Male', '', NULL, 2000, 'uploads/uvatar_3.jpg', '2023-12-03 11:38:46', '2023-12-03 11:38:14');

-- --------------------------------------------------------

--
-- Table structure for table `backup_subjects`
--

CREATE TABLE `backup_subjects` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `subject_code` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_subjects`
--

INSERT INTO `backup_subjects` (`id`, `subject_id`, `subject_code`, `description`, `date_added`, `date_updated`) VALUES
(0, 0, 'CCS 001', 'TECHNICAL COMPUTER CONCEPTS', '2023-12-08 10:11:27', '2023-12-08 10:11:27'),
(1, 1, 'IS 102', 'ENTERPRISE RESOURCE PLANNING', '2023-12-02 22:11:23', '2023-12-02 22:11:23'),
(2, 2, 'IS 103', 'DATABASE SYSTEMS ENTERPRISE', '2023-12-02 22:12:04', '2023-12-02 22:12:04'),
(3, 3, 'IS 104', 'IS INNOVATIONS & NEW TECHNOLOGIES', '2023-12-02 22:12:37', '2023-12-02 22:12:37'),
(4, 4, 'IS 105', 'ENTERPRISE ARCHITECTURE\r\n', '2023-12-02 22:13:05', '2023-12-02 22:13:05'),
(5, 5, 'IS 106', 'IS MAJOR ELECTIVE 1', '2023-12-02 22:13:26', '2023-12-02 22:13:26'),
(6, 6, 'CCS 118', 'MULTIMEDIA SYSTEMS', '2023-12-02 22:13:39', '2023-12-02 22:13:39'),
(7, 7, 'RES 001', 'METHODS OF RESEARCH', '2023-12-03 00:30:13', '2023-12-03 00:30:13'),
(7, 7, 'RES 001', 'METHODS OF RESEARCHS', '2023-12-03 00:30:13', '2023-12-08 10:13:54'),
(7, 7, 'RES 001', 'METHODS OF RESEARCH', '2023-12-03 00:30:13', '2023-12-08 10:14:19'),
(7, 7, 'RES 001', 'METHODS OF RESEARCHS', '2023-12-03 00:30:13', '2023-12-09 15:17:36'),
(8, 0, 'MMA', 'TESTS\r\n', '2023-12-09 15:27:32', '2023-12-09 15:27:49'),
(8, 0, 'MaMA', 'TESTS\r\n', '2023-12-09 15:27:32', '2023-12-09 15:49:16');

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `department_id` int(30) NOT NULL,
  `course_id` int(30) NOT NULL,
  `level` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `class_id`, `department_id`, `course_id`, `level`, `section`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '3', 'A', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(2, 2, 2, 1, '3', 'B', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(7, 0, 2, 3, '4', 'E', '2023-12-10 16:19:33', '2023-12-10 16:19:33');

--
-- Triggers `class`
--
DELIMITER $$
CREATE TRIGGER `backup_data_class` AFTER UPDATE ON `class` FOR EACH ROW BEGIN
  INSERT INTO `class` (
    `id`, 
    `class_id`, 
    `department_id`, 
    `course_id`, 
    `level`, 
    `section`, 
    `created_at`, 
    `updated_at`
  ) VALUES (
    NEW.`class_id`, 
    NEW.`department_id`, 
    NEW.`course_id`, 
    NEW.`level`, 
    NEW.`section`, 
    NEW.`created_at`, 
    NEW.`updated_at`
  );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `class_after_update` AFTER UPDATE ON `class` FOR EACH ROW BEGIN
  INSERT INTO `backup_data_class` (
    `id`, 
    `class_id`, 
    `department_id`, 
    `course_id`, 
    `level`, 
    `section`, 
    `created_at`, 
    `updated_at`
  ) VALUES (
    NEW.`class_id`, 
    NEW.`department_id`, 
    NEW.`course_id`, 
    NEW.`level`, 
    NEW.`section`, 
    NEW.`created_at`, 
    NEW.`updated_at`
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `class_information`
-- (See below for the actual view)
--
CREATE TABLE `class_information` (
`level` varchar(50)
,`section` varchar(50)
,`course` varchar(250)
,`subject_description` text
);

-- --------------------------------------------------------

--
-- Table structure for table `class_subjects`
--

CREATE TABLE `class_subjects` (
  `academic_year_id` int(30) NOT NULL,
  `class_id` int(30) NOT NULL,
  `subject_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_subjects`
--

INSERT INTO `class_subjects` (`academic_year_id`, `class_id`, `subject_id`) VALUES
(1, 1, 1),
(1, 1, 2),
(1, 2, 1),
(1, 2, 2),
(2, 1, 1),
(2, 2, 2),
(1, 4, 3),
(1, 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `class_subjects_faculty`
--

CREATE TABLE `class_subjects_faculty` (
  `academic_year_id` int(30) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `class_id` int(30) NOT NULL,
  `subject_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_subjects_faculty`
--

INSERT INTO `class_subjects_faculty` (`academic_year_id`, `faculty_id`, `class_id`, `subject_id`) VALUES
(1, '12345', 1, 1),
(1, '12345', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `course` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `course_id`, `course`, `description`, `date_added`, `date_updated`) VALUES
(1, 1, 'BSIS', 'BS INFORMATION SYSTEM', '2023-12-03 08:08:50', '2023-12-03 08:45:14'),
(2, 2, 'BSCS', 'BS COMPUTER SCIENCE\r\n', '2023-12-03 06:23:11', '2023-12-09 12:32:20'),
(3, 3, 'BSIT', 'BS INFORMATION TECHNOLOGY', '2023-12-03 06:23:11', '2023-12-08 08:26:28'),
(4, 4, 'BSEMC', 'BS ENTERTAINMENT AND MULTIMEDIA COMPUTING', '2023-12-03 06:23:11', '2023-12-08 07:24:48'),
(5, 5, 'BSE', 'BS EDUCATION MAJOR IN ENGLISH', '2023-12-08 07:25:53', '2023-12-09 13:01:58'),
(19, 0, 'BSIIT', 'TESTEReros', '2023-12-10 15:13:30', '2023-12-10 15:14:56');

--
-- Triggers `course`
--
DELIMITER $$
CREATE TRIGGER `backup_data_course` AFTER UPDATE ON `course` FOR EACH ROW INSERT INTO backup_course (id, course_id, course, description, date_added, date_updated)
VALUES (NEW.id, NEW.course_id, NEW.course, NEW.description, NEW.date_added, NEW.date_updated)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `course_uppercase` BEFORE INSERT ON `course` FOR EACH ROW BEGIN
    SET NEW.course = UPPER(NEW.course);
    SET NEW.description = UPPER(NEW.description);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `department` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `department_id`, `department`, `description`, `date_added`, `date_updated`) VALUES
(1, 1, 'COE', 'COLLEGE OF EDUCATION', '2023-12-03 07:36:56', '2023-12-09 14:52:28'),
(2, 2, 'CSD', 'COMPUTER STUDIES DEPARTMENT\r\n', '2023-12-03 07:37:14', '2023-12-03 07:37:14');

--
-- Triggers `department`
--
DELIMITER $$
CREATE TRIGGER `backup_data_department` AFTER UPDATE ON `department` FOR EACH ROW BEGIN
  INSERT INTO backup_department (id, department_id, department, description, date_added, date_updated)
  VALUES (NEW.id, NEW.department_id, NEW.department, NEW.description, NEW.date_added, NEW.date_updated);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `department_uppercase` BEFORE INSERT ON `department` FOR EACH ROW BEGIN
    SET NEW.department = UPPER(NEW.department);
    SET NEW.description = UPPER(NEW.description);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `id` int(11) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `department_id` int(30) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `middlename` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `email` varchar(250) NOT NULL,
  `contact` varchar(150) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `address` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `dob` int(11) NOT NULL,
  `avatar` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`id`, `faculty_id`, `department_id`, `firstname`, `middlename`, `lastname`, `email`, `contact`, `gender`, `address`, `password`, `dob`, `avatar`, `date_added`, `date_updated`) VALUES
(1, 'F3', 1, 'Leonor', '', 'Rivera', 'leonor@rivera.abc', '09213391313', 'Female', 'Pasig, Philippines', 'password123', 1989, 'uploads/Favatar_1.png', '2023-12-03 06:25:48', '2023-12-03 06:25:48'),
(2, 'F1', 2, 'Andres', '', 'Bonifacio', 'bonifacioandres@abc.com', '09349318870', 'Male', 'Caloocan, Philippines', '3f3a08abc22c2dfa7bf283051c4b12aa', 1980, 'uploads/Favatar_2.png', '2023-12-03 06:28:10', '2023-12-03 06:28:10'),
(3, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', '6f49357f65f8d9add180c78720eb0cb6', 1970, 'uploads/Favatar_3.png', '2023-12-03 06:35:08', '2023-12-03 06:35:08');

--
-- Triggers `faculty`
--
DELIMITER $$
CREATE TRIGGER `backup_data_faculty` AFTER UPDATE ON `faculty` FOR EACH ROW BEGIN
INSERT INTO backup_faculty (id, faculty_id, department_id, firstname, middlename, lastname, email, contact, gender, address, password, dob, avatar, date_added, date_updated) VALUES (NEW.id, NEW.faculty_id, NEW.department_id, NEW.firstname, NEW.middlename, NEW.lastname, NEW.email, NEW.contact, NEW.gender, NEW.address, NEW.password, NEW.dob, NEW.avatar, NEW.date_added, NEW.date_updated); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `id` int(30) NOT NULL,
  `academic_year_id` int(30) NOT NULL,
  `subject_id` int(30) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `ppt_path` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `academic_year_id`, `subject_id`, `faculty_id`, `title`, `description`, `ppt_path`, `date_added`, `date_updated`) VALUES
(1, 1, 2, '12345', 'Lesson 101 Test', '&lt;h2 style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot; open=&quot;&quot; sans&quot;,=&quot;&quot; arial,=&quot;&quot; sans-serif;&quot;=&quot;&quot;&gt;&lt;b&gt;Sample Heading 1&lt;/b&gt;&lt;/h2&gt;&lt;h2 style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot; open=&quot;&quot; sans&quot;,=&quot;&quot; arial,=&quot;&quot; sans-serif;&quot;=&quot;&quot;&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; font-size: 14px;&quot;&gt;Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed enim ipsum, rutrum eu erat sed, lacinia hendrerit sapien. Ut viverra dapibus velit nec pellentesque. Morbi ac gravida tortor. Curabitur scelerisque nisl metus. Fusce diam dui, feugiat vel congue a, convallis pulvinar dui. Donec ut felis vel dolor vehicula tincidunt vitae id nibh. Mauris mollis leo pulvinar vehicula sagittis. Sed bibendum arcu at eros imperdiet pellentesque non non orci. Etiam accumsan pulvinar egestas. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Curabitur nec odio nec quam ultrices facilisis. Nam tempor a neque dapibus lacinia. Etiam porttitor at urna sed pellentesque. Phasellus rhoncus mi at lobortis semper. Vivamus tempus urna nec sagittis vehicula. Nam sagittis velit nec quam molestie volutpat quis et ex.&lt;/p&gt;&lt;/h2&gt;&lt;h2&gt;&lt;b&gt;Sample Heading 2&lt;/b&gt;&lt;/h2&gt;&lt;h2&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; font-size: 14px;&quot;&gt;Sed in imperdiet nisi, non ultrices lectus. Donec auctor, ante sed vestibulum cursus, ex neque scelerisque augue, a faucibus libero lectus eu mauris. Morbi ac quam non felis malesuada lacinia vel laoreet tortor. Proin euismod risus sit amet scelerisque imperdiet. Phasellus ut neque mollis, porttitor velit a, congue libero. Ut cursus accumsan lectus, vitae congue mi pellentesque vitae. Integer pulvinar accumsan dignissim. Proin bibendum dapibus risus at accumsan. Donec a sapien sed arcu malesuada maximus. Integer eu feugiat eros.&lt;/p&gt;&lt;/h2&gt;', 'uploads/slides/lesson_1', '2023-12-03 05:51:18', '2023-12-03 05:51:18'),
(2, 1, 1, '12345', 'Sample 101', '&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif;&quot;&gt;Aliquam dictum ante at dapibus luctus. Maecenas semper pulvinar congue. Pellentesque semper, velit eget auctor euismod, ante sem vulputate augue, ut volutpat felis lorem nec ex. Praesent non porttitor nunc, non ullamcorper est. Donec eu arcu viverra augue tristique fermentum. Duis scelerisque bibendum augue, id laoreet massa tempor eu. Vivamus nec ante est. Fusce eu lacus sapien. Sed viverra lorem nec ante consequat tempor. Quisque ligula dolor, feugiat nec ligula porttitor, fermentum lacinia augue. Morbi fringilla vitae massa vitae tempus. Etiam ut vehicula lectus. Fusce cursus dolor vel dignissim volutpat. Etiam iaculis, justo vel fermentum varius, sem turpis hendrerit nulla, eget dapibus neque urna vitae arcu.&lt;/p&gt;&lt;p style=&quot;margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &amp;quot;Open Sans&amp;quot;, Arial, sans-serif;&quot;&gt;Ut euismod tempor turpis, quis fringilla enim varius eget. Duis id neque blandit, vehicula purus eu, molestie dolor. Aliquam erat volutpat. Pellentesque quis dapibus elit. Curabitur ac lectus tortor. Phasellus et nibh nisl. Phasellus eu imperdiet nisi, tempor semper purus&lt;/p&gt;', 'uploads/slides/lesson_2', '2023-12-03 05:51:18', '2023-12-03 05:51:18'),
(3, 0, 0, '', 'History of Computer Science', NULL, NULL, '2023-12-03 17:07:13', '2023-12-03 17:07:13'),
(4, 0, 0, '', 'Web Development Basics', NULL, NULL, '2023-12-03 17:07:13', '2023-12-03 17:07:13'),
(5, 0, 0, '', 'Data Structures and Algorithms', NULL, NULL, '2023-12-03 17:07:13', '2023-12-03 17:07:13');

-- --------------------------------------------------------

--
-- Table structure for table `lesson_class`
--

CREATE TABLE `lesson_class` (
  `lesson_id` int(30) NOT NULL,
  `class_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lesson_class`
--

INSERT INTO `lesson_class` (`lesson_id`, `class_id`) VALUES
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(1, 1),
(1, 2),
(2, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `middlename` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `email` varchar(250) NOT NULL,
  `contact` varchar(150) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `address` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `dob` int(11) NOT NULL,
  `avatar` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `student_id`, `firstname`, `middlename`, `lastname`, `email`, `contact`, `gender`, `address`, `password`, `dob`, `avatar`, `date_added`, `date_updated`) VALUES
(1, 'S2', 'Anya', '', 'Forger', 'spywars@xyz.com', '09338226692', 'Female', 'Makati, Philippines', 'password123', 1970, 'uploads/uvatar_1.jpg', '2023-12-03 11:32:13', '2023-12-03 11:31:54'),
(3, 'S3', 'Damian', '', 'Desmond', 'desmond@abc.com', '09123456894', 'Male', '', NULL, 2000, 'uploads/uvatar_3.jpg', '2023-12-03 11:38:46', '2023-12-03 11:38:14');

--
-- Triggers `students`
--
DELIMITER $$
CREATE TRIGGER `backup_data_students` AFTER UPDATE ON `students` FOR EACH ROW BEGIN
INSERT INTO backup_students (id, student_id, firstname, middlename, lastname, email, contact, gender, address, password, avatar, date_added, date_updated) VALUES (NEW.id, NEW.student_id, NEW.firstname, NEW.middlename, NEW.lastname, NEW.email, NEW.contact, NEW.gender, NEW.address, NEW.password, NEW.avatar, NEW.date_added, NEW.date_updated); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `student_class`
--

CREATE TABLE `student_class` (
  `id` int(30) NOT NULL,
  `academic_year_id` int(30) NOT NULL,
  `student_id` int(30) NOT NULL,
  `class_id` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_class`
--

INSERT INTO `student_class` (`id`, `academic_year_id`, `student_id`, `class_id`) VALUES
(1, 1, 6231415, 1),
(2, 1, 0, 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_information`
-- (See below for the actual view)
--
CREATE TABLE `student_information` (
`student_firstname` varchar(150)
,`student_middlename` varchar(150)
,`student_lastname` varchar(150)
,`level` varchar(50)
,`section` varchar(50)
,`course` varchar(250)
,`course_description` text
);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `subject_code` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `subject_id`, `subject_code`, `description`, `date_added`, `date_updated`) VALUES
(1, 1, 'IS 102', 'ENTERPRISE RESOURCE PLANNING', '2023-12-02 22:11:23', '2023-12-02 22:11:23'),
(2, 2, 'IS 103', 'DATABASE SYSTEMS ENTERPRISE', '2023-12-02 22:12:04', '2023-12-02 22:12:04'),
(3, 3, 'IS 104', 'IS INNOVATIONS & NEW TECHNOLOGIES', '2023-12-02 22:12:37', '2023-12-02 22:12:37'),
(4, 4, 'IS 105', 'ENTERPRISE ARCHITECTURE\r\n', '2023-12-02 22:13:05', '2023-12-02 22:13:05'),
(5, 5, 'IS 106', 'IS MAJOR ELECTIVE 1', '2023-12-02 22:13:26', '2023-12-02 22:13:26'),
(6, 6, 'CCS 118', 'MULTIMEDIA SYSTEMS', '2023-12-02 22:13:39', '2023-12-02 22:13:39'),
(7, 7, 'RES 001', 'METHODS OF RESEARCHS', '2023-12-03 00:30:13', '2023-12-09 15:17:36');

--
-- Triggers `subjects`
--
DELIMITER $$
CREATE TRIGGER `backup_data_subjects` AFTER UPDATE ON `subjects` FOR EACH ROW BEGIN
  INSERT INTO backup_subjects (id, subject_id, subject_code, description, date_added, date_updated)
  VALUES (NEW.id, NEW.subject_id, NEW.subject_code, NEW.description, NEW.date_added, NEW.date_updated);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `subject_uppercase` BEFORE INSERT ON `subjects` FOR EACH ROW BEGIN
    SET NEW.subject_code = UPPER(NEW.subject_code);
    SET NEW.description = UPPER(NEW.description);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `system_info`
--

CREATE TABLE `system_info` (
  `id` int(30) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Academy LMS'),
(2, 'address', 'Philippines'),
(3, 'contact', '+1234567890'),
(4, 'email', 'info@sample.com'),
(6, 'short_name', 'ALMS'),
(9, 'logo', 'uploads/1701570840_logo.png');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(50) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `lastname` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `avatar` text DEFAULT NULL,
  `last_login` datetime DEFAULT current_timestamp(),
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `username`, `password`, `avatar`, `last_login`, `date_added`, `date_updated`) VALUES
(1, 'John', 'Smith', 'admin', '0192023a7bbd73250516f069df18b500', 'uploads/1619140500_avatar.png', NULL, '2021-01-20 06:02:37', '2023-12-03 01:31:45'),
(2, 'Sherlock', 'Holmes', 'admin2', '482c811da5d5b4bc6d497ffa98491e38', 'uploads/1701570840_uavatar2.png', NULL, '2023-12-03 01:23:55', '2023-12-03 02:34:29'),
(4, 'Hello', 'World', 'faculty1', 'password123', NULL, NULL, '2023-12-04 01:22:43', '2023-12-04 01:22:43');

-- --------------------------------------------------------

--
-- Structure for view `class_information`
--
DROP TABLE IF EXISTS `class_information`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `class_information`  AS SELECT `c`.`level` AS `level`, `c`.`section` AS `section`, `co`.`course` AS `course`, `s`.`description` AS `subject_description` FROM ((`class` `c` join `course` `co` on(`c`.`course_id` = `co`.`course_id`)) join `subjects` `s` on(`co`.`course_id` = `s`.`subject_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `student_information`
--
DROP TABLE IF EXISTS `student_information`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_information`  AS SELECT `students`.`firstname` AS `student_firstname`, `students`.`middlename` AS `student_middlename`, `students`.`lastname` AS `student_lastname`, `class`.`level` AS `level`, `class`.`section` AS `section`, `course`.`course` AS `course`, `course`.`description` AS `course_description` FROM (((`students` join `student_class` on(`students`.`student_id` = `student_class`.`student_id`)) join `class` on(`student_class`.`class_id` = `class`.`class_id`)) join `course` on(`class`.`course_id` = `course`.`course_id`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_year`
--
ALTER TABLE `academic_year`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `backup_department`
--
ALTER TABLE `backup_department`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `backup_faculty`
--
ALTER TABLE `backup_faculty`
  ADD UNIQUE KEY `faculty_info` (`firstname`,`lastname`,`email`,`contact`),
  ADD UNIQUE KEY `faculty_indexing` (`email`),
  ADD KEY `middlename` (`middlename`);

--
-- Indexes for table `backup_students`
--
ALTER TABLE `backup_students`
  ADD UNIQUE KEY `student_infos` (`firstname`,`middlename`,`lastname`,`email`,`contact`) USING HASH;

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `department_indexing` (`department`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `faculty_info` (`firstname`,`lastname`,`email`,`contact`),
  ADD UNIQUE KEY `faculty_indexing` (`email`),
  ADD KEY `middlename` (`middlename`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_infos` (`firstname`,`middlename`,`lastname`,`email`,`contact`) USING HASH;

--
-- Indexes for table `student_class`
--
ALTER TABLE `student_class`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subject_indexing` (`subject_code`),
  ADD UNIQUE KEY `subjects_indexing` (`subject_code`,`description`) USING HASH;

--
-- Indexes for table `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_indexing` (`username`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_year`
--
ALTER TABLE `academic_year`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student_class`
--
ALTER TABLE `student_class`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `weekly_insert_subjects` ON SCHEDULE EVERY 1 WEEK STARTS '2023-12-04 01:07:13' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    INSERT INTO subjects (subject_code, description)
    VALUES ('CCS 101', 'History of Computer Scienc'),
           ('GEE 105', 'Web Development Basics'),
           ('CCS 107', 'Data Structures and Algorithms');
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
