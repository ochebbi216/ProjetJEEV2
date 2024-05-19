<%@ page import="java.util.List"%>
<%@ page import="model.Panier"%>
<%@ page import="model.Commande"%>
<%@ page import="dao.PanierDao"%>
<%@ page import="dao.CommandeDao"%>
<%@ page import="jakarta.servlet.http.Cookie"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>

<%
PanierDao panierDao = new PanierDao();
CommandeDao commandeDao = new CommandeDao();

int totalCarts = 0;
int totalOrders = 0;
int userId = -1;

// Retrieve userId from cookies
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("userId".equals(cookie.getName())) {
            userId = Integer.parseInt(cookie.getValue());
            break;
        }
    }
}

if (userId != -1) {
    try {
        totalCarts = panierDao.findAllByUserId(userId).size();
        totalOrders = commandeDao.findAllByUserId(userId).size();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

// Retrieve userName from cookies
String userName = null;
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("userName".equals(cookie.getName())) {
            userName = cookie.getValue();
            break;
        }
    }
}
%>

<head>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>

<header id="header" class="header fixed-top d-flex align-items-center">
    <div class="container d-flex align-items-center justify-content-between">
        <a href="index.html" class="logo d-flex align-items-center me-auto me-lg-0">
            <h1>Pizza Shop<span>.</span></h1>
        </a>
        <nav id="navbar" class="navbar">
            <ul>
                <li><a href="userPages/Home.jsp">Home</a></li>
                <li><a href="/projetjsp1/pizza?action=menu">Menu</a></li>
                <li><a href="#events">Delivery</a></li>
                <li><a href="#chefs">Chefs</a></li>
                <li><a href="/projetjsp1/panier">
                    Cart &nbsp;<span id="cart-count" class="badge bg-info rounded-pill"> <%= totalCarts %></span>
                </a></li>
                <li><a href="/projetjsp1/commande">
                    Orders &nbsp;<span id="order-count" class="badge bg-success rounded-pill"><%= totalOrders %></span>
                </a></li>
            </ul>
        </nav>
        <span>Dear <i><%= userName %></i></span>
        <a class="btn-book-a-table" href="http://localhost:8080/projetjsp1/User?action=logout">Logout</a>
        <i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i>
        <i class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>
    </div>
</header>
