package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import model.Panier;
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

    public void save(Panier panier) {
        Transaction tx = null;
        try (Session session = openSession()) {
            tx = session.beginTransaction();
            session.persist(panier);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to save panier", e);
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

}
