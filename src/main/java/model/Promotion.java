//package model;
//
//import java.util.Date;
//
//import jakarta.persistence.*;
//@Entity
//@Table(name = "Promotion")
//public class Promotion {
//	@Id @GeneratedValue
//	@Column(name = "promotionId")
//    private int promotionId;
//	
//	@Column(name = "description")
//    private String description;
//    
//	@Column(name = "dateDebut")
//    private Date dateDebut;
//    
//	@Column(name = "dateFin")
//    private Date dateFin;
//    
//	@Column(name = "pourcentageRemise")
//    private float pourcentageRemise;
//
//    public Promotion(int promotionId, String description, Date dateDebut, Date dateFin, float pourcentageRemise) {
//        this.promotionId = promotionId;
//        this.description = description;
//        this.dateDebut = dateDebut;
//        this.dateFin = dateFin;
//        this.pourcentageRemise = pourcentageRemise;
//    }
//
//	public int getPromotionId() {
//		return promotionId;
//	}
//
//	public void setPromotionId(int promotionId) {
//		this.promotionId = promotionId;
//	}
//
//	public String getDescription() {
//		return description;
//	}
//
//	public void setDescription(String description) {
//		this.description = description;
//	}
//
//	public Date getDateDebut() {
//		return dateDebut;
//	}
//
//	public void setDateDebut(Date dateDebut) {
//		this.dateDebut = dateDebut;
//	}
//
//	public Date getDateFin() {
//		return dateFin;
//	}
//
//	public void setDateFin(Date dateFin) {
//		this.dateFin = dateFin;
//	}
//
//	public float getPourcentageRemise() {
//		return pourcentageRemise;
//	}
//
//	public void setPourcentageRemise(float pourcentageRemise) {
//		this.pourcentageRemise = pourcentageRemise;
//	}
//
//}
