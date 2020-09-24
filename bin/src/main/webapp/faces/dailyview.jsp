<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>Redirect</title>
</head>
<body>
    <%
        String redirectURL = "../dailyview.jsp";
        response.sendRedirect(redirectURL);
    %>
</body>
</html>