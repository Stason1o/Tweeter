<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Search</title>
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
                    <a class="navbar-brand" href="/login">LinK</a>
                </div>

                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li><a href="/profile"><span class="glyphicon glyphicon-picture"></span>
                        ${user.firstName}</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li class="drop-down">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-align-justify"></span> &nbsp;Navigate
                            </a>
                            <ul class="inverse-dropdown dropdown-menu">
                                <security:authorize access="hasRole('ROLE_ADMIN')" var="isAdmin"/>
                                <c:if test="${isAdmin}">
                                    <li>
                                        <a href="/admin">
                                            <span class="glyphicon glyphicon-dashboard"></span> &nbsp;Admin Panel
                                        </a>
                                    </li>
                                    <li class="divider"></li>
                                </c:if>
                                <li>
                                    <a href="/main/1">
                                        <span class="glyphicon glyphicon-bell"></span> &nbsp;Feed
                                    </a>
                                </li>
                                <li>
                                    <a href="/followFriends">
                                        <span class="glyphicon glyphicon-user"></span> &nbsp;Friends
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        <span class="glyphicon glyphicon-search"></span> &nbsp;Search
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="drop-down">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown">
                                    <span class="glyphicon glyphicon-cog">
                                        <span class="glyphicon glyphicon-triangle-bottom"></span>
                                    </span>
                            </a>
                            <ul class="inverse-dropdown dropdown-menu">
                                <li>
                                    <a href="">
                                        <span class="glyphicon glyphicon-info-sign"></span> &nbsp;About
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="/logout">
                                        <span class="glyphicon glyphicon-log-out"></span> &nbsp;Log Out
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </div>
        </div>
    </nav>
    <!-- ##Navigation Bar## -->

    <!-- Content -->
    <c:set value="false" var="contains"/>
    <div class="container-fluid">
        <div class="col-sm-4"></div>
        <div class="col-sm-4">
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
                                placeholder="lazy_username" required="" autofocus="" aria-describedby="user-icon"/>
                </div>
                <br>
                <div class="padding-top">
                    <button class="btn btn-lg btn-success btn-block" type="submit">Search</button>
                </div>
            </form:form>

        </div>
        <div class="col-sm-4"></div>
    </div>
    <!-- Content -->

    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
