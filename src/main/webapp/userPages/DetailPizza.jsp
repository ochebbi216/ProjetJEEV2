<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>More about ${pizza.nom} pizza</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="detail-pizza/css/styles.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<style>
.card .card-body .text-center h5,
.card .card-body .text-center span {
    color: black;
    text-decoration: none;
}

</style>
</head>
<body>
<a class="btn btn-outline-dark flex-shrink-0" style="margin:10pt;" type="button"
href="pizza?action=menu"> 
<i class="fa-solid fa-arrow-left"></i> Back to Menu</a>
	<!-- Product section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="row gx-4 gx-lg-5 align-items-center">
				<div class="col-md-6">
					<img class="card-img-top mb-5 mb-md-0" src="${pizza.image}"
						alt="..." />
				</div>
				<div class="col-md-6">

					<h1 class="display-5 fw-bolder">${pizza.nom}</h1>
					<div class="small mb-1"> <b> Category: </b> ${pizza.categorie}</div>
					<div class="small mb-2"><b> Size: </b>  ${pizza.taille}</div>
					<div class="fs-5 mb-5">
						<!--                             <span class="text-decoration-line-through">$45.00</span>
 -->
						<span>Price: ${pizza.prixBase} DT</span>
					</div>
					<p class="lead">${pizza.description}</p>
					<div class="d-flex">
						<input class="form-control text-center me-3" id="inputQuantity"
							type="num" value="1" style="max-width: 3rem" /> 
							<a
							class="btn btn-outline-dark flex-shrink-0" type="button"
							href="panier?action=add&pizzaId=${pizza.id}"> 
							<i class="bi-cart-fill me-1"></i> Add to cart
						</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Related items section-->
<!-- Related items section-->
<section class="py-5 bg-light">
    <div class="container px-4 px-lg-5 mt-5">
        <h2 class="fw-bolder mb-4">Related Pizzas</h2>
        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
            <c:choose>
                <c:when test="${not empty relatedPizzas}">
                    <c:forEach var="relatedPizza" items="${relatedPizzas}">
                    
                        <div class="col mb-5">
                            <a href="pizza?action=detail&id=${relatedPizza.id}"> 
                        
                            <div class="card h-100">
                            
                                <!-- Product image-->
                                <img class="card-img-top" height="250" src="${relatedPizza.image}" alt="${relatedPizza.nom}" />
								<!-- Product details-->
								<div class="card-body p-4">
								    <div class="text-center">
								        <h5 style="color: black !important; text-decoration: none !important;">${relatedPizza.nom}</h5>
								        <!-- Product price-->
								        <span style="color: black !important; text-decoration: none !important;">${relatedPizza.prixBase} DT</span>
								    </div>
								</div>


                                <!-- Product actions-->
                                <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                    <div class="text-center">
                                        <a class="btn btn-outline-dark mt-auto" href="panier?action=add&pizzaId=${relatedPizza.id}">
                                            Add to cart
                                        </a>
                                    </div>
                                </div>
                            </div>
                            </a>
                           
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center text-danger">
                        <p>There are no related items for this pizza.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>


	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Pizza Shop
				2024</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="detail-pizza/js/scripts.js"></script>
</body>
</html>
