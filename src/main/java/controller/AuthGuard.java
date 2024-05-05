//package controller;
//
//import jakarta.servlet.*;
//import jakarta.servlet.http.*;
//import jakarta.servlet.annotation.*;
//import java.io.IOException;
//import model.Admin;
//import dao.AdminDao;
//@WebFilter("/adminPages/*")
//public class AuthGuard implements Filter {
//
//    private AdminDao adminDao = new AdminDao();
//
//    public void init(FilterConfig filterConfig) {}
//
//    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
//        HttpServletRequest request = (HttpServletRequest) req;
//        HttpServletResponse response = (HttpServletResponse) res;
//
//        Cookie[] cookies = request.getCookies();
//        String email = null;
//
//        if (cookies != null) {
//            for (Cookie cookie : cookies) {
//                if ("adminEmail".equals(cookie.getName())) {
//                    email = cookie.getValue();
//                    break;
//                }
//            }
//        }
//
//        if (email != null && adminDao.authenticateByEmail(email)) {
//            chain.doFilter(request, response); // Admin is authenticated, proceed with the request
//        } else {
//            response.sendRedirect(request.getContextPath() + "/AddAdmin.jsp"); // Not authenticated, redirect to login
//        }
//    }
//
//    public void destroy() {}
//
//}
