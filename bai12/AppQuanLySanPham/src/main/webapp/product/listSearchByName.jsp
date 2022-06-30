<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 6/30/2022
  Time: 4:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>List search by name</title>
</head>
<body>
<h1>List search by name</h1>
<p>
    <a href="/products">Back to product list</a>
</p>
<table border="1">
    <tr>
        <td>Id</td>
        <td>Name</td>
        <td>Price</td>
        <td>Image</td>
        <td>Edit</td>
        <td>Delete</td>
    </tr>
    <c:forEach items='${requestScope["productList"]}' var="productList">
        <tr>
            <td><a href="/products?action=search&id=${productList.getId()}">${productList.getId()}</a></td>
            <td>${productList.getName()}</td>
            <td>${productList.getPrice()}</td>
            <td><img src="${productList.getImage()}" width="150" height="150"></td>
            <td><a href="/products?action=edit&id=${productList.getId()}">Edit</a></td>
            <td><a href="/products?action=delete&id=${productList.getId()}">Delete</a></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>

