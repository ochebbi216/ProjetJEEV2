<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jakarta.servlet.http.Cookie"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
boolean isAuthenticated = false;
int userId = -1; 
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if ("userId".equals(cookie.getName())) {
	userId = Integer.parseInt(cookie.getValue());
	isAuthenticated = true;
	break;
		}
	}
}

if (!isAuthenticated || userId == -1) {
	response.sendRedirect("userPages/LoginUser.jsp"); 
	return;
}
request.setAttribute("userId", userId);
%>

<!DOCTYPE html>
<html>
<head>
<title>List of Orders</title>
<link href="assets/img/favicon.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap"
	rel="stylesheet">
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="assets/css/main.css" rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">
	<style>
    .badge-en-attente {
        background-color: #ffc107; /* Yellow */
        color: white;
        font-size: 15px;
        
    }
    .badge-en-cour {
        background-color: #17a2b8; /* Blue */
        color: white;
        font-size: 15px;
        
    }
    .badge-prete {
        background-color: #6c757d; /* Gray */
        color: white;
        font-size: 15px;
    }
    .badge-en-cours-de-livraison {
        background-color: #fd7e14; /* Orange */
        color: white;
        font-size: 15px;

    }
    .badge-commande-livree {
        background-color:  #28a745; /* Green */ 
        color: white;
        font-size: 15px;

    }
</style>
</head>
<body>
	<jsp:include page="client-header.jsp" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="main-panel container">
		<div class="content-wrapper">
			<h1 class="header text-center">List of Orders</h1>
			        <div class="table-responsive">
			
			<table class="table table-bordered text-center">
				<thead class="thead-dark">
					<tr>
						<th scope="col">Pizza x Quantity</th>
						<th scope="col">Status</th>
						<th scope="col">Date Commande</th>
						<th scope="col">Total Price</th>
						<th scope="col">Delivery Address</th>
						<th scope="col">Phone Number</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty commandes}">
							<tr>
								<td colspan="6" style="color: red;">No orders found. Go to
									the menu and place an order.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="commande" items="${commandes}">
								<c:if test="${commande.userid == userId}">
									<tr>
										<td>
											<ul style="list-style-type:circle" >
												<c:forEach var="pizzaId"
													items="${fn:split(commande.pizzas, ',')}">
													<li>${pizzaId}</li>
												</c:forEach>
												<c:if test="${empty commande.pizzas}">
													<li>No pizzas listed</li>
												</c:if>
											</ul>
										</td>
										<td>
												<span class="badge text-white rounded-pill 
													<c:choose>
														<c:when test="${commande.statut == 'en attente'}">badge-en-attente</c:when>
														<c:when test="${commande.statut == 'en cour'}">badge-en-cour</c:when>
														<c:when test="${commande.statut == 'prête'}">badge-prete</c:when>
														<c:when test="${commande.statut == 'en cours de livraison'}">badge-en-cours-de-livraison</c:when>
														<c:when test="${commande.statut == 'commande livrée'}">badge-commande-livree</c:when>
													</c:choose>">${commande.statut}
												</span>
										</td>
										<td><fmt:formatDate value="${commande.dateCommande}"
												pattern="yyyy-MM-dd HH:mm" /></td>
										<td>${commande.prixTotal}DT</td>
										<td>${commande.adresseLivraison}</td>
										<td>${commande.numTel}</td>
									</tr>
								</c:if>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<jsp:include page="footer-client.jsp" />
	<div id="preloader"></div>
	<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="assets/vendor/aos/aos.js"></script>
	<script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
	<script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
	<script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
	<script src="assets/vendor/php-email-form/validate.js"></script>
	<script src="assets/js/main.js"></script>
</body>
</html>
