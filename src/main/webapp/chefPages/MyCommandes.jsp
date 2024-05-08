<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page
	import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest, java.io.IOException"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String chefIdValue = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if ("chefId".equals(cookie.getName())) {
	chefIdValue = cookie.getValue();
	break;
		}
	}
}
%>






<!DOCTYPE html>



<html lang="en">



<head>



<meta charset="UTF-8">



<meta name="viewport" content="width=device-width, initial-scale=1.0">



<title>All Orders</title>



<meta charset="utf-8">



<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">



<!-- plugins:css -->



<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">







<link rel="stylesheet" href="admin/vendors/feather/feather.css">



<link rel="stylesheet"
	href="admin/vendors/ti-icons/css/themify-icons.css">



<link rel="stylesheet" href="admin/vendors/css/vendor.bundle.base.css">



<!-- endinject -->



<!-- Plugin css for this page -->



<link rel="stylesheet"
	href="admin/vendors/datatables.net-bs4/dataTables.bootstrap4.css">



<link rel="stylesheet"
	href="admin/vendors/ti-icons/css/themify-icons.css">



<link rel="stylesheet" type="text/css"
	href="admin/js/select.dataTables.min.css">



<!-- End plugin css for this page -->



<!-- inject:css -->



<link rel="stylesheet" href="admin/css/vertical-layout-light/style.css">



<!-- endinject -->



<link rel="shortcut icon" href="admin/images/favicon.png" />



<style>
body {
	padding-top: 20px;
	background-color: #f8f9fa;
}

.container {
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

table {
	width: 100%;
	margin-top: 20px;
}

th, td {
	text-align: center;
	padding: 8px;
}

td img {
	width: 100px;
	height: auto;
}

.header {
	margin-bottom: 30px;
}
</style>



</head>







<body>



	<div class="container-scroller">







		<jsp:include page="admin-header.jsp" />



		<div class="main-panel">



			<div class="content-wrapper">







				<h1 class="header">List of Available of Orders</h1>



				<!--             <a href="/projetjsp1/AddPizza.jsp" class="btn btn-success"> <i class="fas fa-add"></i> Add New Pizza</a>



 -->



				<table class="table table-striped">

					<thead class="thead-dark">

						<tr>

							<th scope="col">Commande ID</th>

							<th scope="col">Status</th>

							<th scope="col">Date Commande</th>

							<th scope="col">Delivery Address</th>

							<th scope="col">Phone Number</th>

							<th scope="col">Total Price</th>

							<th scope="col">Actions</th>

						</tr>

					</thead>

					<tbody>

						<c:forEach var="commande" items="${commandes}">

							<tr>

								<td>${commande.commandeId}</td>

								<td>${commande.statut}</td>

								<td><fmt:formatDate value="${commande.dateCommande}"
										pattern="yyyy-MM-dd HH:mm" /></td>

								<td>${commande.adresseLivraison}</td>

								<td>${commande.numTel}</td>

								<td>${commande.prixTotal}DT</td>

								<td><c:choose>
										<c:when test="${commande.statut eq 'en attente'}">
											<a
												href="commande?action=startOrder&id=${commande.commandeId}&chefId=<%=chefIdValue%>"
												class="btn btn-outline-primary"> Start Order </a>
										</c:when>
										<c:when test="${commande.statut eq 'en cour'}">
											<a
												href="commande?action=finishOrder&id=${commande.commandeId}&chefId=<%=chefIdValue%>"
												class="btn btn-outline-success"> Finish Order </a>
										</c:when>
										<c:otherwise>
											<!-- Optionally show some info about completed orders -->
											<span>Completed</span>
										</c:otherwise>
									</c:choose> <%-- 								<select class="form-control">

										<option value="">Select Livreur</option>

										<c:forEach var="livreur" items="${livreursDisponibles}">

											<option value="${livreur.livreurId}">${livreur.nom}</option>

										</c:forEach>

								</select>  --%> <%--    <button type="button" onclick="assignLivreur(this, ${commande.commandeId});" class="btn btn-success">Assign</button> --%>

								</td>

							</tr>

						</c:forEach>

					</tbody>

				</table>



			</div>



			<jsp:include page="admin-footer.jsp" />



		</div>



	</div>











	<br>

	<br>

	<br>

	<br>

	<!-- <script>

function assignLivreur(buttonElement, commandeId) {

    var selectElement = buttonElement.previousElementSibling;

    var livreurId = selectElement.value;

    if (livreurId) {

        // Ici, vous pourriez envoyer une requête POST à votre serveur pour affecter le livreur

        console.log("Assigning livreur ID " + livreurId + " to commande ID " + commandeId);

        // Ajoutez ici la logique pour envoyer la requête au serveur

    }

}

</script> -->


<!-- <script>
document.addEventListener("DOMContentLoaded", function() {
    const startButtons = document.querySelectorAll('.btn-outline-primary');
    startButtons.forEach(button => {
        button.addEventListener('click', function() {
            this.classList.remove('btn-outline-primary');
            this.classList.add('btn-outline-success');
            this.innerHTML = 'Finish Order';
            this.href = this.href.replace("startOrder", "finishOrder");
        });
    });
});
</script> -->

	<script>
    document.addEventListener("DOMContentLoaded", function() {
        const startButtons = document.querySelectorAll('.btn-outline-primary');
        startButtons.forEach(button => {
            button.addEventListener('click', function() {
                button.disabled = true;
            });
        });
    });
</script>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>



	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>



	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>







</html>