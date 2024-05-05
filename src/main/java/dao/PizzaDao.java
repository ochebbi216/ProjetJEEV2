package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import model.Pizza;
import util.Hibernate;

public class PizzaDao {

    private Session openSession() {
        return Hibernate.getSessionFactory().openSession();
    }

    public Pizza find(int id) {
        try (Session session = openSession()) {
            return session.get(Pizza.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to find pizza with ID: " + id, e);
        }
    }

    public void save(Pizza pizza) {
        Transaction tx = null;
        try (Session session = openSession()) {
            tx = session.beginTransaction();
            session.persist(pizza);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to save pizza", e);
        }
    }

    public void update(Pizza pizza) {
        Transaction tx = null;
        try (Session session = openSession()) {
            tx = session.beginTransaction();
            session.merge(pizza);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to update pizza", e);
        }
    }

    public void delete(int pizzaId) {
        Transaction tx = null;
        Session session = openSession();
        try (session) {
            tx = session.beginTransaction();
            Pizza pizza = session.get(Pizza.class, pizzaId);
            if (pizza != null) {
                session.remove(pizza);
                tx.commit();
            } else {
                System.out.println("Pizza not found for ID: " + pizzaId);
            }
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to delete pizza with ID: " + pizzaId, e);
        } finally {
        	session.close();
        }
    }

    public List<Pizza> findAll() {
        try (Session session = openSession()) {
            return session.createQuery("FROM Pizza", Pizza.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to fetch all pizzas", e);
        }
    }
}
