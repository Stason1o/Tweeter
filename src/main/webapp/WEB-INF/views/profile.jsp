<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: sbogdanschi
  Date: 6/05/2017
  Time: 7:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile page</title>
</head>
<body>

<c:url var="addAction" value="/profile"/>

<form:form action="${addAction}" commandName="user">
    <c:if test="${!empty user.id}">

        <form:label path="id">
            <spring:message text="ID"/>
        </form:label>
        <form:input path="id" readonly="true" size="8" disabled="true"/>
        <form:hidden path="id"/>
    </c:if>

    <form:label path="firstName">Enter your First Name</form:label>
    <form:input id="firstName" name="firstName" path="firstName" />
    <form:errors path="firstName"/>
    <br>

    <form:label path="lastName">Enter your Last Name</form:label>
    <form:input id="lastName" name="lastName" path="lastName" />
    <form:errors path="lastName"/>
    <br>

    <form:label path="username">Enter your username</form:label>
    <form:input id="username" name="username" path="username" />
    <form:errors path="username"/>


    <form:label path="password">Please enter your password</form:label>
    <form:input type="password" id="password" name="password" path="password" />
    <form:errors path="password"/>
    <br>

    <form:input type="hidden" id="confirmPassword" value="${user.password}" name="confirmPassword" path="confirmPassword" />
    <br>

    <form:label path="email">Please enter your email</form:label>
    <form:input type="email" id="email" name="email" path="email" />
    <form:errors path="email"/>
    <br>

    <form:input type="hidden" id="enabled" value="1" name="enabled" path="enabled"/>

    <c:if test="${!empty user.id}">
        <input type="submit"
               value="<spring:message text="Edit user"/>"/>
    </c:if>
    <input type="submit" value="Submit" />
</form:form>

<a href="<c:url value='/edit/${user.id}' />">Edit</a>
<a href="<c:url value='/delete/${user.id}' />">Delete</a>

<c:forEach items="${user.tweets}" var="userTweets" >
    <p>${userTweets.content} ${userTweets.date} ${userTweets.user.username}</p>
</c:forEach>

<p></p>
</body>
</html>
