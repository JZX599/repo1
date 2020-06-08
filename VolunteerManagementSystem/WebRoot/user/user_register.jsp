<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%String ctx=request.getContextPath();
pageContext.setAttribute("ctx", ctx);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>用户注册页面</title>
				
		<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/user_org_register.css"/>
	</head>
	<body>
		<!--头部-->
		<header></header>
		<!--中部-->
		<article>
			<!--头部提示注册页面-->
			<div class="user_register_top">
				<h1>志愿者注册</h1>
			</div>
			
			<!--中部from表单提交注册-->
			<form id="user_register_form" action="${ctx}/RegistServlet?action=userRegist" method="post">
				<div class="user_register_body">
				
					<div class="user_register_username">
						<span></span>
						<input type="text" name="UName" id="user_name" value="" placeholder="姓名" />
					<label id="hint_user_name"></label>
					</div>
					<div class="user_register_idcard">
						<span></span>
						<input type="text" name="UIdCard" id="user_idcard" value="" placeholder="身份证号" />
						<label id="hint_user_idcard"></label>
					</div>
					
					
					<div class="user_register_phone">
						<span></span>
						<input type="text" name="UPhone" id="user_phone" value="" placeholder="手机号" />
						<label id="hint_user_phone"></label>
					</div>
					<div class="user_register_useraddress">
						<span></span>
						<input type="text" name="UAddress" id="user_address" value="" placeholder="家庭地址" />
						<label ></label>
					</div>
					
					<div class="user_register_password">
						<span></span>
						<input type="password" name="UPassword" id="user_password" value="" placeholder="密码" />
					<label id="hint_user_password"></label>
					</div>
					<div class="user_register_password">
						<span></span>
						<input type="password"  id="user_repassword" value="" placeholder="再次输入密码" />
					<label id="hint_user_repassword"></label>
					</div>
					<div class="user_register_email">
						<span></span>
						<input type="text" id="user_email" name="UEmail" value="" placeholder="邮箱" />
						<input type="button" class="" id="btn_resend_email" onclick="checkemail();" value="发送验证码" />
					</div>
					<div class="user_register_code">
						<span></span>
						<input type="text" name="user_regist_code" id="user_regist_code" value="" placeholder="验证码" />
						<label id="hint_user_regist_code"></label>
					</div>
					
					<div class="user_register_sex">
						<label>性别：</label>
						<input type="radio" name="USex" id="" value="男" checked="checked" class="radio_type" /><label>男</label>
						<input type="radio" name="USex" id="" value="女" class="radio_type" /><label>女</label>
					</div>
					<div class="user_register_btn">
						<input type="button" name="" id="user_regist_sumbit" value="注册" />

					</div>
					
			</form>
			<!--尾部 跳转注册 登录 页面-->
					<div class="login_bottom">
						<div class="a_jump">
							<a href="user_org_login.jsp">登录页面</a><span>|</span>
							<a href="${ctx }/organize/org_register.jsp">组织注册</a>
						</div>
					</div>
				</div>
			
		</article>
		
	<%@include file="footer.jsp" %>

		
	</body>
	<script type="text/javascript" src="${ctx }/js/jquery.min.js"></script>

	<script src="${ctx }/js/ui/user_register.js" type="text/javascript" charset="utf-8"></script>
</html>