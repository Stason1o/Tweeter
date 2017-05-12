<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Profile</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
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
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li><a href=""><span class="glyphicon glyphicon-user"></span> $Username</a></li>
                        <li><a
                                href=""><span
                                class="glyphicon glyphicon-question-sign"><span class="caret"></span></span></a></li>
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
                <c:url var="addAction" value="/myProfile"/>
                <form:form action="${addAction}" commandName="user">

                <h2 class="form-profile-heading">Profile</h2>
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

                <form:label path="username">Username</form:label>
                    <form:input id="username" name="username" path="username" class="form-control"
                                required="" autofocus=""/>
                    <form:errors path="username"/>
                <br>

                <form:label path="password">Password</form:label>
                    <form:input type="password" id="password" name="password" path="password" class="form-control"
                                required="" autofocus=""/>
                    <form:errors path="password"/>
                <br>

                    <form:input type="hidden" id="confirmPassword" value="${user.password}" name="confirmPassword" path="confirmPassword" />
                <br>

                <form:label path="email">Email</form:label>
                    <form:input type="email" id="email" name="email" path="email" class="form-control"
                                required="" autofocus=""/>
                    <form:errors path="email"/>
                <br>

                <form:input type="hidden" id="enabled" value="1" name="enabled" path="enabled"/>

                <c:if test="${!empty user.id}">

                <input type="submit" class="btn btn-success"
                       value="<spring:message text="Edit user"/>"/>
                </c:if>
                <input type="submit" class="btn btn-success" value="Submit" />
                </form:form>

                <a href="<c:url value='/edit/${user.id}' />">Edit</a>
                <a href="<c:url value='/delete/${user.id}' />">Delete</a>

                <c:forEach items="${user.tweets}" var="userTweets" >
                <p>${userTweets.content} ${userTweets.date} ${userTweets.user.username}</p>
                </c:forEach>

                <p></p>
            </div>
        </div>
        <div class="col-md-4">
            <!-- HERE GOES USER'S TWEETS -->
        </div>

        <div class="col-md-3">
            <!-- HERE GOES USER'S FRIENDS -->
        </div>
    <!-- ##Content## -->

    <!--REST OF THE CONTENT GOES HERE. BEFORE <script> tags-->
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="<c:url value="/resources/js/script.js" />"></script>
</body>
</html>
