package controller;

import java.io.IOException;
import java.util.List;

import dao.CommandeDao;
import dao.PanierDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Commande;
import model.Pizza;

import java.util.Date;

@WebServlet("/commande")
public class CommandeController extends HttpServlet {
    private CommandeDao commandeDao;
    private PanierDao panierDao;

    public void init() {
        commandeDao = new CommandeDao();
        panierDao = new PanierDao();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    doPost(request, response);
                    return;
                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Commande commande = commandeDao.find(id);
                    request.setAttribute("commande", commande);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/EditCommande.jsp");
                    dispatcher.forward(request, response);
                    break;
                case "detail":
                    id = Integer.parseInt(request.getParameter("id"));
                    commande = commandeDao.find(id);
                    request.setAttribute("commande", commande);
                    dispatcher = request.getRequestDispatcher("/DetailCommande.jsp");
                    dispatcher.forward(request, response);
                    break;
                default:
                    List<Commande> commandes = commandeDao.findAll();
                    request.setAttribute("commandes", commandes);
                    dispatcher = request.getRequestDispatcher("/AllCommandes.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
        } else {
            List<Commande> commandes = commandeDao.findAll();
            request.setAttribute("commandes", commandes);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/AllCommandes.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    addCommande(request, response);
                    break;
                case "edit":
                    editCommande(request, response);
                    break;
                case "delete":
                    deleteCommande(request, response);
                    break;
            }
        }
    }

    private void addCommande(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
       
        int panierId = Integer.parseInt(request.getParameter("panierId"));
       
            int userId = 1;

            String total = request.getParameter("total");
            if (total == null) {
                throw new IllegalArgumentException("Price total is required");
            }
            float prixTotal = Float.parseFloat(total);

            String statut = "en attente";
           
            String numTel = "24044245";
           
            String adresseLivraison = "taniour";

            Date dateCommande = new Date();
            Commande newCommande = new Commande(userId, statut, dateCommande,numTel ,adresseLivraison, prixTotal);
            commandeDao.save(newCommande);
            panierDao.delete(panierId);
            response.sendRedirect("commande");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        }
    }



    private void editCommande(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int commandeId = Integer.parseInt(request.getParameter("id"));
        String newStatut = request.getParameter("statut");
        Commande existingCommande = commandeDao.find(commandeId);
        if (existingCommande != null) {
            existingCommande.setStatut(newStatut);
            commandeDao.update(existingCommande);
        } else {
            // Optionally handle the case where the Commande does not exist
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Commande not found");
            return;
        }

        response.sendRedirect("commande");
    }


 
    private void deleteCommande(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int commandeId = Integer.parseInt(request.getParameter("id"));
        Commande commande = commandeDao.find(commandeId);
        if (commande != null) {
        commandeDao.delete(commandeId);
            response.sendRedirect("commande");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Commande not found");
        }
    }
}

