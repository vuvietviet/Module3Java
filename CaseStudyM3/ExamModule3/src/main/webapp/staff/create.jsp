<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 7/1/2022
  Time: 4:19 PM
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
        label{
            color: dodgerblue;
        }
        #a-cancel{
            color: white;
        }
    </style>
</head>
<body>
<div align="center">
    <form method="post">
        <h2>Add New Staff</h2>
        <label>Staff ID:</label><br/>
        <input type="text" name="id" id="id" size="45" placeholder="Enter ID"/><br/>

        <label>Staff Name:</label><br/>
        <input type="text" name="name" id="name" size="45" placeholder="Enter name"/><br/>

        <label>Staff Date Of Birth:</label><br/>
        <input type="text" name="dateOfBirth" id="dateOfBirth" size="45" placeholder="Enter date of birth as YYYY/MM/DD"/><br/>

        <label>Staff Address:</label><br/>
        <input type="text" name="address" id="address" size="45" placeholder="Enter address"/><br/>

        <label>Staff Number Phone:</label><br/>
        <input type="text" name="phoneNumber" id="phoneNumber" size="45" placeholder="Enter number phone"/><br/>

        <label>Staff Email:</label><br/>
        <input type="text" name="email" id="email" size="45" placeholder="Enter email"/><br/>

        <label>Staff Department Name:</label><br/>
        <select name="nameDepartment" style="width: 372px" >
            <c:forEach var="list" items="${departments}">
                <option><c:out value="${list}"/></option>
            </c:forEach>
        </select>
        <br/><br/>

        <button type="submit" class="btn btn-info">Save</button>
        <button type="button" class="btn btn-secondary"><a href="/staff?action=staffs" id="a-cancel">Cancel</a></button>
    </form>
</div>
</body>
</html>
