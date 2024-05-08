<%@ page import="java.util.List"%>
<%@ page import="model.Commande"%>
<%@ page import="dao.CommandeDao"%>
<%@ page import="util.Hibernate"%>
  
<% 
int totalOrders = 0;
CommandeDao commandeDao = new CommandeDao();
totalOrders = commandeDao.findUnassignedCommandes().size(); 
%>
<%@ page import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest, java.io.IOException" %>
<%
    String userName = null;  // Initialize the userName variable
    Cookie[] cookies = request.getCookies();  // Get the array of cookies from the request
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("chefName".equals(cookie.getName())) {
                userName = cookie.getValue();  // Retrieve userName from cookie
                break;
            }
        }
    }

%>

<%
int chefIdValue = 0;
Cookie[] cookies2 = request.getCookies();
if (cookies2 != null) {
	for (Cookie cookie : cookies2) {
		if ("chefId".equals(cookie.getName())) {
	chefIdValue = Integer.parseInt(cookie.getValue());
	break;
		}
	}
}
%>
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

              <span class="count"></span>

            </a>



          <li class="nav-item nav-profile dropdown">

            <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" id="profileDropdown">

              <img src="adminlogin/images/Capture.PNG" alt="profile"/>

            </a>

            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="profileDropdown">

           

              <a class="dropdown-item" href="chef1?action=logout">

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

			    <a class="nav-link" href="commande?action=chefcommandes">

			        <i class="icon-layout menu-icon"></i>

			        <span class="menu-title">Waiting Orders</span>
			        <span id="cart-count"
						class="badge bg-info text-white rounded-pill"> <%=totalOrders%></span>
			        

			    </a>

			</li>
			
			<li class="nav-item">

			    <a class="nav-link" href="commande?action=myOrders&chefId=<%=chefIdValue%>">

			        <i class="icon-layout menu-icon"></i>

			        <span class="menu-title">My Orders</span>
<%-- 			        <span id="cart-count"
						class="badge bg-info text-white rounded-pill"> <%=totalOrders%></span> --%>
			        

			    </a>

			</li>
			

				<li class="nav-item">

			    <a class="nav-link" href="pizza?action=pizzachef">

			        <i class="icon-layout menu-icon"></i>

			        <span class="menu-title">All Pizzas</span>

			    </a>

			</li>

         

        </ul>

      </nav>

