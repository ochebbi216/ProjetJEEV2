<%@ page import="java.util.List"%>
<%@ page import="model.Panier"%>
<%@ page import="model.Commande"%>
<%@ page import="dao.PanierDao"%>
<%@ page import="dao.CommandeDao"%>
<%@ page import="util.Hibernate"%>

<%
PanierDao panierDao = new PanierDao();
CommandeDao commandeDao = new CommandeDao();

int totalCarts = 0;
int totalOrders = 0;

try {
	totalCarts = panierDao.findAll().size(); // Assuming findAll fetches all carts relevant to logged in user
	totalOrders = commandeDao.findAll().size(); // Assuming findAll fetches all orders relevant to logged in user
} catch (Exception e) {
	e.printStackTrace();
}
%>

<%@ page import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest, java.io.IOException" %>
<%
    String userName = null;  // Initialize the userName variable
    Cookie[] cookies = request.getCookies();  // Get the array of cookies from the request
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("userName".equals(cookie.getName())) {
                userName = cookie.getValue();  // Retrieve userName from cookie
                break;
            }
        }
    }

%>

<head>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
	rel="stylesheet">

</head>

<header id="header" class="header fixed-top d-flex align-items-center">
	<div
		class="container d-flex align-items-center justify-content-between">
		<a href="index.html"
			class="logo d-flex align-items-center me-auto me-lg-0">
			<h1>
				Pizza Shop<span>.</span>
			</h1>
		</a>
		<nav id="navbar" class="navbar">
			<ul>
				<li><a href="userPages/Home.jsp">Home</a></li>
				<li><a href="/projetjsp1/pizza?action=menu">Menu</a></li>
				<li><a href="#events">Delivery</a></li>
				<li><a href="#chefs">Chefs</a></li>
				<li><a href="/projetjsp1/panier"> 
<!-- 				<i class="fa-solid fa-cart-shopping"></i> 
 -->				Cart <span id="cart-count"
						class="badge bg-info rounded-pill"> <%=totalCarts%></span>
				</a></li>
				<li><a href="/projetjsp1/commande"> 
<!-- 				<i class="fa-solid fa-box"></i> 
 -->				Orders <span id="order-count"
						class="badge bg-success rounded-pill"><%=totalOrders%></span>
				</a></li>

			</ul>
		</nav>
		<span>Dear <i><%= userName %></i> </span>
		<a class="btn-book-a-table" href="../User?action=logout">Logout</a> 
		<i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i> 
		<i class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>
	</div>
</header>
