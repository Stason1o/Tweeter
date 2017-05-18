<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<html>
<head>
    <title>Registration</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/registration.css"%>
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
                    <a class="navbar-brand" href=""></a>
                </div>

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li><a href="/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <li><a href=""><span class="glyphicon glyphicon-info-sign"></span> About</a></li>
                    </ul>
                </div>

            </div>
        </div>
    </nav>
    <!-- ##Navigation Bar## -->

    <!-- Content -->
    <div class="container-fluid" id="main-content">
        <div class="col-lg-3 col-sm-3">
            <!--EMPTY SPACE-->
        </div>
        <div class="col-lg-6 col-sm-6">
            <c:url var="addAction" value="/registration"/>
            <form:form action="${addAction}" commandName="user">

                <h3 class="form-heading">Registration</h3><hr>
                <%--<form:label path="firstName">First name</form:label><br>--%>
                <div class="field input-group input-group-lg registration-username">
                    <span class="input-group-addon" id="name-icon">
                            <span class="glyphicon glyphicon-text-background"></span>
                    </span>
                    <form:input id="firstName" name="firstName" path="firstName" class="form-control"
                                placeholder="First name | e.g. | John" required="" autofocus=""
                                aria-describedby="name-icon"/>
                    <form:errors path="firstName"/>
                </div>
                <br>
                <%--<form:label path="lastName">Last name:</form:label><br>--%>
                <div class="field input-group input-group-lg">
                    <span class="input-group-addon" id="name-icon">
                            <span class="glyphicon glyphicon-text-background"></span>
                    </span>
                    <form:input id="lastName" name="lastName" path="lastName" class="form-control"
                                placeholder="Last name | e.g. | Smith" required="" autofocus=""
                                aria-describedby="name-icon"/>
                    <form:errors path="lastName"/>
                </div>
                <br>
                <%--<form:label path="username">Username:</form:label><br>--%>
                <div class="field input-group input-group-lg">
                    <span class="input-group-addon" id="user-icon">
                            <span class="glyphicon glyphicon-user"></span>
                    </span>
                    <form:input id="username" name="username" path="username" class="form-control"
                                placeholder="Username | e.g. | lazy_username" required="" autofocus=""
                                aria-describedby="user-icon"/>
                    <form:errors path="username"/>
                </div>
                <br>
                <%--<form:label path="password">Password:</form:label><br>--%>
                <div class="field input-group input-group-lg">
                    <span class="input-group-addon" id="password-icon">
                            <span class="glyphicon glyphicon-lock"></span>
                    </span>
                    <form:password id="password" name="password" path="password" class="form-control"
                                   placeholder="Password | e.g. | P@ssword#23.1" required="" autofocus=""
                                   aria-describedby="password-icon"/>
                    <form:errors path="password"/>
                </div>
                <br>
                <%--<form:label path="confirmPassword">Confirm password:</form:label><br>--%>
                <div class="field input-group input-group-lg">
                    <span class="input-group-addon" id="password-icon">
                            <span class="glyphicon glyphicon-lock"></span>
                    </span>
                    <form:password id="confirmPassword" name="confirmPassword" path="confirmPassword" class="form-control"
                                   placeholder="Confirm password | e.g. | P@ssword#23.1" required="" autofocus=""
                                   aria-describedby="password-icon"/>
                    <form:errors path="confirmPassword"/>
                </div>
                <br>
                <%--<form:label path="email">E-mail:</form:label><br>--%>
                <div class="field input-group input-group-lg">
                    <span class="input-group-addon" id="email-icon">
                            <span class="glyphicon glyphicon-envelope"></span>
                    </span>
                    <form:input type="email" id="email" name="email" path="email" class="form-control"
                                placeholder="E-mail | e.g. | john.smith@mail.com" required="" autofocus=""
                                aria-describedby="email-icon"/>
                    <form:errors path="email"/>
                </div>
                <br>

                <form:input type="hidden" id="enabled" value="1" name="enabled" path="enabled"/>

                <div class="padding-top">
                    <button id="submitRegisterOperation" class="btn btn-lg btn-success pull-right" type="submit">Register</button>
                </div>
            </form:form>
        </div>
        <div class="col-lg-3 col-sm-3">
            <!--EMPTY SPACE-->
        </div>
    </div>
    <!-- ##Content## -->

    <!--REST OF THE CONTENT GOES HERE. BEFORE <script> tags-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%--<script src="<c:url value="/resources/js/script.js" />"></script>--%>
</body>
</html>
