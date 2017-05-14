<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Follow friends</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/style.css"%>
    </style>
</head>
<body>
<c:set value="false" var="contains"/>
<div style="margin-left: 30%; width: 300px; float: left; ">
    <c:url var="findPage" value="/globalSearch"/>
    <form:form commandName="user" action="${findPage}">
        <%--<form:form name="searchUser" action="/followFriend/{searchUser}" method="post">--%>
        <h3 class="form-heading">Search User</h3>
        <hr>

        <div class="field input-group input-group-lg">
                <span class="input-group-addon" id="user-icon">
                    <span class="glyphicon glyphicon-user"></span>
                </span>
            <form:input id="username" name="username" path="username" class="form-control"
                        placeholder="lazyuser25" required="" autofocus="" aria-describedby="user-icon"/>
        </div>
        <br>
        <div class="padding-top">
            <button class="btn btn-lg btn-success btn-block" type="submit">Search</button>
        </div>
    </form:form>

</div>

<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
