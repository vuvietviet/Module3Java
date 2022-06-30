<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 6/30/2022
  Time: 11:41 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Search by name</title>
    <style>
        .message{
            color:green;
        }
    </style>
</head>
<body>
<h1>Search by name</h1>
<p>
    <c:if test='${requestScope["message"] != null}'>
        <span class="message">${requestScope["message"]}</span>
    </c:if>
</p>
<p>
    <a href="/products">Back to product list</a>
</p>
<form method="post">

        <input type="text" name="name" id="name">
        <input type="submit" value="Search">

</form>
</body>
</html>
