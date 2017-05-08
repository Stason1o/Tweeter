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
<c:url var="addAction" value="/followFriends"/>
<form:form action="${addAction}" commandName="listUsers">
    <%--<form:form id="loginForm" method="post" action="login" modelAttribute="user">--%>

    <c:forEach var="user" items="${listUsers}" >
        <c:if test="${not empty loggedUser.followedUsers}">
            <c:forEach items="${loggedUser.followedUsers}" var="followedUser">
                <c:choose>
                    <c:when test="${followedUser.id != user.id}">
                        <p>${user.firstName}   ${user.lastName} ${user.id}
                            <button style="height: 30px; width: 100px;" type="submit" name="userSelection" value="${user.id}">Follow</button> </p>
                    </c:when>
                    <c:otherwise>
                        <p>${user.firstName}   ${user.lastName} ${user.id}
                            <button style="height: 30px; width: 100px;" type="submit" name="userSelection" value="${user.id}">Unfollow</button> </p>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:if>
        <c:if test="${empty loggedUser.followedUsers}">
                <p>${user.firstName}   ${user.lastName} ${user.id}
                    <button style="height: 30px; width: 100px;" type="submit" name="userSelection" value="${user.id}">Follow</button> </p>
        </c:if>
    </c:forEach>
</form:form>
</body>
</html>
