<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Edit Pizza</title>
</head>
<body>
	<h1>Edit Pizza</h1>
	<!-- Action should be the URL that your servlet listens to for POST requests, typically the same servlet managing GET requests for the edit page. -->
	<form action="PizzaController?action=edit" method="post">
		<!-- Include hidden field to pass the ID of the pizza being edited -->
		<input type="hidden" name="id" value="${pizza.id}" />

		<div>
			<label for="nom">Name:</label> <input type="text" id="nom" name="nom"
				value="${pizza.nom}" required />
		</div>

		<div>
			<label for="description">Description:</label>
			<textarea id="description" name="description" required>${pizza.description}</textarea>
		</div>

		<div>
			<label for="prixBase">Base Price:</label> <input type="text"
				id="prixBase" name="prixBase" value="${pizza.prixBase}" required />
		</div>

		<div>
			<label for="image">Image:</label> 
			<input type="text" id="image" name="image" value="${pizza.image}" required />
		</div>
		<div>
			<button type="submit" name="edit">Update Pizza</button>
		</div>
	</form>
	<a href="/projetjsp1/AllPizza.jsp">Back to List</a>
</body>
</html>
