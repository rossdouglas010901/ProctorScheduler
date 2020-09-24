<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="app" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Proctor Scheduler - Wrong Login Info</title>
        <link rel="shortcut icon" href="images/favicon.ico" />
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,900&display=swap" rel="stylesheet" />
        <link rel="shortcut icon" href="images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="styles/main.css" />
        <link rel="stylesheet" type="text/css" href="styles/head.css" />
        <link rel="stylesheet" type="text/css" href="styles/google-fonts.css" /> 
    </head>
    <body>
        <div class="errorMessage">
            <h2>Uh Oh!</h2>
            <c:choose>
				<c:when test="${not empty badCredentials}">
				   <%-- must come first in conditions --%>
		  	        <p>Wrong username or password, Please try again</p>
		  	        <button onclick="window.location.href = '${app}/login.jsp';">Try Again</button>
                </c:when>
                <c:when test="${empty sessionScope.loggedInUserFullname}">
                    <p>Looks like you are not logged in properly, you may wish to contact the Proctor Scheduler tool administrator</p>
                    <button onclick="window.location.href = '${app}/login.jsp';">Try Logging In Again</button>
                </c:when>
                <c:when test="${not empty sessionScope.loggedInUserFullname}">
                    <p>"${sessionScope.loggedInUserEmail}" no longer has a valid session</p>
                    <button onclick="window.location.href = '${app}/login.jsp';">Log back in</button>
                </c:when>
                <c:otherwise>
                    <p>An error occurred, try returning to the Calendar (if this error persists, please <a href="mailto:proctor-scheduler@oultoncollege.com">contact your system administrator</a>)</p>
                    <button onclick="window.location.href = '${app}/login.jsp';">Try Logging in again</button>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
