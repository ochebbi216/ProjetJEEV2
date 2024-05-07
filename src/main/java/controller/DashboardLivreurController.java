package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import dao.ChefDao;
import dao.LivreurDao;
import dao.PizzaDao;
import dao.UserDao;
@WebServlet("/dashboardLivreur")
public class DashboardLivreurController extends HttpServlet {
    private ChefDao chefDao = new ChefDao();
    private LivreurDao livreurDao = new LivreurDao();
    private PizzaDao pizzaDao = new PizzaDao();
    private UserDao userDao = new UserDao(); // Assuming this is your client DAO

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalChefs = chefDao.findAll().size();
        int totalLivreurs = livreurDao.findAll().size();
        int totalPizzas = pizzaDao.findAll().size();
        int totalClients = userDao.findAll().size(); // Adjust based on your actual client model
        
        Cookie nameCookie = getCookie(request, "livreurName");  
        if (nameCookie != null) {
            String nom = nameCookie.getValue(); 
            request.setAttribute("nom", nom);
        } else {
            System.out.println("Name cookie not found.");
        }
        
        request.setAttribute("totalChefs", totalChefs);
        request.setAttribute("totalLivreurs", totalLivreurs);
        request.setAttribute("totalPizzas", totalPizzas);
        request.setAttribute("totalClients", totalClients);
   
        RequestDispatcher dispatcher = request.getRequestDispatcher("livreurPages/DashboradLivreur.jsp");
        dispatcher.forward(request, response);
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

    
}
