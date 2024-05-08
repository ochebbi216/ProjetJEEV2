<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest" %>
<%
    boolean isAuthenticated = false;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("adminEmail".equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
                isAuthenticated = true;
                break;
            }
        }
    }

    if (!isAuthenticated) {
        response.sendRedirect("adminPages/AddAdmin.jsp");  // Redirect to the login page if not authenticated
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Pizzas</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title> Admin</title>
  <!-- plugins:css -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  
  <link rel="stylesheet" href="admin/vendors/feather/feather.css">
  <link rel="stylesheet" href="admin/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="admin/vendors/css/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- Plugin css for this page -->
  <link rel="stylesheet" href="admin/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
  <link rel="stylesheet" href="admin/vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" type="text/css" href="admin/js/select.dataTables.min.css">
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="admin/css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="admin/images/favicon.png" />
    <style>
        body {
            padding-top: 0px;
            background-color: #f8f9fa;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
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
     <jsp:include page="admin-header.jsp"/>
      <div class="main-panel">
        <div class="content-wrapper">
        <h1 class="header">List of  Delivery Person</h1>
        <a href="/projetjsp1/AddLivreur.jsp" class="btn btn-success"> <i class="fas fa-add"></i> Add New Livreur</a>
       
        <p>Show Only Available Delivery Person:</p>
        <!-- Form to filter Livreurs based on availability -->
		<form class="filter-form" action="livreur" method="get">
		    <div class="form-row align-items-center "> <!-- Use form-row and align-items-center to align items in the same row -->
		        <div class="col-3">
		            <label for="availableFilter" class="sr-only">Show Only Available Delivery Person:</label>
		            <select id="availableFilter" name="available" class="form-control">
		                <option value="all">All</option>
		                <option value="true">Available</option>
		                <option value="false">Not Available</option>
		            </select>
		        </div>
		        <div class="col-auto">
		            <button type="submit" class="btn btn-primary"> <i class="fas fa-filter"></i> Filter</button>
		        </div>
		    </div>
		</form>


        <table class="table table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>Nom</th>
                    <th>Email</th>
                    <th>Available</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="livreur" items="${Livreurs}">
                    <tr>
                        <td><c:out value="${livreur.nom}"/></td>
                        <td><c:out value="${livreur.email}"/></td>
                        <td>
		                   <c:choose>
		                        <c:when test="${livreur.isAvailable}">
		                            <i class="fas fa-check-circle" style="color:green;"></i>
		                        </c:when>
		                        <c:otherwise>
		                            <i class="fas fa-times-circle" style="color:red;"></i>
		                        </c:otherwise>
		                    </c:choose>                        
                    </td>
                        <td>
                            <a href="livreur?action=edit&id=${livreur.livreurId}" class="btn " style="color:blue;"><i class="fas fa-edit"></i> </a>
                            <button onclick="deleteLivreur(${livreur.livreurId});"class="btn " style="color:red;"><i class="fas fa-trash-alt"></i> </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

  </div>
   
         <jsp:include page="admin-footer.jsp"/>
      <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div> 

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function deleteLivreur(livreurId) {
            if (confirm('Are you sure you want to delete this livreur?')) {
                var form = document.createElement('form');
                document.body.appendChild(form);
                form.method = 'post';
                form.action = 'livreur';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                form.appendChild(actionInput);

                var idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = livreurId;
                form.appendChild(idInput);

                form.submit();
            }
        }
    </script>
</body>
</html>
