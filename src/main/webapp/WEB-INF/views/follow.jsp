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

    <c:forEach items="${listFollowedUsers}" var="followedUser">
        <c:choose>
            <c:when test="${followedUser.followed}">
                <p>
                    <a href="userProfile?username=${followedUser.username}">
                        ${followedUser.firstName}   ${followedUser.lastName} ${followedUser.id}
                    </a>
                    <button style="height: 30px; width: 100px;" type="submit" name="unfollowedFriend" value="${followedUser.id}">UnFollow</button>
                </p>
            </c:when>
            <c:otherwise>
                <p>
                    <a href="userProfile?username=${followedUser.username}">
                        ${followedUser.firstName}   ${followedUser.lastName} ${followedUser.id}
                    </a>
                    <button style="height: 30px; width: 100px;" type="submit" name="followedFriend" value="${followedUser.id}">Follow</button>
                </p>
            </c:otherwise>
        </c:choose>
    </c:forEach>



</form:form>


<c:forEach items="${loggedUser.followedUsers}" var="users">
    <p>${users.id}</p>
</c:forEach>
</body>
</html>
