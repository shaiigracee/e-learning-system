<?php

require_once __DIR__ . '/../../BasePage.php';

class ManageSubjectData extends BasePage
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getSubject($id)
    {
        $stmt = $this->getConnection()->prepare("SELECT * FROM vw_getallsubjects where id = ?");
        $stmt->execute(array($id));
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result;
    }

}

$id = isset($_GET['id']) ? $_GET['id'] : '';
$page = new ManageSubjectData();

if(!empty($id)){
    $subject = $page->getSubject($id);
    foreach($subject as $k => $v){
        $$k = $v;
    }
}

?>

<?php if ($page->getSettings()->chk_flashdata('success')) : ?>
    <script>
        alert_toast("<?php echo $page->getSettings()->flashdata('success') ?>", 'success')
    </script>
<?php endif; ?>

<?php if ($page->getSettings()->chk_flashdata('error')) : ?>
    <script>
        alert_toast("<?php echo $page->getSettings()->flashdata('error') ?>", 'error')
    </script>
<?php endif; ?>



<div class="container-fluid">
	<div class="col-lg-12">
		<div id="msg" class="form-group"></div>
		<form action="" id="manage_subject">
			<input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
			<div class="form-group">
				<label for="subject_code" class="control-label">Subject Code</label>
				<input type="text" name="subject_code" id="subject_code" required class="form-control form-control-sm" value="<?php echo isset($subject_code) ? $subject_code : ''; ?>">
			</div>
			<div class="form-group">
				<label for="description" class="control-label">Description</label>
				<textarea name="description" id="description" cols="30" rows="3" class="form-control" required=""><?php echo isset($description) ? $description : ''; ?></textarea>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function(){
		$('#manage_subject').submit(function(e){
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url:_base_url_+"classes/Master.php?f=save_subject",
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
					}else if(resp ==2){
						$('#msg').html('<span class="alert alert-danger w-fluid">subject already Exist.</span>')
						end_loader();
					}else{
						console.log(resp)
						end_loader();
					}
				}
			})

		})
	})
</script>