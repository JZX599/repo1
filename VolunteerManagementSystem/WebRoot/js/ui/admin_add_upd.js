//验证密码 6- 20个数字 英文 字符 
var checkpwd = /^(\w){6,20}$/;

var checknotnull = /^$| /; //匹配为空或者空格 //名称 不能为空

/*check1 验证修改管理员 名称 不能为空*/
var check1 = false;
/*check2 验证修改管理员 密码 6- 20个数字 英文 字符 */
var check2 = false;

/*check3 验证添加管理员 名称 不能为空*/
var check3 = false;
/*check4 验证添加管理员 密码 6- 20个数字 英文 字符 */
var check4 = false;


/***************************************修改*****************************************/
/*check1 验证修改管理员 名称 不能为空*/
if(!checknotnull.test($("#input_Aname").val())) {
		check1 = true;
		console.log("管理员修改名称正确");
	}
	
	
$("#input_Aname").blur(function() {
	if(checknotnull.test($("#input_Aname").val())) {
		$("#input_Aname_hint").attr("class", "form-group has-error");
		check1 = false;
		console.log("管理员修改名称不能为空");
	} else {
		$("#input_Aname_hint").attr("class", "form-group has-success");
		check1 = true;
		console.log("管理员修改名称正确");
	}

});


/*check2 验证修改管理员 密码 6- 20个数字 英文 字符 */
$("#input_APwd").blur(function() {

if(!checkpwd.test($("#input_APwd").val())) {
		$("#input_APwd_hint").attr("class", "form-group has-error");
		check2 = false;
		console.log("管理员修改密码格式有误");
	} else {
		$("#input_APwd_hint").attr("class", "form-group has-success");
		check2 = true;
		console.log("管理员修改密码格式正确");
	}
});



$("#updadmin_btn").click(function() {
	if(check1) {
		if(check2) {
		
				$('#updadmin_form').submit();
			} else {
				$("#input_APwd_hint").attr("class", "form-group has-error");
			}
		} else {
			$("#input_Aname_hint").attr("class", "form-group has-error");
		}
	
});

$('#upd_admin').on('show.bs.modal', function(event) {
	var button = $(event.relatedTarget) // Button that triggered the modal
	var recipient = button.data('whatever')
	var recipient1 = button.data('aid')
	// Extract info from data-* attributes
	// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	var modal = $(this)

	modal.find('.modal-body #input_Aname').val(recipient)
	modal.find('.modal-body #input_AId').val(recipient1)
});


/***************************************添加*****************************************/


/*check3 验证添加管理员 名称 不能为空*/
if(!checknotnull.test($("#add_Aname").val())) {
		check1 = true;
		console.log("管理员添加名称正确");
	}
	
	
$("#add_Aname").blur(function() {
	if(checknotnull.test($("#add_Aname").val())) {
		$("#add_Aname_hint").attr("class", "form-group has-error");
		check1 = false;
		console.log("管理员添加名称不能为空");
	} else {
		$("#add_Aname_hint").attr("class", "form-group has-success");
		check1 = true;
		console.log("管理员添加名称正确");
	}

});


/*check4 验证添加管理员 密码 6- 20个数字 英文 字符 */
$("#add_APwd").blur(function() {

if(!checkpwd.test($("#add_APwd").val())) {
		$("#add_APwd_hint").attr("class", "form-group has-error");
		check2 = false;
		console.log("管理员添加密码格式有误");
	} else {
		$("#add_APwd_hint").attr("class", "form-group has-success");
		check2 = true;
		console.log("管理员添加密码格式正确");
	}
});



$("#addadmin_btn").click(function() {
	if(check1) {
		if(check2) {
		
				$('#addadmin_form').submit();
			} else {
				$("#add_APwd_hint").attr("class", "form-group has-error");
			}
		} else {
			$("#add_Aname_hint").attr("class", "form-group has-error");
		}
	
});
