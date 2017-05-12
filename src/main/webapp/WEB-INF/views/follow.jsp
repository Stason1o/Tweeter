<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Follow friends</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/style.css"%>
    </style>
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
    <!--Content goes here-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
