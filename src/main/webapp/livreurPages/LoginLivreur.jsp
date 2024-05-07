<%-- <%@ page import="jakarta.servlet.http.Cookie, jakarta.servlet.http.HttpServletRequest, jakarta.servlet.http.HttpServletResponse" %>
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

    // Redirect to the dashboard if already authenticated
    if (isAuthenticated) {
        response.sendRedirect("../userPages/Home.jsp"); // Update this with the path to your dashboard page
        return; // Stop further execution of JSP to ensure redirection happens immediately
    }

%> --%>
<!doctype html>
<html lang="en">
<head>
    <title>Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body class="img js-fullheight" style="background-image: url(../images/bg3.jpg);">
<section class="ftco-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center mb-5">
                <h2 class="heading-section">Welcome Back </h2>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="login-wrap p-0">
                    <h3 class="mb-4 text-center">Sign In</h3>
                    <form action="../livreur?action=login" method="post" class="signin-form">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Email" name="email" required>
                        </div>
                        <div class="form-group">
                            <input id="password-field" type="password" class="form-control" placeholder="Password" name="motDePasse" required>
                            <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                        </div>
                        <div class="form-group">
                            <button type="submit"  name="login" class="form-control btn btn-primary submit px-3">Sign In</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<script src="../js/jquery.min.js"></script>
<script src="../js/popper.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/main.js"></script>
</body>
</html>
