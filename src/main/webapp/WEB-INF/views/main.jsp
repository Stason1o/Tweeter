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
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

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
</body>
</html>
