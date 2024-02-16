<?php 

require_once __DIR__ . '/../../BasePage.php';

class LoadSubjectPage extends BasePage
{
	public function __construct()
	{
		parent::__construct();
	}
	
	public function getAllClassSubjectsBind($academic_year_id, $class_id)
	{

		$stmt = $this->getConnection()->prepare("CALL getAllClassSubjectBind(?,?)");
		$stmt->bindParam(1, $academic_year_id, PDO::PARAM_INT);
		$stmt->bindParam(2, $class_id, PDO::PARAM_INT);
		$stmt->execute();

		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		
		return $result;
	
	}

	//get subject_id and store to array
	public function getSubjectIDs($academic_year_id, $class_id)
	{
		$rows = $this->getAllClassSubjectsBind($academic_year_id, $class_id);
		return array_map(function($class_subject) {
			return $class_subject['subject_id'];
		}, $rows);
	}


	public function getAllSubjects()
	{
		$stmt = $this->getConnection()->prepare("CALL getAllSubjects()");
		$stmt->execute();

		$result = $stmt->fetchAll(PDO::FETCH_ASSOC);
		
		return $result;
	
	}

}

$page = new LoadSubjectPage();
$_settings = $page->getSettings();


$class_id = $_GET['id'] ?? null;
$academic_year_id = ((int) ($_settings->userdata('academic_id') ?? 0));
$subject_arr= $page->getSubjectIDs($academic_year_id, $class_id);
$subjects = $page->getAllSubjects();



?>
<div class="container-fluid">
	<div class="col-md-12">
		<form action="" id="manage_class_subject">
			<input type="hidden" name="class_id" value="<?php echo isset($class_id) ? $class_id : ''; ?>">
			<input type="hidden" name="academic_year_id" value="<?php echo isset($academic_year_id) ? $academic_year_id : ''; ?>">
			<div class="form-group">
				<label for="subject_id" class="control-label">Class</label>
				<select name="subject_id[]" id="subject_id" class="custom-select custom-select-sm select2" required="" multiple="multiple">
					<?php 
					foreach ($subjects as $k => $row):
					?>
						<option value="<?php echo $row['id'] ?>" <?php echo isset($subject_arr) && (in_array($row['id'], $subject_arr)) ? 'selected' : '' ?>><?php echo $row['subject_code'] . " - ".$row['description'] ?></option>
					<?php endforeach; ?>
				</select>
			</div>
		</form>
	</div>
</div>


<script>
	$(document).ready(function(){
		$('.select2').select2();
		$('#manage_class_subject').submit(function(e){
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url:_base_url_+"classes/Master.php?f=load_class_subject",
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