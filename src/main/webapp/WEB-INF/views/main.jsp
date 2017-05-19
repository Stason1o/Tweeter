<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<spring:htmlEscape defaultHtmlEscape="true" />
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Feed</title>
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
                    <button id="dropDownMenu" type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/login">LinK</a>
                </div><!-- end navbar-header -->

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a id="homePageNavBar" href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li><a href="/profile"><span class="glyphicon glyphicon-picture"></span> ${user.firstName}</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="drop-down">
                            <a id="navBarDropDownMenu" href="" class="dropdown-toggle" data-toggle="dropdown">
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
                                    <a id="globalSearchPage" href="/globalSearch">
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
        <h3>Tweets</h3>
        <hr>
        <div class="row">
            <div class="col-sm-1"></div>
            <div class="col-sm-4">
                <form:form method="post" modelAttribute="tweet">
                <div class="row nested-title">
                    <h4>Have something to say?</h4>
                </div>
                <div class="row nested-textarea">
                    <form:textarea path="content" />
                </div>
                <div class="row nested-buttons">
                    <div class="col-sm-8"></div>
                    <div class="col-sm-4">
                        <button id="tweetActionButton" type="submit" class="btn btn-success">Tweet</button>
                    </div>
                </div>
                </form:form>
            </div>


            <div class="col-sm-6">
                <div class="row nested-title">
                    <h4>Tweet list</h4>
                </div>
                <c:set value="false" var="contains"/>
                <security:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin"/>
                <c:forEach var="listTweets" items="${listTweets}">
                <%--<div class="row tweet-wrapper">--%>
                <div id="tweetArea" class="row tweet-wrapper" onclick="location.href='<c:url value="/tweetPage/${listTweets.id}/${currentIndex}"
                />'">
                    <div class="col-sm-2 image">
                        <a href="#">
                            <img class="media-object" src="" alt="user-image">
                        </a>
                    </div>
                    <div class="col-sm-10">
                        <div class="row tweet-content">
                            <div class="col-sm-8 tweet-user-text">
                                <!--NEEDS STYLING-->

                                <c:forEach var="userTweet" items="${user.tweets}">
                                    <c:if test="${listTweets.id == userTweet.tweet.id}">
                                        <c:set var="contains" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <c:choose>
                                    <c:when test="${listTweets.tweet != null}">
                                        <span><b>You Retweeted</b></span>
                                        <div class="retweet-box">
                                            <span class="full-name">
                                                ${listTweets.tweet.user.firstName}
                                                ${listTweets.tweet.user.lastName}
                                            </span>
                                            <span class="user-name"> @${listTweets.tweet.user.username}</span>
                                            <p class="content-text">${listTweets.tweet.content}</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="full-name">${listTweets.user.firstName} ${listTweets.user.lastName}</span>
                                        <span class="user-name"> @${listTweets.user.username}</span>
                                        <p class="content-text">${listTweets.content}</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="col-sm-4"></div>
                        </div>
                        <div class="row tweet-actions">
                           <div class="col-sm-4"></div>
                           <div class="col-sm-8">
                               <%--<button class="btn btn-info" type="submit" name="followedFriend"--%>
                                       <%--value="${unfollowedUser.id}">Follow--%>
                               <%--</button>--%>

                               <c:if test="${contains eq false}" >
                                   <a href="<c:url value='/reTweet/${listTweets.id}' />"><span class="glyphicon glyphicon-retweet"></span> Retweet
                                   </a>
                               </c:if>
                                   <c:set value="false" var="contains"/>

                               <a href="<c:url value='/tweetPage/${listTweets.id}/${currentIndex}' />">
                                   Comment&nbsp; <span class="glyphicon glyphicon-comment"></span>
                               </a>
                           </div>
                        </div>
                    </div>
                </div>

                </c:forEach>
                <jsp:include page="templates/pagination.jsp" />
            </div>
            <div class="col-sm-1"></div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
