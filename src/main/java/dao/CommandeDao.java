package dao;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import model.Commande;
import model.Panier;
import model.Pizza;


import util.Hibernate;

public class CommandeDao {
   private PanierDao panierDao = new PanierDao();

private Session openSession() {
       return Hibernate.getSessionFactory().openSession();
   }

   public Commande find(int id) {
       try (Session session = openSession()) {
           return session.get(Commande.class, id);
       } catch (Exception e) {
           e.printStackTrace();
           throw new RuntimeException("Failed to find commande with ID: " + id, e);
       }
   }

   public void save(Commande commande) {
       Transaction tx = null;
       try (Session session = openSession()) {
           tx = session.beginTransaction();
           session.persist(commande);
           tx.commit();
       } catch (Exception e) {
           if (tx != null) tx.rollback();
           e.printStackTrace();
           throw new RuntimeException("Failed to save commande", e);
       }
   }

   public void update(Commande commande) {
       Transaction tx = null;
       try (Session session = openSession()) {
           tx = session.beginTransaction();
           session.merge(commande);
           tx.commit();
           
       } catch (Exception e) {
           if (tx != null) tx.rollback();
           e.printStackTrace();
           throw new RuntimeException("Failed to update commande", e);
       }
   }

   public void delete(int commandeId) {
       Transaction tx = null;
       Session session = openSession();
       try (session) {
           tx = session.beginTransaction();
           Commande commande = session.get(Commande.class, commandeId);
           if (commande != null) {
               session.remove(commande);
               tx.commit();
           } else {
               System.out.println("commande not found for ID: " + commandeId);
           }
       } catch (Exception e) {
           if (tx != null) tx.rollback();
           e.printStackTrace();
           throw new RuntimeException("Failed to delete commande with ID: " + commandeId, e);
       } finally {
        session.close();
       }
   }

   
   public List<Commande> findAll() {
       try (Session session = openSession()) {
           return session.createQuery("FROM Commande ORDER BY dateCommande DESC", Commande.class).list();
       } catch (Exception e) {
           e.printStackTrace();
           throw new RuntimeException("Failed to fetch all commandes", e);
       }
   }
   public List<Commande> findUnassignedCommandes() {
	    try (Session session = openSession()) {
	    	return session.createQuery("FROM Commande WHERE statut = 'en attente'", Commande.class).list();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ArrayList<>();
	    }
	}

   public List<Commande> findAssignedCommandes(int chefid) {
	    try (Session session = openSession()) {
	        Query<Commande> query = session.createQuery("FROM Commande WHERE (statut = 'en cour' OR statut = 'prête') AND chefid = :chefid ORDER BY dateCommande DESC", Commande.class);
	        query.setParameter("chefid", chefid);  // Make sure to set parameter
	        List<Commande> result = query.list();
	        if (result.isEmpty()) {
	            System.out.println("No commandes found for chefid: " + chefid);
	        } else {
	            System.out.println("Found " + result.size() + " commandes for chefid: " + chefid);
	        }
	        return result;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return new ArrayList<>();
	    }
	}


   public void saveCommandeWithItems(Commande commande) {
	    Transaction tx = null;
	    try (Session session = openSession()) {
	        tx = session.beginTransaction();
	        session.persist(commande); // Persist the commande first to generate the ID
	        tx.commit();
	    } catch (Exception e) {
	        if (tx != null) tx.rollback();
	        e.printStackTrace();
	        throw new RuntimeException("Failed to save commande and update panier items", e);
	    }
	}
   public List<Commande> findAllCommandesWithPizzas() {
	    try (Session session = openSession()) {
	        return session.createQuery("FROM Commande ORDER BY dateCommande DESC", Commande.class).getResultList();
	    } catch (Exception e) {
	        throw new RuntimeException("Failed to fetch commandes with pizzas", e);
	    }
	}
   public List<Commande> findAllByUserId(int userId) {
	    try (Session session = Hibernate.getSessionFactory().openSession()) {
	        return session.createQuery("FROM Commande WHERE userid = :userId", Commande.class)
	                      .setParameter("userId", userId)
	                      .list();
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("Failed to fetch commandes for user ID: " + userId, e);
	    }
	}
   public List<Commande> findCommandesByLivreurId(int livreurId) {
       try (Session session = Hibernate.getSessionFactory().openSession()) {
           Query<Commande> query = session.createQuery("FROM Commande WHERE livreurid = :livreurId ORDER BY dateCommande DESC", Commande.class);
           query.setParameter("livreurId", livreurId);
           return query.list();
       } catch (Exception e) {
           e.printStackTrace();
           throw new RuntimeException("Failed to fetch commandes for livreurId: " + livreurId, e);
       }
   }



}
