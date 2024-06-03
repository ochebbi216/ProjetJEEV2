<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Livreur</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            margin-top: 30px;
            width: auto;
        }
        h2 {
            color: #007bff;
            margin-bottom: 30px;
        }
        label {
            font-weight: bold;
            color: #333;
        }
        .form-control {
            border-radius: 5px;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 10px 20px;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            border: none;
            padding: 10px 20px;
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .button-container {
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Edit Livreur</h2>
    <form action="LivreurController?action=edit" method="post" class="needs-validation" novalidate>
        <!-- Include hidden field to pass the ID of the livreur being edited -->
        <input type="hidden" name="livreurId" value="${Livreur.livreurId}" />
        
        <div class="form-group">
            <label for="nom">Name:</label>
            <input type="text" class="form-control" id="nom" name="nom" value="${Livreur.nom}" required>
            <div class="invalid-feedback">Please enter the name.</div>
        </div>
        
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" value="${Livreur.email}" required>
            <div class="invalid-feedback">Please enter a valid email.</div>
        </div>
        
        <div class="form-group">
            <label for="motDePasse">Password:</label>
            <input type="password" class="form-control" id="motDePasse" name="motDePasse" value="${Livreur.motDePasse}" required>
            <div class="invalid-feedback">Please enter the password.</div>
        </div>
        
        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="isAvailable" name="isAvailable" ${Livreur.isAvailable ? 'checked' : ''}>
            <label class="form-check-label" for="isAvailable">Available</label>
        </div>
        
        <div class="button-container">
            <button type="submit" class="btn btn-primary">Update Livreur</button>
            &nbsp;&nbsp;
            <button type="button" class="btn btn-secondary" onclick="window.location.href='AllLivreur.jsp'">Return</button>
        </div>
    </form>
</div>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script>
    // Example starter JavaScript for disabling form submissions if there are invalid fields
    (function() {
      'use strict';
      window.addEventListener('load', function() {
        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        var forms = document.getElementsByClassName('needs-validation');
        // Loop over them and prevent submission
        var validation = Array.prototype.filter.call(forms, function(form) {
          form.addEventListener('submit', function(event) {
            if (form.checkValidity() === false) {
              event.preventDefault();
              event.stopPropagation();
            }
            form.classList.add('was-validated');
          }, false);
        });
      }, false);
    })();
</script>

</body>
</html>









































<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Livreur</title>
</head>
<body>
    <h1>Edit Livreur</h1>
    <!-- Action should point to the URL mapped to your LivreurController's doPost method with the action edit -->
    <form action="LivreurController?action=edit" method="post">
        <!-- Include hidden field to pass the ID of the livreur being edited -->
        <input type="hidden" name="livreurId" value="${Livreur.livreurId}" />
<input type="text" id="nom" name="nom" value="${Livreur.nom}" required />
<input type="email" id="email" name="email" value="${Livreur.email}" required />
<input type="password" id="motDePasse" name="motDePasse" value="${Livreur.motDePasse}" required />
<input type="checkbox" id="isAvailable" name="isAvailable" ${Livreur.isAvailable ? 'checked' : ''} />

        <div>
            <button type="submit" name="edit">Update Livreur</button>
        </div>
    </form>
    <a href="AllLivreur.jsp">Back to List</a>
</body>
</html>
 --%>