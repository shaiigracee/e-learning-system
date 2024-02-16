<?php
require_once '../config.php';

class Login extends DBConnection
{
	private $settings;
	public function __construct()
	{
		parent::__construct();
		$this->settings = new SystemSettings();
		ini_set('display_error', 1);
	}

	public function __destruct()
	{
		parent::__destruct();
	}

	public function index()
	{
		echo "<h1>Access Denied</h1> <a href='" . base_url . "'>Go Back.</a>";
	}

	public function login()
	{
		extract($_POST);

		$stmt = $this->conn->prepare("SELECT * FROM users WHERE username = :username AND password = MD5(:password)");
		$stmt->execute(array(':username' => $username, ':password' => $password));
		$user = $stmt->fetch(PDO::FETCH_ASSOC);

		if ($user) {
			foreach ($user as $k => $v) {
				if (!is_numeric($k) && $k != 'password') {
					$this->settings->set_userdata($k, $v);
				}
			}
			$this->settings->set_userdata('login_type', 1);

			$stmt = $this->conn->query("SELECT * FROM academic_year WHERE status = 1");
			$academic_year = $stmt->fetch(PDO::FETCH_ASSOC);
			foreach ($academic_year as $k => $v) {
				if (!is_numeric($k)) {
					$this->settings->set_userdata('academic_' . $k, $v);
				}
			}

			return json_encode(array('status' => 'success'));
		} else {
			return json_encode(array('status' => 'incorrect', 'last_qry' => "SELECT * FROM users WHERE username = '$username' AND password = MD5('$password')"));
		}
	}


	public function flogin()
	{
		extract($_POST);

		$stmt = $this->conn->prepare("SELECT * FROM faculty WHERE faculty_id = :faculty_id AND `password` = :password");
		$stmt->execute(array(':faculty_id' => $faculty_id, ':password' => md5($password)));
		$faculty = $stmt->fetch(PDO::FETCH_ASSOC);

		if ($faculty) {
			foreach ($faculty as $k => $v) {
				if (!is_numeric($k)) {
					$this->settings->set_userdata($k, $v);
				}
			}
			$this->settings->set_userdata('login_type', 2);

			$stmt = $this->conn->query("SELECT * FROM academic_year WHERE status = 1");
			$academic_year = $stmt->fetch(PDO::FETCH_ASSOC);
			foreach ($academic_year as $k => $v) {
				if (!is_numeric($k)) {
					$this->settings->set_userdata('academic_' . $k, $v);
				}
			}
			return json_encode(array('status' => 'success'));
		} else {
			return json_encode(array('status' => 'incorrect'));
		}
	}


	public function slogin()
	{
		extract($_POST);

		$stmt = $this->conn->prepare("SELECT * FROM students WHERE student_id = :student_id AND `password` = :password");
		$stmt->execute(array(':student_id' => $student_id, ':password' => md5($password)));
		$student = $stmt->fetch(PDO::FETCH_ASSOC);

		if ($student) {
			foreach ($student as $k => $v) {
				if (!is_numeric($k)) {
					$this->settings->set_userdata($k, $v);
				}
			}
			$this->settings->set_userdata('login_type', 3);

			$stmt = $this->conn->query("SELECT * FROM academic_year WHERE status = 1");
			$academic_year = $stmt->fetch(PDO::FETCH_ASSOC);
			foreach ($academic_year as $k => $v) {
				if (!is_numeric($k)) {
					$this->settings->set_userdata('academic_' . $k, $v);
				}
			}
			return json_encode(array('status' => 'success'));
		} else {
			return json_encode(array('status' => 'incorrect'));
		}
	}


	public function logout()
	{
		if ($this->settings->sess_des()) {
			redirect('admin/login.php');
		}
	}
	public function flogout()
	{
		if ($this->settings->sess_des()) {
			redirect('faculty/login.php');
		}
	}
	public function slogout()
	{
		if ($this->settings->sess_des()) {
			redirect('student/login.php');
		}
	}
}
$action = !isset($_GET['f']) ? 'none' : strtolower($_GET['f']);
$auth = new Login();
switch ($action) {
	case 'login':
		echo $auth->login();
		break;
	case 'flogin':
		echo $auth->flogin();
		break;
	case 'slogin':
		echo $auth->slogin();
		break;
	case 'logout':
		echo $auth->logout();
		break;
	case 'flogout':
		echo $auth->flogout();
		break;
	case 'slogout':
		echo $auth->slogout();
		break;
	default:
		echo $auth->index();
		break;
}
