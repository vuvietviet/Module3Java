<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 7/1/2022
  Time: 4:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Deleting Student</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        table{
            border-collapse: collapse;
            border: 1px solid darkgrey;
        }
        th,td{
            padding: 5px;
        }
        #a-cancel{
            color: aliceblue;
        }
    </style>
</head>
<body class="container">
<h1>Delete Student</h1>
<form method="post">
    <h3>Are you sure?</h3>
        <table>
            <caption>Student Information</caption>
            <tr>
                <th>ID: </th>
                <td>${student.getId()}</td>
            </tr>
            <tr>
                <th>Name: </th>
                <td>${student.getName()}</td>
            </tr>
            <tr>
                <th>Date Of Birth: </th>
                <td>${student.getDateOfBirth()}</td>
            </tr>
            <tr>
                <th>Address: </th>
                <td>${student.getAddress()}</td>
            </tr>
            <tr>
                <th>Number Phone: </th>
                <td>${student.getPhoneNumber()}</td>
            </tr>
            <tr>
                <th>Email: </th>
                <td>${student.getEmail()}</td>
            </tr>
            <tr>
                <th>Class Name: </th>
                <td>${student.getNameClass()}</td>
            </tr>
            <tr>
                <td><button type="submit" class="btn btn-danger">Delete</button></td>
                <td><button type="button" class="btn btn-secondary"><a href="/student?action=students" id="a-cancel">Cancel</a></button> </td>
            </tr>
        </table>
</form>
</body>
</html>
