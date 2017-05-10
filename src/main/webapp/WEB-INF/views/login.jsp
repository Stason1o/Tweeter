<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Login</title>
    <link href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <c:forEach items="${users}" var="u">
        <p>${u.username}<br></p>
        <%--<c:forEach items="${u.tweets}" var="userTweets">--%>
            <%--<p>${userTweets.content} ${userTweets.date} ${userTweets.user}</p>--%>
        <%--</c:forEach>--%>
    </c:forEach>
    <form:form id="loginForm" method="post" action="login" modelAttribute="user">
        <form:label path="username">Enter your username</form:label>
        <form:input id="username" name="username" path="username" /><br>
        <form:label path="password">Please enter your password</form:label>
        <form:password id="password" name="password" path="password" /><br>
        <input type="submit" value="Submit" />
    </form:form>
    <!--Content goes here-->
    <script src="webjars/jquery/1.9.1/jquery.min.js"></script>
    <script src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
