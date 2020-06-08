package Servlet;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import daomain.Organize;
import daomain.User;
import factory.FactoryDao;
import util.MD5Utils;

/**
 * 组织和志愿者找回密码ForgetServlet
 */
@WebServlet("/ForgetServlet")
public class ForgetServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	String contextPath = "";

	public void forget(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("组织和志愿者找回密码ForgetServlet访问成功");
		String froget_type = request.getParameter("froget_type");// 类型
		String forget_IdCard = request.getParameter("forget_IdCard");// 身份证
		String forget_Email = request.getParameter("forget_Email");
		String forget_Code = request.getParameter("forget_Code");
		String forget_password = request.getParameter("forget_password");
		String ForgetEmail = (String) request.getSession().getAttribute("ForgetEmail");// session邮箱
		String ForgetCode = (String) request.getSession().getAttribute("ForgetCode");// session验证码
		// 1.系统判断session邮箱 与页面对应邮箱是否相同
		try {
			if (ForgetEmail.equals(forget_Email)) {
				// 相同
				// 2.判断邮箱验证码
				if (ForgetCode.toLowerCase().equals(forget_Code.toLowerCase())) {
					// 正确
					// 3.重置密码的类型 重置对应对象的密码
					if (froget_type.equals("user")) {
						// 4.通过邮箱与身份证查询 对应的
						/*
						 * FactoryDao.getIOrganizeDaoInstance().
						 * byEmailIdCardgetOrg
						 */

						if (FactoryDao.getUserDaoInstance().byEmailgetUser(forget_Email) != null) {
							User u = FactoryDao.getUserDaoInstance().byEmailIdCardgetUser(forget_Email, forget_IdCard);
							if (u != null) {
								// 查询组织信息成功 执行修改密码
								FactoryDao.getUserDaoInstance().byIdUpdUserPass(u.getUId(),
										MD5Utils.getMD5Code(forget_password));
								response.getWriter().write("<script>alert('重置密码成功！正在跳转登录页面');</script>");
								response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
							} else {
								response.getWriter().write("<script>alert('该邮箱绑定的身份证有误，请重新填写信息重置密码');</script>");
								response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_forget.jsp");

							}

						} else {
							response.getWriter().write("<script>alert('该邮箱尚未注册无需找回');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_forget.jsp");
						}

					} else if (froget_type.equals("organize")) {
						// 4.通过邮箱与身份证查询 对应的
						if (FactoryDao.getIOrganizeDaoInstance().byEmailgetOrg(forget_Email) != null) {
							Organize organize = FactoryDao.getIOrganizeDaoInstance().byEmailIdCardgetOrg(forget_Email,
									forget_IdCard);
							if (organize != null) {
								// 查询组织信息成功 执行修改密码
								FactoryDao.getIOrganizeDaoInstance().byIdUpdOrgPass(organize.getOId(), forget_password);
								response.getWriter().write("<script>alert('重置密码成功！正在跳转登录页面');</script>");
								response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
							} else {
								// 查询组织信息失败 不执行修改密码 提示您的身份证有误 该邮箱绑定的身份证有误
								// 返回找回密码页面
								response.getWriter().write("<script>alert('该邮箱绑定的身份证有误，请重新填写信息重置密码');</script>");
								response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_forget.jsp");
							}
						} else {
							response.getWriter().write("<script>alert('该邮箱尚未注册无需找回');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_forget.jsp");
						}
					} else {
						// 登录类型错误
						response.getWriter().write("<script>alert('页面的登录类型有误，请重新填写信息重置密码');</script>");
						response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_forget.jsp");
					}
				} else {
					// 验证码错误
					response.getWriter().write("<script>alert('重置密码失败,验证码输入有误');</script>");
					response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_forget.jsp");
				}
			} else {
				// 邮箱session保存与页面获取不同
				response.getWriter().write("<script>alert('重置密码失败,邮箱前后输入有误');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_forget.jsp");

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
