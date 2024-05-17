package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import jakarta.persistence.EntityManager;
import model.Panier;
import model.Pizza;
import util.Hibernate;

public class PanierDao {

    private Session openSession() {
        return Hibernate.getSessionFactory().openSession();
    }

    public Panier find(int id) {
        try (Session session = openSession()) {
            return session.get(Panier.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to find panier with ID: " + id, e);
        }
    }


//    public void save(Panier panier) {
//        Transaction tx = null;
//        try (Session session = openSession()) {
//            tx = session.beginTransaction();
//            session.persist(panier);
//            tx.commit();
//        } catch (Exception e) {
//            if (tx != null) tx.rollback();
//            e.printStackTrace();
//            throw new RuntimeException("Failed to save panier", e);
//        }
//    }
    
    public void save(Panier panier) {
        Transaction tx = null;
        Session session = null;
        try {
            session = openSession();
            tx = session.beginTransaction();
            session.persist(panier);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Failed to save panier", e);
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
    public Panier findByPizzaAndUserId(Pizza pizza, int userId) {
        try (Session session = openSession()) {
            // Create a query that selects a Panier where the pizza and userId match the provided values
            Query<Panier> query = session.createQuery("FROM Panier p WHERE p.pizza = :pizza AND p.userid = :userId", Panier.class);
            query.setParameter("pizza", pizza);
            query.setParameter("userId", userId);
            return query.uniqueResult(); // Returns the single result or null if no result found
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to find panier for user ID: " + userId + " and pizza ID: " + pizza.getId(), e);
        }
    }


    public void update(Panier panier) {
        Transaction tx = null;
        try (Session session = openSession()) {
            tx = session.beginTransaction();
            session.merge(panier);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to update panier", e);
        }
    }

    public void delete(int panierId) {
        Transaction tx = null;
        Session session = openSession();
        try (session) {
            tx = session.beginTransaction();
            Panier panier = session.get(Panier.class, panierId);
            if (panier != null) {
                session.remove(panier);
                tx.commit();
            } else {
                System.out.println("Panier not found for ID: " + panierId);
            }
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to delete panier with ID: " + panierId, e);
        } finally {
        	session.close();
        }
    }

    public List<Panier> findAll() {
        try (Session session = openSession()) {
            return session.createQuery("FROM Panier", Panier.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to fetch all paniers", e);
        }
    }
    
    public List<Panier> findAllByUserId(int userId) {
        Transaction tx = null;
        List<Panier> results = null;
        try (Session session = openSession()) {
            tx = session.beginTransaction();
            // Query to find all Panier instances by userid
            results = session.createQuery("FROM Panier p WHERE p.userid = :userid", Panier.class)
                             .setParameter("userid", userId)
                             .list();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to find paniers for user ID: " + userId, e);
        }
        return results;
    }
    
    public void deleteAllByUserId(int userId) {
        Transaction tx = null;
        try (Session session = openSession()) {
            tx = session.beginTransaction();
            Query query = session.createQuery("DELETE FROM Panier WHERE userid = :userId");
            query.setParameter("userId", userId);
            query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to delete paniers for user ID: " + userId, e);
        }
    }

}
