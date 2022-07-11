<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 7/1/2022
  Time: 4:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Staff Management Application</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        table{
            border-collapse: collapse;
        }

        tr:nth-child(odd){
            background-color: #dee2e6;
        }

        th, td {
            padding-left: 15px;
            border-top: 1px solid #dee2e6;
        }
        h1{
            text-align: center;
        }
        form{
            margin: 0;
        }
        #tr-head{
            background-color: ghostwhite;
        }
        #a-add, #a-delete{
            color: aliceblue;
        }
        #a-edit{
            color: black;
        }
    </style>
</head>
<h1>Staff Management</h1>
<br/>
<div align="center">
    <table cellpadding="5">
        <caption><h2>List of Staffs</h2></caption>
        <tr id="tr-head">
            <td colspan="2">
                <button id="btn-add" type="button" class="btn btn-primary"><a href="/staff?action=create" id="a-add">Add</a></button>
            </td>
            <td colspan="6" align="right">
                <form method="post" action="/staff?action=search" id="form-search">
                    <input type="text" name="name" id="name" placeholder="Search">
                    <button type="submit" class="btn btn-outline-success">Search</button>
                </form>
            </td>
        </tr>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Date of birth</th>
            <th>Address</th>
            <th>Phone number</th>
            <th>Email</th>
            <th>Department</th>
            <th>Action</th>
        </tr>
        <c:forEach var="list" items="${listStaff}">
            <tr>
                <td><c:out value="${list.id}"/></td>
                <td><c:out value="${list.name}"/></td>
                <td><c:out value="${list.dateOfBirth}"/></td>
                <td><c:out value="${list.address}"/></td>
                <td><c:out value="${list.phoneNumber}"/></td>
                <td><c:out value="${list.email}"/></td>
                <td><c:out value="${list.nameDepartment}"/></td>
                <td>
                    <button type="button" class="btn btn-warning"><a href="/staff?action=edit&id=${list.id}" id="a-edit">Edit</a></button>
                    <button type="button" class="btn btn-danger"><a href="/staff?action=delete&id=${list.id}" id="a-delete">Delete</a></button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>

