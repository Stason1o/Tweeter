<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Tweet Message</title>
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
                        <li><a href="/profile"><span class="glyphicon glyphicon-user"></span> ${user.firstName}</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="/login"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                        <li class="drop-down">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown">
                                    <span class="glyphicon glyphicon-question-sign">
                                        <span class="caret">
                                        </span>
                                    </span>
                            </a>
                            <ul class="inverse-dropdown dropdown-menu">
                                <li><a href=""><span class="glyphicon glyphicon-info-sign"></span> About</a></li>
                                <li class="divider"></li>
                                <li><a href="/logout"><span class="glyphicon glyphicon-log-out"></span> Log Out</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>

            </div>
        </div>
    </nav>
    <!-- ##Navigation Bar## -->

    <!-- Content -->
    <div class="col-sm-3"></div>
    <div class="col-sm-6">
        <form:form method="post" modelAttribute="editTweet">
            <div class="row nested-title">
                <%--need to delete tweet_id--%>
                Edit tweet { ${editTweet.id} }
            </div>
            <div class="row nested-textarea">
                <form:textarea path="content" />
            </div>
            <div class="row nested-buttons">
                <div class="col-sm-8"></div>
                <div class="col-sm-4">
                    <button type="submit" class="btn btn-success">Tweet</button>
                    <a href="<c:url value='/tweetPage/${idtw}' />" class="btn btn-danger">Cancel</a>
                </div>
            </div>
        </form:form>
    </div>
    <div class="col-sm-3"></div>
    <!-- ##Content## -->

</body>
</html>
