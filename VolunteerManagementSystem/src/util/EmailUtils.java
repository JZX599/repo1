package util;

/*
 * 535错误：错误原因：授权码或者邮箱错误导致的。
 * 554错误：错误原因：发件人邮箱不是QQ邮箱
 * */
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.Properties;
import java.util.UUID;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtils {
	public static MimeMessage mimeMessage = null;

	// 发件人的邮箱和密码
	public static String emailsendaddress = "59948023@qq.com";// 设置服务器发送邮件地址
	// 发件人邮箱密码（有的是授权码）
	public static String emailPassword = "kxijceiumyspbicg";// POP3/SMTP服务授权码
	// 发件人邮箱服务地址
	public static String emailSMTPHost = "smtp.qq.com";// 邮箱服务地址
	// 收件人邮箱
	public static String emailreceiveaddress = null;// 从客户端接收邮件地址

	// 附加内容 邮件文本内容设置
	public static String getEmailContent(int emailType, String emailCode) {
		String html = "默认邮件信息";
		switch(emailType){
	    case 1 :
	    	html="<h2>【i志愿】 您正在进行组织注册，验证码是:</h2><h1>"+ emailCode + "</h1><h2>可忽略大小写！</h2>";//该验证码有效时间为60秒
	    			break;
	    case 2 :
	    	html="<h2>【i志愿】 您的验证码是：</h2><h1>"+ emailCode + "</h1><h2>，该验证码用于重置登录密码，请勿泄露于他人。</h2>";
	    			break;
	    case 3 :
	    	html="<h2>【i志愿】 您正在进行志愿者注册，验证码是:</h2><h1>"+ emailCode + "</h1><h2>可忽略大小写！</h2>";//该验证码有效时间为60秒
			break;
	    case 4 :
	    	html="<h2>【i志愿】 您正在进行组织邮箱更换操作，验证码是:</h2><h1>"+ emailCode + "</h1><h2>可忽略大小写！</h2>";//该验证码有效时间为60秒
			break;
	    case 5 :
	    	html="<h2>【i志愿】 您正在进行志愿者邮箱更换操作，验证码是:</h2><h1>"+ emailCode + "</h1><h2>可忽略大小写！</h2>";//该验证码有效时间为60秒
			break;
	    case 6 :
	    	html="<h2>【i志愿】"+ emailCode + "</h2>";//活动报名未通过
			break;
	    case 7:
	    	html="<h2>【i志愿】"+ emailCode + "</h2>";//活动报名通过
	    	break;
	    case 8:
	    	html="<h2>【i志愿】"+ emailCode + "</h2>";//志愿者被差评提醒信息
	    	break;
	    case 9:
	    	html="<h2>【i志愿】"+ emailCode + "</h2>";//组织审核通过
	    	break;
	    case 10:
	    	html="<h2>【i志愿】"+ emailCode + "</h2>";//志愿者提醒邮件  
	    	break;
	    default :
	    	html="<h1>来自SW;Z鑫的激活邮件，点击链接激活账号:</h1><h3><a href='http://localhost:8080/VolunteerManagementSystem/LoginServlet?action=useractivation&ucode="
	    			+ emailCode + "'>http://localhost:8080/VolunteerManagementSystem/LoginServlet?action=useractivation&ucode=" + emailCode + "</a></h3>";
	    			break;
	}

		return html;
	}

	// 第一步1.创建参数配置，用于连接邮箱服务器的参数配置
	public static Session getSession() {

		// 1、创建参数配置，用于连接邮箱服务器的参数配置
		Properties props = new Properties();
		// 开启debug调试
		props.setProperty("mail.debug", "true");
		// 发送服务器需要身份验证
		props.setProperty("mail.smtp.auth", "true");
		// 设置右键服务器的主机名
		props.setProperty("mail.host", EmailUtils.emailSMTPHost);
		// 发送邮件协议名称
		props.setProperty("mail.transport.protocol", "smtp");
		// 2、根据配置创建会话对象，用于和邮件服务器交互
		Session session = Session.getInstance(props);
		// 设置debug，可以查看详细的发送log
		session.setDebug(true);
		System.out.println("EmailUtils邮件参数配置：----------" + session.toString());
		return session;
	}

	// 第二步2.
	// 使用本工具类调用MimeMessage creatMimeMessage方法 需要填写邮件接收地址和激活码
	public static MimeMessage creatMimeMessage(Session session, String emailsendaddress, String emailreceiveaddress,
			int emailType,String emailCode) throws MessagingException, IOException {
		// 1、创建一封邮件对象
		mimeMessage = new MimeMessage(session);
		// 2、From：发件人
		mimeMessage.setFrom(new InternetAddress(EmailUtils.emailsendaddress, "i志愿", "UTF-8"));// 发件人地址
																								// 发件人昵称
																								// 编码
		// 3、To:收件人（可以增加多个收件人：抄送或者密送）
		mimeMessage.setRecipient(MimeMessage.RecipientType.TO,
				new InternetAddress(emailreceiveaddress, emailreceiveaddress, "UTF-8"));// 1.收件人地址
																			// 2.发件人昵称
																			// 3.编码
		// 4、Subject:邮件主题
		mimeMessage.setSubject("i志愿", "UTF-8");
		// 5、Content:邮件正文（可以使用Html标签）
		mimeMessage.setContent(EmailUtils.getEmailContent(emailType,emailCode), "text/html;charset=UTF-8");

		
		// 6、设置发送时间
		mimeMessage.setSentDate(new Date());
		// 7、保存设置
		mimeMessage.saveChanges();
		// 8、将该邮件保存在本地
		/*OutputStream out = new FileOutputStream("D://MyEmail" + UUID.randomUUID().toString() + ".eml");
		mimeMessage.writeTo(out);
		out.flush();
		out.close();*/
		System.out.println("EmailUtils创建一封邮件对象对应的大小----------" + mimeMessage.getSize());
		return mimeMessage;
	}

	// 第三步3.最后
	// 根据session获取邮件传输对象,发送邮件,发送所有收件人地址
	public static void getTransport(Session session, MimeMessage mimeMessage) throws MessagingException {
		// 4、根据session获取邮件传输对象
		Transport transport = session.getTransport();
		// 5、使用邮箱账号和密码连接邮箱服务器emailsendaddress必须与mimeMessage中的发件人邮箱一致，否则报错
		transport.connect(EmailUtils.emailsendaddress, EmailUtils.emailPassword);
		// 6、发送邮件,发送所有收件人地址
		transport.sendMessage(mimeMessage, mimeMessage.getAllRecipients());
		// 7、关闭连接
		transport.close();
		System.out.println("EmailUtils成功发送一封邮件");

	}

}