<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jakarta.servlet.http.Cookie"%>

<%
boolean isAuthenticated = false;
int userId = -1; // Initialize with an invalid userId
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
	response.sendRedirect("userPages/LoginUser.jsp"); // Redirect to the login page if not authenticated
	return;
}
request.setAttribute("userId", userId);
%>

<!DOCTYPE html>
<html>
<head>
<title>My Cart</title>
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
#deliveryForm {
	display: block; /* Changed from none to block */
	background-color: #f8f9fa;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

#deliveryForm label {
	font-weight: bold;
}

#deliveryForm input {
	margin-bottom: 10px;
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
	<main class="container mt-4">
		<h1 class="text-center">My Cart</h1>
		<br>
		<div class="row">
			<div class="col-8">
				<table class="table table-bordered text-center">
					<thead>
						<tr>
							<th scope="col">image</th>
							<th scope="col">Pizza</th>
							<th scope="col">Quantity</th>
							<th scope="col">Price</th>
							<th scope="col">Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty paniers}">
								<tr>
									<td colspan="4" style="color: red;">Your cart was empty.
										Go to the menu and add what you want.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="panier" items="${paniers}">
									<c:if test="${panier.userid == userId}">
										<tr>
											<td><img style="margin-bottom:25px;" src="${panier.pizza.image}"
												alt="${panier.pizza.nom}" width=100 height=80 /></td>
											<td><br> ${panier.pizza.nom}</td>
											<td><br> <c:out value="x ${panier.quantite}" /></td>
											<td><br><c:out value="${panier.prixTotal} DT" /></td>
											<td><br>
												<button  class="btn "
													onclick="deletePanier(${panier.panierId});">
													<script src="https://cdn.lordicon.com/lordicon.js"></script>
													<lord-icon style="margin-bottom:15px;"
													    src="https://cdn.lordicon.com/drxwpfop.json"
													    trigger="hover"
													    colors="primary:#e83a30,secondary:#545454"
													    style="width:35px;height:35px">
													</lord-icon>
<!-- 													<i class="fa-solid fa-trash"></i>
 -->												</button>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<div id="deliveryForm" class="col-4">
				<h2>Delivery Information:</h2>
				<form method="POST">
					<div class="mb-3">
						<label for="numTel" class="form-label">Phone Number</label> <input
							type="text" class="form-control" id="numTel" name="numTel"
							placeholder="Enter your phone number" required>
					</div>
					<div class="mb-3">
						<label for="adresseLivraison" class="form-label">Delivery
							Address</label> <input type="text" class="form-control"
							id="adresseLivraison" name="adresseLivraison"
							placeholder="Enter your delivery address" required>
					</div>
				</form>
			</div>
		</div>
		<br>
		<button type="button" class="btn btn-primary" onclick="submitOrder();"
			style="float: right;">
			<i class="fa-solid fa-dolly"></i> 
			
			Order All Now!
		</button>
		<a class="btn btn-outline-danger" href="pizza?action=menu"><i
			class="fa-solid fa-pizza-slice"></i> Still Hungry?</a>
	</main>
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
	<script>
function deletePanier(panierId) {
    if (confirm('Are you sure you want to delete this panier?')) {
        var form = document.createElement('form');
        document.body.appendChild(form);
        form.method = 'post';
        form.action = 'panier';
        var actionInput = document.createElement('input');
        actionInput.type = 'hidden';
        actionInput.name = 'action';
        actionInput.value = 'delete';
        form.appendChild(actionInput);
        var idInput = document.createElement('input');
        idInput.type = 'hidden';
        idInput.name = 'id';
        idInput.value = panierId;
        form.appendChild(idInput);
        form.submit();
    }
}
function submitOrder() {
    var cartItems = document.querySelectorAll('tr');
    var cartData = Array.from(cartItems).map(item => {
        return {
            panierId: item.dataset.panierId,
            prixTotal: item.dataset.prixTotal
        };
    });
    var numTel = document.getElementById('numTel').value;
    var adresseLivraison = document.getElementById('adresseLivraison').value;
    fetch('commande?action=add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            cartItems: cartData,
            numTel: numTel,
            adresseLivraison: adresseLivraison
        })
    }).then(response => response.json())
      .then(data => {
          alert('Order successfully placed!');
          // Reload or redirect to a confirmation page
      }).catch(error => {
          console.error('Error:', error);
          alert('Failed to place order');
      });
}
</script>
</body>
</html>
