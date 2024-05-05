<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
