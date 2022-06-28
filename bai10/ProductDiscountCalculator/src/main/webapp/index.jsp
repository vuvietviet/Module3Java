<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 6/28/2022
  Time: 4:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Product Discount Calculator</title>
</head>
<body>
<h2>Discount Calculator</h2>
<form method="post" action="/discount">
  <label>Product Description: </label><br/>
  <input type="text" name="description" placeholder="Description" value="New"/><br/>
  <label>List Price: </label><br/>
  <input type="text" name="listPrice" placeholder="ListPrice" value="0"/><br/>
  <label>Discount Percent: </label><br/>
  <input type="text" name="discount" placeholder="Discount" value="0"/><br/>
  <input type = "submit" id = "submit" value = "Calculator Discount"/>
</form>
</body>
</html>
