<%-- <%@ page import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest, jakarta.servlet.http.HttpServletResponse" %>

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



    // Redirect to the dashboard if already authenticated

    if (isAuthenticated) {

        response.sendRedirect("../chefPages/Home.jsp"); // Update this with the path to your dashboard page

        return; // Stop further execution of JSP to ensure redirection happens immediately

    }



%> --%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>All Pizzas</title>

  <meta charset="utf-8">

  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <title> Chef</title>

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

            padding-top: 20px;

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



        <h1 class="header">List of Available Pizzas</h1>



        

        <table class="table table-striped">

            <thead class="thead-dark">

                <tr>

                    <th>Name</th>

                    <th>Categorie</th>

                    <th>Taille</th>

                    <th>Description</th>

                    <th>Base Price</th>

                    <th>Image</th>

                   

                </tr>

            </thead>

            <tbody>

                <c:forEach var="pizza" items="${pizzas}">

                    <tr>

                        <td><c:out value="${pizza.nom}"/></td>

                        <td><c:out value="${pizza.categorie}"/></td>

                        <td><c:out value="${pizza.taille}"/></td>

                        <td><c:out value="${pizza.description}"/></td>

                        <td><c:out value="${pizza.prixBase}"/> DT</td>

                        <td><img src="${pizza.image}" alt="Pizza Image"/></td>



                    </tr>

                </c:forEach>

            </tbody>

        </table>

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

    <script type="text/javascript">

       

    </script>

</body>

</html>

