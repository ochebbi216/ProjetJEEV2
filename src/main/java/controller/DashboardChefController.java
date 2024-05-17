package controller;

import dao.ChefDao;
import dao.CommandeDao;
import dao.LivreurDao;
import dao.PizzaDao;
import dao.UserDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.List;

@WebServlet("/dashboardchef")
public class DashboardChefController extends HttpServlet {
    private ChefDao chefDao = new ChefDao();
    private LivreurDao livreurDao = new LivreurDao();
    private PizzaDao pizzaDao = new PizzaDao();
    private UserDao userDao = new UserDao(); // Assuming this is your client DAO
//    private CommandeDao commandeDao =new CommandeDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalChefs = chefDao.findAll().size();
        int totalLivreurs = livreurDao.findAll().size();
        int totalPizzas = pizzaDao.findAll().size();
        int totalClients = userDao.findAll().size(); // Adjust based on your actual client model
//        int totalCommandes =commandeDao.findAll().size();
       
        Cookie nameCookie = getCookie(request, "chefName");  
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

//        request.setAttribute("totalCommandes", totalCommandes);
   
        RequestDispatcher dispatcher = request.getRequestDispatcher("chefPages/chefDashboard.jsp");
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