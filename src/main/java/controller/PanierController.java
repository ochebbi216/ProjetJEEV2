package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.UserDao;
import dao.PanierDao;
import dao.PizzaDao;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Panier;
import model.Pizza;
import model.User;

@WebServlet("/panier")
public class PanierController extends HttpServlet {
    private PanierDao panierDao;
    private UserDao userDao;
    private PizzaDao pizzaDao;

    public void init() {
        panierDao = new PanierDao();
        userDao = new UserDao();
        pizzaDao = new PizzaDao();
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
                    Panier panier = panierDao.find(id);
                    request.setAttribute("panier", panier);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/userPages/EditPanier.jsp");
                    dispatcher.forward(request, response);
                    break;
                case "detail":
                    id = Integer.parseInt(request.getParameter("id"));
                    panier = panierDao.find(id);
                    request.setAttribute("panier", panier);
                    dispatcher = request.getRequestDispatcher("/userPages/DetailPanier.jsp");
                    dispatcher.forward(request, response);
                    break;
                default:
                    List<Panier> paniers = panierDao.findAll();
                    request.setAttribute("paniers", paniers);
                    dispatcher = request.getRequestDispatcher("/userPages/AllPanier.jsp");
                    dispatcher.forward(request, response);
                    break;
            }
        } else {
            List<Panier> paniers = panierDao.findAll();
            request.setAttribute("paniers", paniers);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/userPages/AllPanier.jsp");
            dispatcher.forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String action = request.getParameter("action");

        if (action != null) {
            try {
                if ("add".equals(action)) {
                    addPanier(request, response);
                } else if ("edit".equals(action)) {
                    editPanier(request, response);
                } else if ("delete".equals(action)) {
                    deletePanier(request, response);
                } else if  ("modify".equals(action)) {
                    String panierIdParam = request.getParameter("panierId");
                    String pizzaIdParam = request.getParameter("pizzaid");
                    if (panierIdParam != null && pizzaIdParam != null) {
                        try {
                            int panierId = Integer.parseInt(panierIdParam);
                            int pizzaId = Integer.parseInt(pizzaIdParam);
                            // Existing logic to modify the panier...
                        } catch (NumberFormatException e) {
                            e.printStackTrace();
                            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
                        }
                    } else {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
                    }
                }
            } catch (NumberFormatException e) {
                // Log the error and handle it appropriately
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
            }
        }
    }

    private void modifyPanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String panierIdParam = request.getParameter("panierId");
        String pizzaIdParam = request.getParameter("pizzaId");
        String operation = request.getParameter("operation");

        if (panierIdParam == null || pizzaIdParam == null) {
            throw new NumberFormatException("Panier ID or Pizza ID parameter is missing");
        }

        int panierId = Integer.parseInt(panierIdParam);
        int pizzaId = Integer.parseInt(pizzaIdParam);
        Panier panier = panierDao.find(panierId);
        Pizza pizza = pizzaDao.find(pizzaId);

            if (panier != null) {
                if ("increase".equals(operation)) {
                    panier.setQuantite(panier.getQuantite() + 1);
                } else if ("decrease".equals(operation) && panier.getQuantite() > 1) {
                    panier.setQuantite(panier.getQuantite() - 1);
                }
                panier.setPrixTotal(panier.getQuantite() * pizza.getPrixBase());
                panierDao.update(panier);
            }
            response.sendRedirect("panier");
        }
    


    
    private void addPanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        

      int clientId = 1; // Client ID
      int pizzaId = Integer.parseInt(request.getParameter("pizzaId"));
      Pizza p=pizzaDao.find(pizzaId);
      Panier p1=panierDao.find(pizzaId);
      if(p1!=null) {
          p1.setQuantite(p1.getQuantite() + 1);
          p1.setPrixTotal(p.getPrixBase() * p1.getQuantite());   
          panierDao.update(p1);

      }
      else {
          
          Panier panier = new Panier(clientId, pizzaId, 1, p.getPrixBase());
           panierDao.save(panier);
      }


      response.sendRedirect("panier");
  }

    private void editPanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int panierId = Integer.parseInt(request.getParameter("panierId"));
        Panier panier = panierDao.find(panierId);

        if (panier != null) {
            int clientId = Integer.parseInt(request.getParameter("clientId"));
            String[] pizzaIdStrings = request.getParameterValues("pizzaIds");
            float prixTotal = Float.parseFloat(request.getParameter("prixTotal"));

            User client = userDao.find(clientId);

            List<Pizza> pizzas = new ArrayList<>();
            if (pizzaIdStrings != null) {
                for (String pizzaIdStr : pizzaIdStrings) {
                    try {
                        int pizzaId = Integer.parseInt(pizzaIdStr);
                        Pizza pizza = pizzaDao.find(pizzaId);  // Fetch the actual pizza object
                        if (pizza != null) {
                            pizzas.add(pizza);
                        } else {
                            // Log or handle the case where the Pizza ID does not return a Pizza
                            System.out.println("No pizza found with ID: " + pizzaId);
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("Error parsing pizza ID: " + pizzaIdStr);
                        // Optionally, continue to the next ID or handle this situation appropriately
                        continue;
                    }
                }
            }

//            panier.setClient(client);
//            panier.setPizzas(pizzas);
            panier.setPrixTotal(prixTotal);
            panierDao.update(panier);
        } else {
            // Handle case where the Panier is not found
            System.out.println("Panier not found with ID: " + panierId);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Panier not found");
            return;
        }

        // Redirect to the panier list page
        response.sendRedirect("panier");
    }



    private void deletePanier(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        panierDao.delete(id);
        response.sendRedirect("panier");
    }

}
