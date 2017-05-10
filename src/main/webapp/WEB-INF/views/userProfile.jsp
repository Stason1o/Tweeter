<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sbogdanschi
  Date: 9/05/2017
  Time: 12:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${user.firstName} profile page</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <p>
        Name : ${user.firstName}<br>
        Surname: ${user.lastName} <br>
        Username: ${user.username}<br>

        Tweets:
        <c:forEach items="${user.tweets}" var="tweet">
    <p>${tweet.date} <br> ${tweet.content}</p>
    </c:forEach>
    <br>
    Followed users:
    <c:forEach items="${user.followedUsers}" var="followedUser">
        <c:choose>
            <c:when test="${followedUser.id != loggedUser.id}">
                <p>
                    <a href="userProfile?username=${user.username}">
                            ${followedUser.firstName} ${followedUser.lastName} ${followedUser.username}
                    </a>
                </p>
            </c:when>
            <c:otherwise>
                <p>
                    <a href="<c:url value="/myProfile" />" >
                            ${followedUser.firstName} ${followedUser.lastName} ${followedUser.username}
                    </a>
                </p>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    </p>
    <!--Content goes here-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
