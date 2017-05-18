<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Search Results</title>
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
                        <li><a id="homePageNavBar" href="/main/1"><span class="glyphicon glyphicon-home"></span> Home</a></li>
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

    <!-- Content -->
    <div class="container-fluid">
        <c:url var="addAction" value="/followFriends"/>
        <c:set var="contains" value="false"/>
        <c:url var="findPage" value="/globalSearch"/>

        <div class="col-lg-6 col-sm-6">
            <div class="col-lg-6 col-sm-6"></div>
            <div class="col-lg-6 col-sm-6">
                <form:form commandName="user" action="${findPage}">

                    <%--<form:form name="searchUser" action="/followFriend/{searchUser}" method="post">--%>

                    <h3 class="form-heading">Search</h3><hr>
                    <div class="field input-group">
                        <span class="input-group-addon" id="user-icon">
                            <span class="glyphicon glyphicon-user"></span>
                        </span>
                        <form:input id="username" name="username" path="username" class="form-control"
                        placeholder="lazy_username" required="" autofocus="" aria-describedby="user-icon"/>
                    </div>
                    <br>
                    <button class="btn btn-success" type="submit">Search</button>

                </form:form>
            </div>
        </div>

        <div class="col-lg-6 col-sm-6">
            <div class="col-lg-6 col-sm-6">
                <h3 class="form-heading">Results</h3><hr>
                <c:forEach var="user" items="${listUsers}">
                    <div class="row user-wrapper" onclick="location.href='<c:url value="/userProfile/${user.username}"/>'">

                        <div class="col-lg-4 col-sm-4">
                                <a href="#">
                                    <img class="media-object" src="" alt="user-image">
                                </a>
                        </div>

                        <div class="col-lg-8 col-sm-8 user-content-info">
                            <div class="">
                                <p>Name: ${user.firstName}</p>
                                <p>Surname: ${user.lastName}</p>
                            </div>

                            <div class="col-lg-6 col-sm-6"></div>

                            <div class="col-lg-6 col-sm-6">
                                <form:form action="${addAction}" commandName="listUsers">
                                    <c:forEach items="${loggedUser.followedUsers}" var="followedUser">
                                        <c:if test="${user.id == followedUser.id}">
                                            <c:set value="true" var="contains"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${contains eq true}">
                                            <button class="btn btn-warning pull-right" type="submit"
                                                    name="unfollowedFriend" value="${user.id}">UnFollow</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button class="btn btn-success pull-right" type="submit" name="followedFriend"
                                                    value="${user.id}">Follow</button>
                                        </c:otherwise>
                                    </c:choose>
                                </form:form>
                            </div>
                        </div>

                    </div>
                </c:forEach>
            </div>


            <div class="col-lg-6 col-sm-6"></div>
              <div style="float: right">
                <c:url var="addAction" value="/followFriends"/>
                <form:form action="${addAction}" commandName="listUnfollowedUsers">

                    <c:forEach items="${listUnfollowedUsers}" var="unfollowedUser">
                        <p>
                            <a href="<c:url value="/userProfile/${unfollowedUser.username}"/>">
                                    ${unfollowedUser.firstName}   ${unfollowedUser.lastName} ${unfollowedUser.id}
                            </a>
                            <button class="btn btn-success" type="submit" name="followedFriend" value="${unfollowedUser.id}">Follow</button>
                        </p>
                        <br>
                    </c:forEach>

                </form:form>
            </div>

            <div class="col-sm-6"></div>


        </div>
    </div>
    <!-- ##Content## -->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
