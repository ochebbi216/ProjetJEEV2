package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import dao.CommandeDao;
import dao.LivreurDao;
import dao.PanierDao;
import dao.PizzaDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Commande;
import model.Livreur;
import model.Panier;

@WebServlet("/commande")

public class CommandeController extends HttpServlet {

	private CommandeDao commandeDao;

	private PanierDao panierDao;

	private PizzaDao pizzaDao;

	private LivreurDao livreurDao;

	public void init() {

		commandeDao = new CommandeDao();

		panierDao = new PanierDao();

		pizzaDao = new PizzaDao();

		livreurDao = new LivreurDao(); // Initialize the LivreurDao

	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		Integer livreurId = null;

		// Fetch the livreurId from cookies
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("livreurId".equals(cookie.getName())) {
					livreurId = Integer.parseInt(cookie.getValue());
					break;
				}
			}
		}
	       if (livreurId == null) {
	            response.sendRedirect("livreurPages/LoginLivreur.jsp");
	            return;
	        }
		if (action != null) {

			switch (action) {

			case "add":

				doPost(request, response);

				return;

			case "edit":

				int id = Integer.parseInt(request.getParameter("id"));

				Commande commande = commandeDao.find(id);

				request.setAttribute("commande", commande);

				RequestDispatcher dispatcher = request.getRequestDispatcher("/userPages/EditCommande.jsp");

				dispatcher.forward(request, response);

				break;

			case "detail":

				id = Integer.parseInt(request.getParameter("id"));

				commande = commandeDao.find(id);

				request.setAttribute("commande", commande);

				dispatcher = request.getRequestDispatcher("/userPages/DetailCommande.jsp");

				dispatcher.forward(request, response);

				break;

			case "livreurcommandes":

				List<Commande> commandes2 = commandeDao.findCommandesByLivreurId(livreurId);

				request.setAttribute("commandes", commandes2);

				dispatcher = request.getRequestDispatcher("/livreurPages/AllCommandes.jsp");

				dispatcher.forward(request, response);

				break;
			case "chefcommandes":
				List<Commande> unassignedCommandes = commandeDao.findUnassignedCommandes();

				LivreurDao livreurDao = new LivreurDao();
				List<Livreur> livreursDisponibles = livreurDao.findByAvailability(true);

				request.setAttribute("livreursDisponibles", livreursDisponibles);
				request.setAttribute("commandes", unassignedCommandes);

				dispatcher = request.getRequestDispatcher("/chefPages/AllCommandes.jsp");
				dispatcher.forward(request, response);
				break;

			case "myOrders":
				int chefId0 = Integer.parseInt(request.getParameter("chefId"));
				List<Commande> dCommandes = commandeDao.findAssignedCommandes(chefId0);
				LivreurDao livreurDao2 = new LivreurDao();
				List<Livreur> livreursDisponibles2 = livreurDao2.findByAvailability(true);

				request.setAttribute("livreursDisponibles", livreursDisponibles2);
				request.setAttribute("commandes", dCommandes);

				dispatcher = request.getRequestDispatcher("/chefPages/MyCommandes.jsp");
				dispatcher.forward(request, response);
				break;

			case "startOrder":
				int commandeId = Integer.parseInt(request.getParameter("id"));
				int chefId = Integer.parseInt(request.getParameter("chefId"));
				Commande commande0 = commandeDao.find(commandeId);
				if (commande0 != null) {
					commande0.setChefid(chefId);
					commande0.setStatut("en cour");
					commandeDao.update(commande0);

					List<Commande> commandes0 = commandeDao.findAll();
					request.setAttribute("commandes", commandes0);

					RequestDispatcher dispatcher0 = request.getRequestDispatcher("/chefPages/MyCommandes.jsp");
					dispatcher0.forward(request, response);

				} else {
					response.sendError(HttpServletResponse.SC_NOT_FOUND, "Commande not found");
				}
				break;
			case "finishOrder":
				int commandeId0 = Integer.parseInt(request.getParameter("id"));
				int chefid = Integer.parseInt(request.getParameter("chefId"));

				Commande commande4 = commandeDao.find(commandeId0);
				if (commande4 != null && "en cour".equals(commande4.getStatut())) {
					commande4.setStatut("prête");
					commandeDao.update(commande4);

					List<Commande> commandes0 = commandeDao.findAssignedCommandes(chefid);
					request.setAttribute("commandes", commandes0);

					RequestDispatcher dispatcher0 = request.getRequestDispatcher("/chefPages/MyCommandes.jsp");
					dispatcher0.forward(request, response);
				} else {
					response.sendError(HttpServletResponse.SC_NOT_FOUND, "Commande not found");
				}
				break;
			case "startDelivery":
			case "finishDelivery":
				doPost(request, response);
				break;

//			case "livreuravailable":
//
//				LivreurDao livreurDao = new LivreurDao();
//				List<Livreur> livreursDisponibles = livreurDao.findByAvailability(true);
//				request.setAttribute("livreursDisponibles", livreursDisponibles);
//
//				RequestDispatcher dispatcher1 = request.getRequestDispatcher("/chefPages/AllCommandes.jsp");
//				dispatcher1.forward(request, response);
//
//				System.out.println("Nombre de livreurs disponibles: " + livreursDisponibles.size());
//				break;
			default:

				List<Commande> commandes = commandeDao.findAllCommandesWithPizzas();

				request.setAttribute("commandes", commandes);

				dispatcher = request.getRequestDispatcher("/userPages/AllCommandes.jsp");

				dispatcher.forward(request, response);

				break;

			}

		} else {

			List<Commande> commandes = commandeDao.findAll();

			request.setAttribute("commandes", commandes);

			RequestDispatcher dispatcher = request.getRequestDispatcher("/userPages/AllCommandes.jsp");

			dispatcher.forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
			case "assignLivreur":
				assignLivreurAjax(request, response);
				break;
            case "startDelivery":
                updateCommandeStatus(request, response, "en cours de livraison");
                break;
            case "finishDelivery":
                finishDelivery(request, response);
                break;
			}
		}
	}

	private void addCommande(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int userid = 00; // Initialize the userName variable
		Cookie[] cookies = request.getCookies(); // Get the array of cookies from the request
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("userId".equals(cookie.getName())) {
					userid = Integer.parseInt(cookie.getValue()); // Retrieve userName from cookie
					break;
				}
			}
		}
		response.setContentType("application/json");
		Gson gson = new Gson();
		BufferedReader reader = request.getReader();
		JsonObject json = gson.fromJson(reader, JsonObject.class);
		int userId = userid; // Example, should come from session or decoded from request
		String numTel = json.get("numTel").getAsString();
		String adresseLivraison = json.get("adresseLivraison").getAsString();

		try {
			List<Panier> cartItems = panierDao.findAllByUserId(userId);
			if (cartItems == null || cartItems.isEmpty()) {
				throw new IllegalArgumentException("No cart items found for the user.");
			}

			float prixTotal = cartItems.stream().map(Panier::getPrixTotal).reduce(0f, Float::sum);

			// Build the pizza string with quantities
			StringBuilder pizzasStringBuilder = new StringBuilder();
			for (Panier panier : cartItems) {
				pizzasStringBuilder.append(panier.getPizza().getNom()).append(" x ").append(panier.getQuantite())
						.append(", ");
			}
			// Remove the trailing comma and space
			String pizzasString = pizzasStringBuilder.substring(0, pizzasStringBuilder.length() - 2);
			panierDao.deleteAllByUserId(userId);

			Commande newCommande = new Commande(userId, pizzasString, "en attente", new Date(), numTel,
					adresseLivraison, prixTotal);
			commandeDao.saveCommandeWithItems(newCommande);
			response.getWriter().write(gson.toJson("Order placed successfully!"));
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			response.getWriter().write(gson.toJson(e.getMessage()));
		}
	}

	 private void updateCommandeStatus(HttpServletRequest request, HttpServletResponse response, String newStatus) throws IOException {
	        int commandeId = Integer.parseInt(request.getParameter("commandeId"));
	        Commande commande = commandeDao.find(commandeId);

	        if (commande != null) {
	            commande.setStatut(newStatus);
	            commandeDao.update(commande);
	        } else {
	            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Commande not found");
	        }

	        response.sendRedirect("http://localhost:8080/projetjsp1/commande?action=livreurcommandes");
	    }

	    private void finishDelivery(HttpServletRequest request, HttpServletResponse response) throws IOException {
	        int commandeId = Integer.parseInt(request.getParameter("commandeId"));
	        Commande commande = commandeDao.find(commandeId);

	        if (commande != null) {
	            commande.setStatut("commande livrée");
	            commandeDao.update(commande);

	            // Update livreur availability
	            int livreurId = commande.getLivreurid();
	            Livreur livreur = livreurDao.find(livreurId);
	            if (livreur != null) {
	                livreur.setIsAvailable(true);
	                livreurDao.update(livreur);
	            }

	            response.sendRedirect("http://localhost:8080/projetjsp1/commande?action=livreurcommandes");
	        } else {
	            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Commande not found");
	        }
	    }

	private void assignLivreurAjax(HttpServletRequest request, HttpServletResponse response) throws IOException {
		int commandeId = Integer.parseInt(request.getParameter("commandeId"));
		int livreurId = Integer.parseInt(request.getParameter("livreurId"));
		System.out.println("Received commandeId: " + commandeId + ", livreurId: " + livreurId); // Debug statement

		Commande commande = commandeDao.find(commandeId);
		Livreur livreur = livreurDao.find(livreurId); // Find the selected livreur

		if (commande != null && livreur != null) {
			System.out.println("Found Commande: " + commande); // Debug statement
			commande.setLivreurid(livreurId);
			commande.setStatut("prête");

			// Set the livreur's availability to false
			livreur.setIsAvailable(false);
			livreurDao.update(livreur);

			commandeDao.update(commande);
			System.out.println("Updated Commande: " + commande); // Debug statement

			response.sendRedirect("http://localhost:8080/projetjsp1/commande?action=chefcommandes");
		} else {
			response.setContentType("application/json");
			response.getWriter().write("{\"status\":\"error\", \"message\":\"Commande or Livreur not found\"}");
		}
	}

//	private void addCommande(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        response.setContentType("application/json");
//        Gson gson = new Gson();
//        BufferedReader reader = request.getReader();
//        JsonObject json = gson.fromJson(reader, JsonObject.class);
//        int userId = 1; // Example, should come from session or decoded from request
//        String numTel = json.get("numTel").getAsString();
//        String adresseLivraison = json.get("adresseLivraison").getAsString();
//        try {
//            List<Panier> cartItems = panierDao.findAllByUserId(userId);
//            if (cartItems == null || cartItems.isEmpty()) {
//                throw new IllegalArgumentException("No cart items found for the user.");
//            }
//            float prixTotal = cartItems.stream()
//                    .map(Panier::getPrixTotal)
//                    .reduce(0f, Float::sum);
//            // Generate comma-separated pizza IDs
//            String pizzaIds = cartItems.stream()
//                                       .map(item -> String.valueOf(item.getPizza().getId()))
//                                       .collect(Collectors.joining(","));
//            Commande newCommande = new Commande(userId, "en attente", new Date(), numTel, adresseLivraison, prixTotal, pizzaIds);
//            commandeDao.saveCommandeWithItems(newCommande, cartItems);
//            response.getWriter().write(gson.toJson("Order placed successfully!"));
//        } catch (Exception e) {
//            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//            response.getWriter().write(gson.toJson(e.getMessage()));
//        }
//    }
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
