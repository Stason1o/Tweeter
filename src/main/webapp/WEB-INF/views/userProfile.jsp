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
        <c:forEach items="${user.followedUsers}" var="followedUserByLoggedUser">
            <p> <a href="userProfile?username=${user.username}">  ${followedUserByLoggedUser.firstName} ${followedUserByLoggedUser.lastName}</a></p>
        </c:forEach>
    </p>
</body>
</html>
