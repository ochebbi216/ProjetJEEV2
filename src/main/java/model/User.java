package model;

import jakarta.persistence.*;
@Entity
@Table(name = "User")

public class User {
	 @Id @GeneratedValue
	 @Column(name = "id")
	 private int id;
	 @Column(name = "login") 
	 private String login;
	 @Column(name = "pass")
	 private String pass;
	 @Column(name = "nom")
	 private String nom;
	 @Column(name = "prenom")
	 private String prenom;

	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(String login, String pass, String nom, String prenom) {
		this.login = login;
		this.pass = pass;
		this.nom = nom;
		this.prenom = prenom;
	}
	public int getId() {
	    return id;
	}

	
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	@Override
	public String toString() {
		return "User [login=" + login + ", pass=" + pass + "]";
	}
	

}

