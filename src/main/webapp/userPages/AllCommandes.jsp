<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>



<!DOCTYPE html>

<html>

<head>

    <title>All Commandes</title>

</head>

<body>

    <h1>List of All Commandes</h1>

    <table border="1">

        <tr>

            <th>Commande ID</th>

            <th>User ID</th>

            <th>Status</th>

            <th>Date Commande</th>

            <th>Delivery Address</th>

            <th>Total Price</th>

            <th>Actions</th>

        </tr>

		<c:forEach var="commande" items="${commandes}">

		    <tr>

		        <td>${commande.commandeId}</td>

		        <td>${commande.userid}</td>

		        <td>${commande.statut}</td>

		        <td><fmt:formatDate value="${commande.dateCommande}" pattern="yyyy-MM-dd HH:mm"/></td>

		        <td>${commande.adresseLivraison}</td>

		        <td>${commande.prixTotal}</td>

		        <td>

		            <a href="commande?action=detail&id=${commande.commandeId}">Detail</a> |

		            <a href="commande?action=edit&id=${commande.commandeId}">Edit</a> 

		            

		        </td>

		    </tr>

		</c:forEach>



    </table>

    <a href="panier">Add New Commande</a>

</body>

</html>

