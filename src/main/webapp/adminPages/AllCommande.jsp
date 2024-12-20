<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
  <title> Admin-Orders</title>
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

        <h1 class="header">List of orders</h1>
        <div class="table-responsive">
        
       <table class="table table-striped" >
          <thead class="thead-dark">
            <tr>
              <th scope="col">Pizzas</th>
              <th scope="col">Status</th>
              <th scope="col">Commande Date</th>
              <th scope="col">Delivery Address</th>
              <th scope="col">Phone Number</th>
              <th scope="col">Total Price</th>
              <th scope="col">Livreur Name</th>
              <th scope="col">Chef Name</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="commande" items="${commandes}">
              <tr>
                <td>
                  <ul>
                    <c:forEach var="pizzaId" items="${fn:split(commande.pizzas, ',')}">
                      <li> ${pizzaId}</li>
                    </c:forEach>
                    <c:if test="${empty commande.pizzas}">
                      <li>No pizzas listed</li>
                    </c:if>
                  </ul>
                </td>
                <td>${commande.statut}</td>
                <td><fmt:formatDate value="${commande.dateCommande}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td>${commande.adresseLivraison}</td>
                <td>${commande.numTel}</td>
                <td>${commande.prixTotal} DT</td>
                <td><c:out value="${livreurNames[commande.livreurid]}"/></td>
                <td><c:out value="${chefNames[commande.chefid]}"/></td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
        </div>


<!--         <a href="/projetjsp1/AddPizza.jsp" class="btn btn-success">Add New Pizza</a>
 -->
    </div>
   
         <jsp:include page="admin-footer.jsp"/>
      <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div> 

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- <script type="text/javascript">
        function deletePizza(pizzaId) {
            if (confirm('Are you sure you want to delete this order?')) {
                var form = document.createElement('form');
                document.body.appendChild(form);
                form.method = 'post';
                form.action = 'commande';

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
    </script> -->
</body>
</html>
