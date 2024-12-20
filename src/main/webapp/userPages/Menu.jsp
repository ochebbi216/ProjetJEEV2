<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<html lang="en">
<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>Our Menu</title>
<meta content="" name="description">
<meta content="" name="keywords">
<!-- Favicons -->
<link href="assets/img/favicon.png" rel="icon">
<link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Amatic+SC:ital,wght@0,300;0,400;0,500;0,600;0,700&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">
<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="assets/vendor/aos/aos.css" rel="stylesheet">
<link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
<link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
<!-- Template Main CSS File -->
<link href="assets/css/main.css" rel="stylesheet">
<style>
@keyframes gradient {
	0% {
		background-position: 0% 50%;
	}
	50% {
		background-position: 100% 50%;
	}
	100% {
		background-position: 0% 50%;
	}
}

.discount-label {
    position: absolute;
    top: 10px;
    right: 10px;
    background: linear-gradient(-45deg, blue, red);
    background-size: 200% 200%;
    color: white;
    padding: 5px;
    border-radius: 5px;
    font-weight: bold;
    z-index: 10;
    animation: gradient 5s ease infinite;
}
.menu-item {	
    position: relative;
}
</style>



</head>
<body>
    <jsp:include page="client-header.jsp" />
    <br>
    <!-- Menu Section with Dynamic Content -->
    <section id="menu" class="menu">
        <div class="container" data-aos="fade-up">
            <div class="section-header">
                <h2>Our Menu</h2>
                <p>Check Our <span>Yummy Menu</span></p>
            </div>
            <ul class="nav nav-tabs d-flex justify-content-center" data-aos="fade-up" data-aos-delay="200">
                <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#classic">Classic Pizzas</a></li>
                <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#meat-lovers">Meat Lovers' Pizzas</a></li>
                <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#vegetarian">Vegetarian Pizzas</a></li>
                <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#gourmet">Gourmet Pizzas</a></li>
            </ul>
            <br> <br>
            <div class="tab-content">
                <!-- Displaying Classic Pizzas -->
                <div class="tab-pane active" id="classic">
                    <div class="row">
                        <c:forEach var="pizza" items="${classicPizzas}">
                            <div class="col-lg-4" style="margin-top: 25px;">
                                <div class="menu-item">
                                    <a href="pizza?action=detail&id=${pizza.id}">
                                        <img height=250 width=350 src="${pizza.image}" alt="${pizza.nom}">
                                        <c:if test="${pizza.discountPercentage > 0}">
                                            <div class="discount-label">${pizza.discountPercentage}% OFF</div>
                                        </c:if>
                                        <h4 style="margin-top: 15px;">${pizza.nom}</h4>
                                        <p style="color: gray;">${fn:substring(pizza.description, 0, 15)}${fn:length(pizza.description) > 15 ? '...' : ''}</p>
                                        <p class="text-danger">
                                            <b>
                                                <c:choose>
                                                    <c:when test="${pizza.discountPercentage > 0}"> Only 
                                                        <c:set var="discountedPrice" value="${pizza.prixBase - (pizza.prixBase * pizza.discountPercentage / 100)}" />
                                                        <c:out value="${String.format('%.2f', discountedPrice)}" /> DT (From <c:out value="${pizza.prixBase}" /> DT)
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:out value="${pizza.prixBase}" /> DT
                                                    </c:otherwise>
                                                </c:choose>
                                            </b>
                                        </p>
                                        <a class="btn btn-outline-danger" type="button" href="panier?action=add&pizzaId=${pizza.id}">
                                            <img src="assets/wired-outline-146-trolley.gif" width=30 height=30 /> Add to cart
                                        </a>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- Repeat for other categories -->
                <div class="tab-pane" id="meat-lovers">
                    <div class="row">
                        <c:forEach var="p2" items="${meatLoversPizzas}">
                            <div class="col-lg-4">
                                <div class="menu-item">
                                    <a href="pizza?action=detail&id=${p2.id}">
                                        <img src="${p2.image}" alt="${p2.nom}" class="menu-img img-fluid">
                                        <c:if test="${p2.discountPercentage > 0}">
                                            <div class="discount-label">${p2.discountPercentage}% OFF</div>
                                        </c:if>
                                        <h4>${p2.nom}</h4>
                                        <p style="color: gray;">${fn:substring(p2.description, 0, 15)}${fn:length(pizza.description) > 15 ? '...' : ''}</p>
                                        <p class="text-danger">
                                            <b>
                                                <c:choose>
                                                    <c:when test="${p2.discountPercentage > 0}"> Only 
                                                        <c:set var="discountedPrice" value="${p2.prixBase - (p2.prixBase * p2.discountPercentage / 100)}" />
                                                        <c:out value="${String.format('%.2f', discountedPrice)}" /> DT (From <c:out value="${p2.prixBase}" /> DT)
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:out value="${p2.prixBase}" /> DT
                                                    </c:otherwise>
                                                </c:choose>
                                            </b>
                                        </p>
											<a class="btn btn-outline-danger" type="button" href="panier?action=add&pizzaId=${p2.id}">
                                            <img src="assets/wired-outline-146-trolley.gif" width=30 height=30 /> Add to cart
                                        </a>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="tab-pane" id="vegetarian">
                    <div class="row">
                        <c:forEach var="p3" items="${vegetarianPizzas}">
                            <div class="col-lg-4">
                                <div class="menu-item">
                                    <a href="pizza?action=detail&id=${p3.id}">
                                        <img src="${p3.image}" alt="${p3.nom}" class="menu-img img-fluid">
                                        <c:if test="${p3.discountPercentage > 0}">
                                            <div class="discount-label">${p3.discountPercentage}% OFF</div>
                                        </c:if>
                                        <h4>${p3.nom}</h4>
                                        <p style="color: gray;">${fn:substring(p3.description, 0, 15)}${fn:length(pizza.description) > 15 ? '...' : ''}</p>
                                          <p class="text-danger">
                                            <b>
                                                <c:choose>
                                                    <c:when test="${p3.discountPercentage > 0}"> Only 
                                                        <c:set var="discountedPrice" value="${p3.prixBase - (p3.prixBase * p3.discountPercentage / 100)}" />
                                                        <c:out value="${String.format('%.2f', discountedPrice)}" /> DT (From <c:out value="${p3.prixBase}" /> DT)
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:out value="${p3.prixBase}" /> DT
                                                    </c:otherwise>
                                                </c:choose>
                                            </b>
                                        </p>
                                        <a class="btn btn-outline-danger" type="button" href="panier?action=add&pizzaId=${p3.id}">
                                            <img src="assets/wired-outline-146-trolley.gif" width=30 height=30 /> Add to cart
                                        </a>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="tab-pane" id="gourmet">
                    <div class="row">
                        <c:forEach var="p4" items="${gourmetPizzas}">
                            <div class="col-lg-4">
                                <div class="menu-item">
                                    <a href="pizza?action=detail&id=${p4.id}">
                                        <img src="${p4.image}" alt="${p4.nom}" class="menu-img img-fluid">
                                        <c:if test="${p4.discountPercentage > 0}">
                                            <div class="discount-label">${p4.discountPercentage}% OFF</div>
                                        </c:if>
                                        <h4>${p4.nom}</h4>
                                        <p style="color: gray;">${fn:substring(p4.description, 0, 15)}${fn:length(pizza.description) > 15 ? '...' : ''}</p>
                                        <p class="text-danger">
                                            <b>
                                                <c:choose>
                                                    <c:when test="${p4.discountPercentage > 0}"> Only 
                                                        <c:set var="discountedPrice" value="${p4.prixBase - (p4.prixBase * p4.discountPercentage / 100)}" />
                                                        <c:out value="${String.format('%.2f', discountedPrice)}" /> DT (From <c:out value="${p4.prixBase}" /> DT)
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:out value="${p4.prixBase}" /> DT
                                                    </c:otherwise>
                                                </c:choose>
                                            </b>
                                        </p>
                                        <a class="btn btn-outline-danger" type="button" href="panier?action=add&pizzaId=${p4.id}">
                                            <img src="assets/wired-outline-146-trolley.gif" width=30 height=30 /> Add to cart
                                        </a>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="footer-client.jsp" />
    <!-- Vendor JS Files -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/aos/aos.js"></script>
    <script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
    <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
    <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>
    <!-- Template Main JS File -->
    <script src="assets/js/main.js"></script>
</body>
</html>
