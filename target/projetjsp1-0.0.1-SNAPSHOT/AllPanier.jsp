<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>

<head>

    <title>Panier</title>

</head>

<body>

    <h1>Panier</h1>

    <table border="1">

        <tr>

            <th>pizzaid</th>

            <th>userid</th>

            <th>quantite</th>

            <th>Price</th>

            <th>Actions</th>

        </tr>

        <c:forEach var="panier" items="${paniers}">

            <tr>

                <td><c:out value="${panier.pizzaid}"/></td>

                <td><c:out value="${panier.userid}"/></td>

                <td><c:out value="${panier.quantite}"/></td>

                <td><c:out value="${panier.prixTotal}"/></td>



                <td>

				   <a href="#" onclick="deletePanier(${panier.panierId}); return false;">Delete</a> |

				   <a href="commande?action=add&panierId=${panier.panierId}&total=${panier.prixTotal}">+ commander</a> 

				      

                </td>

            </tr>

        </c:forEach>

    </table>

    <a href="/projetjsp1/AddPizza.jsp">Add New Pizza</a>

    <script type="text/javascript">

    function deletePanier(panierId) {

        if (confirm('Are you sure you want to delete this panier?')) {

            var form = document.createElement('form');

            document.body.appendChild(form);

            form.method = 'post';

            form.action = 'panier';



            var actionInput = document.createElement('input');

            actionInput.type = 'hidden';

            actionInput.name = 'action';

            actionInput.value = 'delete';

            form.appendChild(actionInput);



            var idInput = document.createElement('input');

            idInput.type = 'hidden';

            idInput.name = 'id';

            idInput.value = panierId;

            form.appendChild(idInput);



            form.submit();

        }

    }

</script>

    

</body>

</html>

