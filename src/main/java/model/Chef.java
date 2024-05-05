package model;

import jakarta.persistence.*;
@Entity
@Table(name = "Chef")
public class Chef {
	@Id @GeneratedValue
	@Column(name = "chefId")
    private int chefId;
	
	@Column(name = "nom")
    private String nom;
	
	@Column(name = "email")
    private String email;
	
	@Column(name = "motDePasse")
    private String motDePasse;

    public Chef(String nom, String email, String motDePasse) {
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
    }

	public Chef() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getChefId() {
		return chefId;
	}

	public void setChefId(int chefId) {
		this.chefId = chefId;
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

}

