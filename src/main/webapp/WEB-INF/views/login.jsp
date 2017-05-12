<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Login</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <c:forEach items="${users}" var="u">
            <p>${u.username}<br></p>
            <%--<c:forEach items="${u.tweets}" var="userTweets">--%>
                <%--<p>${userTweets.content} ${userTweets.date} ${userTweets.user.username}</p>--%>
            <%--</c:forEach>--%>
        </c:forEach>
            <div class="col-md-6">
                <form:form id="loginForm" method="post" action="login" modelAttribute="user" class="form-login">
                    <%--<form:label path="username">Enter your username</form:label>--%>
                    <h2 class="form-login-heading">Login</h2>
                    <form:input id="username" name="username" path="username" class="form-control"
                                placeholder="Username" required="" autofocus="" /><br>
                    <%--<form:label path="password">Please enter your password</form:label>--%>
                    <form:password id="password" name="password" path="password" class="form-control"
                                   placeholder="Password" required="" autofocus=""/><br>
                    <%--<input type="submit" value="Log in" class="btn btn-success"/>--%>
                    <button class="btn btn-lg btn-success btn-block" type="submit">Log in</button>
                </form:form>
            </div>
    </div>
    <!--Content goes here-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
