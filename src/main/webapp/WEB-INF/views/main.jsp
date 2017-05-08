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
<html>
<head>
    <title>Feed</title>
</head>
<body>

<jsp:useBean id="now" class="java.util.Date" />

<c:url var="addAction" value="/main"/>
<form:form action="${addAction}" commandName="tweet">
    <form:label path="content">Enter tweet content</form:label>
    <form:input id="content" name="content" path="content" /><br>
    <form:input type="hidden" id="date" value="${now}" name="date" path="date"/>
    <input type="submit" value="Submit" />
</form:form>

<p>Tweets :</p>
<c:forEach var="listTweets" items="${listTweets}">
    <div><p>Tweet ID#${listTweets.id},
        posted by <b>${listTweets.user.username}</b>
        at ${listTweets.date}</p> </div>
    <div><p>${listTweets.content}</p></div>
</c:forEach>
</body>
</html>
