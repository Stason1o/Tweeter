<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/style.css"%>
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
                    <a class="navbar-brand" href="">FLASH</a>
                </div><!-- end navbar-header -->

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li><a href=""><span class="glyphicon glyphicon-user"></span>${user.username}</a></li>
                        <li class="drop-down">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-question-sign">
                                    <span class="caret">
                                    </span>
                                </span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Item 1</a></li>
                                <li><a href="/logout">Log Out</a></li>
                            </ul>
                        </li>
                        <ul class="dropdown-menu">
                            <li><a href=""><span class="glyphicon glyphicon-info-sign"></span> About</a></li>
                            <li><a href=""><span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
                        </ul>

                        <li></li>
                    </ul>
                </div>

            </div>
        </div>
    </nav>
    <!-- ##Navigation Bar## -->

    <!-- Content -->
    <div class="container-fluid" id="main-content">
        <div class="row">
            <div class="col-md-3">
                <c:url var="addAction" value="/profile"/>
                <form:form action="${addAction}" commandName="user">
                    <form:input type="hidden" id="id" value="${user.id}" name="id" path="id" />
                <h2 class="form-profile-heading">Profile</h2>
                <span>First name</span>
                <span>${user.firstName}</span>
                <br>
                <span>Last name</span>
                <span>${user.lastName}</span>
                <br>
                <span>Username</span>
                <span>${user.username}</span>
                <br>
                <span>E-mail</span>
                <span>${user.email}</span>
                <br>


                <form:input type="hidden" id="enabled" value="1" name="enabled" path="enabled"/>
                    <a href="<c:url value='/edit/${user.id}' />" class="btn btn-info">Edit</a>
                    <a href="<c:url value='/delete/${user.id}' />" class="btn btn-danger">Delete Profile</a>
                </form:form>

                <p></p>
            </div>

            <div class="col-md-6">
                <!-- HERE GOES USER'S TWEETS -->
                <div class="tweets">
                    <c:forEach items="${user.tweets}" var="userTweets" >
                        <p>${userTweets.content} ${userTweets.date} ${userTweets.user.username}</p>
                    </c:forEach>
                </div>
            </div>

            <div class="col-md-3">
                <!-- HERE GOES USER'S FRIENDS -->
            </div>
        </div>
    </div>
    <!-- ##Content## -->

    <!--REST OF THE CONTENT GOES HERE. BEFORE <script> tags-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>