<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 7/2/2022
  Time: 3:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Student Management Application</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<center>
    <h1>Student Management</h1>
</center>
<div align="center">
    <table border="1" cellpadding="5">
        <caption><h5><a href="/student?action=students">Back To List All Students</a></h5></caption>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Date of birth</th>
            <th>Address</th>
            <th>Phone number</th>
            <th>Email</th>
            <th>Class</th>
            <th>Action</th>
        </tr>
        <c:forEach var="list" items="${students}">
            <tr>
                <td><c:out value="${list.id}"/></td>
                <td><c:out value="${list.name}"/></td>
                <td><c:out value="${list.dateOfBirth}"/></td>
                <td><c:out value="${list.address}"/></td>
                <td><c:out value="${list.phoneNumber}"/></td>
                <td><c:out value="${list.email}"/></td>
                <td><c:out value="${list.nameClass}"/></td>
                <td>
                    <button type="button" class="btn btn-warning"><a style="color: black" href="/student?action=edit&id=${list.id}">Edit</a></button>
                    <button type="button" class="btn btn-danger"><a style="color: aliceblue" href="/student?action=delete&id=${list.id}">Delete</a></button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>

