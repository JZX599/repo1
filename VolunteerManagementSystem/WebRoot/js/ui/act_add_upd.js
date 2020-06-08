//时间格式化
$('#datetimepicker1').datetimepicker({
	format: 'YYYY-MM-DD HH:mm:ss'
});
$('#datetimepicker2').datetimepicker({

	format: 'YYYY-MM-DD HH:mm:ss'
});
$("#btn_res").click(function() {
	alert($('#time2').val());
});
//匹配时间格式
var reDateTime = /^(?:19|20)[0-9][0-9]-(?:(?:0[1-9])|(?:1[0-2]))-(?:(?:[0-2][1-9])|(?:[1-3][0-1])) (?:(?:[0-2][0-3])|(?:[0-1][0-9])):[0-5][0-9]:[0-5][0-9]$/;
var checkname = /^[\u4e00-\u9fa5]{2,4}$/; //匹配2-4个中文
var checknotnull = /^$| /; //匹配为空或者空格//验证验证码不能为空
var checkint2 = /^\d+$/; //匹配非负整数加0   活动积分
var checkint = /^[1-9]\d*$/; //匹配非负整数不加0  预计招募人数
var checkphone = /^1[34578]\d{9}$/; //匹配手机号
var check1 = false;
var check2 = false;
var check3 = false;
var check4 = false;
var check5 = false;
var check6 = false;
var check7 = false; //判断活动开始时间是否在一天以后
var check8 = false;
var check9 = false;//活动地址不为空
/*check8手机号*/
$("#APhone").focus(function() {

	$("#APhone_input").attr("class", "col-xs-6 has-success");
}).blur(function() {
	if(!checkphone.test($("#APhone").val())) {
		$("#APhone_input").attr("class", "col-xs-6 has-error");
		check8 = false;
	} else {
		$("#APhone_input").attr("class", "col-xs-6 has-success");
		check8 = true;
	}
});

/*check9活动地址*/
$("#AAddress").focus(function() {

	$("#AAddress_input").attr("class", "col-xs-6 has-success");
}).blur(function() {
	if(checknotnull.test($("#AAddress").val())) {
		$("#AAddress_input").attr("class", "col-xs-6 has-error");
		check9 = false;
	} else {
		$("#AAddress_input").attr("class", "col-xs-6 has-success");
		check9 = true;
	}
});


/*check1活动名称*/
$("#AName").focus(function() {

	$("#AName_input").attr("class", "col-xs-6 has-success");
}).blur(function() {
	if(checknotnull.test($("#AName").val())) {
		$("#AName_input").attr("class", "col-xs-6 has-error");
		check1 = false;
	} else {
		$("#AName_input").attr("class", "col-xs-6 has-success");
		check1 = true;
	}
});

if(checkphone.test($("#APhone").val())) {
		check8 = true;
	}
if(!checknotnull.test($("#AName").val())) {
		check1 = true;
	}
if(!checknotnull.test($("#AAddress").val())) {
		check9 = true;
	}
if(checkname.test($("#APerson").val())) {
		check4 = true;
	}
if(checkint.test($("#ANumber").val())) {
		check5 = true;
	}
if(checkint2.test($("#AIntegral").val())) {
		check6 = true;
	}

/*check2活动开始时间*/
$("#AStartDate").focus(function() {

	$("#AStartDate_input").attr("class", "col-xs-6 has-success");
}).blur(function() {
	if(!reDateTime.test($("#AStartDate").val())) {
		$("#AStartDate_input").attr("class", "col-xs-6 has-error");
		check2 = false;

	} else {
		var nowDate = new Date();
		var tomorrow = new Date(nowDate.getTime() + 24 * 60 * 60 * 1000);
		var Fifteen = new Date(nowDate.getTime() + 15 * 24 * 60 * 60 * 1000);
		var year = tomorrow.getFullYear();
		//获取当前月
		var month = tomorrow.getMonth() + 1;
		//获取当前日
		var date = tomorrow.getDate();
		var h = tomorrow.getHours(); //获取当前小时数(0-23)
		var m = tomorrow.getMinutes(); //获取当前分钟数(0-59)
		var s = tomorrow.getSeconds();
		var year1 = Fifteen.getFullYear();
		//获取当前月
		var month1 = Fifteen.getMonth() + 1;
		//获取当前日
		var date1 = Fifteen.getDate();
		var h1 = Fifteen.getHours(); //获取当前小时数(0-23)
		var m1 = Fifteen.getMinutes(); //获取当前分钟数(0-59)
		var s1 = Fifteen.getSeconds();

		var tomorrowDate = year + '-' + getNow(month) + "-" + getNow(date) + " " + getNow(h) + ':' + getNow(m) + ":" + getNow(s);
		var FifteenDate = year1 + '-' + getNow(month1) + "-" + getNow(date1) + " " + getNow(h1) + ':' + getNow(m1) + ":" + getNow(s1);
		console.log(FifteenDate + "FifteenDate" + tomorrowDate + "tomorrowDate" + "现在时间" + $("#AStartDate").val());

		function getNow(s) {

			return s < 10 ? '0' + s : s;
		}
		if($("#AStartDate").val() < tomorrowDate || $("#AStartDate").val() > FifteenDate) {
			$("#AStartDate_input").attr("class", "col-xs-6 has-error");
			check2 = false;
			check7 = false;
			console.log(check2 + "eeeeeeeeee" + check7 + 'wwww');
		} else {
			$("#AStartDate_input").attr("class", "col-xs-6 has-success");
			check2 = true;
			check7 = true;
		}
	}
	console.log(check2 + "eeeeeeeeee");
});

/*check3活动结束时间*/
$("#AEndDate").focus(function() {
	$("#AEndDate_input").attr("class", "col-xs-6 has-success");
}).blur(function() {
	if(!reDateTime.test($("#AEndDate").val())) {

		$("#AEndDate_input").attr("class", "col-xs-6 has-error");
		check3 = false;

	} else if(check7 && $("#AEndDate").val() > $("#AStartDate").val()) {
		$("#AEndDate_input").attr("class", "col-xs-6 has-success");
		check3 = true;

	} else {
		$("#AEndDate_input").attr("class", "col-xs-6 has-error");
		check3 = false;
	}
});





/*check4活动联系人*/
$("#APerson").focus(function() {
	$("#APerson_input").attr("class", "col-xs-6 has-success");
}).blur(function() {
	if(!checkname.test($("#APerson").val())) {
		$("#APerson_input").attr("class", "col-xs-6 has-error");
		check4 = false;
	} else {
		$("#APerson_input").attr("class", "col-xs-6 has-success");
		check4 = true;
	}
});

/*check5预计招募人数*/
$("#ANumber").focus(function() {
	$("#ANumber_input").attr("class", "col-xs-6 has-success");
}).blur(function() {
	if(!checkint.test($("#ANumber").val())) {
		$("#ANumber_input").attr("class", "col-xs-6 has-error");
		check5 = false;
	} else {
		$("#ANumber_input").attr("class", "col-xs-6 has-success");
		check5 = true;
	}
});

/*check6活动积分*/
$("#AIntegral").focus(function() {
	$("#AIntegral_input").attr("class", "col-xs-6 has-success");
}).blur(function() {
	if(!checkint2.test($("#AIntegral").val())) {
		$("#AIntegral_input").attr("class", "col-xs-6 has-error");
		check6 = false;
	} else {
		$("#AIntegral_input").attr("class", "col-xs-6 has-success");
		check6 = true;
	}
});





$("#upd_act_sub").click(function() {
	console.log(check9 + "check9活动名称 "+check1 + "check1活动名称 " + check2 + "check2活动开始时间" + check3 + "check3活动结束时间" + check4 + "check4活动联系人" + check5 + "check5预计招募人数" + check6 + "check6活动积分");
	if(window.confirm("确定要提交吗？")) {
		/*验证地址选择不能为空*/
		if($("#city").val() == "" || $("#county").val() == "") {

			alert("请您选择地址信息");
			return false;
		} else if(!check7) {

			alert("活动开始时间必须在一天以后且在十五天以内");
			$("#AStartDate_input").attr("class", "col-xs-6 has-error");

		} else if(!check3) {
			alert("活动结束时间必须在活动开始时间以后");
			$("#AEndDate_input").attr("class", "col-xs-6 has-error");
		} else {

		if(check1){
					if(check2){
					if(check4){
					if(check5){
					if(check6){
					if(check8){
					if(check9){
				$("#upd_act_form").submit();
					}else{
						$("#AAddress_input").attr("class", "col-xs-6 has-error");
					}
				}else{
					$("#APhone_input").attr("class", "col-xs-6 has-error");
				}
				}else{
					$("#AIntegral_input").attr("class", "col-xs-6 has-error");
				}
				}else{
					$("#ANumber_input").attr("class", "col-xs-6 has-error");
				}
				}else{
				$("#APerson_input").attr("class", "col-xs-6 has-error");
				}
				}else{
					$("#AStartDate_input").attr("class", "col-xs-6 has-error");
				}
			}else{
				$("#AName_input").attr("class", "col-xs-6 has-error");
			}

		}

	}

});


$("#add_act_sub").click(function() {
	console.log(check9 + "check9活动名称 "+check1 + "check1活动名称 " + check2 + "check2活动开始时间" + check3 + "check3活动结束时间" + check4 + "check4活动联系人" + check5 + "check5预计招募人数" + check6 + "check6活动积分");
	if(window.confirm("确定要提交吗？")) {
		 if(!check7) {

			alert("活动开始时间必须在一天以后且在十五天以内");
			$("#AStartDate_input").attr("class", "col-xs-6 has-error");

		} else if(!check3) {
			alert("活动结束时间必须在活动开始时间以后");
			$("#AEndDate_input").attr("class", "col-xs-6 has-error");
		} else {

			if(check1 && check2 && check4 && check5 && check6 && check8&& check9) {

				/*表单提交*/
				$("#add_act_form").submit();

			} else {
				alert("部分信息填写有误")
				return false;
			}

		}

	}

});