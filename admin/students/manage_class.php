<?php
require_once('../../config.php');
$student_id = $_GET['student_id'];

class ManageClassPage
{
	private $conn;
	private $settings;

	function __construct()
	{
		$this->conn = (new DBConnection())->conn;
		$this->settings = new SystemSettings();
	}

	function getSettings()
	{
		return $this->settings;
	}

	function getAllClassByStudentID($id)
	{
		$stmt = $this->conn->prepare("CALL getAllClassByStudentID(?)");

		$stmt->bindParam(1, $id, PDO::PARAM_STR);
		$stmt->execute();

		// Fetch all rows from the result set
		$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

		return $rows;
	}

	function getAllClasses()
	{
		$stmt = $this->conn->prepare("CALL getAllClasses()");
		$stmt->execute();

		// Fetch all rows from the result set
		$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

		return $rows;
	}
}

$classPage = new ManageClassPage();
$settings = $classPage->getSettings();
$classes = $classPage->getAllClasses();
$studentByClass = $classPage->getAllClassByStudentID($student_id);

$id = null;
$academic_year_id = null;
$class_id = null;

if (count($studentByClass) > 0) {
	$id = $studentByClass[0]['id'];
	$academic_year_id = $studentByClass[0]['academic_year_id'];
	$class_id = $studentByClass[0]['class_id'];
}


$academic_year_id = isset($academic_year_id) ? $academic_year_id : $settings->userdata('academic_id');

?>
<div class="container-fluid">
	<div class="col-md-12">
		<form action="" id="manage_class">
			<input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
			<input type="hidden" name="student_id" value="<?php echo isset($student_id) ? $student_id : ''; ?>">
			<input type="hidden" name="academic_year_id" value="<?php echo $academic_year_id; ?>">
			<div class="form-group">
				<label for="class_id" class="control-label">Class</label>
				<select name="class_id" id="class_id" class="custom-select custom-select-sm select2" required="">
					<?php foreach ($classes as $k => $class) : ?>
						<option value="<?php echo $class['id'] ?>" <?php echo isset($class_id) && $class_id == $class['id'] ? 'selected' : '' ?>><?php echo $class['class'] ?></option>
					<?php endforeach; ?>
				</select>
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
				url: _base_url_ + "classes/Master.php?f=student_class",
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
					} else {
						console.log(resp)
						end_loader();
					}
				}
			})

		})
	})
</script>