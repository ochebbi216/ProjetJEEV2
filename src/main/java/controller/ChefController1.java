package controller;

import model.Chef;
import model.User;
import dao.ChefDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
@WebServlet("/chef1")
public class ChefController1 extends HttpServlet {

    private ChefDao chefDao = new ChefDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Chef Chef = chefDao.find(id);
            request.setAttribute("Chef", Chef);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/adminPages/EditChef.jsp");
            dispatcher.forward(request, response);
        }if(action != null && action.equals("detail")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Chef Chef = chefDao.find(id);
            request.setAttribute("Chef", Chef);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/adminPages/DetailChef.jsp");
            dispatcher.forward(request, response);
        }
        else if(action != null && action.equals("logout")) {
            logoutChef(request, response);
        }
       
        else {
            List<Chef> Chefs = chefDao.findAll();
            request.setAttribute("Chefs", Chefs);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/adminPages/AllChef.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("add")) {
                addChef(request, response);
            } else if (action.equals("edit")) {
                editChef(request, response);}
                else if (action.equals("login")) {
                    loginChef(request, response);
            } else if (action.equals("delete")) {
                deleteChef(request, response);
            }
        }
    }
       


    private void loginChef(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email").trim();
        String motDePasse = request.getParameter("motDePasse").trim();

        System.out.println("Input Email: " + email);
        System.out.println("Input Password: " + motDePasse);

        Chef chef = chefDao.authenticate(email, motDePasse);
        if (chef != null) {
            String nom = chef.getNom();
            int id = chef.getChefId();
            String idStr = String.valueOf(id);

            System.out.println("Authenticated Chef Name: " + nom);
            System.out.println("Chef ID: " + idStr);

            // Create cookies for the email and name (URL encode here)
            Cookie emailCookie = new Cookie("chefEmail", email);
            Cookie nameCookie = new Cookie("chefName", nom);
            Cookie idCookie = new Cookie("chefId", idStr);

            // Set cookie properties
            emailCookie.setMaxAge(60 * 60 * 24 * 7);  // valid for 7 days
            nameCookie.setMaxAge(60 * 60 * 24 * 7);
            idCookie.setMaxAge(60 * 60 * 24 * 7); // for example, set cookie to expire after 7 days

            emailCookie.setHttpOnly(true);
            nameCookie.setHttpOnly(true);

            emailCookie.setSecure(true);  // Send only over secure connections
            nameCookie.setSecure(true);

            emailCookie.setPath("/");
            nameCookie.setPath("/");
            idCookie.setPath("/"); // available to all paths

            response.addCookie(idCookie);
            response.addCookie(emailCookie);
            response.addCookie(nameCookie);

            response.sendRedirect("http://localhost:8080/projetjsp1/commande?action=chefcommandes");
        } else {
            System.out.println("Invalid credentials for email: " + email);
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid credentials");
        }
    }

        private void logoutChef(HttpServletRequest request, HttpServletResponse response) throws IOException {
            // Invalidate the session if exists
            HttpSession session = request.getSession(false); // Retrieve the existing session if it exists, do not create a new one
            if (session != null) {
                session.invalidate(); // Invalidate the session to remove any session data
            }

            // Clear cookies related to the user login
            clearCookie(request, response, "chefEmail");
            clearCookie(request, response, "chefName");
            clearCookie(request, response, "chefId");


            // Redirect to login page
            response.sendRedirect("chefPages/LoginChef.jsp");
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

    private void addChef(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
     

        Chef Chef = new Chef(nom,email,motDePasse);
        chefDao.save(Chef);
        response.sendRedirect("chefPages/LoginChef.jsp");
    }

    private void editChef(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
   

        Chef Chef = chefDao.find(id);
        if (Chef != null) {
            Chef.setNom(nom);
            Chef.setEmail(email);
            Chef.setMotDePasse(motDePasse);
       
 
            response.sendRedirect("chef1");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Chef not found");
        }
    }

    private void deleteChef(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Chef Chef = chefDao.find(id);
        if (Chef != null) {
            chefDao.delete(id);
            response.sendRedirect("chef1");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Chef not found");
        }
    }
}