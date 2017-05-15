<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:url var="firstUrl" value="/main/1" />
<c:url var="lastUrl" value="/main/${deploymentLog}" />
<c:url var="prevUrl" value="/main/${currentIndex - 1}" />
<c:url var="nextUrl" value="/main/${currentIndex + 1}" />
<html>
<head>
    <title>Feed</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/style.css"%>
    </style>
</head>
<body>

<form:form method="post" modelAttribute="tweet">
    <form:label path="content">Enter tweet content</form:label>
    <form:input path="content" /><br>

    <input type="submit" value="Submit" />
</form:form>

<p>Tweets :</p>
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

<div>
    <c:forEach var="likeList" items="${likeList}">
        ${likeList.content}
    </c:forEach>
</div>

</body>
</html>
