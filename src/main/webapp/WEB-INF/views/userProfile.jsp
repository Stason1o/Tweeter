<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>${user.firstName} profile page</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/style.css"%>
    </style>
</head>
<body>
<c:set value="false" var="contains"/>
<c:url var="addAction" value="/userProfile"/>
    <p>
        Name : ${user.firstName}<br>
        Surname: ${user.lastName} <br>
        Username: ${user.username}<br>
        <form:form action="${addAction}" commandName="user">
            <c:forEach items="${listFollowedUsers}" var="followedUser">
                    <c:if test="${followedUser.username eq user.username}">
                        <c:set var="contains" value="true"/>
                    </c:if>
            </c:forEach>
            <c:choose>
                <c:when test="${contains}">
                    <button class="btn btn-warning" type="submit" name="unfollowedFriend" value="${user.id}">UnFollow</button>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-success" type="submit" name="followedFriend" value="${user.id}">Follow</button>
                </c:otherwise>
            </c:choose>
            <security:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin"/>
            <c:if test="${isAdmin}">
                <c:choose>
                    <c:when test="${user.enabled == true}">
                        <button class="btn btn-warning" type="submit" name="userBanUnban" value="${user.id}">Ban</button>
                    </c:when>
                    <c:otherwise>
                        <button class="btn btn-success" type="submit" name="userBanUnban" value="${user.id}">UnBan</button>
                    </c:otherwise>
                </c:choose>
                <button class="btn btn-primary" type="submit" name="userToDelete" value="${user.id}">Delete ${user.username}</button>
            </c:if>
        </form:form>
        Tweets:
        <c:forEach items="${user.tweets}" var="tweet">
            <p>${tweet.date} <br> ${tweet.content}</p>
        </c:forEach>
        <br>
        Followed users:
        <c:forEach items="${user.followedUsers}" var="followedUser">
            <p>
                <a href="<c:url value="/userProfile/${followedUser.username}"/>">
                        ${followedUser.firstName} ${followedUser.lastName} ${followedUser.username}
                </a>
            </p>
            <%--<p>--%>
                <%--<a href="<c:url value="/profile" />" >--%>
                        <%--${followedUser.firstName} ${followedUser.lastName} ${followedUser.username}--%>
                <%--</a>--%>
            <%--</p>--%>
        </c:forEach>
    </p>
    <!--Content goes here-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
