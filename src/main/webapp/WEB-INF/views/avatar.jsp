<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<spring:htmlEscape defaultHtmlEscape="true" />
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Feed</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/style.css"%>
    </style>
</head>
<body>

<%--<p><img src="${pageContext.request.contextPath}${user.image}" alt="Письма мастера дзен"></p>--%>

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
                    <li><a  href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                    <li><a id="homePageNavBar" href="/profile"><span class="glyphicon glyphicon-picture"></span>
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
                                <a href="#">
                                    <span class="glyphicon glyphicon-bell"></span> &nbsp;Feed
                                </a>
                            </li>
                            <li>
                                <a href="/followFriends">
                                    <span class="glyphicon glyphicon-user"></span> &nbsp;Friends
                                </a>
                            </li>
                            <li>
                                <a href="/globalSearch">
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
<div class="col-sm-3">
    <div class="container-fluid">
        <div class="row">
            <h2 class="form-profile-heading">Profile</h2>

            <h4>Choose new Avatar</h4>

        </div>
    </div>

    <form:form method="post">
        <button style="height:200px; width:200px; margin: 0; padding: 0" type="submit" name="image" value="/resources/images/1.jpg" >
            <img src="${pageContext.request.contextPath}/resources/images/1.jpg" style="height:100%;margin: 0; padding: 0"></button>
        <button style="height:200px; width:200px; margin: 0; padding: 0" type="submit" name="image" value="/resources/images/2.jpg" >
            <img src="${pageContext.request.contextPath}/resources/images/2.jpg" style="height:100%;margin: 0; padding: 0"></button>
        <button type="submit" name="image" value="/resources/images/3.jpg" ><img src="${pageContext.request.contextPath}/resources/images/3.jpg"></button>
        <button type="submit" name="image" value="/resources/images/4.png" ><img src="${pageContext.request.contextPath}/resources/images/4.png"></button>
        <button type="submit" name="image" value="/resources/images/5.jpg" ><img src="${pageContext.request.contextPath}/resources/images/5.jpg"></button>

    </form:form>


</div>




</body>
</html>
