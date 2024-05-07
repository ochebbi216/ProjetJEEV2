package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import model.Commande;
import model.Panier;
import util.Hibernate;

public class CommandeDao {
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

   public void saveCommandeWithItems(Commande commande, List<Panier> cartItems) {
       Transaction tx = null;
       try (Session session = openSession()) {
           tx = session.beginTransaction();
           session.persist(commande);
           for (Panier item : cartItems) {
               item.setCommande(commande);
               session.merge(item);
           }
           tx.commit();
       } catch (Exception e) {
           if (tx != null) tx.rollback();
           e.printStackTrace();
           throw new RuntimeException("Failed to save commande and update panier items", e);
       }
   }
   
   public List<Commande> findAll() {
       try (Session session = openSession()) {
           return session.createQuery("FROM Commande", Commande.class).list();
       } catch (Exception e) {
           e.printStackTrace();
           throw new RuntimeException("Failed to fetch all commandes", e);
       }
   }
   

}
