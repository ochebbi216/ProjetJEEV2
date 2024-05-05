package dao;

import java.util.List;

import org.hibernate.Session;

import org.hibernate.Transaction;
import org.hibernate.query.Query;

import model.Admin;

import util.Hibernate;

public class AdminDao {

	private Session openSession() {

		return Hibernate.getSessionFactory().openSession();

	}

	public Admin find(int id) {

		try (Session session = openSession()) {

			return session.get(Admin.class, id);

		} catch (Exception e) {

			e.printStackTrace();

			throw new RuntimeException("Failed to find user with ID: " + id, e);

		}

	}
	
	public Admin authenticate(String email, String motDePasse) {
        try (Session session = openSession()) {
            String hql = "FROM Admin WHERE email = :email AND motDePasse = :motDePasse";
            Query query = session.createQuery(hql);
            query.setParameter("email", email);
            query.setParameter("motDePasse", motDePasse);
            return (Admin) query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Authentication failed", e);
        }
    }

	public void save(Admin user) {

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

	public void update(Admin user) {

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

			Admin user = session.get(Admin.class, userId);

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

	public List<Admin> findAll() {

		try (Session session = openSession()) {

			return session.createQuery("FROM Admin", Admin.class).list();

		} catch (Exception e) {

			e.printStackTrace();

			throw new RuntimeException("Failed to fetch all users", e);

		}

	}

}
