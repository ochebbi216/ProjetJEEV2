<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
    <title>Delivery - All Orders</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="admin/vendors/feather/feather.css">
    <link rel="stylesheet" href="admin/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="admin/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="admin/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
    <link rel="stylesheet" type="text/css" href="admin/js/select.dataTables.min.css">
    <link rel="stylesheet" href="admin/css/vertical-layout-light/style.css">
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
        .header {
            margin-bottom: 30px;
        }
    </style>
</head>

<body>
    <div class="container-scroller">
        <jsp:include page="livreur-header.jsp" />
        <div class="main-panel">
            <div class="content-wrapper">
                <h1 class="header">List of Available Orders</h1>
                        <div class="table-responsive">
                
                <table class="table table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Commande ID</th>
                            <th scope="col">Status</th>
                            <th scope="col">Date Commande</th>
                            <th scope="col">Delivery Address</th>
                            <th scope="col">Phone Number</th>
                            <th scope="col">Total Price</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="commande" items="${commandes}">
                            <tr>
                                <td>${commande.commandeId}</td>
                                <td>${commande.statut}</td>
                                <td><fmt:formatDate value="${commande.dateCommande}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>${commande.adresseLivraison}</td>
                                <td>${commande.numTel}</td>
                                <td>${commande.prixTotal}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${commande.statut eq 'prête'}">
                                            <form action="commande" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="startDelivery" />
                                                <input type="hidden" name="commandeId" value="${commande.commandeId}" />
                                                <button type="submit" class="btn btn-success">Start Delivery</button>
                                            </form>
                                        </c:when>
                                        <c:when test="${commande.statut eq 'en cours de livraison'}">
                                            <form action="commande" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="finishDelivery" />
                                                <input type="hidden" name="commandeId" value="${commande.commandeId}" />
                                                <button type="submit" class="btn btn-primary">Delivery Finished</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <span id="cart-count"
												class="badge bg-secondary text-white rounded-pill"> No actions available</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
            </div>
            <jsp:include page="livreur-footer.jsp" />
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
