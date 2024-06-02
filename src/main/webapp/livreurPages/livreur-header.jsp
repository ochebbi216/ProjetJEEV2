<%@ page import="jakarta.servlet.http.Cookie"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%   
String userName = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("livreurName".equals(cookie.getName())) {
            userName = cookie.getValue();
            break;
        }
    }
}
%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
      <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
<!--       <img src="path_to_your_logo.png" alt="Pizza Shop Logo" width="100" height="100">
 -->      
      <a class="navbar-brand brand-logo mr-5" href="dashboard"><img src="admin/images/logopizza.png" style="width:130%;" class="mr-2" alt="logo"/></a>
        <a class="navbar-brand brand-logo-mini" href="dashboard"><img src="admin/images/logopizza.png" alt="logo"/></a> 
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
        <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
          <span class="icon-menu"></span>
        </button>
        <ul class="navbar-nav mr-lg-2">
          <li class="nav-item nav-search d-none d-lg-block">
            <div class="input-group">
              <div class="input-group-prepend hover-cursor" id="navbar-search-icon">
          </li>
        </ul>
        <ul class="navbar-nav navbar-nav-right">
          <li class="nav-item dropdown">
              <span class="count"><%= userName %></span>
            </a>

          <li class="nav-item nav-profile dropdown">
            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">
              <img src="adminlogin/images/Capture.PNG" alt="profile"/>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">
           
              <a class="dropdown-item" href="livreur?action=logout">
                <i class="ti-power-off text-primary"></i>
                Logout
              </a>
            </div>
          </li>
 
        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
          <span class="icon-menu"></span>
        </button>
      </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:partials/_settings-panel.html -->
  
  
       
      <!-- partial -->
      <!-- partial:partials/_sidebar.html -->
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
        <!-- Dashboard Link -->
        <li class="nav-item">
            <a class="nav-link" href="dashboardLivreur">
                <i class="fas fa-tachometer-alt menu-icon"></i>
                <span class="menu-title">Dashboard</span>
            </a>
        </li>
        
        <!-- All Pizzas Link -->
        <li class="nav-item">
            <a class="nav-link" href="pizza?action=livreurPizza">
                <i class="fas fa-pizza-slice menu-icon"></i>
                <span class="menu-title">All Pizzas</span>
            </a>
        </li>
        
        <!-- My Commandes Link -->
        <li class="nav-item">
            <a class="nav-link" href="commande?action=livreurcommandes">
                <i class="fas fa-receipt menu-icon"></i>
                <span class="menu-title">My Commandes</span>
            </a>
        </li>
    </ul>
</nav>
