package controller;

import model.Pizza;
import dao.PizzaDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/pizza")
public class PizzaController extends HttpServlet {

    private PizzaDao pizzaDao = new PizzaDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Pizza pizza = pizzaDao.find(id);
            request.setAttribute("pizza", pizza);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/EditPizza.jsp");
            dispatcher.forward(request, response);
        }if(action != null && action.equals("detail")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Pizza pizza = pizzaDao.find(id);
            request.setAttribute("pizza", pizza);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/DetailPizza.jsp");
            dispatcher.forward(request, response);
        }else {
            List<Pizza> pizzas = pizzaDao.findAll();
            request.setAttribute("pizzas", pizzas);
            RequestDispatcher dispatcher = request.getRequestDispatcher("adminPages/AllPizza.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("add")) {
                addPizza(request, response);
            } else if (action.equals("edit")) {
                editPizza(request, response);
            } else if (action.equals("delete")) {
                deletePizza(request, response);
            }
        }
    }

    private void addPizza(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nom = request.getParameter("nom");
        String categorie = request.getParameter("categorie");
        String taille = request.getParameter("taille");
        String description = request.getParameter("description");
        float prixBase = Float.parseFloat(request.getParameter("prixBase"));
        String image = request.getParameter("image");

        Pizza pizza = new Pizza(nom, categorie, taille, description, prixBase, image );
        pizzaDao.save(pizza);
        response.sendRedirect("pizza");
    }

    private void editPizza(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String categorie = request.getParameter("categorie");
        String taille = request.getParameter("taille");
        String description = request.getParameter("description");
        float prixBase = Float.parseFloat(request.getParameter("prixBase"));
        String image = request.getParameter("image");

        Pizza pizza = pizzaDao.find(id);
        if (pizza != null) {
            pizza.setNom(nom);
            pizza.setCategorie(categorie);
            pizza.setTaille(taille);
            pizza.setDescription(description);
            pizza.setPrixBase(prixBase);
            pizza.setImage(image);
            pizzaDao.update(pizza);
            response.sendRedirect("pizza");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Pizza not found");
        }
    }

    private void deletePizza(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Pizza pizza = pizzaDao.find(id);
        if (pizza != null) {
            pizzaDao.delete(id);
            response.sendRedirect("pizza");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Pizza not found");
        }
    }
}
