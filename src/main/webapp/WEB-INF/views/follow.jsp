<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<c:url var="addAction" value="/registration"/>
<form:form action="${addAction}" commandName="listUsers">

    <c:forEach var="user" items="${listUsers}" >
        <p>${user.firstName}   ${user.lastName} <input type="submit" value="Follow" /></p>
    </c:forEach>
</form:form>
</body>
</html>
