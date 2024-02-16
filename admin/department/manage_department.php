<?php

require_once __DIR__ . '/../../BasePage.php';

class ManageDepartmentsData extends BasePage
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getDepartment($id)
    {
        $stmt = $this->getConnection()->prepare("SELECT * FROM vw_getAllDepartments WHERE id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        return $result;
    }
}

$id = $_GET['id'] ?? '';
$page = new ManageDepartmentsData();

if(!empty($id)){
    $data = $page->getDepartment($id);
    foreach($data as $k => $v){
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
        <form action="" id="manage_department">
            <input type="hidden" name="id" value="<?php echo isset($id) ? $id : ''; ?>">
            <div class="form-group">
                <label for="department" class="control-label">Department</label>
                <input type="text" name="department" id="department" required class="form-control form-control-sm" value="<?php echo isset($department) ? $department : ''; ?>">
            </div>
            <div class="form-group">
                <label for="description" class="control-label">Description</label>
                <textarea name="description" id="description" cols="30" rows="3" class="form-control" required=""><?php echo isset($description) ? $description : ''; ?></textarea>
            </div>
        </form>
    </div>
</div>


<script>
    $(document).ready(function() {
        $('#manage_department').submit(function(e) {
            e.preventDefault();
            start_loader();
            $('#msg').html('')
            $.ajax({
                url: _base_url_ + "classes/Master.php?f=save_department",
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
                        $('#msg').html('<span class="alert alert-danger w-fluid">Department already Exist.</span>')
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