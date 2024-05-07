package dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import model.User;
import util.Hibernate;

public class UserDao {
	
    private Session openSession() {
        return Hibernate.getSessionFactory().openSession();
    }
    
    public User find(int id) {
        try (Session session = openSession()) {
            return session.get(User.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to find user with ID: " + id, e);
        }
    }
    
	public boolean authenticateByEmail(String email) {
	    try (Session session = openSession()) {
	        String hql = "SELECT count(*) FROM User WHERE login = :login";
	        Query<Long> query = session.createQuery(hql, Long.class);
	        query.setParameter("email", email);
	        return query.uniqueResult() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	public User authenticate(String login, String pass) {
        try (Session session = openSession()) {
            String hql = "FROM User WHERE login = :login AND pass = :pass";
            Query query = session.createQuery(hql);
            query.setParameter("login", login);
            query.setParameter("pass", pass);
            return (User) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Authentication failed", e);
        }
    }

    public void save(User user) {
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

    public void update(User user) {
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
            User user = session.get(User.class, userId);
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

    public List<User> findAll() {
        try (Session session = openSession()) {
            return session.createQuery("FROM User", User.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to fetch all users", e);
        }
    }
}
