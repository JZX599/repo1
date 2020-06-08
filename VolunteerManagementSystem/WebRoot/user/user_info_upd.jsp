<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
	
		<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css"/>
		<link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/bootstrapValidator.css"/>
		<link rel="stylesheet" type="text/css" href="../css/ui/act_list_add_upd.css" />
		
		<title></title>
		<style type="text/css">
			* {
				box-sizing: border-box;
				padding: 0px;
				margin: 0px;
				list-style: none;
				text-decoration: none;
			}
			
			.info_a {
				font-size: 14px;
				font-weight: bold;
			}
			
			th {
				background-color: #F0F0F0;
				/*text-align: center;*/
			}
			
			.form-group {
				padding-top: 5px;
			}
		</style>
	</head>

	<body>

		<div class="son_body" style="margin-top: -20px">
			<div class="container-fluid">
				<div class="row">
					<h3>个人信息</h3>
					<hr />
				</div>

				<div class="container">
					<div class="row">
						<div class="col-lg-10 col-lg-offset-1">
	<form id="user_info_from" method="post" class="form-horizontal" action="${ctx }/UserServlet?action=userupdinfo">
							
								<div class="panel-group" id="steps">
									<!-- 查看信息 -->
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title"><a class="info_a" data-toggle="collapse" data-parent="#steps" href="#stepOne">基本信息</a></h4>
										</div>
										<div id="stepOne" class="panel-collapse collapse in">
											<div class="panel-body">
												<table class="table table-bordered" border="" cellspacing="" cellpadding="">
													<tr>
														<th>志愿者编号</th>
														<td>${user.UId }</td>
														<th>姓名</th>
														<td>${user.UName }</td>
													</tr>
													<tr>
														<th>性别</th>
														<td>${user.USex }</td>
														<th>身份证号</th>
														<td>${user.UIdCard }</td>
													</tr>
													<tr>
														<th>积分</th>
														<td>${user.UIntegral } 分</td>
														<th>地址</th>
														<td>${user.UAddress }</td>
													</tr>
													<tr>
														<th>手机号</th>
														<td>${user.UPhone }</td>
														<th>邮箱</th>
														<td>${user.UEmail }</td>

													</tr>
													<tr>
														<th>信誉度</th>
<td>


<c:if test="${user.UCredit<=0 }">
						<c:forEach begin="0" end="5">
							<i class="fa fa-star-o" style="color: #F0E50F;font-size: 14px" aria-hidden="true"></i>
						</c:forEach>
					</c:if>
								
					<c:if test="${user.UCredit>0 && user.UCredit<6 }">
						<c:forEach begin="0" end="${user.UCredit-1 }">
								<i class="fa fa-star" style="color: #F0E50F;font-size: 14px"
											aria-hidden="true"></i>
						</c:forEach> 
						<c:forEach begin="0" end="${5-user.UCredit}">
								<i class="fa fa-star-o" style="color: #F0E50F;font-size: 14px"
											aria-hidden="true"></i>
						</c:forEach>
					</c:if>
					<c:if test="${user.UCredit>=6 }">
								<c:forEach begin="0" end="5">
										<i class="fa fa-star" style="color: #F0E50F;font-size: 14px"
											aria-hidden="true"></i>
								</c:forEach>
					</c:if>
													
</td>
														<th>注册时间</th>
														<td>${user.UDate }</td>

													</tr>
													<tr>
														<th>服务时长</th>
														<td>${user.UHours } 小时</td>

														<th>账号状态</th>
														<td>
														<c:if test="${user.UState ==1 }">正常</c:if>
														<c:if test="${user.UState ==2 }">冻结</c:if>
														</td>
													</tr>

												</table>
											</div>
										</div>
									</div>

									<!-- 修改信息 -->
								
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title"><a class="info_a" data-toggle="collapse" data-parent="#steps" href="#stepTwo">修改信息</a></h4>
										</div>
										<div id="stepTwo" class="panel-collapse collapse ">
											<div class="panel-body">

												<div class="form-group">
													<label class="col-xs-3 control-label">姓名</label>
													<div class="col-xs-5">
														<input type="text" class="form-control" name="UName" value="${user.UName }"/>
													</div>
												</div>
												<div class="form-group">
													<label class="col-xs-3 control-label">身份证</label>
													<div class="col-xs-5">
														<input type="text" class="form-control input-sm" name="UIdCard" value="${user.UIdCard }" />
													</div>
												</div>
												<div class="form-group">
													<label class="col-xs-3 control-label">手机</label>
													<div class="col-xs-5">
														<input type="text" class="form-control" name="UPhone" value="${user.UPhone }"/>
													</div>
												</div>

												<div class="form-group">
													<label class="col-xs-3 control-label">性别</label>
													<div class="col-xs-5">
														<div class="btn-group" data-toggle="buttons">
														<c:if test="${user.USex eq '男' }">
															<label class="btn btn-man active">
											    <input type="radio" name="USex" value="男" checked="checked">男
											  </label>
															<label class="btn btn-woman" style="margin-left: 5px;">
											    <input type="radio" name="USex" value="女" >女
											  </label>
														</c:if>
														<c:if test="${user.USex eq '女' }">
															<label class="btn btn-man ">
											    <input type="radio" name="USex" value="男" >男
											  </label>
															<label class="btn btn-woman active" style="margin-left: 5px;">
											    <input type="radio" name="USex" value="女" checked="checked">女
											  </label>
														</c:if>
														</div>
													</div>
												</div>
												<div class="form-group">
													<label class="col-xs-3 control-label">地址</label>
													<div class="col-xs-5">
														<input type="text" class="form-control" name="UAddress" value="${user.UAddress }"/>
													</div>
												</div>

												<div class="form-group">

													<div class="col-xs-9 col-xs-offset-4">
														<button type="reset" class="btn btn-primary">重置</button>
														<button type="submit" class="btn btn-primary " >修改</button>
													</div>
												</div>

											</div>
										</div>
									</div>

								</div>
							</form>
							
						</div>
					</div>

				</div>

			</div>

		</div>

		

	</body>
		
		<script src="../js/jquery.min.js" type="text/javascript" charset="utf-8"></script>
	
		<script src="../js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="../js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
		
		<script src="../js/ui/user_org_infoupd.js" type="text/javascript" charset="utf-8"></script>
</html>