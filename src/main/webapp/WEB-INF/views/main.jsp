<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sbogdanschi
  Date: 4/05/2017
  Time: 7:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:url var="firstUrl" value="/main/1" />
<c:url var="lastUrl" value="/main/${deploymentLog}" />
<c:url var="prevUrl" value="/main/${currentIndex - 1}" />
<c:url var="nextUrl" value="/main/${currentIndex + 1}" />
<html>
<head>
    <title>Feed</title>
</head>
<body>

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

</body>
</html>
