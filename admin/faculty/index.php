<?php

require_once __DIR__ . '/../../BasePage.php';

class FacultyPage extends BasePage
{
	public function __construct()
	{
		parent::__construct();
	}

	public function getAllFaculties()
	{
		$stmt = $this->getConnection()->prepare("SELECT * FROM vw_getFaculties");
		$stmt->execute();

		// Fetch all rows from the result set
		$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

		return $rows;
	}
}

$page = new FacultyPage();
$_settings = $page->getSettings();

$rows = $page->getAllFaculties();

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
				<a class="btn btn-block btn-sm btn-default btn-flat border-primary new_faculty" href="javascript:void(0)"><i class="fa fa-plus"></i> Add New</a>
			</div>
		</div>
		<div class="card-body">
			<table class="table tabe-hover table-bordered" id="list">
				<thead>
					<tr>
						<th class="text-center">#</th>
						<th>Avatar</th>
						<th>Faculty ID</th>
						<th>Name</th>
						<th>Department</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<?php
					$i = 1;

					foreach($rows as $k => $row):
					?>
						<tr>
							<th class="text-center"><?php echo $i++ ?></th>
							<td>
								<center><img src="<?php echo validate_image($row['avatar']) ?>" alt="" class="img-thumbnail border-rounded" width="75px" height="75px" style="object-fit: cover;"></center>
							</td>
							<td><b><?php echo $row['faculty_id'] ?></b></td>
							<td><b><?php echo $row['faculty_name'] ?></b></td>
							<td><b><?php echo $row['department'] ?></b></td>
							<td class="text-center">
								<div class="btn-group">
									<button type="button" class="btn btn-default btn-block btn-flat dropdown-toggle dropdown-hover dropdown-icon" data-toggle="dropdown" aria-expanded="false">
										Action
										<span class="sr-only">Toggle Dropdown</span>
									</button>
									<div class="dropdown-menu" role="menu" style="">
										<a class="dropdown-item action_class" href="javascript:void(0)" data-id="<?php echo $row['id'] ?>">Load Class</a>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item action_edit" href="javascript:void(0)" data-id="<?php echo $row['id'] ?>">Edit</a>
										<div class="dropdown-divider"></div>
										<a class="dropdown-item action_delete" href="javascript:void(0)" data-id="<?php echo $row['id'] ?>">Delete</a>
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
		$('.new_faculty').click(function() {
			uni_modal("New Faculty", "./faculty/manage.php", 'mid-large')
		})
		$('.action_edit').click(function() {
			uni_modal("Manage Faculty", "./faculty/manage.php?id=" + $(this).attr('data-id'), 'mid-large')
		})
		$('.action_class').click(function() {
			uni_modal("Load Class", "./faculty/manage_class.php?faculty_id=" + $(this).attr('data-id'), 'mid-large')
		})
		$('.view_faculty').click(function() {
			uni_modal("Person's CTS Card", "./faculty/card.php?id=" + $(this).attr('data-id'))
		})
		$('.action_delete').click(function() {
			_conf("Are you sure to delete this faculty?", "delete_faculty", [$(this).attr('data-id')])
		})
		$('#list').dataTable()
	})

	function delete_faculty($id) {
		start_loader()
		$.ajax({
			url: _base_url_ + 'classes/Master.php?f=delete_faculty',
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