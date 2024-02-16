<?php

require_once '../config.php';

class StudentsPage
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

	function getStudentList()
	{
		$stmt = $this->conn->prepare("SELECT * FROM vw_getAllStudents");
		$stmt->execute();

		// Fetch all rows from the result set
		$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

		return $rows;
	}
}

$student_page = new StudentsPage();
$students = $student_page->getStudentList();

?>

<?php if ($_settings->chk_flashdata('success')) : ?>
	<script>
		alert_toast("<?php echo $_settings->flashdata('success') ?>", 'success')
	</script>
<?php endif; ?>
<div class="col-lg-12">
	<div class="card card-outline card-primary">
		<div class="card-header">
			<div class="card-tools">
				<a class="btn btn-block btn-sm btn-default btn-flat border-primary new_student" href="javascript:void(0)"><i class="fa fa-plus"></i> Add New</a>
			</div>
		</div>
		<div class="card-body">
			<table class="table tabe-hover table-bordered" id="list">
				<thead>
					<tr>
						<th class="text-center">#</th>
						<th>Avatar</th>
						<th>Student ID</th>
						<th>Name</th>
						<th>Current Class</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<?php $i = 1; ?>
					<?php foreach($students as $k => $student): ?>
						<tr>
							<th class="text-center"><?php echo $i++ ?></th>
							<td>
								<center><img src="<?php echo validate_image($student['avatar'] ?? '') ?>" alt="" class="img-thumbnail border-rounded" width="75px" height="75px" style="object-fit: cover;"></center>
							</td>
							<td><b><?php echo $student['student_id'] ?></b></td>
							<td><b><?php echo ucwords($student['student_lastname'] . ", " . $student['student_firstname'] . ' ' . $student['student_middlename']) ?></b></td>
							<td><b><?php echo $student['class'] ?></b></td>
							<td class="text-center">
								<div class="btn-group">
									<button type="button" class="btn btn-default btn-block btn-flat dropdown-toggle dropdown-hover dropdown-icon" data-toggle="dropdown" aria-expanded="false">
										Action
										<span class="sr-only">Toggle Dropdown</span>
									</button>
									<div class="dropdown-menu" role="menu" style="">
										<a class="dropdown-item action_class" href="javascript:void(0)" data-id="<?php echo $student['id'] ?>">Update Class</a>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item action_edit" href="javascript:void(0)" data-id="<?php echo $student['id'] ?>">Edit</a>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item action_delete" href="javascript:void(0)" data-id="<?php echo $student['id'] ?>">Delete</a>
									</div>
								</div>
							</td>
						</tr>
					<?php endforeach; ?>
				</tbody>
			</table>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		$('.new_student').click(function() {
			uni_modal("New Student", "./students/manage.php", 'mid-large')
		})
		$('.action_edit').click(function() {
			uni_modal("Manage Student", "./students/manage.php?id=" + $(this).attr('data-id'), 'mid-large')
		})
		$('.action_class').click(function() {
			uni_modal("Update Student Class", "./students/manage_class.php?student_id=" + $(this).attr('data-id'), 'mid-large')
		})
		$('.view_student').click(function() {
			uni_modal("Person's CTS Card", "./students/card.php?id=" + $(this).attr('data-id'))
		})
		$('.action_delete').click(function() {
			_conf("Are you sure to delete this Student?", "delete_student", [$(this).attr('data-id')])
		})
		$('#list').dataTable()
	})

	function delete_student($id) {
		start_loader()
		$.ajax({
			url: _base_url_ + 'classes/Master.php?f=delete_student',
			method: 'POST',
			data: {
				id: $id
			},
			success: function(resp) {
				if (resp == 1) {
					location.reload()
				}
			}
		})
	}
</script>