package model;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Panier")
public class Panier {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "panierId")
    private int panierId;

    @Column(name = "userid")
    private int userid;

    @ManyToOne
    @JoinColumn(name = "pizzaId", referencedColumnName = "pizzaId")
    private Pizza pizza;

    @Column(name = "quantite")
    private int quantite;

    @Column(name = "prixTotal")
    private float prixTotal;

    public Panier() {
    }

    public Panier(int userid, Pizza pizza, int quantite, float prixTotal) {
        this.userid = userid;
        this.pizza = pizza;
        this.quantite = quantite;
        this.prixTotal = prixTotal;
    }

    // Getters and Setters
    public int getPanierId() {
        return panierId;
    }

    public void setPanierId(int panierId) {
        this.panierId = panierId;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public Pizza getPizza() {
        return pizza;
    }

    public void setPizza(Pizza pizza) {
        this.pizza = pizza;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite(int quantite) {
        this.quantite = quantite;
    }

    public float getPrixTotal() {
        return prixTotal;
    }

    public void setPrixTotal(float prixTotal) {
        this.prixTotal = prixTotal;
    }

}
