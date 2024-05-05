package controller;


import java.io.IOException;
import java.util.Vector;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.Hibernate;

/**
 * Servlet implementation class InscriptionController
 */
public class inscriptionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public inscriptionController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String l=request.getParameter("login");
		String p=request.getParameter("pass");
		String n=request.getParameter("nom");
		String pr=request.getParameter("prenom");
		User u=new User(l,p,n,pr);
		
		
		 //insérer une entité
		SessionFactory sessionFactory = Hibernate.getSessionFactory();
		 Session session= sessionFactory.openSession();
		 Transaction tx=null;
		 try {
		 tx = session.beginTransaction();
		 session.persist(u);
		 tx.commit();
		 }
		 catch (Exception e) { if (tx!=null) tx.rollback(); throw e; }
		 finally { session.close(); }
		 
		 
		 
		ServletContext c = getServletContext();
		Vector<User> users=new Vector();
		if(c.getAttribute("users")!=null)
		{
			users = (Vector<User>)c.getAttribute("users");
		}
		
		users.add(u);
		c.setAttribute("users",users);
		response.sendRedirect("/projetjsp1/auth.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
