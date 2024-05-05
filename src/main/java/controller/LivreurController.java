package controller;

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
                RequestDispatcher dispatcher = request.getRequestDispatcher("/EditLivreur.jsp");
                dispatcher.forward(request, response);
            } else if (action.equals("detail")) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/DetailLivreur.jsp");
                dispatcher.forward(request, response);
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/AllLivreur.jsp");
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
                case "delete":
                    deleteLivreur(request, response);
                    break;
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
