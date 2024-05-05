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
        }else {
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
            } else if (action.equals("delete")) {
                deleteUser(request, response);
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
        response.sendRedirect("User");
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
