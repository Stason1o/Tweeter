<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<spring:htmlEscape defaultHtmlEscape="true" />
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile Edit</title>
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
    <div class="container-fluid" id="main-content">
        <div class="row">
            <div class="col-md-3">
                <c:url var="addAction" value="/profile"/>
                <form:form action="${addAction}" commandName="user">

                <h2 class="form-profile-heading">Profile</h2>

                    <p><img src="${pageContext.request.contextPath}${user.image}" width="75%" align="center" vspace="5%" hspace="11%"></p>
                    <a href="<c:url value='/avatar/${user.id}' />" class="btn btn-success btn-block">Change Avatar</a>
                <br>

                <h2 class="form-profile-heading">Profile</h2>
                <form:label path="firstName">First Name</form:label>

                <form:input type="hidden" id="id" value="${user.id}" name="id" path="id"/>

                    <form:label path="firstName">First Name</form:label>

                    <form:input id="firstName" name="firstName" path="firstName" class="form-control"
                                 required="" autofocus=""/>
                    <form:errors path="firstName"/>
                <br>

                <form:label path="lastName">Last Name</form:label>
                    <form:input id="lastName" name="lastName" path="lastName" class="form-control"
                                required="" autofocus=""/>
                    <form:errors path="lastName"/>
                <br>

                <%--<form:label path="username">Username</form:label>--%>
                    <form:input type="hidden" id="username" name="username" path="username" class="form-control"
                                required="" autofocus=""/>
                    <%--<form:errors path="username"/>--%>
                <%--<br>--%>

                <%--<form:label path="password">Password</form:label>--%>
                    <form:input type="hidden" id="password" name="password" path="password" class="form-control"
                                required="" autofocus=""/>
                    <%--<form:errors path="password"/>--%>
                <%--<br>--%>

                    <form:input type="hidden" id="confirmPassword" value="${user.password}" name="confirmPassword" path="confirmPassword" />
                <%--<br>--%>

                <%--<form:label path="email">Email</form:label>--%>
                    <form:input type="hidden" id="email" name="email" path="email" class="form-control"
                                required="" autofocus=""/>
                    <%--<form:input type="hidden" id="tweets" name="tweets" path="tweets" class="form-control"--%>
                                <%--required="" autofocus=""/>--%>
                    <%--<form:input type="hidden" id="followedUsers" name="followedUsers" path="followedUsers" class="form-control"--%>
                                <%--required="" autofocus=""/>--%>
                    <%--<form:errors path="email"/>--%>
                <%--<br>--%>

                <form:input type="hidden" id="enabled" value="1" name="enabled" path="enabled"/>

                <%--<c:if test="${!empty user.id}">--%>

                <%--<form:input type="hidden" id="oldEmail" value="${user.oldEmail}" name="oldEmail" path="oldEmail" />--%>
                <%--<br>--%>


                <input type="submit" class="btn btn-success" value="Save" />
                <a href="<c:url value='/profile' />" class="btn btn-danger">Cancel</a>
                </form:form>

                <p></p>
            </div>

            <div class="col-md-6">
                <!-- HERE GOES USER'S TWEETS -->
                <div class="tweets">
                    <c:forEach items="${user.tweets}" var="userTweets" >
                        <p><c:out value=" ${userTweets.content} ${userTweets.date} ${userTweets.user.username}"/></p>
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
