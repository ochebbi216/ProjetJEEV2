<%-- 

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>chefs</title>
    <!-- Add link to CSS files and any additional head elements -->
</head>
<body>

<h2>Add Chef</h2>

<!-- Action should point to the URL mapped to your PizzaController's doPost method -->
<form action="chef1?action=add" method="post">
   
    <div>
        <label for="nom">nom:</label>
        <input type="nom" id="nom" name="nom" required>
    </div>
    <div>
        <label for="email">email:</label>
        <input type="email" id="email" name="email" required>
    </div>
    <div>
        <label for="motDePasse">Password:</label>
        <input type="motDePasse" id="motDePasse" name="motDePasse" required>
    </div>
    
    <div>
    <div>
        <button type="submit" name="add">Add Chef</button>
    </div>
</form>

</body>
</html>
 --%>
<!doctype html>
<html lang="en">
<head>
    <title>Inscription</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="img js-fullheight" style="background-image: url(images/chef2.jpg);">
<section class="ftco-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center mb-5">
                <h2 class="heading-section">Inscription</h2>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-4">
                <div class="login-wrap p-0">
                    <h3 class="mb-4 text-center">Create your account</h3>
                    <form action="ChefController1?action=add" method="post" class="signin-form">
                 
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Nom" name="nom" required>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Email" name="email" required>
                        </div>
                        <div class="form-group">
                            <input id="password-field" type="password" class="form-control" placeholder="Password" name="motDePasse" required>
                            <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="form-control btn btn-primary submit px-3">Sign Up</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<script src="js/jquery.min.js"></script>
<script src="js/popper.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>

