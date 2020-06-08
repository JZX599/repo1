package Servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import daomain.Organize;
import daomain.User;
import factory.FactoryDao;
import util.Constant;
import util.MD5Utils;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	String contextPath = "";

	// 志愿者登录//组织登录
	public void user_org_login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("登录的servlet访问成功");

		String loginID = request.getParameter("login_ID");
		String login_password = request.getParameter("login_password");
		String login_code = request.getParameter("login_code");
		String login_type = request.getParameter("login_type");
		try {
			if (request.getSession().getAttribute("checkcode").equals(login_code)) {

				if (login_type.equals("user_login")) {

					User user = FactoryDao.getUserDaoInstance().userLogin(loginID, MD5Utils.getMD5Code(login_password));

					if (user != null) {
						// 登录成功
						if (user.getUState() == Constant.User_State_Pass) {
							request.getSession().removeAttribute("orgnaize");
							request.getSession().setAttribute("user", user);
							System.out.println("志愿者登录成功");
							response.getWriter().write("<script>alert('登录成功');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/index.jsp");

						} else {
							response.getWriter().write("<script>alert('该志愿者账号被冻结请联系管理员解冻！');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");

						}
					} else {
						response.getWriter().write("<script>alert('账号或者密码错误！');</script>");
						response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");

					}
				} else {
					Organize organize = FactoryDao.getIOrganizeDaoInstance().orgLogin(loginID,
							MD5Utils.getMD5Code(login_password));
					if (organize != null) {
						if (organize.getOState() == Constant.Org_State_Pass) {
							// 组织审核通过 去掉session中如果有志愿者存在就删除session
							request.getSession().removeAttribute("user");
							request.getSession().setAttribute("organize", organize);
							System.out.println("组织登录成功");
							response.getWriter().write("<script>alert('登录成功');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/index.jsp");

						} else if (organize.getOState() == Constant.Org_State_Wait) {
							response.getWriter().write("<script>alert('登录失败，组织待审核！');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");

						} else if (organize.getOState() == Constant.Org_State_Restrict) {
							response.getWriter().write("<script>alert('登录失败，组织被限制登录！');</script>");
							response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
						}
					} else {
						response.getWriter().write("<script>alert('账号或者密码错误！');</script>");
						response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
					}
				}
				System.out.println("session获取的验证码：" + request.getSession().getAttribute("checkcode"));

			} else {
				response.getWriter().write("<script>alert('验证码输入有误');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
			}
		} catch (SQLException e) {

			e.printStackTrace();
		}

	}

}
