<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin </title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        <%@include file="/resources/css/style.css"%>
    </style>
</head>
<body>

<c:set var="roleUser" value="false"/>
<c:set var="roleAdmin" value="false"/>
<c:set var="roleModerator" value="false"/>
<c:url var="addAction" value="/admin"/>
<form:form action="${addAction}" commandName="listUsers">
    <div class="row">
        <c:forEach items="${listUsers}" var="user">
            <c:if test="${user.username != username}" >
                <div class="col-md-10 col-md-offset-2">
                    <p>
                        <a href="<c:url value="/userProfile/${user.username}"/>">${user.username} ${user.firstName} ${user.lastName} ${user.email}</a>
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
                        <c:choose>
                            <c:when test="${roleAdmin eq false}">
                                <button class="btn btn-success" type="submit" name="adminRole" value="${user.id}">Add Admin Role</button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-danger" type="submit" name="adminRole" value="${user.id}">Remove Admin Role</button>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${roleModerator eq false}">
                                <button class="btn btn-success" type="submit" name="moderatorRole" value="${user.id}">Add Moderator Role</button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-danger" type="submit" name="moderatorRole" value="${user.id}">Remove Moderator Role</button>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${roleUser eq false}">
                                <button class="btn btn-success" type="submit" name="userRole" value="${user.id}">Add User Role</button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-danger" type="submit" name="userRole" value="${user.id}">Remove User Role</button>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${user.enabled == true}">
                                <button class="btn btn-warning" type="submit" name="userBanUnban" value="${user.id}">Ban</button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-success" type="submit" name="userBanUnban" value="${user.id}">UnBan</button>
                            </c:otherwise>
                        </c:choose>
                        <button class="btn btn-primary" type="submit" name="userToDelete" value="${user.id}">Delete</button>
                    </p>
                </div>
            </c:if>
            <c:set var="roleUser" value="false"/>
            <c:set var="roleAdmin" value="false"/>
            <c:set var="roleModerator" value="false"/>
        </c:forEach>
    </div>
</form:form>
<p>admin page; ${username}</p>

<a href="<c:url value="/logout" />">Logout</a>

<!--Content goes here-->
<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>
