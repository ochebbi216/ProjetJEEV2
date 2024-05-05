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

//    @ManyToOne
//    @JoinColumn(name = "userId", referencedColumnName = "id")
    @Column(name = "userid")
    private int userid;

    @ManyToOne
    @JoinColumn(name = "commandeId", referencedColumnName = "commandeId")
    private Commande commande;
   
    @Column(name = "pizzaid")
    private int pizzaid;

    @Column(name = "quantite")
    private int quantite;

@Column(name = "prixTotal")
    private float prixTotal;

    public Panier() {
   
    }

    public Panier(int userid, int pizzaid, int quantite, float prixTotal ) {
        this.userid = userid;
        this.pizzaid = pizzaid;
        this.quantite = quantite;
        this.prixTotal = prixTotal;

    }

    public int getPanierId() {
        return panierId;
    }

    public int getUserid() {
return userid;
}

public void setUserid(int userid) {
this.userid = userid;
}

public int getPizzaid() {
return pizzaid;
}

public void setPizzaid(int pizzaid) {
this.pizzaid = pizzaid;
}

public void setPanierId(int panierId) {
        this.panierId = panierId;
    }

    public float getPrixTotal() {
        return prixTotal;
    }

    public void setPrixTotal(float prixTotal) {
        this.prixTotal = prixTotal;
    }
   
    public int getQuantite() {
return quantite;
}

public void setQuantite(int quantite) {
this.quantite = quantite;
}

    public Commande getCommande() {
        return commande;
    }

    public void setCommande(Commande commande) {
        this.commande = commande;
    }
}