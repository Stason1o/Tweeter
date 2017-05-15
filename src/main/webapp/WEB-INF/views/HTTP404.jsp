<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Error 404: Page Not Found</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/errors.css"%>
    </style>
</head>
<body>
<div class="container-fluid" id="main-content">
    <div class="row one">
        <div class="col-md-2"></div>
        <div class="col-md-4">
            <div id="error">HTTP ERROR</div>
            <div id="error-no">404</div>
        </div>
        <div class="divider-vertical"></div>
        <%--<div class="col-md-2">--%>
        <%--<!--vertical delimiter sexy one-->--%>
        <%----%>
        <%--</div>--%>
        <div class="col-md-4">
            <div id="error-type">Page Not Found</div>
            <div id="error-msg">The page you are searching doesn't exist on this server!</div>

            <%--ERROR 403 - Forbidden: Access is denied.--%>
            <%--You don't have permission to access {page} on this server.--%>
            <%--Sorry, but the page you are looking for was either not found or does not exist.--%>
            <%--Try refreshing the page or click the button below to go back to the Homepage.--%>

        </div>
        <div class="col-md-2"></div>
    </div>
    <div class="row two">
        <ul class="list-inline text-center text-sm">
            <li class="list-inline-item"><a class="text-muted">GO</a></li>
            <li class="list-inline-item"><a href="/login" class="text-muted">Home</a></li>
            <li class="list-inline-item"><a href="/registration" class="text-muted">Register</a></li>
        </ul>
        <div class="text-center">
            <span class="glyphicon glyphicon-copyright-mark"></span>
            <span>2017</span>
            <span>-</span>
            <span>ENDAVA. LazyCats Team.</span>
        </div>
    </div>
</div>

</body>
</html>
