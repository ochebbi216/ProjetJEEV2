<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest, java.io.IOException"%>

<%
boolean isAuthenticated = false;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("chefEmail".equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
            isAuthenticated = true;
            break;
        }
    }
}

if (!isAuthenticated) {
    response.sendRedirect("chefPages/LoginChef.jsp"); // Redirect to the login page if not authenticated
    return;
}

String chefIdValue = null;
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if ("chefId".equals(cookie.getName())) {
            chefIdValue = cookie.getValue();
            break;
        }
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chef - My Orders</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="admin/vendors/feather/feather.css">
    <link rel="stylesheet" href="admin/vendors/ti-icons/css/themify-icons.css">
    <link rel="stylesheet" href="admin/vendors/css/vendor.bundle.base.css">
    <link rel="stylesheet" href="admin/vendors/datatables.net-bs4/dataTables.bootstrap4.css">
    <link rel="stylesheet" href="admin/vendors/ti-icons/css/themify-icons.css">
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
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
            <h1 class="header">My Orders</h1>
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
                        <td><fmt:formatDate value="${commande.dateCommande}" pattern="yyyy-MM-dd HH:mm"/></td>
                        <td>${commande.adresseLivraison}</td>
                        <td>${commande.numTel}</td>
                        <td>${commande.prixTotal}DT</td>
                        <td>
                            <c:choose>
                                <c:when test="${commande.statut eq 'en cour'}">
                                    <button class="btn btn-outline-success" onclick="showAssignLivreurModal(${commande.commandeId})">Finish Order</button>
                                </c:when>
                                <c:otherwise>
                                    <span id="cart-count"
												class="badge bg-success text-white rounded-pill"> Completed</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            </div>
        </div>
        <jsp:include page="admin-footer.jsp"/>
    </div>
</div>

<!-- Assign Livreur Modal -->
<div class="modal fade" id="assignLivreurModal" tabindex="-1" aria-labelledby="assignLivreurModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="assignLivreurForm">
                <div class="modal-header">
                    <h5 class="modal-title" id="assignLivreurModalLabel">Assign Delivery Man</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="commandeId" id="commandeId">
                    <div class="form-group">
                        <label for="livreurId">Select Delivery Man:</label>
                        <select class="form-control" id="livreurId" name="livreurId">
                            <c:forEach var="livreur" items="${livreursDisponibles}">
                                <option value="${livreur.livreurId}">${livreur.nom}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Assign</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    function showAssignLivreurModal(commandeId) {
        $('#commandeId').val(commandeId);
        $('#assignLivreurModal').modal('show');
    }

    $(document).ready(function () {
        $('#assignLivreurForm').on('submit', function (e) {
            e.preventDefault();
            console.log("Form submitted");
            $.ajax({
                url: 'commande?action=assignLivreur',
                type: 'POST',
                data: $(this).serialize(),
                success: function (response) {
                    console.log("AJAX success", response);
                    let res = JSON.parse(response);
                    if (res.status === "success") {
                        $('#assignLivreurModal').modal('hide');
                        setTimeout(function () {
                            window.location.href = "http://localhost:8080/projetjsp1/commande?action=chefcommandes"; // Redirect to the desired page
                        }, 500); // Adjust the delay as needed
                    } else {
                        alert('Error: ' + res.message);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log("AJAX error", textStatus, errorThrown);
                    alert('Error assigning delivery man');
                }
            });
        });
    });
</script>

</body>
</html>
