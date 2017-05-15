<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:url var="firstUrl" value="/main/1" />
<c:url var="lastUrl" value="/main/${deploymentLog}" />
<c:url var="prevUrl" value="/main/${currentIndex - 1}" />
<c:url var="nextUrl" value="/main/${currentIndex + 1}" />
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
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="">FLASH</a>
                </div>

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li><a href=""><span class="glyphicon glyphicon-info-sign"></span> About</a></li>
                        <li><a href="/profile"><span class="glyphicon glyphicon-user"></span> ${user.firstName}</a></li>
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
                    New Tweet
                </div>
                <div class="row nested-textarea">
                    <form:textarea path="content" />
                </div>
                <div class="row nested-buttons">
                    <div class="col-sm-8"></div>
                    <div class="col-sm-4">
                        <button type="submit" class="btn btn-success">Tweet</button>
                    </div>
                </div>
                </form:form>
            </div>

            <div class="col-sm-6">
                <div class="row nested-title">
                    Tweets
                </div>
                <c:forEach var="listTweets" items="${listTweets}">

                <div class="row tweet-wrapper">
                    <div class="col-sm-2 image">
                        <a href="#">
                            <img class="media-object" src="" alt="user-image">
                        </a>
                    </div>
                    <div class="col-sm-10">
                        <div class="row tweet-content">
                            <div class="col-sm-8 tweet-user-text">
                                <%--<p>Tweet ID#${listTweets.id},--%>
                                <%--posted by--%>
                                <span class="full-name">${listTweets.user.firstName} ${listTweets.user.lastName}</span>
                                <span class="user-name"> @${listTweets.user.username}</span>
                                <%--at ${listTweets.date()}--%>
                                <p class="content-text">${listTweets.content}</p>
                            </div>
                            <div class="col-sm-4"></div>
                        </div>
                        <div class="row tweet-actions">
                            <div class="col-sm-8"></div>
                            <c:if test="${listTweets.user.id == user.id}">
                            <div class="col-sm-4">
                                <a href="<c:url value='/editTweet/${listTweets.id}' />" class="btn btn-success">Edit</a>
                                <a href="<c:url value='/deleteTweet/${listTweets.id}' />" class="btn btn-danger">Delete</a>
                            </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                </c:forEach>

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
            <div class="col-sm-1"></div>
        </div>
    </div>
<%--STAS--%>
<p>Tweets :</p>
<security:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin"/>

<c:forEach var="listTweets" items="${listTweets}">
    <div>
        <p><a href="<c:url value='/tweetPage/${listTweets.id}' />">Tweet ID#${listTweets.id},</a>
        posted by <b>${listTweets.user.username}</b>
        at ${listTweets.date}</p> </div>

    <c:choose>
        <c:when test="${listTweets.tweet != null}">
            ReTweeted:<div style="border: 4px double black; width: 400px; margin-left: 50px;"><p>Tweet ID#${listTweets.tweet.id},
                posted by <b>${listTweets.tweet.user.username}</b>
                at ${listTweets.tweet.date}</p>
            <p>${listTweets.tweet.content}</p></div>
        </c:when>
        <c:otherwise>
            <div><p>${listTweets.content}</p></div>
        </c:otherwise>
    </c:choose>

    <%--<div><p>${listTweets.content}</p></div>--%>
    <%--<div><p>${listTweets.tweet.id}</p></div>--%>

    <c:if test="${listTweets.user.id == user.id}">
        <a href="<c:url value='/editTweet/${listTweets.id}' />">Edit</a>
    </c:if>
    <c:if test="${listTweets.user.id == user.id || isAdmin}">
        <a href="<c:url value='/deleteTweet/${listTweets.id}' />">Delete</a>
    </c:if>
    <a href="<c:url value='/tweetPage/${listTweets.id}' />">Commit</a>
    <c:if test="${listTweets.user.id != user.id}">
        <a href="<c:url value='/reTweet/${listTweets.id}' />">ReTweet</a>
    </c:if>

    <button style="height: 30px; width: 100px;" type="submit" name="followedFriend" value="${unfollowedUser.id}">Follow</button>

</c:forEach>
<br>
<div class="pagination">
    <ul>
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

</body>
</html>
