package controller;

import model.Chef;
import dao.ChefDao;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/chef")
public class ChefController extends HttpServlet {

    private ChefDao chefDao = new ChefDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Chef Chef = chefDao.find(id);
            request.setAttribute("Chef", Chef);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/EditChef.jsp");
            dispatcher.forward(request, response);
        }if(action != null && action.equals("detail")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Chef Chef = chefDao.find(id);
            request.setAttribute("Chef", Chef);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/DetailChef.jsp");
            dispatcher.forward(request, response);
        }else {
            List<Chef> Chefs = chefDao.findAll();
            request.setAttribute("Chefs", Chefs);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/AllChef.jsp");
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
                editChef(request, response);
            } else if (action.equals("delete")) {
                deleteChef(request, response);
            }
        }
    }

    private void addChef(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("taille");
        String motDePasse = request.getParameter("description");
     

        Chef Chef = new Chef(nom,email,motDePasse);
        chefDao.save(Chef);
        response.sendRedirect("Chef");
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
        
 
            response.sendRedirect("Chef");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Chef not found");
        }
    }

    private void deleteChef(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Chef Chef = chefDao.find(id);
        if (Chef != null) {
            chefDao.delete(id);
            response.sendRedirect("Chef");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Chef not found");
        }
    }
}
