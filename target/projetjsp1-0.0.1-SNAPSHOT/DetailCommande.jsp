<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html>

<head>

    <title>Commande Details</title>

</head>

<body>

    <h1>Commande Details</h1>

    <div>

        <label>Commande ID:</label>

        <span>${commande.commandeId}</span>

    </div>

    <div>

        <label>User ID:</label>

        <span>${commande.userid}</span>

    </div>

    <div>

        <label>Status:</label>

        <span>${commande.statut}</span>

    </div>

    <div>

        <label>Date of Commande:</label>

        <span><fmt:formatDate value="${commande.dateCommande}" pattern="yyyy-MM-dd HH:mm"/></span>

    </div>

    <div>

        <label>Delivery Address:</label>

        <span>${commande.adresseLivraison}</span>

    </div>

    <div>

        <label>Total Price:</label>

        <span>${commande.prixTotal}</span>

    </div>

    <a href="/projetjsp1/commande">Back to List</a>

</body>

</html>