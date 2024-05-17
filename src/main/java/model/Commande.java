package model;

import java.util.Date;
import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "Commande")
public class Commande {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "commandeId")
    private int commandeId;

    @Column(name = "userid")
    private int userid;

    @Column(name = "chefid")
    private Integer chefid;
    
    @Column(name = "pizzas")
    private String pizzas; 

    @Column(name = "livreurid")
    private Integer livreurid;

    @Column(name = "statut")
    private String statut;

    @Column(name = "dateCommande")
    @Temporal(TemporalType.TIMESTAMP)
    private Date dateCommande;

    @Column(name = "adresseLivraison")
    private String adresseLivraison;

    @Column(name = "numTel")
    private String numTel;

    @Column(name = "prixTotal")
    private float prixTotal;

//    @Column(name = "pizzas")
//    private String pizzas; // Comma-separated pizza IDs

    // One-to-many relationship with Panier
//    @OneToMany(mappedBy = "commande", cascade = CascadeType.ALL)
//    private List<Panier> paniers;

    // Constructor without commandeId as it's auto-generated
    public Commande(int userid,String pizzas, String statut, Date dateCommande, String numTel, String adresseLivraison, float prixTotal) {
        this.userid = userid;
        this.pizzas = pizzas;
        this.statut = statut;
        this.dateCommande = dateCommande;
        this.adresseLivraison = adresseLivraison;
        this.prixTotal = prixTotal;
        this.numTel = numTel;

    }

    public Commande() {
        super();
    }

    // Getters and setters
    public int getCommandeId() {
        return commandeId;
    }

    public String getNumTel() {
        return numTel;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public Integer getChefid() {
        return chefid;
    }

    public void setChefid(Integer chefid) {
        this.chefid = chefid;
    }

    public Integer getLivreurid() {
        return livreurid;
    }

    public void setLivreurid(Integer livreurid) {
        this.livreurid = livreurid;
    }

    public void setNumTel(String numTel) {
        this.numTel = numTel;
    }

    public void setCommandeId(int commandeId) {
        this.commandeId = commandeId;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public Date getDateCommande() {
        return dateCommande;
    }

    public void setDateCommande(Date dateCommande) {
        this.dateCommande = dateCommande;
    }

    public String getAdresseLivraison() {
        return adresseLivraison;
    }

    public void setAdresseLivraison(String adresseLivraison) {
        this.adresseLivraison = adresseLivraison;
    }

    public float getPrixTotal() {
        return prixTotal;
    }

    public void setPrixTotal(float prixTotal) {
        this.prixTotal = prixTotal;
    }

    public String getPizzas() {
        return pizzas;
    }

    public void setPizzas(String pizzas) {
        this.pizzas = pizzas;
    }

//    public List<Panier> getPaniers() {
//        return paniers;
//    }
//
//    public void setPaniers(List<Panier> paniers) {
//        this.paniers = paniers;
//    }
}
