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
    <title>Student Management Application</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        table{
            border-collapse: collapse;
            border: 1px solid black;
        }
        th,td{
            padding: 5px;
        }
        button{
            margin-left: 10px;
        }
        #a-cancel{
            color: aliceblue;
        }
    </style>
</head>
<body>
<center>
    <h1>Student Management</h1>
</center>
<div align="center">
    <form method="post">
        <table>
            <caption>
                <h5>
                    Edit Information Of Student
                </h5>
            </caption>
            <c:if test="${student != null}">
                <input type="hidden" name="id" value="<c:out value='${student.id}' />"/>
            </c:if>
            <tr>
                <th>Student Name:</th>
                <td>
                    <input type="text" name="name" size="45"
                           value="<c:out value='${student.name}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Student Date Of Birth:</th>
                <td>
                    <input type="text" name="dateOfBirth" size="45"
                           value="<c:out value='${student.dateOfBirth}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Student Address:</th>
                <td>
                    <input type="text" name="address" size="45"
                           value="<c:out value='${student.address}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Student Number Phone:</th>
                <td>
                    <input type="text" name="phoneNumber" size="45"
                           value="<c:out value='${student.phoneNumber}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Student Email:</th>
                <td>
                    <input type="text" name="email" size="45"
                           value="<c:out value='${student.email}' />"
                    />
                </td>
            </tr>
            <tr>
                <th>Student Class Name:</th>
                <td>
                    <select name="nameClass" style="width: 372px" >
                        <c:forEach var="list" items="${classes}">
                            <c:if test="${list.equals(student.nameClass)}">
                                <option selected = "selected"><c:out value="${list}"/></option>
                            </c:if>
                            <c:if test="${!list.equals(student.nameClass)}">
                                <option><c:out value="${list}"/></option>
                            </c:if>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button type="submit" class="btn btn-info">Save</button>
                    <button type="button" class="btn btn-secondary"><a href="/student?action=students" id="a-cancel">Cancel</a></button>
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>

