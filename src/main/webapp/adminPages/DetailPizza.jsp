<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Details Pizza</title>
</head>
<body>
    <h1>Details Pizza</h1>

        <input type="hidden" name="id" value="${pizza.id}" />
        
        <div>
            <label for="nom">Name:</label>
            <input type="text" id="nom" name="nom" value="${pizza.nom}" disabled/>
        </div>
         <div>
            <label for="taille">Taille:</label>
            <input type="text" id="taille" name="taille" value="${pizza.taille}" disabled/>
        </div>
        
        <div>
            <label for="description">Description:</label>
            <textarea id="description" name="description" disabled>${pizza.description}</textarea>
        </div>
        <div>
            <label for="prixBase">Prix:</label>
            <input type="number" id="prixBase" name="prixBase" value="${pizza.prixBase}" disabled/>
        </div>
        
        <div>
            <label for="image">Image:</label>
			<img src="${pizza.image}" alt="Pizza" width="300" height="230">
        </div>

    <a href="/projetjsp1/AllPizza.jsp">Back to List</a>
</body>
</html>
