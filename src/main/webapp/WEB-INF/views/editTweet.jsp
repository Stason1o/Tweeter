<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: sbogdanschi
  Date: 4/05/2017
  Time: 7:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Tweet Message</title>
</head>
<body>

${editTweet.id}
<%--${editedTweet}--%>
<form:form method="post" modelAttribute="editTweet">
    <form:label path="content">Enter tweet content</form:label>
    <form:input path="content" /><br>

    <input type="submit" value="Submit" />
</form:form>
</body>
</html>
