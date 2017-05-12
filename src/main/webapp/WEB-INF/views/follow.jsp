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
    <div style="float:left">
            <form:form action="${addAction}" commandName="listFollowedUsers">

            <c:forEach items="${listFollowedUsers}" var="followedUser">
                            <a href="userProfile?username=${followedUser.username}">
                                    ${followedUser.firstName} ${followedUser.lastName} ${followedUser.id}
                            </a>
                <button style="height: 30px; width: 100px;" type="submit" name="unfollowedFriend" value="${followedUser.id}">UnFollow</button>
                <br>
            </c:forEach>

        </form:form>
    </div>
    <div style="float: right">
        <form:form action="${addAction}" commandName="listUnfollowedUsers">

            <c:forEach items="${listUnfollowedUsers}" var="unfollowedUser">
                <p>
                <a href="userProfile?username=${unfollowedUser.username}">
                ${unfollowedUser.firstName}   ${unfollowedUser.lastName} ${unfollowedUser.id}
                </a>
                <button style="height: 30px; width: 100px;" type="submit" name="followedFriend" value="${unfollowedUser.id}">Follow</button>
                </p>
                <br>
            </c:forEach>

        </form:form>
    </div>


    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
