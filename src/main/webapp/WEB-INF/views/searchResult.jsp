<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sbogdanschi
  Date: 14/05/2017
  Time: 4:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/style.css"%>
    </style>
</head>
<body>
<c:url var="addAction" value="/followFriends"/>
<c:set var="contains" value="false"/>
<c:forEach var="user" items="${listUsers}">
    <a href="<c:url value="/userProfile/${user.username}"/>">
        Name: ${user.firstName}
        Surname: ${user.lastName}
    </a>

    <form:form action="${addAction}" commandName="listUsers">
        <c:forEach items="${loggedUser.followedUsers}" var="followedUser">
            <c:if test="${user.id == followedUser.id}">
                <c:set value="true" var="contains"/>
            </c:if>
        </c:forEach>
        <c:choose>
            <c:when test="${contains eq true}">
                <button class="btn btn-warning" type="submit" name="unfollowedFriend" value="${user.id}">UnFollow</button>
            </c:when>
            <c:otherwise>
                <button class="btn btn-success" type="submit" name="followedFriend" value="${user.id}">Follow</button>
            </c:otherwise>
        </c:choose>
    </form:form>

    <br>
    <br>
</c:forEach>
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
