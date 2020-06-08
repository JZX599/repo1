package Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import daomain.Organize;
import daomain.User;
import factory.FactoryDao;
import util.MD5Utils;

/**
 * /OrganizeServlet?action=
 */
@WebServlet("/OrganizeServlet")
public class OrganizeServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	String contextPath = "";

	public void Logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("志愿者的servlet访问成功");
		request.getSession().removeAttribute("organize");
		response.getWriter().write("<script>alert('退出登录成功');</script>");
		response.setHeader("refresh", "1;url=" + contextPath + "/index.jsp");
	}

	// 通过组织id获取组织信息
	public void getOrgMsg(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("志愿者的servlet访问成功");
		Organize organize1 = null;
		organize1 = (Organize) request.getSession().getAttribute("organize");
		try {
			Organize organize = FactoryDao.getIOrganizeDaoInstance().getOrgbyOId(organize1.getOId());
			request.getSession().setAttribute("organize", organize);
			response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_safe.jsp");
		} catch (Exception e) {

			e.printStackTrace();
		}

	}

	// 组织修改邮箱
	public void orgupdEmail(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("组织修改邮箱");
			Organize organize = null;
			organize = (Organize) request.getSession().getAttribute("organize");
			String oldEmail = request.getParameter("oldemail");
			String newEmail = request.getParameter("newemail");// 页面传入的邮箱
			System.out.println("组织id" + organize.getOId() + "新邮箱" + newEmail + "-" + oldEmail);
			String org_updemail_code = request.getParameter("org_updemail_code");// 页面传入的邮箱验证码
			String OrgUpdEmail = (String) request.getSession().getAttribute("OrgUpdEmail");// 更换的邮箱
			String OrgUpdEmailCode = (String) request.getSession().getAttribute("OrgUpdEmailCode");// 邮箱验证码
			// 新旧邮箱判断 不一样执行底下操作
			if (!oldEmail.equals(newEmail)) {

				// 验证邮箱前后输入
				if (OrgUpdEmail.equals(newEmail)) {
					// 验证邮箱验证码
					if (OrgUpdEmailCode.toLowerCase().equals(org_updemail_code.toLowerCase())) {
						// 验证组织邮箱是否已被注册
						Organize o = FactoryDao.getIOrganizeDaoInstance().getOrgbyOEmail(newEmail);
						if (o == null) {
							if (FactoryDao.getIOrganizeDaoInstance().updEmail(organize.getOId(), oldEmail,
									newEmail) == 1) {

								response.getWriter().write("<script>alert('邮箱修改成功');</script>");
								getOrgMsg(request, response);

								response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_safe.jsp");
							} else {
								response.getWriter().write("<script>alert('邮箱修改失败，请重试');</script>");
								response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_safe.jsp");
							}
						} else {
							response.getWriter().write("<script>alert('邮箱修改失败，新邮箱已绑定其他组织');</script>");
							response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_safe.jsp");

						}
					} else {
						response.getWriter().write("<script>alert('邮箱验证码输入错误，请重新输入');</script>");
						response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_safe.jsp");

					}
				} else {
					response.getWriter().write("<script>alert('邮箱前后输入错误，请重新输入');</script>");
					response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_safe.jsp");
				}
			} else {
				response.getWriter().write("<script>alert('输入的新邮箱与旧邮箱一致无需更换');</script>");
				response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_safe.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 组织修改密码
	public void orgupdPassword(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		contextPath = request.getContextPath();// 获得项目路径名
		System.out.println("组织修改密码");
		Organize organize = (Organize) request.getSession().getAttribute("organize");

		try {
			String oldpwd = request.getParameter("oldpwd");
			String newpwd = request.getParameter("newpwd");
			int i = FactoryDao.getIOrganizeDaoInstance().updPwd(organize.getOId(), MD5Utils.getMD5Code(oldpwd),
					MD5Utils.getMD5Code(newpwd));
			if (i == 1) {
				response.getWriter().write("<script>alert('密码修改成功');</script>");
				response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_safe.jsp");
			} else {
				response.getWriter().write("<script>alert('旧密码错误，请重新输入');</script>");
				response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_safe.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// 组织修改信息
	public void orgupdinfo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Organize organize;
			int i = 0;
			contextPath = request.getContextPath();// 获得项目路径名
			System.out.println("组织修改信息");
			organize = (Organize) request.getSession().getAttribute("organize");
			if (organize == null) {
				response.getWriter().write("<script>alert('组织未登录，请先登录');</script>");
				response.setHeader("refresh", "1;url=" + contextPath + "/user/user_org_login.jsp");
			} else {
				Map<String, String[]> map = request.getParameterMap();

				Organize org = new Organize();
				BeanUtils.populate(org, map);
				System.out.println("页面取得要更新的值-------" + org.toString());

				if (org.getOIdCard().equals(organize.getOIdCard())) {
					i = FactoryDao.getIOrganizeDaoInstance().updOrgInfo(organize.getOId(), org);
				} else {
					Organize organize2 = FactoryDao.getIOrganizeDaoInstance().byIdCardgetOrg(org.getOIdCard());
					if (organize2 != null) {
						response.getWriter().write("<script>alert('身份证已被绑定其他组织,信息修改失败！');</script>");
						response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_info_upd.jsp");

					} else {
						i = FactoryDao.getIOrganizeDaoInstance().updOrgInfo(organize.getOId(), org);

					}
				}
				organize = FactoryDao.getIOrganizeDaoInstance().getOrgbyOId(organize.getOId());

				request.getSession().setAttribute("organize", organize);

				if (i == 1) {
					response.getWriter().write("<script>alert('信息修改成功');</script>");
					response.setHeader("refresh", "0;url=" + contextPath + "/organize/org_info_upd.jsp");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
