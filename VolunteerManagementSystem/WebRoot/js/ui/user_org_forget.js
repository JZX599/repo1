/*身份证验证*/
var check1 = false;

/*邮箱验证*/
/*判断发送短信按钮是否被点击*/
var isClick = false; /*倒计时按钮是否被点击*/
var wait = 6; /*发送邮件倒计时*/
var send = true; /*send发送邮件次数开关*/
/*邮件验证*/
var check2 = false;


/*检验密码长度必须大于等于6位  数字英文组成*/
var check3 = false;
/*再次输入密码*/
var check4 = false;

/*验证码   不为空   */
var check5 = false;

//匹配邮箱
var checkempty = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
var checknotnull = /^$| /; //匹配为空或者空格//验证验证码不能为空
var checkeidcard = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; //身份证验证

/*check1身份证验证*/
$("#forget_IdCard").blur(function() {
			if(checkeidcard.test($("#forget_IdCard").val())) {
				$("#forget_IdCard").css("border", "1px #D9D9D9 solid").css("border-left", "none");//正确
				check1 = true;
			} else {
				$("#forget_IdCard").css("border", "2px solid #D9534F");//错误
				check1 = false;
			}
		});
/*邮箱验证*/
$("#forget_Email").blur(function() {
	if(!checkempty.test($("#forget_Email").val())) {
		$("#forget_Email").css("border", "2px solid #D9534F");
		check2 = false;
		console.log("判断邮箱错误");
	} else {
		$("#forget_Email").css("border", "1px #D9D9D9 solid").css("border-left", "none");
		check2 = true;
		console.log("判断邮箱正确");
	}
});

//check2验证邮箱

function checkemail() {
	if(check2) {
		console.log("输ru邮箱正确");

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
				$.post("/VolunteerManagementSystem/EmailServlet?action=getForgetCode", {
					'email' :  $('#forget_Email').val()
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
		console.log("输ru邮箱错误");
		console.log(check2 + "11");
		alert("输入邮箱错误");

	}

}

/*check3新密码不能为空且大于等于6位*/
$("#forget_password").blur(function() {
	if($("#forget_password").val().length < 6 || checknotnull.test($("#forget_password").val())) {
	$("#forget_password").css("border", "2px solid #D9534F");//错误
		check3 = false;
	} else {
		$("#forget_password").css("border", "1px #D9D9D9 solid").css("border-left", "none");//正确
		check3 = true;
	}
});

/*check4两次输入密码判断*/
$("#forget_repassword").blur(function() {
	if($("#forget_password").val().length >= 6 && !checknotnull.test($("#forget_password").val()) && $("#forget_password").val() == ($("#forget_repassword").val())) {
		$("#forget_repassword").css("border", "1px #D9D9D9 solid").css("border-left", "none");//正确
		check4 = true;
	} else {
		$("#forget_repassword").css("border", "2px solid #D9534F");//错误
		check4 = false;
	}
});




/*check5验证码   不为空   */
$("#forget_Code").blur(function() {
			if(!checknotnull.test($("#forget_Code").val())) {
				$("#forget_Code").css("border", "1px #D9D9D9 solid").css("border-left", "none");//正确
				check5 = true;
			} else {
				$("#forget_Code").css("border", "2px solid #D9534F");//错误
				check5 = false;
			}
		});
		

/*check1身份证验证
 * check2验证邮箱
 * check3新密码不能为空且大于等于6位
 * check4两次输入密码
 *  check5验证码
 * */

$("#forget_sumbit").click(function() {
	console.log(check1+"身份证 "+check2+"邮箱"+check3+"新密码"+check4+"再次"+check5+"验证码"+isClick+"：是否点击");
	if(window.confirm("确定要重置密码吗？")){
		if(isClick) {
			if(check1 && check2 && check3 && check4&& check5) {
				/*表单提交*/
				$("#forget_form").submit();
			} else {
				alert("部分信息填写有误，表单未提交")
				return false;
			}
		} else {
			alert("您尚未获取验证码")
			return false;
		}
	}
});
