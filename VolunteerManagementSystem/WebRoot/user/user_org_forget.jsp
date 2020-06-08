<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%String ctx=request.getContextPath();
pageContext.setAttribute("ctx", ctx);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title></title>
	</head>

	<link rel="stylesheet" type="text/css" href="${ctx }/css/ui/user_org_forget.css" />

	<body>
		<!--头部-->
		<header></header>
		<!--中部-->
		<article>
			<!--头部提示登录页面-->
			<div class="forget_top">
				<h1>重置密码</h1>
			</div>
			<!--中部from表单提交登录-->
			<form id="forget_form" action="${ctx}/ForgetServlet?action=forget" method="post">
				<div class="forget_body">
					<div class="forget_username">
						<span></span>
						<input type="text" name="forget_IdCard" id="forget_IdCard" value="" placeholder="身份证" />
					</div>
					<div class="forget_email">
						<span></span>
						<input type="text" id="forget_Email" name="forget_Email" value="" placeholder="邮箱" />
						<input type="button" class="" id="btn_resend_email" onclick="checkemail();" value="发送验证码" />
					</div>
					<div class="forget_code">
						<span></span>
						<input type="text" name="forget_Code" id="forget_Code" value="" placeholder="验证码" />

					</div>
					
					<div class="forget_password">
						<span></span>
						<input type="password" name="forget_password" id="forget_password" value="" placeholder="新密码(长度大于等于6位)" />
					</div>
						<div class="forget_password">
						<span></span>
						<input type="password"  id="forget_repassword" value="" placeholder="再次输入密码" />
					</div>
					<div class="login_type">
						<label>找回：</label>
						<input type="radio" name="froget_type" id="" value="user" checked="checked" class="radio_type" /><label>志愿者</label>
						<input type="radio" name="froget_type" id="" value="organize" class="radio_type" /><label>组织</label>
					</div>
					<div class="forget_btn">
						<input type="button" name="" id="forget_sumbit" value="提交" />
					</div>

					<!--尾部 跳转注册 登录 页面-->
					<div class="login_bottom">
						<div class="a_jump">
							<a href="user_org_login.jsp">登录页面</a><span>|</span>
							<a href="user_register.jsp">志愿者注册</a>
							<span>|</span>
							<a href="${ctx }/organize/org_register.jsp">组织注册</a>
						</div>
					</div>
				</div>
			</form>
		</article>
		<!-- 尾部 -->
	<%@include file="footer.jsp" %>
	</body>
	<script type="text/javascript" src="${ctx }/js/jquery.min.js"></script>
	<script src="${ctx }/js/ui/user_org_forget.js" type="text/javascript" charset="utf-8"></script>

	

</html>