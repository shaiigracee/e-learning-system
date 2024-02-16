<?php
require_once('../config.php');
class Master extends DBConnection
{
	private $settings;
	public function __construct()
	{
		parent::__construct();
		$this->settings = new SystemSettings();
	}

	public function __destruct()
	{
		parent::__destruct();
	}

	public function save_academic()
	{
		extract($_POST);

		try {

			if (empty($id) && !isset($id)) {
				//check if sy is already exist, call vw_getAllAY
				$stmt = $this->conn->prepare("SELECT * FROM vw_getAllAY WHERE sy = :sy");
				$stmt->bindParam(':sy', $sy, PDO::PARAM_STR);
				$stmt->execute();

				if ($stmt->rowCount() > 0) {

					$this->settings->set_flashdata('error', " School Year already exist.");
					return 1;
				}
			}


			//check if $id is empty, call manageAcademic_insert
			$sql = "CALL manageAcademic_insert(:sy, :status)";

			if (!empty($id) && isset($id)) {
				$sql = "CALL managaAcademic_update(:id, :sy, :status)";
			}

			// Prepare the statement
			$stmt = $this->conn->prepare($sql);

			if(!empty($id) && isset($id)) $stmt->bindParam(':id', $id, PDO::PARAM_INT);

			//bind parameters
			$stmt->bindParam(':sy', $sy, PDO::PARAM_STR);
			$stmt->bindParam(':status', $status, PDO::PARAM_INT);

			//execute the statement
			$stmt->execute();

			$this->settings->set_flashdata('success', " Academic Year Successfully saved.");
			return 1;
		} catch (Exception $e) {
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
	}

	public function delete_academic()
	{
		extract($_POST);

		try {
			// Create a new PDO instance
			$pdo = $this->conn;

			// Set the PDO error mode to exception
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// Prepare the SQL call to the stored procedure
			$sql = "CALL manageAcademic_delete(:id)";

			// Prepare the statement
			$stmt = $pdo->prepare($sql);
			$stmt->bindParam(':id', $id, PDO::PARAM_INT);

			$stmt->execute();

			$this->settings->set_flashdata('success', " Academic Year is deleted.");
			return 1;
		} catch (PDOException $e) {
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
	}

	public function save_department()
	{
		extract($_POST);

		//if id is empty and not set, check if department colmn is already exist, call vw_getAllDepartments
		if (empty($id) && !isset($id)) {
			$stmt = $this->conn->prepare("SELECT * FROM vw_getAllDepartments WHERE department = :department");
			$stmt->bindParam(':department', $department, PDO::PARAM_STR);
			$stmt->execute();

			if ($stmt->rowCount() > 0) {
				$this->settings->set_flashdata('error', " Department already exist.");
				return 1;
			}
		}

		//create default sql, call manageDepartment_insert
		$sql = "CALL manageDepartment_insert(:department, :description)";

		//if id is not empty and set, update the sql, call manageDepartment_update
		if (!empty($id) && isset($id)) {
			$sql = "CALL manageDepartment_update(:id, :department, :description)";
		}

		// Prepare the statement
		$stmt2 = $this->conn->prepare($sql);

		//if id is not empty and set, bind the id
		if (!empty($id) && isset($id)) $stmt2->bindParam(':id', $id, PDO::PARAM_INT);

		//bind parameters
		$stmt2->bindParam(':department', $department, PDO::PARAM_STR);
		$stmt2->bindParam(':description', $description, PDO::PARAM_STR);

		//execute the statement
		$stmt2->execute();

		$this->settings->set_flashdata('success', " Department Successfully saved.");
		return 1;

	}
	public function delete_department()
	{
		extract($_POST);

		//CALL manageDepartment_delete
		$stmt = $this->conn->prepare("CALL manageDepartment_delete(:id)");
		$stmt->bindParam(':id', $id, PDO::PARAM_INT);
		
		$stmt->execute();

		$this->settings->set_flashdata('success', " Department is deleted.");
		return 1;
	}

	public function save_course()
	{
		extract($_POST);

		try
		{
			// Create a new PDO instance
			$pdo = $this->conn;

			// Set the PDO error mode to exception
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// Prepare the SQL call to the stored procedure
			$sql = "CALL manageCourse_insert(:course, :description)";

			if (!empty($id) && isset($id)) {
				$sql = "CALL manageCourse_update(:id, :course, :description)";
			}

			// Prepare the statement
			$stmt = $pdo->prepare($sql);

			if (!empty($id) && isset($id)) $stmt->bindParam(':id', $id, PDO::PARAM_INT);

			// Bind parameters
			$stmt->bindParam(':course', $course, PDO::PARAM_STR);
			$stmt->bindParam(':description', $description, PDO::PARAM_STR);

			// Execute the statement
			$stmt->execute();

			$this->settings->set_flashdata('success', " Course Successfully saved.");
			return 1;
		}
		catch(Exception $e)
		{
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
		catch(Exception $e)
		{
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}

	}

	public function delete_course()
	{
		extract($_POST);

		try
		{
			//call manageCourse_delete
			$stmt = $this->conn->prepare("CALL manageCourse_delete(:id)");
			$stmt->bindParam(':id', $id, PDO::PARAM_INT);
			$stmt->execute();

			$this->settings->set_flashdata('success', " Course is deleted.");
			return 1;
		}
		catch(Exception $e)
		{
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
	}

	public function save_subject()
	{
		extract($_POST);

		try
		{
			// Create a new PDO instance
			$pdo = $this->conn;

			// Set the PDO error mode to exception
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// Prepare the SQL call to the stored procedure
			$sql = "CALL manageSubject_insert(:subject_code, :description)";

			if (!empty($id) && isset($id)) {
				$sql = "CALL manageSubject_update(:id, :subject_code, :description)";
			}

			// Prepare the statement
			$stmt = $pdo->prepare($sql);

			if (!empty($id) && isset($id)) $stmt->bindParam(':id', $id, PDO::PARAM_INT);

			// Bind parameters
			$stmt->bindParam(':subject_code', $subject_code, PDO::PARAM_STR);
			$stmt->bindParam(':description', $description, PDO::PARAM_STR);

			// Execute the statement
			$stmt->execute();

			$this->settings->set_flashdata('success', " Subject Successfully saved.");
			return 1;
		}
		catch(Exception $e)
		{
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
		catch(Exception $e)
		{
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
	}
	public function delete_subject()
	{
		extract($_POST);

		
		try
		{
			//call manageSubject_delete
			$stmt = $this->conn->prepare("CALL manageSubject_delete(:id)");
			$stmt->bindParam(':id', $id, PDO::PARAM_INT);
			$stmt->execute();

			$this->settings->set_flashdata('success', " Subject is deleted.");
			return 1;
		}
		catch(Exception $e)
		{
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
		catch(Exception $e)
		{
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
	}

	public function save_student()
	{
		extract($_POST);

		try {
			// Create a new PDO instance
			$pdo = $this->conn;

			// Set the PDO error mode to exception
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// Prepare the SQL call to the stored procedure
			$sql = "CALL manageStudent_insert(:student_id, :firstname, :middlename, :lastname, :email, :contact, :gender, :address, :password, :dob, :avatar)";

			if (!empty($id) && isset($id)) {
				$sql = "CALL manageStudent_update(:id, :student_id, :firstname, :middlename, :lastname, :email, :contact, :gender, :address, :password, :dob, :avatar)";
			}

			// Prepare the statement
			$stmt = $pdo->prepare($sql);

			if (!empty($id) && isset($id)) $stmt->bindParam(':id', $id, PDO::PARAM_INT);

			// Bind parameters
			$stmt->bindParam(':student_id', $student_id, PDO::PARAM_STR);
			$stmt->bindParam(':firstname', $firstname, PDO::PARAM_STR);
			$stmt->bindParam(':middlename', $middlename, PDO::PARAM_STR);
			$stmt->bindParam(':lastname', $lastname, PDO::PARAM_STR);
			$stmt->bindParam(':email', $email, PDO::PARAM_STR);
			$stmt->bindParam(':contact', $contact, PDO::PARAM_STR);
			$stmt->bindParam(':gender', $gender, PDO::PARAM_STR);
			$stmt->bindParam(':address', $address, PDO::PARAM_STR);
			$stmt->bindParam(':password', $password, PDO::PARAM_STR);
			$stmt->bindParam(':dob', $dob, PDO::PARAM_INT);
			$stmt->bindParam(':avatar', $avatar, PDO::PARAM_STR);

			// Set parameter values
			$student_id = $_POST['student_id'];
			$firstname = $_POST['firstname'];
			$middlename = $_POST['middlename'];
			$lastname = $_POST['lastname'];
			$email = $_POST['email'];
			$contact = $_POST['contact'];
			$gender = $_POST['gender'];
			$address = $_POST['address'];
			$password = md5($student_id);
			$dob = $_POST['dob'];; // UNIX timestamp
			$avatar = "/";

			// Execute the statement
			$stmt->execute();

			$this->settings->set_flashdata('success', " Student Successfully saved.");
			return 1;
		} catch (PDOException $e) {
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			$resp['sql'] = $sql;
			return json_encode($resp);
		}
	}


	public function delete_student()
	{
		extract($_POST);

		try {
			// Create a new PDO instance
			$pdo = $this->conn;

			// Set the PDO error mode to exception
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// Prepare the SQL call to the stored procedure
			$sql = "CALL deleteStudentByID(:id)";

			// Prepare the statement
			$stmt = $pdo->prepare($sql);

			if (!empty($id) && isset($id)) $stmt->bindParam(':id', $id, PDO::PARAM_INT);

			$stmt->execute();

			$this->settings->set_flashdata('success', " Student is deleted.");
			return 1;
		} catch (PDOException $e) {
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			$resp['sql'] = $sql;
			return json_encode($resp);
		}
	}

	public function save_class()
	{
		extract($_POST);

		try {
			//call manageClass_insert(:course_id, :department_id, :level, :section)

			// Create a new PDO instance
			$pdo = $this->conn;

			// Set the PDO error mode to exception
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// Prepare the SQL call to the stored procedure
			$sql = "CALL manageClass_insert(:course_id, :department_id, :level, :section)";

			if (isset($_POST['id']) && (!empty($_POST['id']))) {
				$sql = "CALL manageClass_update(:id, :course_id, :department_id, :level, :section)";
			}

			// Prepare the statement
			$stmt = $pdo->prepare($sql);

			// Bind parameters
			$stmt->bindParam(':course_id', $course_id, PDO::PARAM_INT);
			$stmt->bindParam(':department_id', $department_id, PDO::PARAM_INT);
			$stmt->bindParam(':level', $level, PDO::PARAM_INT);
			$stmt->bindParam(':section', $section, PDO::PARAM_STR);

			if (isset($_POST['id']) && (!empty($_POST['id']))) {
				$stmt->bindParam(':id', $id, PDO::PARAM_INT);
			}

			// Execute the statement
			$stmt->execute();

			$this->settings->set_flashdata('success', " Class Successfully saved.");
			return 1;
		} catch (Exception $e) {
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
	}

	public function delete_class()
	{
		extract($_POST);

		//call manageClass_delete(:id)
		try {
			$pdo = $this->conn;
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$sql = "CALL manageClass_delete(:id)";

			$stmt = $pdo->prepare($sql);
			$stmt->bindParam(':id', $id, PDO::PARAM_INT);
			$stmt->execute();

			$this->settings->set_flashdata('success', " Class is deleted.");
			return 1;
		} catch (Exception $e) {
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}
	}

	public function student_class()
	{
		extract($_POST);

		try {
			// Create a new PDO instance
			$pdo = $this->conn;

			// Set the PDO error mode to exception
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// Prepare the SQL call to the stored procedure
			$sql = "CALL InsertStudentClass(:academic_year_id_param, :student_id_param, :class_id_param)";

			if (isset($_POST['id']) && (!empty($_POST['id']))) {
				$sql = "CALL UpdateStudentClass(:id, :academic_year_id_param, :student_id_param, :class_id_param)";
			}


			// Prepare the statement
			$stmt = $pdo->prepare($sql);

			// Bind parameters

			if (isset($_POST['id']) && (!empty($_POST['id']))) {
				$stmt->bindParam(':id', $id, PDO::PARAM_INT);
			}

			$stmt->bindParam(':academic_year_id_param', $academic_year_id, PDO::PARAM_INT);
			$stmt->bindParam(':student_id_param', $student_id, PDO::PARAM_INT);
			$stmt->bindParam(':class_id_param', $class_id, PDO::PARAM_INT);

			// Execute the statement
			$stmt->execute();

			$this->settings->set_flashdata('success', " Student is Successfully assigned");
			return 1;
		} catch (PDOException $e) {
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			$resp['sql'] = $sql;
			return json_encode($resp);
		}
	}


	public function load_class_subject()
	{
		extract($_POST);

		$this->conn->beginTransaction();

		try {
			//call removeClassSubject($class_id, $academic_year_id)
			$stmt = $this->conn->prepare("CALL deleteAllBindSubjectsToClass(:academic_year_id, :class_id)");
			$stmt->bindParam(':class_id', $class_id, PDO::PARAM_INT);
			$stmt->bindParam(':academic_year_id', $academic_year_id, PDO::PARAM_INT);
			$stmt->execute();

			//loop subject_id
			foreach ($subject_id as $key => $value) {
				//call bindClassSubject($class_id, $academic_year_id, $subject_id)
				$stmt = $this->conn->prepare("CALL bindSubjectsToClass(:academic_year_id, :class_id, :subject_id)");
				$stmt->bindParam(':class_id', $class_id, PDO::PARAM_INT);
				$stmt->bindParam(':academic_year_id', $academic_year_id, PDO::PARAM_INT);
				$stmt->bindParam(':subject_id', $subject_id[$key], PDO::PARAM_INT);
				$stmt->execute();
			}
		} catch (Exception $e) {
			// Rollback the transaction
			$this->conn->rollBack();
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}

		// Commit the transaction
		$this->conn->commit();
		$this->settings->set_flashdata('success', " Class Subject Loads Successfully saved.");
		return 1;
	}


	public function save_faculty()
	{
		extract($_POST);
		try {
			// Create a new PDO instance
			$pdo = $this->conn;

			// Set the PDO error mode to exception
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// Prepare the SQL call to the stored procedure
			$sql = "CALL insert_faculty(:faculty_id, :department_id, :firstname, :middlename, :lastname, :email, :contact, :gender, :address, :password, :dob, :avatar)";

			if (!empty($id) && isset($id)) {
				$sql = "CALL update_faculty(:id, :faculty_id, :department_id, :firstname, :middlename, :lastname, :email, :contact, :gender, :address, :password, :dob, :avatar)";
			}

			// Prepare the statement
			$stmt = $pdo->prepare($sql);

			if (!empty($id) && isset($id)) $stmt->bindParam(':id', $id, PDO::PARAM_INT);

			$password = md5($faculty_id);

			// Bind parameters
			$stmt->bindParam(':faculty_id', $faculty_id, PDO::PARAM_STR);
			$stmt->bindParam(':department_id', $department_id, PDO::PARAM_STR);
			$stmt->bindParam(':firstname', $firstname, PDO::PARAM_STR);
			$stmt->bindParam(':middlename', $middlename, PDO::PARAM_STR);
			$stmt->bindParam(':lastname', $lastname, PDO::PARAM_STR);
			$stmt->bindParam(':email', $email, PDO::PARAM_STR);
			$stmt->bindParam(':contact', $contact, PDO::PARAM_STR);
			$stmt->bindParam(':gender', $gender, PDO::PARAM_STR);
			$stmt->bindParam(':address', $address, PDO::PARAM_STR);
			$stmt->bindParam(':password', $password, PDO::PARAM_STR);
			$stmt->bindParam(':dob', $dob, PDO::PARAM_INT);
			$stmt->bindParam(':avatar', $avatar, PDO::PARAM_STR);


			// Execute the statement
			$stmt->execute();

			$this->settings->set_flashdata('success', " Faculty Successfully saved.");
			return 1;
		} catch (PDOException $e) {
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			$resp['sql'] = $sql;
			return json_encode($resp);
		}
	}


	public function delete_faculty()
	{
		extract($_POST);

		try {
			// Create a new PDO instance
			$pdo = $this->conn;

			// Set the PDO error mode to exception
			$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

			// Prepare the SQL call to the stored procedure
			$sql = "CALL deleteFacultyByID(:id)";

			// Prepare the statement
			$stmt = $pdo->prepare($sql);

			if (!empty($id) && isset($id)) $stmt->bindParam(':id', $id, PDO::PARAM_INT);

			$stmt->execute();

			$this->settings->set_flashdata('success', " Faculty is deleted.");
			return 1;
		} catch (PDOException $e) {
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			$resp['sql'] = $sql;
			return json_encode($resp);
		}
		return 1;
	}



	/**
	 * Load faculty subjects
	 * @return string
	 */
	public function load_faculty_subj()
	{
		extract($_POST);

		//create a PDO transaction
		$this->conn->beginTransaction();

		//call removeClassBindFaculty($faculty_id)
		$stmt = $this->conn->prepare("CALL removeClassBindFaculty(:faculty_id)");
		$stmt->bindParam(':faculty_id', $faculty_id, PDO::PARAM_INT);
		$stmt->execute();

		try {



			//loop class_subj
			foreach ($class_subj as $key => $value) {
				$ex = explode("_", $class_subj[$key]);
				$class_id = $ex[0];
				$subject_id = $ex[1];

				//call bindFacultyToClasses($faculty_id, $academic_year_id, $class_id, $subject_id)
				$stmt = $this->conn->prepare("CALL bindFacultyToClasses(:faculty_id, :academic_year_id, :class_id, :subject_id)");
				$stmt->bindParam(':faculty_id', $faculty_id, PDO::PARAM_INT);
				$stmt->bindParam(':academic_year_id', $academic_year_id, PDO::PARAM_INT);
				$stmt->bindParam(':class_id', $class_id, PDO::PARAM_INT);
				$stmt->bindParam(':subject_id', $subject_id, PDO::PARAM_INT);
				$stmt->execute();
			}
		} catch (Exception $e) {
			// Rollback the transaction
			$this->conn->rollBack();
			// Handle errors
			var_dump($e->getMessage());
			$resp['err'] = "error saving data";
			return json_encode($resp);
		}

		// Commit the transaction
		$this->conn->commit();
		$this->settings->set_flashdata('success', " Faculty is deleted.");
		return 1;
	}

}

$Master = new Master();
$action = !isset($_GET['f']) ? 'none' : strtolower($_GET['f']);
$sysset = new SystemSettings();
switch ($action) {
	case 'save_academic':
		echo $Master->save_academic();
		break;
	case 'delete_academic':
		echo $Master->delete_academic();
		break;
	case 'save_department':
		echo $Master->save_department();
		break;
	case 'delete_department':
		echo $Master->delete_department();
		break;

	case 'save_course':
		echo $Master->save_course();
		break;
	case 'delete_course':
		echo $Master->delete_course();
		break;

	case 'save_subject':
		echo $Master->save_subject();
		break;
	case 'delete_subject':
		echo $Master->delete_subject();
		break;
	case 'save_student':
		echo $Master->save_student();
		break;
	case 'delete_student':
		echo $Master->delete_student();
		break;
	case 'save_class':
		echo $Master->save_class();
		break;
	case 'delete_class':
		echo $Master->delete_class();
		break;
	case 'student_class':
		echo $Master->student_class();
		break;
	case 'load_class_subject':
		echo $Master->load_class_subject();
		break;
	case 'save_faculty':
		echo $Master->save_faculty();
		break;
	case 'delete_faculty':
		echo $Master->delete_faculty();
		break;
	case 'faculty_class':
		echo $Master->load_faculty_subj();
		break;
	// case 'save_lesson':
	// 	echo $Master->save_lesson();
	// 	break;
	default:
		// echo $sysset->index();
		break;
}
