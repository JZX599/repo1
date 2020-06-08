package Servlet;

import java.io.IOException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BaseServlet extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("BaseServlet");
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		String action = request.getParameter("action");
		System.out.println("获取前端页面方法："+action);
		Method method=null;
		try {
			// 获取当前对象字节
			Class clazz = this.getClass();
			method = clazz.getMethod(action, HttpServletRequest.class, HttpServletResponse.class);

			if (method != null) {
				// 如果有获取到前端页面传来的方法 就通过当前字节去寻找对应方法执行
				// 执行方法返回String 类型的地址 所以需要强制转换类型
				String path = (String) method.invoke(this, request, response);
				System.out.println("BaseServlet:获取到方法返回路径为：" + path);
				/*if (path != null) {
					
					request.getRequestDispatcher(path).forward(request, response);
					
				}*/
			}else{
				System.out.println("没有找到要执行的方法");
			}

		} catch (Exception e) {

			e.printStackTrace();
		}

		/* response.sendRedirect(contextPath+"/admin/add.jsp"); */

	}
	
	

}
