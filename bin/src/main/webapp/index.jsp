<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="sessionUsername" scope="session" value="${sessionScope.loggedInUserEmail}" />
<c:choose>
    <c:when test="${not empty sessionUsername && sessionUsername ne 'null'}">
        <c:redirect url = "calendar.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:forward page="login.jsp" />
    </c:otherwise>
</c:choose>
