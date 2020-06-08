<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />

		<link rel="stylesheet" href="${ctx }/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx }/css/font-awesome.min.css" />
		<title></title>
	</head>

	<style type="text/css">
		* {
			box-sizing: border-box;
			padding: 0px;
			margin: 0px;
			list-style: none;
			text-decoration: none;
		}
		
		h3 {
			font-size: 14px;
			color: #3E9EA5;
			font-weight: bold;
			margin: 5px;
			margin-top: 10px;
		}
		
		hr {
			margin-top: 10px;
			margin-bottom: 10px;
		}
		
		body {
			background: rgb(243, 243, 243);
		}
		
		.son_body {
			background: white;
			border: 1px solid #ECECEC;
		}
		
		th {
			background-color: #D1D1D1;
			text-align: center;
		}
		
		td {}
		/*-------------按钮--------------*/
	</style>

	<body>

		<div class="son_body">
			<div class="container-fluid">
				<div class="row">
					<h3>账号安全</h3>
					<hr />
				</div>

			</div>

			<div class="container">
				<div class="row">
					<div class="col-md-2">

					</div>
					<div class="col-md-8">
						<div class="row" style="padding-top: 50px;">
							<div class="col-md-6">
								<h2 style="margin: 0;font-size: 18px;">账号密码</h2>
								<span style="font-size: 12px;">用于保护账号信息和登录安全</span>

							</div>
							<div class="col-md-6">
								<a href="" class="btn btn-success  col-md-6" data-toggle="modal" data-target="#updpass_Modal">修改</a>
							</div>
						</div>
						<div class="row" style="padding-top: 50px;padding-bottom: 50px;">
							<div class="col-md-6">
								<h2 style="margin: 0;font-size: 18px;">更换邮箱</h2>
								<span style="font-size: 12px;">新邮箱接收验证码后，可以进行修改邮箱</span>
							</div>
							<div class="col-md-6">
								<a href="" class="btn btn-success  col-md-6" data-toggle="modal" data-target="#updemail_Modal">更换</a>
							</div>
						</div>
					</div>
					<div class="col-md-2">

					</div>
				</div>

			</div>

		</div>
		<!-- 更新密码 -->
		<div class="modal fade bs-example-modal-sm" id="updpass_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title text-center" id="myModalLabel">修改密码</h4>
					</div>
					<div class="modal-body">
						<form action="${ctx }/UserServlet?action=userupdPassword" method="post" id="updpwd_form">
							<div class="form-group " id="yuan_psw_hint">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1"><i class="fa fa-lock" style="font-size: 18px;" aria-hidden="true"></i></span>
									<input id="yuan_psw" type="text" name="oldpwd" class="form-control " placeholder="请输入原密码" aria-describedby="basic-addon1">
								</div>
							</div>

							<div class="form-group " id="new_psw_hint">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1"><i class="fa fa-lock" style="font-size: 18px;" aria-hidden="true"></i></span>
									<input type="text" class="form-control " name="newpwd" id="new_psw" placeholder="请输入新密码" aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="form-group " id="renew_psw_hint">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1"><i class="fa fa-lock" style="font-size: 18px;" aria-hidden="true"></i></span>
									<input type="text" class="form-control " id="renew_psw" placeholder="请再次输入新密码" aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="modal-footer">
								<span class="pull-left" style="color: #6C6C6C;">
			新密码不少于6位
		</span>
								<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
								<button id="updpwd_btn" class="btn btn-primary" type="button">提交</button>
							</div>
						</form>
					</div>

				</div>
			</div>
		</div>

		<!-- 更换邮箱 -->
		<div class="modal fade bs-example-modal-sm" id="updemail_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title text-center" id="myModalLabel">修改邮箱</h4>
					</div>
					<div class="modal-body">
						<form action="${ctx }/UserServlet?action=userupdEmail" method="post" id="updemail_form">
							<div class="form-group ">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">旧邮箱</span>
									<input type="text" class="form-control " name="oldemail" readonly="readonly" aria-describedby="basic-addon1" value="${user.UEmail }">
								</div>
							</div>

							<div class="form-group  " id="emailcheck_hint">
								<div class="input-group ">

									<span class="input-group-addon" id="basic-addon1">新邮箱</span>
									<input type="text" id="emailcheck" name="newemail" class="form-control  col-md-10 " placeholder="请输入新邮箱" aria-describedby="basic-addon1">

									<span class="input-group-btn">
        <input class="btn btn-success " type="button" id="btn_resend_email" onclick="checkemail();" value="发送验证码">
      </span>

								</div>
							</div>
							<div class="form-group " id="emailcodecheck_hint">
								<div class="input-group">
									<span class="input-group-addon">验证码</span>
									<input type="text" class="form-control " name="user_updemail_code" id="emailcodecheck" placeholder="请输入新邮箱验证码" aria-describedby="basic-addon1">
								</div>
							</div>
							<div class="modal-footer">
								<span class="pull-left" id="fasong"></span>
								<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
								<button type="button" id="updemail_btn" class="btn btn-primary">提交</button>
							</div>
						</form>
					</div>

				</div>
			</div>
		</div>
	</body>
	<!--JQuery   popper   bootstrap-->
	<script src="${ctx }/js/jquery.min.js" type="text/javascript" charset="utf-8"></script>

	<!--下拉提示框使用-->
	<script src="${ctx }/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctx }/js/ui/user_safe.js" type="text/javascript" charset="utf-8"></script>

</html>