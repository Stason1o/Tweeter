<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sbogdanschi
  Date: 7/05/2017
  Time: 7:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Follow friends</title>
</head>
<body>
<c:forEach var="user" items="${listUsers}" >
    <p>${user.firstName}   ${user.lastName}</p>
</c:forEach>
</body>
</html>
