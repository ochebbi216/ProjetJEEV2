package controller;

import model.Admin;
import model.Livreur;
import dao.LivreurDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.sql.Timestamp;  // Import for handling the timestamp

@WebServlet("/livreur")
public class LivreurController extends HttpServlet {

    private LivreurDao livreurDao = new LivreurDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            Livreur livreur = livreurDao.find(id);
            request.setAttribute("Livreur", livreur);
            if (action.equals("edit")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/adminPages/EditLivreur.jsp");
                dispatcher.forward(request, response);
            } else if (action.equals("detail")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/adminPages/DetailLivreur.jsp");
                dispatcher.forward(request, response);
            }else if(action != null && action.equals("logout")) {
                logoutLivreur(request, response);
            }
        } else {
        	String availabilityFilter = request.getParameter("available");

            List<Livreur> livreurs;
            if (availabilityFilter != null && !availabilityFilter.equals("all")) {
                boolean isAvailable = Boolean.parseBoolean(availabilityFilter);
                livreurs = livreurDao.findByAvailability(isAvailable);
            } else {
                livreurs = livreurDao.findAll();
            }
        request.setAttribute("Livreurs", livreurs);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/adminPages/AllLivreur.jsp");
        dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    addLivreur(request, response);
                    break;
                case "edit":
                    editLivreur(request, response);
                    break;
                case "login":
                	loginLivreur(request, response);
                    break;
                case "delete":
                    deleteLivreur(request, response);
                    break;
            }
        }
    }
    private void loginLivreur(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        Livreur livreur = livreurDao.authenticate(email, motDePasse);
        if (livreur != null) {
            // Encrypt the email and password before storing them in cookies
            String nom = livreur.getNom();
            int id = livreur.getLivreurId();
            String idStr = String.valueOf(id); // Convert int to String

            // Create cookies for the encrypted email and password
            Cookie emailCookie = new Cookie("livreurEmail", email);
            Cookie NameCookie = new Cookie("livreurName", nom);
            Cookie IdCookie = new Cookie("livreurId", idStr);


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


            // Add the cookies to the response
            response.addCookie(emailCookie);
            response.addCookie(NameCookie);
            response.addCookie(IdCookie); 

            
            response.sendRedirect("dashboardLivreur");
        } else {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid credentials");
        };
    }
    private void logoutLivreur(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Invalidate the session if exists
        HttpSession session = request.getSession(false); // Retrieve the existing session if it exists, do not create a new one
        if (session != null) {
            session.invalidate(); // Invalidate the session to remove any session data
        }

        // Clear cookies related to the user login
        clearCookie(request, response, "livreurEmail");
        clearCookie(request, response, "livreurName");
        clearCookie(request, response, "livreurId");

        // Redirect to login page
        response.sendRedirect("livreurPages/LoginLivreur.jsp");
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
    private void addLivreur(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        boolean isAvailable = Boolean.parseBoolean(request.getParameter("isAvailable")); // Assume input from form as checkbox

        Livreur livreur = new Livreur(nom, email, motDePasse, isAvailable);
        livreurDao.save(livreur);
        response.sendRedirect("livreur");
    }

    private void editLivreur(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("livreurId"));
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        boolean isAvailable = request.getParameter("isAvailable") != null;  // Changed to directly check if checkbox is present

        Livreur livreur = livreurDao.find(id);
        if (livreur != null) {
            livreur.setNom(nom);
            livreur.setEmail(email);
            livreur.setMotDePasse(motDePasse);
            livreur.setIsAvailable(isAvailable);  // Update availability status

            livreurDao.update(livreur);  // Make sure you have an update method in your DAO to handle this
            response.sendRedirect("livreur");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Livreur not found");
        }
    }
    
    

    private void deleteLivreur(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Livreur livreur = livreurDao.find(id);
        if (livreur != null) {
            livreurDao.delete(id);
            response.sendRedirect("livreur");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Livreur not found");
        }
    }
}
