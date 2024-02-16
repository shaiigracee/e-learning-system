<?php 

require_once __DIR__ . '/../../BasePage.php';;

class LoadClassSubjectPage extends BasePage
{
	public function __construct()
	{
		parent::__construct();
	}

	public function getActiveAssignedClasses($faculty_id)
	{
		$stmt = $this->getConnection()->prepare("CALL getFacultyClassBind(?)");
		$stmt->bindParam(1, $faculty_id, PDO::PARAM_INT);
		$stmt->execute();

		// Fetch all rows from the result set
		$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

		return $rows;
	}

	public function getClassSubjectsByAcademicYear($academic_year_id)
	{
		$stmt = $this->getConnection()->prepare("CALL getAllClassSubjectsByActiveAY(?)");
		$stmt->bindParam(1, $academic_year_id, PDO::PARAM_INT);
		$stmt->execute();

		// Fetch all rows from the result set
		$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

		return $rows;
	}

	public function getOnlyIDMerges($id)
	{
		$rows = $this->getActiveAssignedClasses($id);
		return array_map(function($data) {
			return $data['class_subj'];
		}, $rows);
	}

}

$academic_year_id = isset($academic_year_id) ? $academic_year_id : $_settings->userdata('academic_id');

$faculty_id = isset($_GET['faculty_id']) ? $_GET['faculty_id'] : '';

$page = new LoadClassSubjectPage();
$class_subj_arr = $page->getOnlyIDMerges($faculty_id);
$classes = $page->getClassSubjectsByAcademicYear($academic_year_id);


?>
<div class="container-fluid">
	<div class="col-md-12">
		<form action="" id="manage_class">
			<input type="hidden" name="faculty_id" value="<?php echo isset($faculty_id) ? $faculty_id : ''; ?>">
			<input type="hidden" name="academic_year_id" value="<?php echo isset($academic_year_id) ? $academic_year_id : ''; ?>">
			<div class="form-group">
				<label for="class_subj" class="control-label">Class</label>
				<select name="class_subj[]" id="class_subj" class="custom-select custom-select-sm select2" required="" multiple="multiple">
					<?php 
					foreach($classes as $v => $row):
					?>
						<option value="<?php echo $row['id_merged'] ?>" <?php echo isset($class_subj_arr) && (in_array($row['id_merged'], $class_subj_arr)) ? 'selected' : '' ?>><?php echo $row['subj'] ?></option>
					<?php endforeach; ?>
				</select>
			</div>
		</form>
	</div>
</div>


<script>
	$(document).ready(function(){
		$('.select2').select2();
		$('#manage_class').submit(function(e){
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url:_base_url_+"classes/Master.php?f=faculty_class",
				method:"POST",
				data:$(this).serialize(),
				error:err=>{
					console.log(err)
					alert_toast("An error occured.","error")
					end_loader();
				},
				success:function(resp){
					if(resp == 1){
						location.reload()
					}else{
						console.log(resp)
						end_loader();
					}
				}
			})

		})
	})
</script>