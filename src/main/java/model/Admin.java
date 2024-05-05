package model;

import jakarta.persistence.*;
@Entity
@Table(name = "Admin")
public class Admin {
	
	@Id @GeneratedValue
	@Column(name = "adminId")
    private int adminId;	
	
	@Column(name = "nom")
    private String nom;
	
	@Column(name = "email")
    private String email;
	
	@Column(name = "motDePasse")
    private String motDePasse;

    public Admin( String nom, String email, String motDePasse) {
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
    }

    public Admin() {
		super();
		// TODO Auto-generated constructor stub
	}

	// Getters and Setters
    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMotDePasse() {
        return motDePasse;
    }

    public void setMotDePasse(String motDePasse) {
        this.motDePasse = motDePasse;
    }

    // Methods like gererUtilisateurs(), gererCommandes(), gererPromotions() would go here
}

