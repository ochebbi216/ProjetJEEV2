package controller;

import model.Admin;
import dao.AdminDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {

    private AdminDao AdminDao = new AdminDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Admin Admin = AdminDao.find(id);
            request.setAttribute("Admin", Admin);
            RequestDispatcher dispatcher = request.getRequestDispatcher("adminPages/EditAdmin.jsp");
            dispatcher.forward(request, response);
        }if(action != null && action.equals("detail")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Admin Admin = AdminDao.find(id);
            request.setAttribute("Admin", Admin);
            RequestDispatcher dispatcher = request.getRequestDispatcher("adminPages/DetailAdmin.jsp");
            dispatcher.forward(request, response);
            
        }else if(action != null && action.equals("logout")) {
            logoutAdmin(request, response);
        }
        
        else {
            List<Admin> Admins = AdminDao.findAll();
            request.setAttribute("Admins", Admins);
            RequestDispatcher dispatcher = request.getRequestDispatcher("adminPages/AllAdmin.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("add")) {
                addAdmin(request, response);
            } else if (action.equals("edit")) {
                editAdmin(request, response);
            } else if (action.equals("login")) {
                loginAdmin(request, response);
            } else if (action.equals("delete")) {
                deleteAdmin(request, response);
            }
        }
    }

    private void loginAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException{
            String email = request.getParameter("email");
            String motDePasse = request.getParameter("motDePasse");
            Admin admin = AdminDao.authenticate(email, motDePasse);
            if (admin != null) {
                // Encrypt the email and password before storing them in cookies
                String nom = admin.getNom();


                // Create cookies for the encrypted email and password
                Cookie emailCookie = new Cookie("adminEmail", email);
                Cookie NameCookie = new Cookie("adminName", nom);

                // Set cookie properties
                emailCookie.setMaxAge(60 * 60 * 24 * 7);  // valid for 7 days
                NameCookie.setMaxAge(60 * 60 * 24 * 7);

                emailCookie.setHttpOnly(true);
                NameCookie.setHttpOnly(true);

                emailCookie.setSecure(true);  // Send only over secure connections
                NameCookie.setSecure(true);

                emailCookie.setPath("/");
                NameCookie.setPath("/");

                // Add the cookies to the response
                response.addCookie(emailCookie);
                response.addCookie(NameCookie);
                
                response.sendRedirect("dashboard");
            } else {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid credentials");
            };
	}

	private void addAdmin(HttpServletRequest request, HttpServletResponse response)  throws IOException{
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
     

        Admin Admin = new Admin(nom,email,motDePasse);
        AdminDao.save(Admin);
        response.sendRedirect("admin");
    }

    private void editAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
   

        Admin Admin = AdminDao.find(id);
        if (Admin != null) {
            Admin.setNom(nom);
            Admin.setEmail(email);
            Admin.setMotDePasse(motDePasse);
        
 
            response.sendRedirect("admin");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Admin not found");
        }
    }
    
    
    private Cookie getCookie(HttpServletRequest request, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookieName.equals(cookie.getName())) {
                    return cookie;
                }
            }
        }
        return null;
    }
    private void logoutAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Invalidate the session if exists
        HttpSession session = request.getSession(false); // Retrieve the existing session if it exists, do not create a new one
        if (session != null) {
            session.invalidate(); // Invalidate the session to remove any session data
        }

        // Clear cookies related to the user login
        clearCookie(request, response, "adminEmail");
        clearCookie(request, response, "adminName");

        // Redirect to login page
        response.sendRedirect("adminPages/AddAdmin.jsp");
    }

    private void clearCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    cookie.setValue(""); // Set the value to empty
                    cookie.setPath("/"); // Ensure you set the path exactly same as it was set during creation
                    cookie.setMaxAge(0); // Set the maximum age to 0 to delete the cookie
                    response.addCookie(cookie); // Add the modified cookie to the response to effectively delete it from the client
                }
            }
        }
    }

    private void deleteAdmin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Admin Admin = AdminDao.find(id);
        if (Admin != null) {
            AdminDao.delete(id);
            response.sendRedirect("admin");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Admin not found");
        }
    }
}
