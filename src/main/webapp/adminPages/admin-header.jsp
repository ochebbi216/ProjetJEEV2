<%@ page import="jakarta.servlet.http.Cookie"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%   
String userName = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("adminName".equals(cookie.getName())) {
            userName = cookie.getValue();
            break;
        }
    }
}
%>
    <!-- partial:partials/_navbar.html -->
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
           
              <a class="dropdown-item" href="admin?action=logout">
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
          <li class="nav-item">
            <a class="nav-link" href="dashboard">
              <i class="icon-grid menu-icon"></i>
              <span class="menu-title">Dashboard</span>
              
            </a>
          </li>
			<li class="nav-item">
			    <a class="nav-link" href="User">
			        <i class="icon-layout menu-icon"></i>
			        <span class="menu-title">All Clients</span>
			    </a>
			</li>
			
				<li class="nav-item">
			    <a class="nav-link" href="chef">
			        <i class="icon-layout menu-icon"></i>
			        <span class="menu-title">All Chefs</span>
			    </a>
			</li>
				<li class="nav-item">
			    <a class="nav-link" href="pizza">
			        <i class="icon-layout menu-icon"></i>
			        <span class="menu-title">All Pizzas</span>
			    </a>
			</li>
         		<li class="nav-item">
			    <a class="nav-link" href="livreur">
			        <i class="icon-layout menu-icon"></i>
			        <span class="menu-title">All Delivery Persons</span>
			    </a>
			</li>
         
        </ul>
      </nav>