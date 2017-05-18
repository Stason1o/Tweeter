<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${user.firstName} Profile</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/style.css"%>
    </style>
</head>

<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-inverse navbar-static-top">
        <div class="container-nav">
            <div class="container-fluid">

                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/login">LinK</a>
                </div><!-- end navbar-header -->

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li><a href="#"><span class="glyphicon glyphicon-picture"></span> ${user.firstName}</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="drop-down">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-align-justify"></span> &nbsp;Navigate
                            </a>
                            <ul class="inverse-dropdown dropdown-menu">
                                <security:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin"/>
                                <c:if test="${isAdmin}">
                                    <li>
                                        <a href="/admin">
                                            <span class="glyphicon glyphicon-dashboard"></span> &nbsp;Admin Panel
                                        </a>
                                    </li>
                                    <li class="divider"></li>
                                </c:if>
                                <li>
                                    <a href="/main/1">
                                        <span class="glyphicon glyphicon-bell"></span> &nbsp;Feed
                                    </a>
                                </li>
                                <li>
                                    <a href="/followFriends">
                                        <span class="glyphicon glyphicon-user"></span> &nbsp;Friends
                                    </a>
                                </li>
                                <li>
                                    <a href="/globalSearch">
                                        <span class="glyphicon glyphicon-search"></span> &nbsp;Search
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="drop-down">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown">
                                    <span class="glyphicon glyphicon-cog">
                                        <span class="glyphicon glyphicon-triangle-bottom"></span>
                                    </span>
                            </a>
                            <ul class="inverse-dropdown dropdown-menu">
                                <li>
                                    <a href="">
                                        <span class="glyphicon glyphicon-info-sign"></span> &nbsp;About
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="/logout">
                                        <span class="glyphicon glyphicon-log-out"></span> &nbsp;Log Out
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </div>
        </div>
    </nav>
    <!-- ##Navigation Bar## -->

    <!-- Content -->
    <div class="container-fluid" id="main-content">
        <div class="row">
            <div class="col-sm-3">
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

    <!-- ##Content## -->
    <!--Content goes here-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
