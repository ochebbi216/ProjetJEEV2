<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest" %>
<%
    boolean isAuthenticated = false;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("livreurEmail".equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
                isAuthenticated = true;
                break;
            }
        }
    }

    if (!isAuthenticated) {
        response.sendRedirect("livreurPages/LoginLivreur.jsp");  // Redirect to the login page if not authenticated
        return;
    }
%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivery - All Pizzas</title>
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

     <jsp:include page="livreur-header.jsp"/>
      <div class="main-panel">
        <div class="content-wrapper">

        <h1 class="header">List of Available Pizzas</h1>
<!--             <a href="/projetjsp1/AddPizza.jsp" class="btn btn-success"> <i class="fas fa-add"></i> Add New Pizza</a>
 -->        
        <table class="table table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>Name</th>
                    <th>Categorie</th>
                    <th>Taille</th>
                    <th>Description</th>
                    <th>Base Price</th>
                    <th>Image</th>
<!--                     <th>Actions</th>
 -->                </tr>
            </thead>
            <tbody>
                <c:forEach var="pizza" items="${pizzas}">
                    <tr>
                        <td><c:out value="${pizza.nom}"/></td>
                        <td><c:out value="${pizza.categorie}"/></td>
                        <td><c:out value="${pizza.taille}"/></td>
                        <td><c:out value="${fn:substring(pizza.description, 0, 15)}${fn:length(pizza.description) > 15 ? '...' : ''}"/></td>
                        <td><c:out value="${pizza.prixBase}"/> DT</td>
                        <td><img src="${pizza.image}" alt="Pizza Image"/></td>
<%--                         <td>
		            <a href="pizza?action=edit&id=${pizza.id}" class="btn " style="color:blue;"><i class="fas fa-edit"></i> </a>
		            <button onclick="deletePizza(${pizza.id});" class="btn " style="color:red;"><i class="fas fa-trash-alt"></i> </button>
                             <a href="panier?action=add&pizzaId=${pizza.id}" class="btn btn-warning">Add to Cart</a>
                        </td> --%>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
<!--         <a href="/projetjsp1/AddPizza.jsp" class="btn btn-success">Add New Pizza</a>
 -->
    </div>
   
		<jsp:include page="livreur-footer.jsp"/>
      <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div> 

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function deletePizza(pizzaId) {
            if (confirm('Are you sure you want to delete this pizza?')) {
                var form = document.createElement('form');
                document.body.appendChild(form);
                form.method = 'post';
                form.action = 'pizza';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                form.appendChild(actionInput);

                var idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = pizzaId;
                form.appendChild(idInput);

                form.submit();
            }
        }
    </script>
</body>
</html>
