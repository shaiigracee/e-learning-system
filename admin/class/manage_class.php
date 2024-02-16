<?php

//require once BasePage.php
require_once __DIR__ . '/../../BasePage.php';

class ManageDataClass extends BasePage
{
	public function __construct()
	{
		parent::__construct();
	}

	public function getDepartments()
	{
		$stmt = $this->getConnection()->prepare("CALL getDepartments()");
		$stmt->execute();

		// Fetch all rows from the result set
		$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

		return $rows;
	}

	public function getAllCourses()
	{
		$stmt = $this->getConnection()->prepare("CALL getAllCourses()");
		$stmt->execute();

		// Fetch all rows from the result set
		$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

		return $rows;
	
	}

	public function getClassById($id)
	{
		$stmt = $this->getConnection()->prepare("SELECT * FROM vw_getAllClasses WHERE id = ?");
		$stmt->execute(array($id));
		$result = $stmt->fetch(PDO::FETCH_ASSOC);
		return $result;
	}

}

$page = new ManageDataClass();
$departments = $page->getDepartments();
$courses = $page->getAllCourses();

$id =  $_GET['id'] ?? null;

if(!empty($id)){
	$class = $page->getClassById($id);
	foreach ($class as $key => $value) {
		$$key = $value;
	}
}

?>


<div class="container-fluid">
	<div class="col-lg-12">
		<div id="msg" class="form-group"></div>
		<form action="" id="manage_class">
			<input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
			<div class="form-group">
				<label for="department_id" class="control-label">Department</label>
				<select name="department_id" id="department_id" class="custom-select custom-select-sm select2" required="">
					<?php
					foreach ($departments as $k => $row):
					?>
						<option value="<?php echo $row['id'] ?>" <?php echo isset($department_id) && $department_id == $row['id'] ? 'selected' : '' ?>><?php echo $row['department'] ?></option>
					<?php endforeach; ?>
				</select>
			</div>
			<div class="form-group">
				<label for="course_id" class="control-label">Course</label>
				<select name="course_id" id="course_id" class="custom-select custom-select-sm select2" required="">
					<?php
					foreach ($courses as $k => $row):
					?>
						<option value="<?php echo $row['id'] ?>" <?php echo isset($course_id) && $course_id == $row['id'] ? 'selected' : '' ?>><?php echo $row['course'] ?></option>
					<?php endforeach; ?>
				</select>
			</div>
			<div class="form-group">
				<label for="level" class="control-label">Level</label>
				<input type="text" name="level" id="level" required class="form-control form-control-sm" value="<?php echo isset($level) ? $level : ''; ?>">
			</div>
			<div class="form-group">
				<label for="level" class="control-label">Section</label>
				<input type="text" name="section" id="section" required class="form-control form-control-sm" value="<?php echo isset($section) ? $section : ''; ?>">
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		$('.select2').select2();
		$('#manage_class').submit(function(e) {
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url: _base_url_ + "classes/Master.php?f=save_class",
				method: "POST",
				data: $(this).serialize(),
				error: err => {
					console.log(err)
					alert_toast("An error occured.", "error")
					end_loader();
				},
				success: function(resp) {
					if (resp == 1) {
						location.reload()
					} else if (resp == 2) {
						$('#msg').html('<span class="alert alert-danger w-fluid">Class already Exist.</span>')
						end_loader();
					} else {
						console.log(resp)
						end_loader();
					}
				}
			})

		})
	})
</script>