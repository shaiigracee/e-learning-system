<?php

require_once __DIR__ . '/../../BasePage.php';

class ManageCourseData extends BasePage
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getCourse($id)
    {
        $stmt = $this->getConnection()->prepare("SELECT * FROM vw_getallcourses where id = ?");
        $stmt->execute([$id]);
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result;
    }
}

$id = isset($_GET['id']) ? $_GET['id'] : '';
$page = new ManageCourseData();

if(!empty($id)){
    $course = $page->getCourse($id);
    foreach($course as $k => $v){
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
        <form action="" method="post" id="manage_course" onsubmit="return validateForm()">
            <input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
            <div class="form-group">
                <label for="course" class="control-label">Course</label>
                <input type="text" name="course" id="course" required class="form-control form-control-sm" value="<?php echo isset($course) ? $course : ''; ?>">
            </div>
            <div class="form-group">
                <label for="description" class="control-label">Description</label>
                <textarea name="description" id="description" cols="30" rows="3" class="form-control" required=""><?php echo isset($description) ? $description : ''; ?></textarea>
            </div>
        </form>
    </div>
</div>

<script>
    function validateForm() {

        return true; 
    }
</script>






<script>
	$(document).ready(function(){
		$('#manage_course').submit(function(e){
			e.preventDefault();
			start_loader();
			$('#msg').html('')
			$.ajax({
				url:_base_url_+"classes/Master.php?f=save_course",
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
						$('#msg').html('<span class="alert alert-danger w-fluid">Course already Exist.</span>')
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