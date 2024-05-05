<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%  
    String m = (String)request.getAttribute("message");
    if (m != null)
        out.print("<span style='color:red'>" + m + "</span><br><br>");
%>

<form action='Auth' method='post'>
    login <input type='text' name='login'><br>
    password <input type='password' name='pass'><br>
    <input type='submit'><br>
</form>
<a href='inscription.jsp'> Inscription </a>

</body>
</html>
