package model;

import jakarta.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "Livreur")
public class Livreur {
    @Id @GeneratedValue
    @Column(name = "livreurId")
    private int livreurId;
    
    @Column(name = "nom")
    private String nom;
    
    @Column(name = "email")
    private String email;
    
    @Column(name = "motDePasse")
    private String motDePasse;

    // Field to indicate if the delivery person is currently available
    @Column(name = "isAvailable")
    private boolean isAvailable;



    public Livreur(String nom, String email, String motDePasse, boolean isAvailable) {
        this.nom = nom;
        this.email = email;
        this.motDePasse = motDePasse;
        this.isAvailable = isAvailable;
    }

    public Livreur() {
        super();
    }

    // Getter and Setter for isAvailable
    public boolean getIsAvailable() {
        return isAvailable;
    }

    

    public void setIsAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }


    // Existing getters and setters
    public int getLivreurId() {
        return livreurId;
    }

    public void setLivreurId(int livreurId) {
        this.livreurId = livreurId;
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
