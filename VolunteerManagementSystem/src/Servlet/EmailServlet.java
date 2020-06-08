package Servlet;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.CommonUtils;
import util.Constant;
import util.EmailUtils;

/**
 * Servlet implementation class EmailServlet
 */
@WebServlet("/EmailServlet")
public class EmailServlet extends BaseServlet {
	private static final long serialVersionUID = 1L;
	String contextPath = "";
	// contextPath = request.getContextPath();//获得项目路径名
	// 以下为单纯的从服务器驱动发送一封邮件到用户的邮箱 当用户注册成功后执行发送邮件操作
	// 第一步1.创建参数配置，用于连接邮箱服务器的参数配置
	Session session = EmailUtils.getSession();
	MimeMessage mimeMessage;

	public void getOrgRegistCode(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		System.out.println("EmailServlet访问成功");
		String OrgRegEmail = request.getParameter("email");// "1072766478@qq.com"
		String OrgRegistCode = CommonUtils.getRandomCode();
		// HttpSession httpSession = request.getSession();
		// httpSession.setMaxInactiveInterval(60);
		// 设置session保存时间为60秒
		request.getSession().setAttribute("OrgRegEmail", OrgRegEmail);
		request.getSession().setAttribute("OrgRegistCode", OrgRegistCode);
		try {
			// 第二步2.使用本工具类调用MimeMessage creatMimeMessage方法
			// 需要填写邮件接收地址和激活码
			// user.getUemail()取得注册的邮箱地址
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, OrgRegEmail,
					Constant.Org_Regist_Code, OrgRegistCode);
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			response.getWriter().write("<script>alert('邮件发送成功');</script>");
		} catch (MessagingException e) {
			System.out.println("发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试");
			response.getWriter().write("<script>alert('发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试');</script>");
			// e.printStackTrace();
		}
	}

	public void getForgetCode(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		System.out.println("EmailServlet访问成功");
		String ForgetEmail = request.getParameter("email");// "1072766478@qq.com"
		String ForgetCode = CommonUtils.getRandomCode();
		// HttpSession httpSession = request.getSession();
		// httpSession.setMaxInactiveInterval(60);
		// 设置session保存时间为60秒
		request.getSession().setAttribute("ForgetEmail", ForgetEmail);
		request.getSession().setAttribute("ForgetCode", ForgetCode);
		try {
			// 第二步2.使用本工具类调用MimeMessage creatMimeMessage方法
			// 需要填写邮件接收地址和激活码
			// user.getUemail()取得注册的邮箱地址
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, ForgetEmail,
					Constant.Forget_Code, ForgetCode);
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			response.getWriter().write("<script>alert('邮件发送成功');</script>");
		} catch (MessagingException e) {
			System.out.println("发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试");
			response.getWriter().write("<script>alert('发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试');</script>");
			// e.printStackTrace();
		}

	}

	public void getUserRegistCode(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		System.out.println("EmailServlet访问成功");
		String UserRegEmail = request.getParameter("email");// "1072766478@qq.com"
		String UserRegistCode = CommonUtils.getRandomCode();
		// HttpSession httpSession = request.getSession();
		// httpSession.setMaxInactiveInterval(60);
		// 设置session保存时间为60秒
		request.getSession().setAttribute("UserRegEmail", UserRegEmail);
		request.getSession().setAttribute("UserRegistCode", UserRegistCode);
		try {
			// 第二步2.使用本工具类调用MimeMessage creatMimeMessage方法
			// 需要填写邮件接收地址和激活码
			// user.getUemail()取得注册的邮箱地址
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, UserRegEmail,
					Constant.User_Regist_Code, UserRegistCode);
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			response.getWriter().write("<script>alert('邮件发送成功');</script>");
		} catch (MessagingException e) {
			System.out.println("发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试");
			response.getWriter().write("<script>alert('发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试');</script>");
			// e.printStackTrace();
		}

	}

	// 组织换新邮箱
	public void getOrgUpdEmailCode(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		System.out.println("EmailServlet访问成功");
		String OrgUpdEmail = request.getParameter("email");// "1072766478@qq.com"
		String OrgUpdEmailCode = CommonUtils.getRandomCode();

		request.getSession().setAttribute("OrgUpdEmail", OrgUpdEmail);
		request.getSession().setAttribute("OrgUpdEmailCode", OrgUpdEmailCode);
		try {
			// 第二步2.使用本工具类调用MimeMessage creatMimeMessage方法
			// 需要填写邮件接收地址和激活码
			// user.getUemail()取得注册的邮箱地址
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, OrgUpdEmail,
					Constant.Org_UpdEmail_Code, OrgUpdEmailCode);
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			response.getWriter().write("<script>alert('邮件发送成功');</script>");
		} catch (MessagingException e) {
			System.out.println("发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试");
			response.getWriter().write("<script>alert('发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试');</script>");
			// e.printStackTrace();
		}

	}

	// 志愿者换新邮箱
	public void getUserUpdEmailCode(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		System.out.println("EmailServlet访问成功");
		String UserUpdEmail = request.getParameter("email");// "1072766478@qq.com"
		String UserUpdEmailCode = CommonUtils.getRandomCode();

		request.getSession().setAttribute("UserUpdEmail", UserUpdEmail);
		request.getSession().setAttribute("UserUpdEmailCode", UserUpdEmailCode);
		try {
			// 第二步2.使用本工具类调用MimeMessage creatMimeMessage方法
			// 需要填写邮件接收地址和激活码
			// user.getUemail()取得注册的邮箱地址
			mimeMessage = EmailUtils.creatMimeMessage(session, EmailUtils.emailsendaddress, UserUpdEmail,
					Constant.User_UpdEmail_Code, UserUpdEmailCode);
			// 第三步3.根据session获取邮件传输对象,发送邮件,发送所有收件人地址
			EmailUtils.getTransport(session, mimeMessage);
			response.getWriter().write("<script>alert('邮件发送成功');</script>");
		} catch (MessagingException e) {
			System.out.println("发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试");
			response.getWriter().write("<script>alert('发送邮件失败,邮箱尚未开通或者网络连接超时,请重新试');</script>");
			// e.printStackTrace();
		}

	}

}
