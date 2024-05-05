<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Add New Pizza</title>
    <!-- Link to Bootstrap CSS for styling -->
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
            margin-top: 20;
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

<div class="container col-6" >
    <h2>Add New Pizza</h2>

    <form action="PizzaController?action=add" method="post" class="needs-validation" novalidate>

        <div class="form-group">
            <label for="nom">Name:</label>
            <input type="text" class="form-control" id="nom" name="nom" required>
            <div class="invalid-feedback">Please enter the pizza name.</div>
        </div>
        <div class="form-group">
            <label for="categorie">Size:</label>
            <select class="form-control" id="categorie" name="categorie" required>
                <option value="">--Select a category--</option>
                <option value="Classic">Classic Pizza</option>
                <option value="Meat Lovers">Meat Lovers' Pizza</option>
                <option value="Vegetarian ">Vegetarian Pizza</option>
                <option value="Gourmet  ">Gourmet Pizza </option>
                
            </select>
            <div class="invalid-feedback">Please select a category.</div>
        </div>
        
        <div class="form-group">
            <label for="taille">Size:</label>
            <select class="form-control" id="taille" name="taille" required>
                <option value="">--Select a size--</option>
                <option value="petit">Small</option>
                <option value="moyenne">Medium</option>
                <option value="large">Large</option>
            </select>
            <div class="invalid-feedback">Please select a size.</div>
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea class="form-control" id="description" name="description"></textarea>
        </div>

        <div class="form-group">
            <label for="prixBase">Base Price:</label>
            <input type="text" class="form-control" id="prixBase" name="prixBase" required>
            <div class="invalid-feedback">Please provide the base price.</div>
        </div>

        <div class="form-group">
            <label for="image">Image:</label>
            <input type="text" class="form-control" id="image" name="image">
        </div>

        <div class="button-container">
            <button type="submit" class="btn btn-primary">Add Pizza</button>
            &nbsp;
            &nbsp;
            <button type="button" class="btn btn-secondary" onclick="window.location.href='AllPizza.jsp'">Return</button>
        </div>

    </form>
</div>

<!-- Optional JavaScript; choose one of the two! -->
<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
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
