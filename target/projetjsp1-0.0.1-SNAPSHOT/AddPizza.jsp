<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New Pizza</title>
    <!-- Add link to CSS files and any additional head elements -->
</head>
<body>

<h2>Add New Pizza</h2>

<!-- Action should point to the URL mapped to your PizzaController's doPost method -->
<form action="PizzaController?action=add" method="post">
    <div>
        <label for="nom">Name:</label>
        <input type="text" id="nom" name="nom" required>
    </div>
    <div>
        <label for="description">Description:</label>
        <textarea id="description" name="description" ></textarea>
    </div>
    <div>
        <label for="prixBase">Base Price:</label>
        <input type="number" id="prixBase" name="prixBase"  required>
    </div>
        <div>
        <label for="image">Image:</label>
        <input type="text" id="image" name="image"  >
    </div>
    <div>
        <button type="submit" name="add">Add Pizza</button>
    </div>
</form>

</body>
</html>
