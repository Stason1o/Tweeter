<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: sbogdanschi
  Date: 28/04/2017
  Time: 2:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
<p>Welcome page; ${username}</p>

<sec:authorize var="loggedIn" access="isAuthenticated()"/>
<c:if test="${loggedIn}">
    <a href="<c:url value="/logout" />">Logout</a>
</c:if>
</body>
</html>
