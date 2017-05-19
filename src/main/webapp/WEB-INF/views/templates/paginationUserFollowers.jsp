<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url var="firstUrlFollow" value="/profile/1/1" />
<%--@elvariable id="deploymentLog" type="java"--%>
<c:url var="lastUrlFollow" value="/profile/${pageTweet}/${deploymentLogFollow}" />
<%--@elvariable id="currentIndex" type="java"--%>
<c:url var="prevUrlFollow" value="/profile/${pageTweet}/${currentIndexFollow - 1}" />
<c:url var="nextUrlFollow" value="/profile/${pageTweet}/${currentIndexFollow + 1}" />
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/pagination.css"%>
    </style>
</head>
<body>
    <div class="row pages">
        <ul class="pagination">
            <c:choose>
                <c:when test="${currentIndexFollow == 1}">
                    <li class="disabled"><a href="#">&lt;&lt;</a></li>
                    <li class="disabled"><a href="#">&lt;</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${firstUrlFollow}">&lt;&lt;</a></li>
                    <li><a href="${prevUrlFollow}">&lt;</a></li>
                </c:otherwise>
            </c:choose>
            <c:forEach var="c" begin="${beginIndexFollow}" end="${endIndexFollow}">
                <c:url var="pageUrlFollow" value="/profile/${pageTweet}/${c}" />
                <c:choose>
                    <c:when test="${c == currentIndexFollow}">
                        <li class="active"><a href="${pageUrlFollow}"><c:out value="${c}" /></a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageUrlFollow}"><c:out value="${c}" /></a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:choose>
                <c:when test="${currentIndexFollow == deploymentLogFollow}">
                    <li class="disabled"><a href="#">&gt;</a></li>
                    <li class="disabled"><a href="#">&gt;&gt;</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${nextUrlFollow}">&gt;</a></li>
                    <li><a href="${lastUrlFollow}">&gt;&gt;</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</body>
</html>