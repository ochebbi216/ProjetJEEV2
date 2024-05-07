package controller;

import com.google.gson.Gson;

import com.google.gson.JsonObject;

import java.io.BufferedReader;

import java.io.IOException;

import java.util.List;

import org.hibernate.Hibernate;

import org.hibernate.Session;

import org.hibernate.Transaction;

import dao.CommandeDao;

import dao.PanierDao;

import jakarta.servlet.*;

import jakarta.servlet.http.*;

import jakarta.servlet.annotation.*;

import model.Commande;

import model.Panier;

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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

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

			default:

				List<Commande> commandes = commandeDao.findAll();

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

			}

		}

	}

	private void addCommande(HttpServletRequest request, HttpServletResponse response) throws IOException {

		response.setContentType("application/json");

		Gson gson = new Gson();

		BufferedReader reader = request.getReader();

		JsonObject json = gson.fromJson(reader, JsonObject.class);

		int userId = 1; // Example, should come from session or decoded from request

		String numTel = json.get("numTel").getAsString();

		String adresseLivraison = json.get("adresseLivraison").getAsString();

		try {

			List<Panier> cartItems = panierDao.findAllByUserId(userId);

			if (cartItems == null || cartItems.isEmpty()) {

				throw new IllegalArgumentException("No cart items found for the user.");

			}

			float prixTotal = cartItems.stream()

					.map(Panier::getPrixTotal)

					.reduce(0f, Float::sum);

			Commande newCommande = new Commande(userId, "en attente", new Date(), numTel, adresseLivraison, prixTotal);

			commandeDao.saveCommandeWithItems(newCommande, cartItems);

			response.getWriter().write(gson.toJson("Order placed successfully!"));

		} catch (Exception e) {

			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

			response.getWriter().write(gson.toJson(e.getMessage()));

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
