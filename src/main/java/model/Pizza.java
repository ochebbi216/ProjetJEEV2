package model;

import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "Pizza")
public class Pizza {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "pizzaId")
	private int pizzaId;

	@Column(name = "nom")
	private String nom;
	
	@Column(name = "categorie")
	private String categorie;

	@Column(name = "taille")
	private String taille;

	@Column(name = "description")
	private String description;

	@Column(name = "prixBase")
	private float prixBase;

	@Column(name = "image")
	private String image;
	@Column(name = "discountPercentage")
	private float discountPercentage = 0;


//	@ManyToMany(mappedBy = "pizzas")
//	private List<Commande> commandes;
    
    @OneToMany(mappedBy = "pizza")
    private List<Panier> paniers;
    
	// JPA requires a no-arg constructor
	public Pizza() {
	}


	// Removed the pizzaId from the constructor as it's auto-generated
	public Pizza(String nom,String categorie , String taille , String description, float prixBase, String image) {
		this.nom = nom;
		this.categorie = categorie;
		this.taille = taille;
		this.description = description;
		this.prixBase = prixBase;
		this.image = image;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getId() {
		return pizzaId;
	}

	public void setId(int id) {
		this.pizzaId = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getTaille() {
		return taille;
	}

	public void setTaille(String taille) {
		this.taille = taille;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public float getPrixBase() {
		return prixBase;
	}

	public void setPrixBase(float prixBase) {
		this.prixBase = prixBase;
	}
	public String getCategorie() {
		return categorie;
	}

	public void setCategorie(String categorie) {
		this.categorie = categorie;
	}
//    public List<Commande> getCommandes() {
//        return commandes;
//    }
//
//    public void setCommandes(List<Commande> commandes) {
//        this.commandes = commandes;
//    }
    public List<Panier> getPaniers() {
        return paniers;
    }

    public void setPaniers(List<Panier> paniers) {
        this.paniers = paniers;
    }
	public float getDiscountPercentage() {
	    return discountPercentage;
	}

	public void setDiscountPercentage(float discountPercentage) {
	    this.discountPercentage = discountPercentage;
	}
}