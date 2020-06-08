<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%String ctx=request.getContextPath();
pageContext.setAttribute("ctx", ctx);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
		
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/user_org_login.css"/>
	</head>
	<body>
			<!--头部-->
		<header></header>
		<!--中部-->
		<article>

<!--头部提示登录页面-->
<div class="login_top">
	<h1>登录</h1>
	
</div>
<!--中部from表单提交登录-->
<form id="login_form" action="${ctx }/LoginServlet?action=user_org_login" method="post">
	
<div class="login_body">
	<div class="login_username">
		<span></span>
		<input type="text" name="login_ID" id="input_username"  placeholder="ID" />
	</div>
	<div class="login_password">
		<span></span>
		<input type="password" name="login_password" id="input_password" value="" placeholder="密码" />
	</div>
	<div class="login_check">
		
		<input type="text" name="login_code" id="input_check" value="" placeholder="验证码"/>
		<img src="${ctx }/CheckCodeServlet" onclick="change(this)"></img>
	</div>
	<div class="login_type">
			<label>登录方式：</label>
		<input type="radio" name="login_type" id="" value="user_login"  checked="checked" class="radio_type" /><label>志愿者</label>
		<input type="radio" name="login_type" id="" value="org_login" class="radio_type" /><label >组织</label>
	</div>
	<div class="login_btn">
		<input type="button" name="" id="login_sumbit"  value="登录" />
	</div>
	

</div>

</form>

<!--尾部 跳转注册 忘记密码 管理员登录页面-->
<div class="login_bottom">
	<a href="user_register.jsp">志愿者注册</a><span>|</span><a href="${ctx }/organize/org_register.jsp">组织注册</a><span>|</span><a href="${ctx }/admin/admin_login.jsp">管理员登录</a>
		<div class="a_jump">
			
		<a href="user_org_forget.jsp">忘记密码？</a>
	
		</div>
</div>

		</article>
		<!--尾部-->
		<%@ include file="footer.jsp" %>
	</body>
	<script type="text/javascript" src="${ctx }/js/jquery.min.js"></script>
	
<script type="text/javascript">
	$(function() {
		var check1=false;
		var check2=false;
		var check3=false;
		var checknotnull = /^$| /; //匹配为空或者空格//验证验证码不能为空
		//用户名不能为空
			$("#input_username").blur(function() {
				if(!checknotnull.test($("#input_username").val())) {
					$("#input_username").css("border","1px #D9D9D9 solid").css("border-left","none");
					check1=true;
				} else {
				$("#input_username").css("border","2px solid #D9534F");
				}
			});
			//密码不能为空
			$("#input_password").blur(function() {
				if(!checknotnull.test($("#input_password").val())) {
					$("#input_password").css("border","1px #D9D9D9 solid").css("border-left","none");
					check2=true;
				} else {
				/*alert("您输入的密码不能为空");*/
				$("#input_password").css("border","2px solid #D9534F");
				}
			});
		//验证码不能为空
			$("#input_check").blur(function() {
				if(!checknotnull.test($("#input_check").val())) {
					$("#input_check").css("border","1px #D9D9D9 solid").css("border-left","none");
					check3=true;
				} else {
					$("#input_check").css("border","2px solid #D9534F");
				}
			});
			
			
			//提交表单
			
			$("#login_sumbit").click(function () {
			
				if(check1&&check2&&check3){
				
	/*表单提交*/
				$("#login_form").submit();
		
				}else{
					alert("信息填写有误，表单未提交")
					return false;
				}
			});
	});
	
	
	/* 登录验证码 */
	function change(obj){
	obj.src="${ctx}/CheckCodeServlet?recash="+new Date().getTime();
	}
</script>
</html>
