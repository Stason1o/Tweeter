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

    <c:forEach var="registeredUser" items="${listUsers}" >
        <c:if test="${not empty loggedUser.followedUsers}">
            <c:forEach items="${loggedUser.followedUsers}" var="followedUserByLoggedUser">
                <c:choose>
                    <c:when test="${followedUserByLoggedUser.id != registeredUser.id }">
                        <p><a href="userProfile?username=${registeredUser.username}">
                                ${registeredUser.firstName}   ${registeredUser.lastName} ${registeredUser.id}</a>
                            <button style="height: 30px; width: 100px;" type="submit" name="followedFriend" value="${registeredUser.id}">Follow</button> </p>
                    </c:when>
                    <c:otherwise>
                        <p><a href="userProfile?username=${registeredUser.username}">
                                ${registeredUser.firstName}   ${registeredUser.lastName} ${registeredUser.id}</a>
                            <button style="height: 30px; width: 100px;" type="submit" name="unfollowedFriend" value="${registeredUser.id}">Unfollow</button> </p>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:if>
        <c:if test="${empty loggedUser.followedUsers}">
                <p><a href="userProfile?username=${registeredUser.username}">
                        ${registeredUser.firstName}   ${registeredUser.lastName} ${registeredUser.id}</a>
                    <button style="height: 30px; width: 100px;" type="submit" name="followedFriend" value="${registeredUser.id}">Follow</button> </p>
        </c:if>
    </c:forEach>
</form:form>
</body>
</html>
