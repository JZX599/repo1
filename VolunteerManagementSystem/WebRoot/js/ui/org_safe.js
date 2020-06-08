//匹配邮箱
var checkempty = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
var checknotnull = /^$| /; //匹配为空或者空格//验证验证码不能为空

//原密码
var check1 = false;
//新密码
var check2 = false;
//再次输入密码
var check3 = false;
/****************************************修改密码*********************************************************/
//验证码
var check7 = false;
//邮箱
var check6 = false;
/*******************************************修改邮箱******************************************************/
/****************************************修改密码*********************************************************/
if($("#yuan_psw").val().length < 6 || checknotnull.test($("#yuan_psw").val())) {
	check1 = false;
} else {
	check1 = true;
}

$("#yuan_psw").blur(function() {
	if($("#yuan_psw").val().length < 6 || checknotnull.test($("#yuan_psw").val())) {
		console.log("原密码输入有误");
		$("#yuan_psw_hint").attr("class", "form-group has-error");
		check1 = false;
	} else {
		console.log("原密码输入正确");
		$("#yuan_psw_hint").attr("class", "form-group has-success");
		check1 = true;
	}
});

/*----------新密码------*/

if($("#new_psw").val().length < 6 || checknotnull.test($("#new_psw").val())) {
	check2 = false;
} else {
	check2 = true;
}

$("#new_psw").blur(function() {
	if($("#new_psw").val().length < 6 || checknotnull.test($("#new_psw").val())) {
		console.log("新密码输入有误");
		$("#new_psw_hint").attr("class", "form-group has-error");
		check2 = false;
	} else {
		console.log("新密码输入正确");
		$("#new_psw_hint").attr("class", "form-group has-success");
		check2 = true;
	}
});

/*再次输入密码*/
$("#renew_psw").blur(function() {
	if($("#new_psw").val().length >= 6 && !checknotnull.test($("#new_psw").val()) && $("#new_psw").val() == ($("#renew_psw").val())) {
		$("#renew_psw_hint").attr("class", "form-group has-success");
		check3 = true;
		console.log("再次新密码输入正确");
	} else {
		$("#renew_psw_hint").attr("class", "form-group has-error");
		check3 = false;
		console.log("再次新密码输入有误");
	}
});

$('#updpwd_btn').click(function() {
	if(check1) {
		if(check2) {
			if(check3) {
				$('#updpwd_form').submit();
			} else {
				$("#renew_psw_hint").attr("class", "form-group has-error");
			}
		} else {
			$("#new_psw_hint").attr("class", "form-group has-error");
		}
	} else {
		$("#yuan_psw_hint").attr("class", "form-group has-error");
	}
});

/*******************************************修改密码********************************************/

/*******************************************修改邮箱******************************************************/
/*------------------验证码不为空check7------------------*/
if(checknotnull.test($("#emailcodecheck").val())) {
	check7 = false;
	console.log("判断邮箱验证码错误");
} else {
	check7 = true;
	console.log("判断邮箱验证码正确");
}

$("#emailcodecheck").blur(function() {
	if(checknotnull.test($("#emailcodecheck").val())) {
		$("#emailcodecheck_hint").attr("class", "form-group has-error");
		check7 = false;
		console.log("判断邮箱验证码错误");
	} else {
		$("#emailcodecheck_hint").attr("class", "form-group has-success");
		check7 = true;
		console.log("判断邮箱验证码正确");
	}
});
/*--------------------//验证邮箱----------------------------------*/
if(!checkempty.test($("#emailcheck").val())) {

	check6 = false;
	console.log("判断邮箱错误");
} else {

	check6 = true;
	console.log("判断邮箱正确");
}
$("#emailcheck").blur(function() {
	if(!checkempty.test($("#emailcheck").val())) {
		$("#emailcheck_hint").attr("class", "form-group has-error");
		check6 = false;
		console.log("判断邮箱错误");
	} else {
		$("#emailcheck_hint").attr("class", "form-group has-success");
		check6 = true;
		console.log("判断邮箱正确");
	}
});
/*--------------------------------------------------------------------*/

/*判断发送短信按钮是否被点击*/
var isClick = false; /*倒计时按钮是否被点击*/
/*邮件验证*/

var wait = 6; /*发送邮件倒计时*/
var send = true; /*send发送邮件次数开关*/
var email = $('#org_email').val(); /*获取邮件输入值进行ajax请求*/

function checkemail() {
	$("#btn_resend_email").attr("class", "btn btn-success ");
	if(check6) {
		console.log("发送验证码按钮验证输入邮箱正确");

		if(wait == 0) {
			$("#btn_resend_email").removeAttr("disabled");
			$("#btn_resend_email").attr("value", "发送验证码");
			wait = 6;
			send = true;

		} else {
			if(send) {
				console.log("请求发送邮件");
				isClick = true;
				/*1.ajax请求发送邮件*/
				$.post("/VolunteerManagementSystem/EmailServlet?action=getOrgUpdEmailCode", {
					'email': $('#emailcheck').val()
				}, function(o) {

				});

				/*2.send发送邮件次数开关*/
				send = false;

			}
			$("#btn_resend_email").attr("disabled", true);
			$("#btn_resend_email").attr("value", "重新发送(" + wait + "s)");
			wait--;
			// setTimeout() 方法用于在指定的毫秒数后调用函数或计算表达式
			setTimeout(function() { // 定时执行
				checkemail();
			}, 1000);
		}
	} else {
		console.log("发送验证码按钮验证输入邮箱错误");
		console.log(check6 + "11");
		$("#emailcheck_hint").attr("class", "form-group has-error");

	}

}
/*---------------更换邮箱按钮------------*/
$('#updemail_btn').click(function() {
	if(check6) {
		if(check7) {
			if(isClick) {
				$('#updemail_form').submit();
			} else {
				$("#btn_resend_email").attr("class", "btn btn-danger ");
			}
		} else {
			$("#emailcodecheck_hint").attr("class", "form-group has-error");
		}
	} else {

		$("#emailcheck_hint").attr("class", "form-group has-error");
	}
});