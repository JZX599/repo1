package test;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;

import daomain.Admin;

import java.io.IOException;

public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) servletRequest;

        Admin admin = (Admin) httpServletRequest.getSession().getAttribute("admin");

        if (admin == null) {
            httpServletRequest.getRequestDispatcher("/admin/admin_login.jsp").forward(servletRequest,servletResponse);
        } else {
            filterChain.doFilter(servletRequest,servletResponse);
        }
    }

    @Override
    public void destroy() {

    }
}
