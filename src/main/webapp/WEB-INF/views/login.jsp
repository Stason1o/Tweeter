<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="full">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/main.css"%>
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
                    <a class="navbar-brand" href="/login">LinK</a>
                </div>

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li><a href="/registration"><span class="glyphicon glyphicon-pencil"></span> Register</a></li>
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
    <div class="container-fluid background background-image">
        <div class="col-lg-8 col-sm-8 welcome-align">
            <p class="welcome">Welcome to LinK</p>
            <p class="welcome-msg">
                Connect with your friends, colleagues and business partners.
                <br>Share success stories. Enjoy beautiful moments.<br>Make and cherish memories, and so much more.
                <br>A place that you can use for your business activities, hobbies or day to day life.
            </p>
        </div>

        <div class="col-lg-4 col-sm-4 login-align">

            <form:form id="loginForm" method="post" action="login" modelAttribute="user" class="form-login">

                <h3 class="form-heading">Login</h3><hr>

                <div class="field input-group input-group-lg login-username">
                    <span class="input-group-addon" id="user-icon">
                        <span class="glyphicon glyphicon-user"></span>
                    </span>
                    <form:input id="username" name="username" path="username" class="form-control"
                            placeholder="lazyuser25" required="" autofocus="" aria-describedby="user-icon"/>
                </div>
                <br>
                <div class="field input-group input-group-lg">
                        <%--<form:label path="password">Password:</form:label>--%>
                     <span class="input-group-addon" id="password-icon">
                        <span class="glyphicon glyphicon-lock"></span>
                    </span>
                    <form:password id="password" name="password" path="password" class="form-control"
                                   placeholder="P@ssword#23.1" required="" autofocus=""
                                   aria-describedby="password-icon"/>
                </div>
                <br>
                <div>
                    <button type="submit" class="btn btn-lg btn-success pull-right">Log in</button>
                    <%--<input type="button" value="Register" onclick="window.location='/registration'"--%>
                           <%--class="btn btn-lg btn-warning">--%>
                </div>
            </form:form>
        </div>
    </div>
    <!-- ##Content## -->

    <!--REST OF THE CONTENT GOES HERE. BEFORE <script> tags-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
