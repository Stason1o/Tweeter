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
        <%@include file="/resources/css/profile_user.css"%>
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
                        <li><a href="/profile"><span class="glyphicon glyphicon-picture"></span> ${loggedUser.firstName}</a></li>
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
    <div class="container-fluid">
        <div class="row">
            <div class="profile">
                <h3 class="form-heading">Profile</h3><hr>
            </div>

            <div class="col-lg-3 col-sm-3 general-info">
                <div class="row nested-title general-info">
                    <h4>General information</h4>
                </div>

                <c:set value="false" var="contains"/>
                <c:url var="addAction" value="/userProfile"/>
                <form:form action="${addAction}" commandName="user">
                    <form:input type="hidden" id="id" value="${user.id}" name="id" path="id" />

                    <div class="row user-info">
                        <div class="col-lg-6 col-sm-6">
                            <a href="#">
                                <img class="media-object" src="" alt="user-profile-image">
                            </a>
                        </div>

                        <div class="col-lg-6 col-sm-6">
                            <p class="full-name"><span class="glyphicon glyphicon-user"></span>&nbsp;
                                    ${user.firstName} ${user.lastName}
                            </p>
                            <p class="username">&nbsp;&nbsp;&nbsp;&nbsp; @${user.username}</p>
                            <p class="email"><span class="glyphicon glyphicon-envelope"></span>&nbsp;
                                    ${user.email}
                            </p>
                        </div>
                    </div>

                    <div class="row button-control">
                        <div class="col-lg-8 col-sm-8">
                            <security:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin"/>
                            <c:if test="${isAdmin}">
                                <span>
                                    <button class="btn btn-danger pull-left" type="submit" name="userToDelete"
                                            value="${user.id}">
                                        Delete ${user.username}
                                    </button>
                                </span>
                                <c:choose>

                                    <c:when test="${user.enabled == true}">
                                        <span>
                                            <button class="btn btn-warning" type="submit"
                                                    name="userBanUnban"
                                                    value="${user.id}">
                                                Ban
                                            </button>
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span>
                                            <button class="btn btn-success" type="submit"
                                                    name="userBanUnban" value="${user.id}">
                                                UnBan
                                            </button>
                                        </span>
                                    </c:otherwise>

                                </c:choose>
                            </c:if>
                                <%--<form:input type="hidden" id="enabled" value="1" name="enabled" path="enabled"/>--%>
                                <%--<a href="<c:url value='/edit/${user.id}' />" class="btn btn-info">Edit</a>--%>
                        </div>

                        <div class="col-lg-4 col-sm-4">
                            <c:forEach items="${loggedUser.followedUsers}" var="followedUser">
                                <c:if test="${followedUser.id == user.id}">
                                    <c:set var="contains" value="true"/>
                                </c:if>
                            </c:forEach>
                            <c:choose>

                                <c:when test="${contains}">
                                    <button class="btn btn-warning" type="submit" name="unfollowedFriend" value="${user.id}">
                                        UnFollow
                                    </button>
                                </c:when>

                                <c:otherwise>
                                    <button class="btn btn-success" type="submit" name="followedFriend" value="${user.id}">
                                        Follow
                                    </button>
                                </c:otherwise>

                            </c:choose>

                            <c:set var="contains" value="false"/>
                            <%--<form:input type="hidden" id="enabled" value="1" name="enabled" path="enabled"/>--%>
                            <%--<a id="deleteProfile" href="<c:url value='/delete/${user.id}' />" class="btn btn-danger">Delete Profile</a>--%>
                        </div>
                        <div class="col-sm-6">
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
                            <%--<form:input type="hidden" id="enabled" value="1" name="enabled" path="enabled"/>--%>
                            <%--<a href="<c:url value='/edit/${user.id}' />" class="btn btn-info">Edit</a>--%>

                                <%--<form:input type="hidden" id="enabled" value="1" name="enabled" path="enabled"/>--%>
                                <%--<a id="deleteProfile" href="<c:url value='/delete/${user.id}' />" class="btn btn-danger">Delete Profile</a>--%>
                        </div>
                    </div>

                </form:form>
            </div>

            <div class="col-lg-6 col-sm-6 tweet-list">
                <div class="row nested-title">
                    <h4>Tweet list</h4>
                </div>

                <c:forEach items="${user.tweets}" var="userTweets" >
                    <c:if test="${!userTweets.comment}">

                        <div class="row tweet-wrapper" onclick="location.href='<c:url
                                value="/tweetPage/${userTweets.id}/${currentIndex}"/>'">
                            <div class="col-lg-2 col-sm-2 image">
                                <a href="#">
                                    <img class="media-object" src="" alt="user-image">
                                </a>
                            </div>

                            <div class="col-lg-10 col-sm-10">
                                <div class="row tweet-content">
                                    <div class="col-lg-8 col-sm-8 tweet-user-text">
                                        <!--NEEDS STYLING-->
                                        <c:choose>

                                            <c:when test="${userTweets.tweet != null}">
                                                <span><b>You Retweeted</b></span>
                                                <div class="retweet-box">
                                                <span class="full-name">
                                                    ${userTweets.user.firstName} ${userTweets.user.lastName}
                                                </span>
                                                    <span class="user-name"> @${userTweets.user.username}</span>
                                                    <p class="content-text">${userTweets.content}</p>
                                                </div>
                                            </c:when>

                                            <c:otherwise>
                                            <span class="full-name">
                                                ${userTweets.user.firstName} ${userTweets.user.lastName}
                                            </span>
                                                <span class="user-name"> @${userTweets.user.username}</span>
                                                <p class="content-text">${userTweets.content}</p>
                                            </c:otherwise>

                                        </c:choose>
                                    </div>
                                    <div class="col-lg-4 col-sm-4"></div>
                                </div>

                                <div class="row tweet-actions">
                                    <div class="col-lg-4 col-sm-4"></div>

                                    <div class="col-lg-8 col-sm-8">
                                        <c:if test="${userTweets.user.id != user.id}">
                                            <span>
                                                <a href="<c:url value='/reTweet/${userTweets.id}' />" class="btn btn-info pull-left">
                                                    <span class="glyphicon glyphicon-retweet"></span> &nbsp;Retweet
                                                </a>
                                            </span>
                                        </c:if>

                                        <span>
                                            <a href="<c:url value='/tweetPage/${userTweets.id}/${currentIndex}' />">
                                                Comment&nbsp; <span class="glyphicon glyphicon-comment"></span>
                                            </a>
                                        </span>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </c:if>
                </c:forEach>

                <jsp:include page="templates/pagination.jsp" />

            </div>

            <div class="col-lg-3 col-sm-3 friend-list">
                <div class="row nested-title">
                    <h4>Friends</h4>
                </div>
                <c:set var="contains" value="false"/>
                <c:url var="addAction" value="/profile"/>
                <form:form action="${addAction}" commandName="loggedUser">
                    <c:forEach items="${user.followedUsers}" var="followedUser">
                        <c:forEach items="${loggedUser.followedUsers}" var="user">
                            <c:if test="${user.id == followedUser.id}">
                                <c:set var="contains" value="true"/>
                            </c:if>
                        </c:forEach>
                        <div class="row user-wrapper" onclick="location.href='<c:url
                                value="/userProfile/${followedUser.username}"/>'">

                            <div class="col-lg-4 col-sm-4">
                                <a href="#">
                                    <img class="media-object" src="" alt="user-image">
                                </a>
                            </div>

                            <div class="col-lg-8 col-sm-8 user-content-info">
                                <div class="friend-name">
                                    <p class="name"><b>Name:</b> ${followedUser.firstName}</p>
                                    <p class="surname"><b>Surname:</b> ${followedUser.lastName}</p>
                                </div>

                                <div class="col-lg-6 col-sm-6"></div>

                                <div class="col-lg-6 col-sm-6">
                                    <c:choose>
                                        <c:when test="${contains eq true}">
                                            <button class="btn btn-warning pull-right" type="submit"
                                                    name="unfollowedFriend" value="${followedUser.id}">UnFollow</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-success pull-right" type="submit"
                                                    name="followedFriend" value="${followedUser.id}">Follow</button>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:set var="contains" value="true"/>
                                </div>
                            </div>

                        </div>

                    </c:forEach>

                    <jsp:include page="templates/pagination.jsp" />

                </form:form>
            </div>
        </div>
    </div>
    <!-- ##Content## -->

    <!--REST OF THE CONTENT GOES HERE. BEFORE <script> tags-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
