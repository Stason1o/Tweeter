<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tweet Page</title>
</head>
<body>
    <p>Tweet ID#${tweet.id},
    posted by <b>${tweet.user.username}</b>
    at ${tweet.date}</p> </div>

    <c:choose>
        <c:when test="${tweet.tweet != null}">
            ReTweeted:<div style="border: 4px double black; width: 400px; margin-left: 50px;"><p>Tweet ID#${tweet.tweet.id},
            posted by <b>${tweet.tweet.user.username}</b>
            at ${tweet.tweet.date}</p>
            <p>${tweet.tweet.content}</p></div>
        </c:when>
        <c:otherwise>
            <div><p>${tweet.content}</p></div>
        </c:otherwise>
    </c:choose>

    <br>

    <form:form method="post" modelAttribute="commit">
        <form:label path="content">Enter tweet comment</form:label>
        <form:input path="content" /><br>

        <input type="submit" value="Submit" />
    </form:form>

    <p><b>Comments :</b></p>
    <c:forEach var="commitTweets" items="${commitTweets}">
        <div>
            <p> posted by <b>${commitTweets.user.username}</b>
                at ${commitTweets.date}</p> </div>

        <div><p>${commitTweets.content}</p></div>
    </c:forEach>
</body>
</html>
