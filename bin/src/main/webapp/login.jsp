<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
    login.jsp
        Login form allowing user to enter credentials for checking validity and access roles 
        (based on AccountType) against current user list.
    @since 2020-01-24
    @author bcopeland
--%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>Proctor Scheduler - Login</title>
        <link rel="shortcut icon" href="images/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="styles/google-fonts.css" />
        <link rel="stylesheet" type="text/css" href="styles/login.css" />
    </head>
    <body>
        <form name="form" action="<%=request.getContextPath()%>/login" method="post">
           <h2>Proctor Scheduler - Login</h2>
           <input type="email" id="email" name="email" class="field" placeholder="Username" autofocus="autofocus"
                   required="required" 
                   maxlength="65" 
                   placeholder=" "
                   title="Please fill out this field"
                   pattern="^[_A-Za-zàâèêéëîïôùûüçÀÂÈÊÉËÎÏÔÙÛÜÇ0-9-+]+(.[_A-Za-zàâèêéëîïôùûüçÀÂÈÊÉËÎÏÔÙÛÜÇ0-9-]+)*@[A-Za-zàâèêéëîïôùûüçÀÂÈÊÉËÎÏÔÙÛÜÇ0-9-]+(.[A-Za-zàâèêéëîïôùûüçÀÂÈÊÉËÎÏÔÙÛÜÇ0-9]+)*\.([A-Za-zàâèêéëîïôùûüçÀÂÈÊÉËÎÏÔÙÛÜÇ]{2,})$" 
                   data-error-message="Please enter a valid email address" 
                   oninvalid="setCustomValidity(this.getAttribute('data-error-message'));" 
                   onchange="setCustomValidity('');" />
           <input type="password" id="password" name="password" class="field" placeholder="Password" />
           <br><br><span class="error"><%=(request.getAttribute("errMessage") == null) ? "" : request.getAttribute("errMessage")%></span><br>
           <input type="hidden" name="name" placeholder="Name" value="GUEST" /> 
           <input class="submit" type="submit" class="button" value="Login" /> 
        </form>
    </body>
</html>