/*校验用户名   2-4位中文*/
var check1 = false;
/*检验密码长度必须大于等于6位  数字英文组成*/
var check2 = false;
/*再次输入密码*/
var check3 = false;
/*输入组织名称*/
var check4 = false;
/*身份证验证*/
var check5 = false;

/*判断发送短信按钮是否被点击*/
var isClick = false; /*倒计时按钮是否被点击*/
/*邮件验证*/
var check6 = false;
var wait = 6; /*发送邮件倒计时*/
var send = true; /*send发送邮件次数开关*/
var email = $('#org_email').val(); /*获取邮件输入值进行ajax请求*/
/*判断验证码输入是否为空*/
var check7 = false;

//匹配邮箱
var checkempty = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

var checkname = /^[\u4e00-\u9fa5]{2,4}$/; //匹配2-4个中文
var checknotnull = /^$| /; //匹配为空或者空格//验证验证码不能为空
var checkeidcard = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/; //身份证验证

//验证邮箱

$("#org_email").blur(function() {
	if(!checkempty.test($("#org_email").val())) {
		$("#org_email").css("border", "2px solid #D9534F");
		check6 = false;
		console.log("判断邮箱错误");
	} else {
		$("#org_email").css("border", "1px #D9D9D9 solid").css("border-left", "none");
		check6 = true;
		console.log("判断邮箱正确");
	}
});

//验证邮箱

function checkemail() {
	if(check6) {
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
				/*1.ajax请求发送邮件*/
				$.post("/VolunteerManagementSystem/EmailServlet?action=getOrgRegistCode", {
					'email' :  $('#org_email').val()
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
		console.log(check6 + "11");
		alert("输入邮箱错误");

	}

}

/*用户名应该为2-4位中文*/
$("#org_person").focus(function() {
	$(this).next().text('用户名应该为2-4位中文').css("color", "#008000");
}).blur(function() {
	if(!checkname.test($("#org_person").val())) {
		$("#hint_org_person").text("*输入有误").css("color", "#FF0000");
		check1 = false;
	} else {
		$("#hint_org_person").text("");
		check1 = true;
	}
});
/*密码不能为空且大于等于6位*/
$("#org_password").focus(function() {
	$(this).next().text('密码必须大于等于6位').css("color", "#008000");
}).blur(function() {
	if($("#org_password").val().length < 6 || checknotnull.test($("#org_password").val())) {
		$("#hint_org_password").text("*输入有误").css("color", "#FF0000");
		check2 = false;
	} else {
		$("#hint_org_password").text("");
		check2 = true;
	}
});
/*两次输入密码判断*/
$("#org_repassword").blur(function() {
	if($("#org_password").val().length >= 6 && !checknotnull.test($("#org_password").val()) && $("#org_password").val() == ($("#org_repassword").val())) {
		$("#hint_org_repassword").text("").css("color", "#FF0000");
		check3 = true;
	} else {
		$("#hint_org_repassword").text("*输入有误").css("color", "#FF0000");
		check3 = false;
	}
});

/*输入的组织名称  不能为空*/
$("#org_name").focus(function() {
	$(this).next().text('组织名称不能为空').css("color", "#008000");
}).blur(function() {
	if(checknotnull.test($("#org_name").val())) {
		$("#hint_org_name").text("*输入有误").css("color", "#FF0000");
		check4 = false;
	} else {
		$("#hint_org_name").text("");
		check4 = true;
	}
});

/*输入真实身份证信息格式*/
$("#org_idCard").focus(function() {
	$(this).next().text('真实身份证信息').css("color", "#008000");
}).blur(function() {
	if(!checkeidcard.test($("#org_idCard").val())) {
		$("#hint_org_idCard").text("*输入有误").css("color", "#FF0000");
		check5 = false;
	} else {
		$("#hint_org_idCard").text("");
		check5 = true;
	}
});

/*输入的验证码不能为空*/
$("#org_regist_code").focus(function() {
	$(this).next().text('验证码不能为空').css("color", "#008000");
}).blur(function() {
	if(checknotnull.test($("#org_regist_code").val())) {
		$("#hint_org_regist_code").text("*输入有误").css("color", "#FF0000");
		check7 = false;
	} else {
		$("#hint_org_regist_code").text("");
		check7 = true;
	}
});



$("#org_name").focus(function() {
	$(this).next().text('组织名称不能为空').css("color", "#008000");
}).blur(function() {
	if(checknotnull.test($("#org_name").val())) {
		$("#hint_org_name").text("*输入有误").css("color", "#FF0000");
		check4 = false;
	} else {
		$("#hint_org_name").text("");
		check4 = true;
	}
});
//省市联动

var pcarr = []; //数组定义 数组的序号用字符串
pcarr["厦门市"] = ["思明区", "湖里区", "集美区", "海沧区", "同安区", "翔安区"];

for(var p in pcarr) { //对数组pcarr进行循环
	$("<option value='" + p + "'>" + p + "</option>")
		.appendTo($("#city"));
}
//给省下拉框设置值改变的事件
$("#city").change(function() {
	$("#county")[0].length = 1; //长度为1,只留下拉的一个选项
	var pv = $(this).val(); //得到下拉框省的值
	var cc = pcarr[pv];
	$.each(cc, function() {
		$("<option value='" + this + "'>" + this + "</option>")
			.appendTo($("#county"));
	});
});

//提交表单   
/*check1校验用户名 */
/*check2检验密码长度必须大于等于6位  数字英文组成*/
/*check3再次输入密码*/
/*check4输入组织名称*/
/*check5身份证验证*/
/*isClick判断发送短信按钮是否被点击*/
/* check6邮件验证*/
 /*wait发送邮件倒计时*/
/*send发送邮件次数开关*/
/*check7判断验证码输入是否为空*/


$("#org_regist_sumbit").click(function() {
	console.log(check1+"用户名 "+check2+"密码"+check3+"再次"+check4+"组织名称"+check5+"身份证"+check6+"邮件验证"+check7+"验证码"+isClick+"：是否点击");
	if(window.confirm("确定要注册吗？")){
		/*验证地址选择不能为空*/

		if($("#city").val() == "" || $("#county").val() == "") {
		alert("请您选择地址信息")
		return false;
	} else {
		if(isClick) {

			if(check1 && check2 && check3 && check4&& check5&& check6&& check7) {

				/*表单提交*/
				$("#org_regist_form").submit();

			} else {
				alert("部分信息填写有误，表单未提交")
				return false;
			}
		} else {
			alert("您尚未获取验证码")
			return false;
		}
	}

	}
	
});





