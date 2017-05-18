<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:url var="firstUrl" value="/tweetPage/1" />
<c:url var="lastUrl" value="/tweetPage/${deploymentLog}" />
<c:url var="prevUrl" value="/tweetPage/${currentIndex - 1}" />
<c:url var="nextUrl" value="/tweetPage/${currentIndex + 1}" />
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tweets</title>
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
                </div>

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li><a href="/profile"><span class="glyphicon glyphicon-picture"></span>
                        ${loggedUser.firstName}</a></li>
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
        <h3>Tweets</h3>
        <hr>
        <div class="col-sm-3"></div>
        <div class="col-sm-6">
            <div class="row tweet-add-comment>">
                <div>
                    <span class="full-name">
                        ${tweet.user.firstName}
                        ${tweet.user.lastName}
                    </span>
                    <span class="user-name"> @${tweet.user.username}</span>
                </div>
                <%--<form:input type="hidden" id="id" value="${tweet.id}" name="id" path="id"/>--%>
                <c:choose>
                    <c:when test="${tweet.tweet != null}">
                        <span><b>You Retweeted</b></span>
                        <div style="border: 1px solid #000">
                            <span class="full-name">
                                ${tweet.tweet.user.firstName}
                                ${tweet.tweet.user.lastName}
                            </span>
                            <span class="user-name"> @${tweet.tweet.user.username}</span>
                            <p class="content-text"><c:out value=" ${tweet.tweet.content}"/></p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div><p class="content-text"><c:out value="${tweet.content}"/></p></div>
                        <%--<c:if test="${tweet.user.id == loggedUser.id}">--%>
                            <a href="<c:url value='/main/${page}' />" class="btn btn-info">
                                <span class="glyphicon glyphicon-arrow-left"></span> Back
                            </a>
                            <a href="/editTweet/${tweet.id}?page=${page}" class="btn btn-success">
                                <span class="glyphicon glyphicon-edit"></span> Edit
                            </a>
                        <%--</c:if>--%>
                        <%--<c:if test="${tweet.user.id == loggedUser.id || isAdmin}">--%>
                            <a id="deleteTweetLink" href="<c:url value='/deleteTweet/${tweet.id}' />" class="btn btn-danger"><span
                                    class="glyphicon glyphicon-remove"></span> Delete</a>
                        <%--</c:if>--%>
                    </c:otherwise>
                </c:choose>

                <br><br>
                <form:form method="post" modelAttribute="commit">
                    <%--<form:input type="hidden" id="id" value="${tweet.id}" name="id" path="id"/>--%>
                    <form:label path="content">Enter tweet comment</form:label>
                    <form:input path="content" /><br>

                    <%--<input type="submit" value="Comment" />--%>
                    <button type="submit" class="btn btn-info">
                       Comment&nbsp; <span class='glyphicon glyphicon-comment'></span>
                    </button>
                </form:form>
            </div>

            <div class="row tweet-comments>">
                <p><b>Comments :</b></p>
                <c:forEach var="commitTweets" items="${commitTweets}">
                    <div>
                        <span class="full-name">
                            ${commitTweets.user.firstName}
                            ${commitTweets.user.lastName}
                        </span>
                        <span class="user-name"> @${commitTweets.user.username}</span>
                    </div>

                    <div>
                        <p><c:out value=" ${commitTweets.content}"/></p>
                    </div>
                </c:forEach>
            </div>

            <div class="row pages">
                <ul class="pagination">
                    <c:choose>
                        <c:when test="${currentIndex == 1}">
                            <li class="disabled"><a href="#">&lt;&lt;</a></li>
                            <li class="disabled"><a href="#">&lt;</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${firstUrl}">&lt;&lt;</a></li>
                            <li><a href="${prevUrl}">&lt;</a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
                        <c:url var="pageUrl" value="/main/${i}" />
                        <c:choose>
                            <c:when test="${i == currentIndex}">
                                <li class="active"><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${currentIndex == deploymentLog}">
                            <li class="disabled"><a href="#">&gt;</a></li>
                            <li class="disabled"><a href="#">&gt;&gt;</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${nextUrl}">&gt;</a></li>
                            <li><a href="${lastUrl}">&gt;&gt;</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>

        <div class="col-sm-3"></div>

    </div>
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
