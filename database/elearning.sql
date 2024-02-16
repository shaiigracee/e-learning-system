-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 15, 2024 at 04:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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
CREATE DEFINER=`root`@`%` PROCEDURE `bindFacultyToClasses` (IN `p_faculty_id` INT, IN `p_academic_year_id` INT, IN `p_class_id` INT, IN `p_subject_id` INT)   BEGIN

-- INSERT THE DATA AFTER
INSERT INTO class_subjects_faculty(academic_year_id, faculty_id, class_id, subject_id)
VALUES (p_academic_year_id, p_faculty_id, p_class_id, p_subject_id);

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `bindSubjectsToClass` (IN `a_id` INT, IN `c_id` INT, IN `s_id` INT)   BEGIN

INSERT INTO class_subjects (
	class_id,
	academic_year_id,
	subject_id
) VALUES (
	c_id,
	a_id,
	s_id
);

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `deleteAllBindSubjectsToClass` (IN `a_id` INT, IN `c_id` INT)   BEGIN

DELETE FROM class_subjects WHERE academic_year_id = a_id AND class_id = c_id;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `deleteFacultyByID` (IN `p_id` INT(11))   BEGIN
	DELETE FROM faculty WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `deleteStudentByID` (IN `student_id` INT)   BEGIN
DELETE FROM students WHERE students.id = student_id;
DELETE FROM student_class WHERE student_class.student_id = student_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getAllClassByStudentID` (IN `student_id` VARCHAR(50))   BEGIN
SELECT * FROM student_class WHERE student_class.student_id = student_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getAllClasses` ()   BEGIN
SELECT c.*,d.department, CONCAT(co.course, ' ', c.level, '-',c.section) as class FROM class c inner join department d on d.id = c.department_id inner join course co on co.id = c.course_id order by d.department asc, CONCAT(co.course, ' ', c.level, '-',c.section) asc;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getAllClassSubjectBind` (IN `p_academic_year_id` INT(11), IN `p_class_id` INT(11))   BEGIN
	SELECT * FROM class_subjects WHERE academic_year_id = p_academic_year_id AND class_id = p_class_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getAllClassSubjectsByActiveAY` (IN `p_academic_year_id` INT(11))   BEGIN
	
	SELECT concat(cs.class_id, '_', cs.subject_id) as `id_merged`, concat(co.course,' ',c.level,'-',c.section,' [',s.subject_code,']') as subj 
	FROM class_subjects cs 
	INNER join class c on c.id = cs.class_id 
	INNER join subjects s on cs.subject_id = s.id 
	INNER join course co on co.id = c.course_id
	
	WHERE cs.academic_year_id = p_academic_year_id;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getAllCourses` ()   BEGIN

SELECT * FROM course;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getAllStudents` ()   BEGIN
SELECT 

`elearning`.`students`.`id` AS `id`,
    	`elearning`.`students`.`student_id` AS `student_id`,
        `elearning`.`students`.`firstname` AS `student_firstname`,
        `elearning`.`students`.`middlename` AS `student_middlename`,
        `elearning`.`students`.`lastname` AS `student_lastname`,
        `scb`.`level` AS `level`,
        `scb`.`section` AS `section`,
        `scb`.`course` AS `course`,
        `scb`.`description` AS `course_description`,
        `scb`.`academic_year_id` AS `academic_year_id`,
        CONCAT(`scb`.`course`, ' ', `scb`.`level`, ' ', `scb`.`section`) AS `class`

FROM students 
LEFT JOIN (
SELECT 
sc.id as `sc_id`,  
sc.student_id as `sc_student_id`, 
sc.class_id, 
sc.academic_year_id, 
class.course_id, 
class.`section`, 
class.`level`, 
class.department_id,
course.course,
course.description
FROM student_class sc 
LEFT JOIN class ON class.id = sc.class_id
LEFT JOIN course ON course.id = class.course_id
) as scb ON scb.sc_student_id = students.id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getAllSubjects` ()   BEGIN
SELECT * FROM subjects;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getDepartments` ()   BEGIN
SELECT * FROM department;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getFaculties` ()   BEGIN

SELECT CONCAT(faculty.lastname, ' ', faculty.firstname, ' ', faculty.middlename) as `faculty_name`, faculty.id as `id`, faculty.faculty_id, department.department, department.description, faculty.avatar FROM faculty INNER JOIN department ON department.id = faculty.department_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getFacultyByID` (IN `p_faculty_id` INT)   BEGIN
SELECT * FROM faculty WHERE id = p_faculty_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getFacultyClassBind` (IN `p_id` INT(11))   BEGIN
SELECT CONCAT(class_id,'_',subject_id) as class_subj FROM `class_subjects_faculty` where faculty_id = p_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `getStudentByID` (IN `student_id` INT)   BEGIN
SELECT * FROM students WHERE students.id = student_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `InsertStudentClass` (IN `academic_year_id_param` INT, IN `student_id_param` INT, IN `class_id_param` INT)   BEGIN
    INSERT INTO student_class (academic_year_id, student_id, class_id)
    VALUES (academic_year_id_param, student_id_param, class_id_param);
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `insert_faculty` (IN `p_faculty_id` VARCHAR(50), IN `p_department_id` INT, IN `p_firstname` VARCHAR(150), IN `p_middlename` VARCHAR(150), IN `p_lastname` VARCHAR(150), IN `p_email` VARCHAR(250), IN `p_contact` VARCHAR(150), IN `p_gender` VARCHAR(20), IN `p_address` TEXT, IN `p_password` TEXT, IN `p_dob` INT, IN `p_avatar` TEXT)   BEGIN
    INSERT INTO faculty (
        faculty_id, 
        department_id, 
        firstname, 
        middlename, 
        lastname, 
        email, 
        contact, 
        gender, 
        address, 
        password, 
        dob,
        avatar
    ) VALUES (
        p_faculty_id, 
        p_department_id, 
        p_firstname, 
        p_middlename, 
        p_lastname, 
        p_email, 
        p_contact, 
        p_gender, 
        p_address, 
        p_password, 
        p_dob,
        p_avatar
    );
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `managaAcademic_update` (IN `p_id` INT(30), IN `p_sy` TEXT, IN `p_status` INT(5))   BEGIN

UPDATE academic_year 
SET
  sy = p_sy,
  `status` = p_status
 
 WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageAcademic_delete` (IN `p_id` INT(30))   BEGIN
    DELETE
FROM
    academic_year
WHERE
    id = p_id ;
SELECT
    "Deleted Successfully" AS message ; END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageAcademic_insert` (IN `p_sy` TEXT, IN `p_status` INT)   BEGIN
    -- Insert the new academic year
    INSERT INTO academic_year (sy, `status`)
    VALUES (p_sy, p_status);

    -- Return success message
    SELECT 'Academic Year Added Successfully' AS msg;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageClass_delete` (IN `p_id` INT(11))   BEGIN
    DELETE
FROM
    class
WHERE
    id = p_id ;
SELECT
    "Deleted Successfully" AS message ; END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageClass_insert` (IN `p_course` VARCHAR(255), IN `p_department` VARCHAR(255), IN `p_level` VARCHAR(255), IN `p_section` VARCHAR(50))   BEGIN
    INSERT INTO class(
        course_id,
        department_id,
        `level`,
        section
    )
VALUES(
    p_course,
    p_department,
    p_level,
    p_section
) ;



END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageClass_update` (IN `p_id` INT(11), IN `p_course` INT(255), IN `p_department` INT(255), IN `p_level` INT(255), IN `p_section` VARCHAR(50))   BEGIN

UPDATE `class`
SET
    course_id = p_course,
    department_id = p_department,
    `level` = p_level,
    section = p_section
WHERE
    id = p_id ;

SELECT
    'Class Updated Successfully' AS msg ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageCourse_delete` (IN `p_id` INT(11))   BEGIN
    DELETE
FROM
    course
WHERE
    id = p_id ;
SELECT
    "Deleted Successfully" AS message ; END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageCourse_insert` (IN `p_courseName` VARCHAR(255), IN `p_courseDescription` VARCHAR(255))   BEGIN

        -- Insert the new course
    INSERT INTO course(
        course,
        description
    )
VALUES(
    p_courseName,
    p_courseDescription
) ;
SELECT
    'Course Added Successfully' AS msg ;

 END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageCourse_update` (IN `p_id` INT(11), IN `p_courseName` VARCHAR(255), IN `p_courseDescription` VARCHAR(255))   BEGIN

UPDATE course
SET

course = p_courseName,
description = p_courseDescription

WHERE id = p_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageDepartment_delete` (IN `p_id` INT(11))   BEGIN
    DELETE
FROM
    department
WHERE
    id = p_id ;
SELECT
    "Deleted Successfully" AS message ; END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageDepartment_insert` (IN `p_departmentName` VARCHAR(255), IN `p_departmentDescription` VARCHAR(255))   BEGIN
    INSERT INTO department(
        department,
        description
    )
VALUES(
    p_departmentName,
    p_departmentDescription
) ;
SELECT
    'Department Added Successfully' AS msg ;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageDepartment_update` (IN `p_id` INT, IN `p_departmentName` TEXT, IN `p_departmentDescription` VARCHAR(250))   BEGIN

UPDATE department
SET 
department = p_departmentName,
description = p_departmentDescription

WHERE id = p_id;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageStudent_insert` (IN `p_student_id` VARCHAR(50), IN `p_firstname` VARCHAR(150), IN `p_middlename` VARCHAR(150), IN `p_lastname` VARCHAR(150), IN `p_email` VARCHAR(250), IN `p_contact` VARCHAR(150), IN `p_gender` VARCHAR(20), IN `p_address` TEXT, IN `p_password` TEXT, IN `p_dob` INT, IN `p_avatar` TEXT)   BEGIN
    INSERT INTO students (
        student_id, 
        firstname, 
        middlename, 
        lastname, 
        email, 
        contact, 
        gender, 
        address, 
        password, 
        dob, 
        avatar
    ) VALUES (
        p_student_id, 
        p_firstname, 
        p_middlename, 
        p_lastname, 
        p_email, 
        p_contact, 
        p_gender, 
        p_address, 
        p_password, 
        p_dob, 
        p_avatar
    );
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageStudent_update` (IN `p_id` INT, IN `p_student_id` VARCHAR(50), IN `p_firstname` VARCHAR(150), IN `p_middlename` VARCHAR(150), IN `p_lastname` VARCHAR(150), IN `p_email` VARCHAR(250), IN `p_contact` VARCHAR(150), IN `p_gender` VARCHAR(20), IN `p_address` TEXT, IN `p_password` TEXT, IN `p_dob` INT, IN `p_avatar` TEXT)   BEGIN
    UPDATE students
    SET 
    student_id = p_student_id,
        firstname = p_firstname,
        middlename = p_middlename,
        lastname = p_lastname,
        email = p_email,
        contact = p_contact,
        gender = p_gender,
        address = p_address,
        password = p_password,
        dob = p_dob,
        avatar = p_avatar
    WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `manageSubject_delete` (IN `p_id` INT(11))   BEGIN
    DELETE
FROM
    subjects
WHERE
    id = p_id ;
SELECT
    "Deleted Successfully" AS message ; END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageSubject_insert` (IN `p_subject_code` VARCHAR(255), IN `p_subjectDescription` VARCHAR(255))   BEGIN

    INSERT INTO subjects(
        subject_code,
        description
    )
VALUES(
    p_subject_code,
    p_subjectDescription
) ;
SELECT
    'Subject Added Successfully' AS msg ;

END$$

CREATE DEFINER=`root`@`%` PROCEDURE `manageSubject_update` (IN `p_id` INT(11), IN `p_subject_code` VARCHAR(250), IN `p_subjectDescription` TEXT)   BEGIN

UPDATE subjects
SET

subjects.subject_code = p_subject_code,
subjects.description = p_subjectDescription

WHERE id = p_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `removeClassBindFaculty` (IN `p_faculty_id` INT)   BEGIN

-- remove all binded classes
DELETE FROM class_subjects_faculty WHERE class_subjects_faculty.faculty_id = p_faculty_id;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `UpdateStudentClass` (IN `id_param` INT, IN `academic_year_id_param` INT, IN `student_id_param` INT, IN `class_id_param` INT)   BEGIN
    UPDATE student_class
    SET academic_year_id = academic_year_id_param,
        student_id = student_id_param,
        class_id = class_id_param
    WHERE id = id_param;
END$$

CREATE DEFINER=`root`@`%` PROCEDURE `update_faculty` (IN `p_id` INT(11), IN `faculty_id` VARCHAR(50), IN `department_id` INT(30), IN `firstname` VARCHAR(150), IN `middlename` VARCHAR(150), IN `lastname` VARCHAR(150), IN `email` VARCHAR(250), IN `contact` VARCHAR(150), IN `gender` VARCHAR(20), IN `address` TEXT, IN `password` TEXT, IN `dob` INT(11), IN `avatar` TEXT)   BEGIN

    UPDATE faculty
    
    SET
    faculty_id = faculty_id,
    department_id = department_id,
    firstname = firstname,
    middlename = middlename,
    lastname = lastname,
    email = email,
    contact = contact,
    gender = gender,
    address = address,
    password = password,
    dob = dob,
    avatar = avatar
    
    WHERE faculty.id = p_id;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `academic_year`
--

CREATE TABLE `academic_year` (
  `id` int(11) NOT NULL,
  `sy` text NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `academic_year`
--

INSERT INTO `academic_year` (`id`, `sy`, `status`) VALUES
(1, '2021-2025', 1);

-- --------------------------------------------------------

--
-- Table structure for table `backup_class`
--

CREATE TABLE `backup_class` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `level` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_class`
--

INSERT INTO `backup_class` (`id`, `department_id`, `course_id`, `level`, `section`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '3', 'A', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(2, 2, 1, '3', 'B', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(3, 0, 0, '', '', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(13, 1, 3, '1', '1', '2024-02-14 17:56:37', '2024-02-14 17:56:37'),
(1, 1, 3, '3', '3', '2023-12-08 07:28:47', '2024-02-15 13:10:05'),
(1, 1, 3, '3', '3', '2023-12-08 07:28:47', '2024-02-15 13:10:05'),
(1, 1, 3, '3', '3', '2023-12-08 07:28:47', '2024-02-15 13:10:05'),
(1, 1, 3, '3', '3', '2023-12-08 07:28:47', '2024-02-15 13:10:05'),
(16, 1, 19, '2', '1', '2024-02-15 14:22:14', '2024-02-15 14:22:14'),
(16, 1, 19, '10', '10', '2024-02-15 14:22:14', '2024-02-15 14:28:11'),
(16, 1, 19, '10', '10', '2024-02-15 14:22:14', '2024-02-15 14:53:12'),
(16, 1, 19, '10', '1', '2024-02-15 14:22:14', '2024-02-15 14:53:53');

-- --------------------------------------------------------

--
-- Table structure for table `backup_course`
--

CREATE TABLE `backup_course` (
  `id` int(11) NOT NULL,
  `course` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_course`
--

INSERT INTO `backup_course` (`id`, `course`, `description`, `date_added`, `date_updated`) VALUES
(1, 'BSIS', 'BS INFORMATION SYSTEM', '2023-12-03 08:08:50', '2023-12-03 08:45:14'),
(2, 'BSCS', 'BS COMPUTER SCIENCE', '2023-12-03 06:23:11', '2023-12-03 06:21:44'),
(3, 'BSIT', 'BS INFORMATION TECHNOLOGY', '2023-12-03 06:23:11', '2023-12-03 06:22:00'),
(4, 'BSEMC', 'BS ENTERTAINMENT AND MULTIMEDIA COMPUTING', '2023-12-03 06:23:11', '2023-12-03 06:22:29'),
(5, 'BSE', 'BS EDUCATION MAJOR IN ENGLISHS', '2023-12-08 07:25:53', '2023-12-08 07:26:11'),
(3, 'BSIT', 'BS INFORMATION TECHNOLOGY1', '2023-12-03 06:23:11', '2023-12-08 08:08:49'),
(3, 'BSIT', 'BS INFORMATION TECHNOLOGY2', '2023-12-03 06:23:11', '2023-12-08 08:09:10'),
(3, 'BSIT', 'BS INFORMATION TECHNOLOGY', '2023-12-03 06:23:11', '2023-12-08 08:26:28'),
(2, 'BSCS', 'BS COMPUTER SCIENCED', '2023-12-03 06:23:11', '2023-12-08 12:26:52'),
(2, 'BSCS', 'BS COMPUTER SCIENCES', '2023-12-03 06:23:11', '2023-12-08 12:26:58'),
(2, 'BSCS', 'BS COMPUTER SCIENCE', '2023-12-03 06:23:11', '2023-12-08 15:51:59'),
(0, 'TEST2', 'HELLO WORLD1', '2023-12-09 02:21:18', '2023-12-09 02:22:18'),
(2, 'BSCS', 'BS COMPUTER SCIENCES', '2023-12-03 06:23:11', '2023-12-09 12:32:10'),
(2, 'BSCS', 'BS COMPUTER SCIENCE\r\n', '2023-12-03 06:23:11', '2023-12-09 12:32:20'),
(5, 'BSE', 'BS EDUCATION MAJOR IN ENGLISH', '2023-12-08 07:25:53', '2023-12-09 13:01:58'),
(14, 'PE', 'PHYSICAL EDUCATIONS', '2023-12-09 13:00:48', '2023-12-09 13:03:49'),
(15, 'PE', 'PHYSICAL EDUCATIONSSSSSS', '2023-12-09 14:22:33', '2023-12-09 14:25:09'),
(15, 'PE', 'PHYSICAL EDUCATION', '2023-12-09 14:22:33', '2023-12-09 14:32:53'),
(16, 'GEE', 'CONTEMPORARY WORLDS', '2023-12-09 14:33:57', '2023-12-09 14:35:48'),
(15, 'PEE', 'PHYSICAL EDUCATION', '2023-12-09 14:22:33', '2023-12-09 15:49:49'),
(15, 'PEE', 'PHYSICAL EDUCATIONS', '2023-12-09 14:22:33', '2023-12-09 15:50:19'),
(18, 'BSEE', 'TESTERS', '2023-12-10 15:08:36', '2023-12-10 15:08:55'),
(19, 'BSIIT', 'TESTEReros', '2023-12-10 15:13:30', '2023-12-10 15:14:56'),
(2, 'BSCS', 'BS COMPUTER SCIENCES in\r\n', '2023-12-03 06:23:11', '2024-02-15 13:50:46'),
(2, 'BSCS', 'BS COMPUTER SCIENCES IN\r\n', '2023-12-03 06:23:11', '2024-02-15 15:29:11'),
(22, 'BSED', 'EDUCATION', '2024-02-15 15:29:35', '2024-02-15 15:29:35');

-- --------------------------------------------------------

--
-- Table structure for table `backup_faculty`
--

CREATE TABLE `backup_faculty` (
  `id` int(11) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `department_id` int(11) NOT NULL,
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
(1, 'F3', 1, 'Leonor', '', 'Rivera', 'leonor@rivera.abc', '09213391313', 'Female', 'Pasig, Philippines', 'password123', 1989, 'uploads/Favatar_1.png', '2023-12-03 06:25:48', '2023-12-03 06:25:48'),
(1, 'F123123', 1, 'test', 'test', 'test', 'sasdas@gmail.com', '3423', 'Male', '123123', '37e86e39460549efbc1cbcab16e54aa5', 2024, NULL, '2023-12-03 06:25:48', '2024-02-14 15:42:14'),
(2, 'F123123', 1, 'test', 'test', 'test', 'sasdas@gmail.com', '3423', 'Male', '123123', '37e86e39460549efbc1cbcab16e54aa5', 2024, NULL, '2023-12-03 06:28:10', '2024-02-14 15:42:14'),
(3, 'F123123', 1, 'test', 'test', 'test', 'sasdas@gmail.com', '3423', 'Male', '123123', '37e86e39460549efbc1cbcab16e54aa5', 2024, NULL, '2023-12-03 06:35:08', '2024-02-14 15:42:14'),
(4, 'F123123', 1, 'test', 'test', 'test', 'sasdas@gmail.com', '3423', 'Male', '123123', '37e86e39460549efbc1cbcab16e54aa5', 2024, NULL, '2024-02-14 15:06:37', '2024-02-14 15:06:37'),
(1, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', 'fe5c3684dce76cdd9f7f42430868aa74', 1970, NULL, '2023-12-03 06:25:48', '2024-02-14 15:45:26'),
(2, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', 'fe5c3684dce76cdd9f7f42430868aa74', 1970, NULL, '2023-12-03 06:28:10', '2024-02-14 15:45:26'),
(3, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', 'fe5c3684dce76cdd9f7f42430868aa74', 1970, NULL, '2023-12-03 06:35:08', '2024-02-14 15:45:26'),
(1, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', 'fe5c3684dce76cdd9f7f42430868aa74', 1970, NULL, '2023-12-03 06:25:48', '2024-02-14 15:46:44'),
(2, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', 'fe5c3684dce76cdd9f7f42430868aa74', 1970, NULL, '2023-12-03 06:28:10', '2024-02-14 15:46:44'),
(3, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', 'fe5c3684dce76cdd9f7f42430868aa74', 1970, NULL, '2023-12-03 06:35:08', '2024-02-14 15:46:44'),
(3, 'F2', 2, 'Gabriella', '', 'Silang', 'gabriella.silang@xyz.com', '09303150890', 'Female', 'Pasay, Philippines', 'fe5c3684dce76cdd9f7f42430868aa74', 1970, NULL, '2023-12-03 06:35:08', '2024-02-14 15:46:44'),
(1, 'F3', 2, 'Leonor', '', 'RiVERe', 'leonor@rivera.abc', '09213391313', 'Female', 'Pasig, Philippines', '4b6bf4b531770872d4328ce69bef5627', 1989, NULL, '2023-12-03 06:25:48', '2024-02-15 13:32:33');

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
(3, 'S3', 'Damian', '', 'Desmond', 'desmond@abc.com', '09123456894', 'Male', '', NULL, 2000, 'uploads/uvatar_3.jpg', '2023-12-03 11:38:46', '2023-12-03 11:38:14'),
(5, '55', 'test', '', 'test', 'test@gmail.com', '2312312', 'Male', '12312', '098f6bcd4621d373cade4e832627b4f6', 0, '/', '2024-02-12 18:56:59', '2024-02-13 15:12:50'),
(4, '54', '', '', '', '', '', 'Male', '', '098f6bcd4621d373cade4e832627b4f6', 0, '/', '2024-02-12 18:55:24', '2024-02-13 15:12:50'),
(4, '54', 'x', 'x', '', '', '', 'Male', '', '098f6bcd4621d373cade4e832627b4f6', 0, '/', '2024-02-12 18:55:24', '2024-02-13 15:13:49'),
(4, '54', 'x', 'x', 'x', '', '', 'Male', '', '098f6bcd4621d373cade4e832627b4f6', 0, '/', '2024-02-12 18:55:24', '2024-02-13 15:13:55'),
(6, '55', 'Anya', '', 'Forgerrrrrrr', 'spywars@xyz.com', '09338226692', 'Female', 'Makati, Philippines', 'b53b3a3d6ab90ce0268229151c9bde11', 0, '/', '2024-02-13 15:42:44', '2024-02-13 15:50:12'),
(1, 'S2', 'Anyaaaaaaa', '', 'Forger', 'spywars@xyz.com', '09338226692', 'Female', 'Makati, Philippines', 'b9eeaf6a16ca49f37df57620aed91b62', 0, '/', '2023-12-03 11:32:13', '2024-02-13 15:50:23'),
(4, '54', 'x', 'x', 'x', '', '', 'Male', '', 'a684eceee76fc522773286a895bc8436', 0, '/', '2024-02-12 18:55:24', '2024-02-13 15:58:25'),
(4, '54', 'gegegegegegege', 'x', 'x', '', '', 'Male', '', 'a684eceee76fc522773286a895bc8436', 0, '/', '2024-02-12 18:55:24', '2024-02-13 16:00:11'),
(9, '12312312111', '12312aaaaaaa', '', '312312', '', '', 'Male', '', '81fdd1620d6fb9f8dbf77c22890818db', 0, '/', '2024-02-15 07:39:37', '2024-02-15 07:39:50'),
(10, '231231', 'dasdsa', 'eqweq', 'qweqwe', '', '', 'Male', '', '5775f3eaccbaa66732e805cb621bbf3d', 0, '/', '2024-02-15 07:45:18', '2024-02-15 07:45:25'),
(1, 'S2', 'IBA', '', 'Forger', 'spywars@xyz.com', '09338226692', 'Female', 'Makati, Philippines', 'b9eeaf6a16ca49f37df57620aed91b62', 0, '/', '2023-12-03 11:32:13', '2024-02-15 13:08:45'),
(1, 'S2', 'IBA', '', 'Forgersd', 'spywars@xyz.com', '09338226692', 'Female', 'Makati, Philippines', 'b9eeaf6a16ca49f37df57620aed91b62', 0, '/', '2023-12-03 11:32:13', '2024-02-15 14:33:51'),
(11, 'S15', 'TRYYY', 'HHSHS', 'GAGAGAG', 'Boruto@gmail.com', '1234456788', 'Male', 'Kono', '74a21b5dd9b92ad1e11f2f39f34a4394', 0, '/', '2024-02-15 13:06:19', '2024-02-15 13:06:19');

-- --------------------------------------------------------

--
-- Table structure for table `backup_subjects`
--

CREATE TABLE `backup_subjects` (
  `id` int(11) NOT NULL,
  `subject_code` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backup_subjects`
--

INSERT INTO `backup_subjects` (`id`, `subject_code`, `description`, `date_added`, `date_updated`) VALUES
(0, 'CCS 001', 'TECHNICAL COMPUTER CONCEPTS', '2023-12-08 10:11:27', '2023-12-08 10:11:27'),
(1, 'IS 102', 'ENTERPRISE RESOURCE PLANNING', '2023-12-02 22:11:23', '2023-12-02 22:11:23'),
(2, 'IS 103', 'DATABASE SYSTEMS ENTERPRISE', '2023-12-02 22:12:04', '2023-12-02 22:12:04'),
(3, 'IS 104', 'IS INNOVATIONS & NEW TECHNOLOGIES', '2023-12-02 22:12:37', '2023-12-02 22:12:37'),
(4, 'IS 105', 'ENTERPRISE ARCHITECTURE\r\n', '2023-12-02 22:13:05', '2023-12-02 22:13:05'),
(5, 'IS 106', 'IS MAJOR ELECTIVE 1', '2023-12-02 22:13:26', '2023-12-02 22:13:26'),
(6, 'CCS 118', 'MULTIMEDIA SYSTEMS', '2023-12-02 22:13:39', '2023-12-02 22:13:39'),
(7, 'RES 001', 'METHODS OF RESEARCH', '2023-12-03 00:30:13', '2023-12-03 00:30:13'),
(7, 'RES 001', 'METHODS OF RESEARCHS', '2023-12-03 00:30:13', '2023-12-08 10:13:54'),
(7, 'RES 001', 'METHODS OF RESEARCH', '2023-12-03 00:30:13', '2023-12-08 10:14:19'),
(7, 'RES 001', 'METHODS OF RESEARCHS', '2023-12-03 00:30:13', '2023-12-09 15:17:36'),
(8, 'MMA', 'TESTS\r\n', '2023-12-09 15:27:32', '2023-12-09 15:27:49'),
(8, 'MaMA', 'TESTS\r\n', '2023-12-09 15:27:32', '2023-12-09 15:49:16'),
(1, 'IS 102', 'ENTERPRISE RESOURCEs', '2023-12-02 22:11:23', '2024-02-15 14:00:55'),
(1, 'IS 102', 'ENTERPRISE RESOURCEs', '2023-12-02 22:11:23', '2024-02-15 15:18:57'),
(1, 'IS 102', 'ENTERPRISE RESOURCEsd', '2023-12-02 22:11:23', '2024-02-15 15:20:53'),
(10, 'GEE', 'TEST', '2024-02-15 15:21:36', '2024-02-15 15:21:36'),
(1, 'IS 102', 'ENTERPRISE RESOURCESD', '2023-12-02 22:11:23', '2024-02-15 15:24:52');

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `level` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `department_id`, `course_id`, `level`, `section`, `created_at`, `updated_at`) VALUES
(1, 2, 3, '3', '3', '2023-12-08 07:28:47', '2024-02-15 13:55:24'),
(2, 2, 1, '3', 'B', '2023-12-08 07:28:47', '2023-12-08 07:28:47'),
(13, 1, 3, '2', '2', '2024-02-14 17:56:37', '2024-02-15 14:11:23'),
(14, 2, 1, '3', '3', '2024-02-15 07:41:01', '2024-02-15 13:43:58'),
(16, 1, 19, '10', '1', '2024-02-15 14:22:14', '2024-02-15 14:53:53');

--
-- Triggers `class`
--
DELIMITER $$
CREATE TRIGGER `backup_class_delete` AFTER DELETE ON `class` FOR EACH ROW BEGIN
    INSERT INTO backup_class(
        id,
        department_id,
        course_id,
        level,
        section,
        created_at,
        updated_at
    )
VALUES(
    OLD.id,
    OLD.department_id,
    OLD.course_id,
    OLD.level,
    OLD.section,
    OLD.created_at,
    OLD.updated_at
);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `backup_class_insert` AFTER INSERT ON `class` FOR EACH ROW BEGIN
INSERT INTO backup_class (id, department_id, course_id, level, section, created_at, updated_at) 

VALUES (NEW.id, NEW.department_id, NEW.course_id, NEW.level, NEW.section, NEW.created_at, NEW.updated_at); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `backup_class_update` AFTER UPDATE ON `class` FOR EACH ROW BEGIN
INSERT INTO backup_class (id, department_id, course_id, level, section, created_at, updated_at) 

VALUES (NEW.id, NEW.department_id, NEW.course_id, NEW.level, NEW.section, NEW.created_at, NEW.updated_at); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `class_subjects`
--

CREATE TABLE `class_subjects` (
  `academic_year_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_subjects`
--

INSERT INTO `class_subjects` (`academic_year_id`, `class_id`, `subject_id`) VALUES
(1, 2, 2),
(1, 2, 4),
(1, 11, 2),
(1, 15, 4),
(1, 15, 5);

-- --------------------------------------------------------

--
-- Table structure for table `class_subjects_faculty`
--

CREATE TABLE `class_subjects_faculty` (
  `academic_year_id` int(11) NOT NULL,
  `faculty_id` varchar(50) NOT NULL,
  `class_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class_subjects_faculty`
--

INSERT INTO `class_subjects_faculty` (`academic_year_id`, `faculty_id`, `class_id`, `subject_id`) VALUES
(1, '1', 1, 1),
(1, '2', 2, 1),
(1, '3', 1, 1),
(1, '3', 2, 2),
(1, '7', 2, 1),
(1, '9', 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` int(11) NOT NULL,
  `course` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `course`, `description`, `date_added`, `date_updated`) VALUES
(1, 'BSIS', 'BS INFORMATION SYSTEM', '2023-12-03 08:08:50', '2023-12-03 08:45:14'),
(2, 'BSCS', 'BS COMPUTER SCIENCES IN\r\n', '2023-12-03 06:23:11', '2024-02-15 15:29:11'),
(3, 'BSIT', 'BS INFORMATION TECHNOLOGY', '2023-12-03 06:23:11', '2023-12-08 08:26:28'),
(4, 'BSEMC', 'BS ENTERTAINMENT AND MULTIMEDIA COMPUTING', '2023-12-03 06:23:11', '2023-12-08 07:24:48'),
(5, 'BSE', 'BS EDUCATION MAJOR IN ENGLISH', '2023-12-08 07:25:53', '2023-12-09 13:01:58'),
(19, 'BSIIT', 'BACHELOR OF SCIENCEEEEEE', '2023-12-10 15:13:30', '2024-02-15 13:15:30'),
(22, 'BSED', 'EDUCATION', '2024-02-15 15:29:35', '2024-02-15 15:29:35');

--
-- Triggers `course`
--
DELIMITER $$
CREATE TRIGGER `backup_course_delete` AFTER DELETE ON `course` FOR EACH ROW BEGIN
INSERT INTO backup_course (id, course, description, date_added, date_updated) VALUES (OLD.id, OLD.course, OLD.description, OLD.date_added, OLD.date_updated); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `backup_course_insert` AFTER INSERT ON `course` FOR EACH ROW BEGIN
INSERT INTO backup_course (id, course, description, date_added, date_updated) VALUES (NEW.id, NEW.course, NEW.description, NEW.date_added, NEW.date_updated); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `backup_data_course` AFTER UPDATE ON `course` FOR EACH ROW BEGIN
INSERT INTO backup_course (id, course, description, date_added, date_updated) VALUES (NEW.id, NEW.course, NEW.description, NEW.date_added, NEW.date_updated); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `course_uppercase` BEFORE INSERT ON `course` FOR EACH ROW BEGIN
    SET NEW.course = UPPER(NEW.course);
    SET NEW.description = UPPER(NEW.description);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `course_uppercase_after` BEFORE UPDATE ON `course` FOR EACH ROW BEGIN
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
  `department` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`id`, `department`, `description`, `date_added`, `date_updated`) VALUES
(1, 'COE', 'COLLEGE OF EDUCATIONS', '2023-12-03 07:36:56', '2024-02-15 15:32:47'),
(2, 'CSD', 'COMPUTER STUDIES DEPARTMENT\r\n', '2023-12-03 07:37:14', '2023-12-03 07:37:14'),
(8, 'COL', 'COLLEGE OF LAW', '2024-02-15 15:17:44', '2024-02-15 15:17:44');

--
-- Triggers `department`
--
DELIMITER $$
CREATE TRIGGER `Department_uppercase` BEFORE INSERT ON `department` FOR EACH ROW BEGIN
    SET NEW.department = UPPER(NEW.department);
    SET NEW.description = UPPER(NEW.description);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Department_uppercase_after` BEFORE UPDATE ON `department` FOR EACH ROW BEGIN
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
  `department_id` int(11) NOT NULL,
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
(1, 'F3', 2, 'Leonor', '', 'RiVERe', 'leonor@rivera.abc', '09213391313', 'Female', 'Pasig, Philippines', '4b6bf4b531770872d4328ce69bef5627', 1989, NULL, '2023-12-03 06:25:48', '2024-02-15 13:32:33'),
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
DELIMITER $$
CREATE TRIGGER `backup_faculty_delete` AFTER DELETE ON `faculty` FOR EACH ROW BEGIN
INSERT INTO backup_faculty (id, faculty_id, department_id, firstname, middlename, lastname, email, contact, gender, address, password, dob, avatar, date_added, date_updated) VALUES (OLD.id, OLD.faculty_id, OLD.department_id, OLD.firstname, OLD.middlename, OLD.lastname, OLD.email, OLD.contact, OLD.gender, OLD.address, OLD.password, OLD.dob, OLD.avatar, OLD.date_added, OLD.date_updated); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `backup_faculty_insert` AFTER INSERT ON `faculty` FOR EACH ROW BEGIN
INSERT INTO backup_faculty (id, faculty_id, department_id, firstname, middlename, lastname, email, contact, gender, address, password, dob, avatar, date_added, date_updated) VALUES (NEW.id, NEW.faculty_id, NEW.department_id, NEW.firstname, NEW.middlename, NEW.lastname, NEW.email, NEW.contact, NEW.gender, NEW.address, NEW.password, NEW.dob, NEW.avatar, NEW.date_added, NEW.date_updated); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `id` int(11) NOT NULL,
  `academic_year_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
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
  `lesson_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL
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
(1, 'S2', 'IBA', '', 'Forgersd', 'spywars@xyz.com', '09338226692', 'Female', 'Makati, Philippines', 'b9eeaf6a16ca49f37df57620aed91b62', 1970, '/', '2023-12-03 11:32:13', '2024-02-15 14:33:51'),
(4, '54', 'gegegegegegege', 'x', 'x', '', '', 'Male', '', 'a684eceee76fc522773286a895bc8436', 1970, '/', '2024-02-12 18:55:24', '2024-02-13 16:00:11');

--
-- Triggers `students`
--
DELIMITER $$
CREATE TRIGGER `backup_data_students` AFTER UPDATE ON `students` FOR EACH ROW BEGIN
    INSERT INTO backup_students(
        id,
        student_id,
        firstname,
        middlename,
        lastname,
        email,
        contact,
        gender,
        address,
        password,
        avatar,
        date_added,
        date_updated
    )
VALUES(
    NEW.id,
    NEW.student_id,
    NEW.firstname,
    NEW.middlename,
    NEW.lastname,
    NEW.email,
    NEW.contact,
    NEW.gender,
    NEW.address,
    NEW.password,
    NEW.avatar,
    NEW.date_added,
    NEW.date_updated
) ;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `backup_student_delete` AFTER DELETE ON `students` FOR EACH ROW BEGIN
    INSERT INTO backup_students(
        id,
        student_id,
        firstname,
        middlename,
        lastname,
        email,
        contact,
        gender,
        address,
        password,
        avatar,
        date_added,
        date_updated
    )
VALUES(
    OLD.id,
    OLD.student_id,
    OLD.firstname,
    OLD.middlename,
    OLD.lastname,
    OLD.email,
    OLD.contact,
    OLD.gender,
    OLD.address,
    OLD.password,
    OLD.avatar,
    OLD.date_added,
    OLD.date_updated
) ;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `backup_student_insert` AFTER INSERT ON `students` FOR EACH ROW BEGIN
    INSERT INTO backup_students(
        id,
        student_id,
        firstname,
        middlename,
        lastname,
        email,
        contact,
        gender,
        address,
        password,
        avatar,
        date_added,
        date_updated
    )
VALUES(
    NEW.id,
    NEW.student_id,
    NEW.firstname,
    NEW.middlename,
    NEW.lastname,
    NEW.email,
    NEW.contact,
    NEW.gender,
    NEW.address,
    NEW.password,
    NEW.avatar,
    NEW.date_added,
    NEW.date_updated
) ;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `student_class`
--

CREATE TABLE `student_class` (
  `id` int(11) NOT NULL,
  `academic_year_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_class`
--

INSERT INTO `student_class` (`id`, `academic_year_id`, `student_id`, `class_id`) VALUES
(10, 1, 4, 2),
(12, 1, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `id` int(11) NOT NULL,
  `subject_code` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`id`, `subject_code`, `description`, `date_added`, `date_updated`) VALUES
(1, 'IS 102', 'ENTERPRISE RESOURCESD', '2023-12-02 22:11:23', '2024-02-15 15:24:52'),
(2, 'IS 103', 'DATABASE SYSTEMS ENTERPRISE', '2023-12-02 22:12:04', '2023-12-02 22:12:04'),
(3, 'IS 104', 'IS INNOVATIONS & NEW TECHNOLOGIES', '2023-12-02 22:12:37', '2023-12-02 22:12:37'),
(4, 'IS 105', 'ENTERPRISE ARCHITECTURE\r\n', '2023-12-02 22:13:05', '2023-12-02 22:13:05'),
(5, 'IS 106', 'IS MAJOR ELECTIVE 1', '2023-12-02 22:13:26', '2023-12-02 22:13:26'),
(6, 'CCS 118', 'MULTIMEDIA SYSTEMS', '2023-12-02 22:13:39', '2023-12-02 22:13:39'),
(7, 'RES 001', 'METHODS OF RESEARCHS', '2023-12-03 00:30:13', '2023-12-09 15:17:36'),
(10, 'GEE', 'TEST', '2024-02-15 15:21:36', '2024-02-15 15:21:36');

--
-- Triggers `subjects`
--
DELIMITER $$
CREATE TRIGGER `backup_data_subjects` AFTER UPDATE ON `subjects` FOR EACH ROW BEGIN
INSERT INTO backup_subjects (id, subject_code, description, date_added, date_updated) VALUES (NEW.id, NEW.subject_code, NEW.description, NEW.date_added, NEW.date_updated); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `backup_subjects_delete` AFTER DELETE ON `subjects` FOR EACH ROW BEGIN
INSERT INTO backup_subjects (id, subject_code, description, date_added, date_updated) VALUES (OLD.id, OLD.subject_code, OLD.description, OLD.date_added, OLD.date_updated); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `backup_subjects_insert` AFTER INSERT ON `subjects` FOR EACH ROW BEGIN
INSERT INTO backup_subjects (id, subject_code, description, date_added, date_updated) VALUES (NEW.id, NEW.subject_code, NEW.description, NEW.date_added, NEW.date_updated); 
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
DELIMITER $$
CREATE TRIGGER `subject_uppercase_after` BEFORE UPDATE ON `subjects` FOR EACH ROW BEGIN
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
  `id` int(11) NOT NULL,
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
  `id` int(11) NOT NULL,
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
-- Stand-in structure for view `vw_getallay`
-- (See below for the actual view)
--
CREATE TABLE `vw_getallay` (
`id` int(11)
,`sy` text
,`status` tinyint(4)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_getallclasses`
-- (See below for the actual view)
--
CREATE TABLE `vw_getallclasses` (
`id` int(11)
,`department_id` int(11)
,`course_id` int(11)
,`level` varchar(50)
,`section` varchar(50)
,`created_at` timestamp
,`updated_at` timestamp
,`department` varchar(250)
,`class` varchar(352)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_getallcourses`
-- (See below for the actual view)
--
CREATE TABLE `vw_getallcourses` (
`id` int(11)
,`course` varchar(250)
,`description` text
,`date_added` timestamp
,`date_updated` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_getalldepartments`
-- (See below for the actual view)
--
CREATE TABLE `vw_getalldepartments` (
`id` int(11)
,`department` varchar(250)
,`description` text
,`date_added` timestamp
,`date_updated` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_getallstudents`
-- (See below for the actual view)
--
CREATE TABLE `vw_getallstudents` (
`id` int(11)
,`student_id` varchar(50)
,`student_firstname` varchar(150)
,`student_middlename` varchar(150)
,`student_lastname` varchar(150)
,`level` varchar(50)
,`section` varchar(50)
,`course` varchar(250)
,`course_description` text
,`academic_year_id` int(11)
,`class` varchar(352)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_getallsubjects`
-- (See below for the actual view)
--
CREATE TABLE `vw_getallsubjects` (
`id` int(11)
,`subject_code` varchar(250)
,`description` text
,`date_added` timestamp
,`date_updated` timestamp
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_getfaculties`
-- (See below for the actual view)
--
CREATE TABLE `vw_getfaculties` (
`faculty_name` varchar(452)
,`id` int(11)
,`faculty_id` varchar(50)
,`department` varchar(250)
,`description` text
,`avatar` text
);

-- --------------------------------------------------------

--
-- Structure for view `vw_getallay`
--
DROP TABLE IF EXISTS `vw_getallay`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_getallay`  AS SELECT `academic_year`.`id` AS `id`, `academic_year`.`sy` AS `sy`, `academic_year`.`status` AS `status` FROM `academic_year` ORDER BY `academic_year`.`sy` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `vw_getallclasses`
--
DROP TABLE IF EXISTS `vw_getallclasses`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_getallclasses`  AS SELECT `c`.`id` AS `id`, `c`.`department_id` AS `department_id`, `c`.`course_id` AS `course_id`, `c`.`level` AS `level`, `c`.`section` AS `section`, `c`.`created_at` AS `created_at`, `c`.`updated_at` AS `updated_at`, `d`.`department` AS `department`, concat(`co`.`course`,' ',`c`.`level`,'-',`c`.`section`) AS `class` FROM ((`class` `c` join `department` `d` on(`d`.`id` = `c`.`department_id`)) join `course` `co` on(`co`.`id` = `c`.`course_id`)) ORDER BY `d`.`department` ASC, concat(`co`.`course`,' ',`c`.`level`,'-',`c`.`section`) ASC ;

-- --------------------------------------------------------

--
-- Structure for view `vw_getallcourses`
--
DROP TABLE IF EXISTS `vw_getallcourses`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_getallcourses`  AS SELECT `course`.`id` AS `id`, `course`.`course` AS `course`, `course`.`description` AS `description`, `course`.`date_added` AS `date_added`, `course`.`date_updated` AS `date_updated` FROM `course` ORDER BY `course`.`course` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `vw_getalldepartments`
--
DROP TABLE IF EXISTS `vw_getalldepartments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_getalldepartments`  AS SELECT `department`.`id` AS `id`, `department`.`department` AS `department`, `department`.`description` AS `description`, `department`.`date_added` AS `date_added`, `department`.`date_updated` AS `date_updated` FROM `department` ORDER BY `department`.`department` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `vw_getallstudents`
--
DROP TABLE IF EXISTS `vw_getallstudents`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_getallstudents`  AS SELECT `students`.`id` AS `id`, `students`.`student_id` AS `student_id`, `students`.`firstname` AS `student_firstname`, `students`.`middlename` AS `student_middlename`, `students`.`lastname` AS `student_lastname`, `scb`.`level` AS `level`, `scb`.`section` AS `section`, `scb`.`course` AS `course`, `scb`.`description` AS `course_description`, `scb`.`academic_year_id` AS `academic_year_id`, concat(`scb`.`course`,' ',`scb`.`level`,' ',`scb`.`section`) AS `class` FROM (`students` left join (select `sc`.`id` AS `sc_id`,`sc`.`student_id` AS `sc_student_id`,`sc`.`class_id` AS `class_id`,`sc`.`academic_year_id` AS `academic_year_id`,`class`.`course_id` AS `course_id`,`class`.`section` AS `section`,`class`.`level` AS `level`,`class`.`department_id` AS `department_id`,`course`.`course` AS `course`,`course`.`description` AS `description` from ((`student_class` `sc` left join `class` on(`class`.`id` = `sc`.`class_id`)) left join `course` on(`course`.`id` = `class`.`course_id`))) `scb` on(`scb`.`sc_student_id` = `students`.`id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vw_getallsubjects`
--
DROP TABLE IF EXISTS `vw_getallsubjects`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_getallsubjects`  AS SELECT `subjects`.`id` AS `id`, `subjects`.`subject_code` AS `subject_code`, `subjects`.`description` AS `description`, `subjects`.`date_added` AS `date_added`, `subjects`.`date_updated` AS `date_updated` FROM `subjects` ;

-- --------------------------------------------------------

--
-- Structure for view `vw_getfaculties`
--
DROP TABLE IF EXISTS `vw_getfaculties`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_getfaculties`  AS SELECT concat(`faculty`.`lastname`,' ',`faculty`.`firstname`,' ',`faculty`.`middlename`) AS `faculty_name`, `faculty`.`id` AS `id`, `faculty`.`faculty_id` AS `faculty_id`, `department`.`department` AS `department`, `department`.`description` AS `description`, `faculty`.`avatar` AS `avatar` FROM (`faculty` join `department` on(`department`.`id` = `faculty`.`department_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_year`
--
ALTER TABLE `academic_year`
  ADD PRIMARY KEY (`id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_class`
--
ALTER TABLE `student_class`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_year`
--
ALTER TABLE `academic_year`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `faculty`
--
ALTER TABLE `faculty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `student_class`
--
ALTER TABLE `student_class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
