package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import model.Chef;
import util.Hibernate;

public class ChefDao {
	
    private Session openSession() {
        return Hibernate.getSessionFactory().openSession();
    }
    
    public Chef find(int id) {
        try (Session session = openSession()) {
            return session.get(Chef.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to find user with ID: " + id, e);
        }
    }

    public void save(Chef user) {
        Transaction tx = null;
        try (Session session = openSession()) {
            tx = session.beginTransaction();
            session.persist(user);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to save user", e);
        }
    }

    public void update(Chef user) {
        Transaction tx = null;
        try (Session session = openSession()) {
            tx = session.beginTransaction();
            session.merge(user);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to update user", e);
        }
    }

    public void delete(int userId) {
        Transaction tx = null;
        Session session = openSession();
        try (session) {
            tx = session.beginTransaction();
            Chef user = session.get(Chef.class, userId);
            if (user != null) {
                session.remove(user);
                tx.commit();
            } else {
                System.out.println("User not found for ID: " + userId);
            }
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            throw new RuntimeException("Failed to delete user with ID: " + userId, e);
        } finally {
        	session.close();
        }
    }

    public List<Chef> findAll() {
        try (Session session = openSession()) {
            return session.createQuery("FROM Chef", Chef.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to fetch all users", e);
        }
    }
}
