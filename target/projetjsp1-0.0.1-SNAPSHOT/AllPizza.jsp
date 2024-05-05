<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Pizzas</title>
</head>
<body>
    <h1>List of Available Pizzas</h1>
    <table>
        <tr>
            <th>Name</th>
            <th>Description</th>
            <th>Base Price</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="pizza" items="${pizzas}">
            <tr>
                <td><c:out value="${pizza.nom}"/></td>
                <td><c:out value="${pizza.description}"/></td>
                <td><c:out value="${pizza.prixBase}"/></td>
                <td><img src="${pizza.image}" alt="Pizza Image" style="width:100px; height:auto;"/></td>
                
                <td>
                   <a href="pizza?action=edit&id=${pizza.id}">Edit</a> |
				   <a href="#" onclick="deletePizza(${pizza.id}); return false;">Delete</a>|
				   <a href="pizza?action=detail&id=${pizza.id}">Details</a> |
				   
				   

                </td>
            </tr>
        </c:forEach>
    </table>
    <a href="/projetjsp1/AddPizza.jsp">Add New Pizza</a>
    <script type="text/javascript">
    function deletePizza(pizzaId) {
        if (confirm('Are you sure you want to delete this pizza?')) {
            var form = document.createElement('form');
            document.body.appendChild(form);
            form.method = 'post';
            form.action = 'pizza';

            var actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';
            form.appendChild(actionInput);

            var idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = pizzaId;
            form.appendChild(idInput);

            form.submit();
        }
    }
</script>
    
</body>
</html>
