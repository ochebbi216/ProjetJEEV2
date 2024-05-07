package controller;

import model.User;
import dao.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/User")
public class UserController extends HttpServlet {

    private UserDao UserDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            User User = UserDao.find(id);
            request.setAttribute("User", User);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/adminPages/EditUser.jsp");
            dispatcher.forward(request, response);
        }if(action != null && action.equals("detail")) {
            int id = Integer.parseInt(request.getParameter("id"));
            User User = UserDao.find(id);
            request.setAttribute("User", User);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/adminPages/DetailUser.jsp");
            dispatcher.forward(request, response);
        }
        else if(action != null && action.equals("logout")) {
            logoutUser(request, response);
        }
        else {
            List<User> Users = UserDao.findAll();
            request.setAttribute("Users", Users);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/adminPages/AllUser.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("add")) {
                addUser(request, response);
            } else if (action.equals("edit")) {
                editUser(request, response);
            } else if (action.equals("login")) {
                loginUser(request, response);
            }else if (action.equals("delete")) {
                deleteUser(request, response);
            }
        }
    }
    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        User user = UserDao.authenticate(email, motDePasse);
        if (user != null) {
            // Encrypt the email and password before storing them in cookies
            String nom = user.getNom();
            int id = user.getId();
            String idStr = String.valueOf(id); // Convert int to String


            // Create cookies for the encrypted email and password
            Cookie emailCookie = new Cookie("userEmail", email);
            Cookie NameCookie = new Cookie("userName", nom);
            Cookie IdCookie = new Cookie("userId", idStr);

            // Set cookie properties
            emailCookie.setMaxAge(60 * 60 * 24 * 7);  // valid for 7 days
            NameCookie.setMaxAge(60 * 60 * 24 * 7);
            IdCookie.setMaxAge(60 * 60 * 24 * 7); // for example, set cookie to expire after 7 days

            emailCookie.setHttpOnly(true);
            NameCookie.setHttpOnly(true);

            emailCookie.setSecure(true);  // Send only over secure connections
            NameCookie.setSecure(true);

            emailCookie.setPath("/");
            NameCookie.setPath("/");
            IdCookie.setPath("/"); // available to all paths
            
            response.addCookie(IdCookie); 
            response.addCookie(emailCookie);
            response.addCookie(NameCookie);
            
            response.sendRedirect("userPages/Home.jsp");
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid credentials");
        };
}
    private void logoutUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Invalidate the session if exists
        HttpSession session = request.getSession(false); // Retrieve the existing session if it exists, do not create a new one
        if (session != null) {
            session.invalidate(); // Invalidate the session to remove any session data
        }

        // Clear cookies related to the user login
        clearCookie(request, response, "userEmail");
        clearCookie(request, response, "userName");
        clearCookie(request, response, "userId");


        // Redirect to login page
        response.sendRedirect("userPages/LoginUser.jsp");
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
    private void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	String login = request.getParameter("login");
    	String nom = request.getParameter("nom");
        String pass = request.getParameter("pass");
        String prenom = request.getParameter("prenom");
     

        User User = new User(login,pass,nom,prenom);
        UserDao.save(User);
        response.sendRedirect("userPages/LoginUser.jsp");
    }

    private void editUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String login = request.getParameter("login");
    	String nom = request.getParameter("nom");
        String pass = request.getParameter("pass");
        String prenom = request.getParameter("prenom");
   

        User User = UserDao.find(id);
        if (User != null) {
            User.setNom(nom);
            User.setLogin(login);
            User.setPass(pass);
            User.setPrenom(prenom);
        
 
            response.sendRedirect("User");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User User = UserDao.find(id);
        if (User != null) {
            UserDao.delete(id);
            response.sendRedirect("User");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
        }
    }
}
