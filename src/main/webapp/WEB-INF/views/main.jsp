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

<<<<<<< HEAD
    <jsp:useBean id="now" class="java.util.Date" />

    <c:url var="addAction" value="/main"/>
    <form:form action="${addAction}" commandName="tweet">
        <form:label path="content">Enter tweet content</form:label>
        <form:input id="content" name="content" path="content" /><br>
        <input type="submit" value="Submit" />
    </form:form>

    <p>Tweets :</p>
    <c:forEach var="listTweets" items="${listTweets}">
        <div><p>Tweet ID#${listTweets.id},
            posted by <b>${listTweets.user.username}</b>
            at ${listTweets.date}</p> </div>
        <div><p>${listTweets.content}</p></div>
    </c:forEach>
    <!--Content goes here-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
=======
<form:form method="post" modelAttribute="tweet">
    <form:label path="content">Enter tweet content</form:label>
    <form:input path="content" /><br>

    <input type="submit" value="Submit" />
</form:form>

<p>Tweets :</p>
<c:forEach var="listTweets" items="${listTweets}">
    <div><p>Tweet ID#${listTweets.id},
        posted by <b>${listTweets.user.username}</b>
        at ${listTweets.date}</p> </div>
    <div><p>${listTweets.content}</p></div>

    <c:if test="${listTweets.user.id == user.id}">
        <a href="<c:url value='/editTweet/${listTweets.id}' />">Edit</a>
        <a href="<c:url value='/deleteTweet/${listTweets.id}' />">Delete</a>
    </c:if>
</c:forEach>

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

>>>>>>> f8ffb906c577865d63eab5f56dc3c2b4c871d438
</body>
</html>
