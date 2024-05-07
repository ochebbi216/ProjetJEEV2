<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page
	import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest"%>
<%
boolean isAuthenticated = false;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if ("userEmail".equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
	isAuthenticated = true;
	break;
		}
	}
}

if (!isAuthenticated) {
	response.sendRedirect("userPages/LoginUser.jsp"); // Redirect to the login page if not authenticated
	return;
}
%>

<!DOCTYPE html>

<html>

<head>

<title>All Commandes</title>
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

</head>

<body>
	<jsp:include page="client-header.jsp" />

	<main class="container mt-4">
		<br> <br> <br> <br> <br> <br>

		<h1 class="text-center">My Orders</h1>
		<br>
		<table class="table table-bordered text-center">
			<thead>

				<tr>

					<th scope="col">Commande ID</th>

					<th scope="col">Status</th>

					<th scope="col">Date Commande</th>

					<th scope="col">Delivery Address</th>

					<th scope="col">Total Price</th>

				</tr>
			</thead>
			<c:forEach var="commande" items="${commandes}">

				<tr>

					<td>${commande.commandeId}</td>


					<td>${commande.statut}</td>

					<td><fmt:formatDate value="${commande.dateCommande}"
							pattern="yyyy-MM-dd HH:mm" /></td>

					<td>${commande.adresseLivraison}</td>

					<td>${commande.prixTotal}</td>


				</tr>

			</c:forEach>



		</table>

		<a class="btn btn-outline-danger" href="panier"><i
			class="fa-solid fa-pizza-slice"></i> Add New Order</a>
	</main>
	<br>
	<br>
	<br>
	<br>

	<jsp:include page="footer-client.jsp" />
	<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>

