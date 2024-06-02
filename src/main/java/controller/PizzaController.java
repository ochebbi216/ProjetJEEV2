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
        String destination = null;
        
        if (action != null) {
            switch (action) {
                case "edit":
                    int editId = Integer.parseInt(request.getParameter("id"));
                    Pizza editPizza = pizzaDao.find(editId);
                    request.setAttribute("pizza", editPizza);
                    destination = "/adminPages/EditPizza.jsp";
                    break;
                case "detail":
                    int detailId = Integer.parseInt(request.getParameter("id"));
                    Pizza detailPizza = pizzaDao.find(detailId);
                    request.setAttribute("pizza", detailPizza);
                    List<Pizza> relatedPizzas = pizzaDao.findByCategoryExcluding(detailPizza.getCategorie(), detailPizza.getId());
                    request.setAttribute("relatedPizzas", relatedPizzas);
                    destination = "/userPages/DetailPizza.jsp";
                    break;
                case "pizzachef":
                    List<Pizza> chefPizzas = pizzaDao.findAll();
                    request.setAttribute("pizzas", chefPizzas);
                    destination = "/chefPages/AllPizza.jsp";
                    break;
                case "menu":
                    request.setAttribute("classicPizzas", pizzaDao.findByCategory("Classic"));
                    request.setAttribute("meatLoversPizzas", pizzaDao.findByCategory("Meat Lovers"));
                    request.setAttribute("vegetarianPizzas", pizzaDao.findByCategory("Vegetarian"));
                    request.setAttribute("gourmetPizzas", pizzaDao.findByCategory("Gourmet"));
                    destination = "/userPages/Menu.jsp";
                    break;
                case "livreurPizza":
                    List<Pizza> livreurPizzas = pizzaDao.findAll();
                    request.setAttribute("pizzas", livreurPizzas);
                    destination = "livreurPages/AllPizza.jsp";
                    break;
                default:
                    List<Pizza> defaultPizzas = pizzaDao.findAll();
                    request.setAttribute("pizzas", defaultPizzas);
                    destination = "/adminPages/AllPizza.jsp";
                    break;
            }
        } else {
            List<Pizza> pizzas = pizzaDao.findAll();
            request.setAttribute("pizzas", pizzas);
            destination = "/adminPages/AllPizza.jsp";
        }

        if (destination != null && !response.isCommitted()) {
            RequestDispatcher dispatcher = request.getRequestDispatcher(destination);
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

        Pizza pizza = new Pizza(nom, categorie, taille, description, prixBase, image);
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
        float discountPercentage = Float.parseFloat(request.getParameter("discountPercentage"));
        String image = request.getParameter("image");

        Pizza pizza = pizzaDao.find(id);
        if (pizza != null) {
            pizza.setNom(nom);
            pizza.setCategorie(categorie);
            pizza.setTaille(taille);
            pizza.setDescription(description);
            pizza.setPrixBase(prixBase);
            pizza.setDiscountPercentage(discountPercentage);
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
