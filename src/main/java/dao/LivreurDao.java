package dao;

import java.util.List;

import org.hibernate.Session;

import org.hibernate.Transaction;

import model.Livreur;

import util.Hibernate;

public class LivreurDao {

	private Session openSession() {

		return Hibernate.getSessionFactory().openSession();

	}

	public Livreur find(int id) {

		try (Session session = openSession()) {

			return session.get(Livreur.class, id);

		} catch (Exception e) {

			e.printStackTrace();

			throw new RuntimeException("Failed to find user with ID: " + id, e);

		}

	}
	
	public List<Livreur> findByAvailability(boolean isAvailable) {
	    try (Session session = openSession()) {
	        return session.createQuery("FROM Livreur WHERE isAvailable = :status", Livreur.class)
	                      .setParameter("status", isAvailable)
	                      .list();
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException("Failed to fetch livreurs by availability", e);
	    }
	}


	public void save(Livreur user) {

		Transaction tx = null;

		try (Session session = openSession()) {

			tx = session.beginTransaction();

			session.persist(user);

			tx.commit();

		} catch (Exception e) {

			if (tx != null)

				tx.rollback();

			e.printStackTrace();

			throw new RuntimeException("Failed to save user", e);

		}

	}

	public void update(Livreur user) {

		Transaction tx = null;

		try (Session session = openSession()) {

			tx = session.beginTransaction();

			session.merge(user);

			tx.commit();

		} catch (Exception e) {

			if (tx != null)

				tx.rollback();

			e.printStackTrace();

			throw new RuntimeException("Failed to update user", e);

		}

	}

	public void delete(int userId) {

		Transaction tx = null;

		Session session = openSession();

		try (session) {

			tx = session.beginTransaction();

			Livreur user = session.get(Livreur.class, userId);

			if (user != null) {

				session.remove(user);

				tx.commit();

			} else {

				System.out.println("User not found for ID: " + userId);

			}

		} catch (Exception e) {

			if (tx != null)

				tx.rollback();

			e.printStackTrace();

			throw new RuntimeException("Failed to delete user with ID: " + userId, e);

		} finally {

			session.close();

		}

	}

	public List<Livreur> findAll() {

		try (Session session = openSession()) {

			return session.createQuery("FROM Livreur", Livreur.class).list();

		} catch (Exception e) {

			e.printStackTrace();

			throw new RuntimeException("Failed to fetch all users", e);

		}

	}

}
