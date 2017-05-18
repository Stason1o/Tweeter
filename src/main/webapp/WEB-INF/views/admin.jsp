<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Panel</title>
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
                                        <a href="#">
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
    <c:set var="roleUser" value="false"/>
    <c:set var="roleAdmin" value="false"/>
    <c:set var="roleModerator" value="false"/>
    <c:url var="addAction" value="/admin"/>
    <form:form action="${addAction}" commandName="listUsers">
        <div class="container-fluid">
            <h3>Administration Panel</h3>
            <hr>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <div class="table-responsive">
                        <table class="table table-condensed table-hover">

                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Full name</th>
                                <th>Username</th>
                                <th>E-mail</th>
                                <th>Actions</th>
                            </tr>
                            </thead>

                            <tbody>
                                <c:forEach items="${listUsers}" var="user">
                                    <c:if test="${user.username != username}" >
                                        <c:forEach items="${user.roles}" var="role">
                                            <c:choose>
                                                <c:when test="${role.id == 1}">
                                                    <c:set var="roleAdmin" value="true"/>
                                                </c:when>
                                                <c:when test="${role.id == 3}">
                                                    <c:set var="roleModerator" value="true"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="roleUser" value="true"/>
                                                </c:otherwise>
                                            </c:choose>
                                    <%--*${role.role}--%>
                                        </c:forEach>

                                        <tr>
                                            <td>${user.id}</td>
                                            <td>${user.firstName} ${user.lastName}</td>
                                            <td><a href="<c:url value="/userProfile/${user.username}"/>">${user.username}</a></td>
                                            <td>${user.email}</td>
                                            <td>
                                                <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
                                                        choose <span class="caret"></span>
                                                </button>

                                                <ul class="dropdown-menu">
                                                    <li><a href="#">
                                                        <c:choose>
                                                            <c:when test="${roleAdmin eq false}">
                                                                <button class="btn btn-success" type="submit" name="adminRole" value="${user.id}">Add
                                                                    Admin Role</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-danger" type="submit" name="adminRole" value="${user.id}">Remove Admin Role</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a></li>

                                                    <li><a href="#">
                                                        <c:choose>
                                                            <c:when test="${roleModerator eq false}">
                                                                <button class="btn btn-success" type="submit" name="moderatorRole" value="${user.id}">Add Moderator Role</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-danger" type="submit" name="moderatorRole" value="${user.id}">Remove Moderator Role</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a></li>

                                                    <li><a href="#">
                                                        <c:choose>
                                                            <c:when test="${roleUser eq false}">
                                                                <button class="btn btn-success" type="submit" name="userRole" value="${user.id}">Add User Role</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-danger" type="submit" name="userRole" value="${user.id}">Remove User Role</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a></li>

                                                    <li><a href="#">
                                                        <c:choose>
                                                            <c:when test="${user.enabled == true}">
                                                                <button class="btn btn-warning" type="submit" name="userBanUnban" value="${user.id}">Ban</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button class="btn btn-success" type="submit" name="userBanUnban" value="${user.id}">UnBan</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a></li>

                                                    <li><a href="#">
                                                        <button class="btn btn-primary" type="submit" name="userToDelete" value="${user.id}">Delete</button>
                                                    </a></li>
                                                </ul>
                                            </td>

                                        </tr>

                                    </c:if>
                                    <c:set var="roleUser" value="false"/>
                                    <c:set var="roleAdmin" value="false"/>
                                    <c:set var="roleModerator" value="false"/>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-sm-2"></div>
            </div>
        </div>
    </form:form>
    <!-- ##Content## -->

<%--<p>admin page; ${username}</p>--%>

<%--<a href="<c:url value="/logout" />">Logout</a>--%>

<!--Content goes here-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
