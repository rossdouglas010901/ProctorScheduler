<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Proctor Scheduler - Wrong Login Info</title>
        <link rel="shortcut icon" href="images/favicon.ico" />
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,900&display=swap" rel="stylesheet" />
        <link rel="stylesheet" type="text/css" href="styles/login.css" />
        <link rel="stylesheet" type="text/css" href="styles/main.css" />
    </head>
    <body>
        <div class="errorMessage">
            <h2>Uh Oh!</h2>
            <p>Looks like you are not logged in Properly</p>
            <%--
            <p>"<%= session.getAttribute("loggedInUserFullname") %>" Is not a valid login </p>
            <p>Email: <%= session.getAttribute("loggedInUserEmail") %></p>
            --%>
            <button onclick="window.location.href = '<%=request.getContextPath()%>/login.jsp';">Try Again</button>
        </div>
    </body>
</html>