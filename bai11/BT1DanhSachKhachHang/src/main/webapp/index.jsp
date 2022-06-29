<%@ page import="models.KhachHang" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 6/29/2022
  Time: 8:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<head>
  <title>Simple Dictionary</title>
  <style>
    table{
      border-collapse: collapse;
      width: 100%;
    }
    th, td{
      padding: 8px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }
    h2{
      margin-left: 30%;
    }
  </style>
</head>
<body>
    <h2>Danh sách khách hàng</h2>
    <table>
      <tr>
        <th>Tên</th>
        <th>Ngày sinh</th>
        <th>Địa chỉ</th>
        <th>Ảnh</th>
      </tr>
      <%
            List<KhachHang> khachHangList = new ArrayList<>();
            khachHangList.add(new KhachHang("Mai Văn Hoàn","1983-08-20","Hà Nội","img1.jpg"));
            khachHangList.add(new KhachHang("Mai Văn Hoà","1983-08-21","Bắc Giang","img2.jpg"));
            khachHangList.add(new KhachHang("Mai Thị Hà","1983-08-22","Nam Định","img3.png"));
            khachHangList.add(new KhachHang("Mai Văn Hoan","1983-08-23","Hà Tây","img4.jpg"));
            khachHangList.add(new KhachHang("Mai Văn Hoàng","1983-08-24","Hà Nội","img5.jpg"));

            request.setAttribute("khachHangList",khachHangList);

      %>
      <c:forEach items="${khachHangList}" var="khachHangList">
        <tr>
          <td>${khachHangList.name }</td>
          <td>${khachHangList.ngaySinh }</td>
          <td>${khachHangList.diaChi }</td>
          <td><img src="${khachHangList.anh }" alt="" width="150" height="250"></td>
        </tr>
      </c:forEach>
    </table>

</body>
</html>
