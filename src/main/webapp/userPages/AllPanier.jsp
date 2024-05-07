<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest" %>
<%
    boolean isAuthenticated = false;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("userEmail".equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
                isAuthenticated = true;
                break;
            }
        }
    }

    if (!isAuthenticated) {
        response.sendRedirect("userPages/LoginUser.jsp");  // Redirect to the login page if not authenticated
        return;
    }
%>
<!DOCTYPE html>

<html>

<head>

    <title>My Cart</title>

    <link href="assets/img/favicon.png" rel="icon">

    <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">

    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <link href="assets/css/main.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>

        #deliveryForm {

            display: block; /* Changed from none to block */

            background-color: #f8f9fa;

            padding: 20px;

            border-radius: 8px;

            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);

        }

        #deliveryForm label {

            font-weight: bold;

        }

        #deliveryForm input {

            margin-bottom: 10px;

        }

    </style>

</head>

<body>

<jsp:include page="client-header.jsp"/>

<main class="container mt-4">

    <h1 class="text-center">My Cart</h1>

    <div class="row">

        <div class="col-8">

            <table class="table table-bordered text-center">

                <thead>

                    <tr>

                        <th scope="col">Pizza ID</th>

                        <th scope="col">User ID</th>

                        <th scope="col">Quantity</th>

                        <th scope="col">Price</th>

                        <th scope="col">Actions</th>

                    </tr>

                </thead>

                <tbody>

                    <c:forEach var="panier" items="${paniers}">

                        <tr>

                            <td><c:out value="${panier.pizzaid}"/></td>

                            <td><c:out value="${panier.userid}"/></td>

                            <td><c:out value="${panier.quantite}"/></td>

                            <td><c:out value="${panier.prixTotal}"/></td>

                            <td>

                                <button class="btn btn-outline-danger" onclick="deletePanier(${panier.panierId});"><i class="fa-solid fa-trash"></i></button>

                            </td>

                        </tr>

                    </c:forEach>

                </tbody>

            </table>

            <button type="button" class="btn btn-outline-primary" onclick="submitOrder();">Order All Now!</button>

        </div>

        <div id="deliveryForm" class="col-4">

            <h2>Delivery Information:</h2>

            <form method="POST">

                <div class="mb-3">

                    <label for="numTel" class="form-label">Phone Number</label>

                    <input type="text" class="form-control" id="numTel" name="numTel" placeholder="Enter your phone number" required>

                </div>

                <div class="mb-3">

                    <label for="adresseLivraison" class="form-label">Delivery Address</label>

                    <input type="text" class="form-control" id="adresseLivraison" name="adresseLivraison" placeholder="Enter your delivery address" required>

                </div>

            </form>

        </div>

    </div>

    <a class="btn btn-outline-danger" href="pizza?action=menu"><i class="fa-solid fa-pizza-slice"></i> Still Hungry?</a>

</main>

<jsp:include page="footer-client.jsp"/>

<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<script>

function deletePanier(panierId) {

    if (confirm('Are you sure you want to delete this panier?')) {

        var form = document.createElement('form');

        document.body.appendChild(form);

        form.method = 'post';

        form.action = 'panier';



        var actionInput = document.createElement('input');

        actionInput.type = 'hidden';

        actionInput.name = 'action';

        actionInput.value = 'delete';

        form.appendChild(actionInput);



        var idInput = document.createElement('input');

        idInput.type = 'hidden';

        idInput.name = 'id';

        idInput.value = panierId;

        form.appendChild(idInput);



        form.submit();

    }

}


function submitOrder() {

    var cartItems = document.querySelectorAll('tr');

    var cartData = Array.from(cartItems).map(item => {

        return {

            panierId: item.dataset.panierId,

            prixTotal: item.dataset.prixTotal

        };

    });

    var numTel = document.getElementById('numTel').value;

    var adresseLivraison = document.getElementById('adresseLivraison').value;

    fetch('commande?action=add', {

        method: 'POST',

        headers: {

            'Content-Type': 'application/json',

        },

        body: JSON.stringify({

            cartItems: cartData,

            numTel: numTel,

            adresseLivraison: adresseLivraison

        })

    }).then(response => response.json())

      .then(data => {

          alert('Order successfully placed!');

          // Reload or redirect to a confirmation page

      }).catch(error => {

          console.error('Error:', error);

          alert('Failed to place order');

      });

}

</script>

</body>

</html>


