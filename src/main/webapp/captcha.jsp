<%@page import="com.oultoncollege.util.PreventXSS"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.captcha.botdetect.web.servlet.Captcha"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form  method="post">
<%
  // Adding BotDetect Captcha to the page
  Captcha captcha = Captcha.load(request, "exampleCaptcha");
  captcha.setUserInputID("captchaCode");

  String captchaHtml = captcha.getHtml();
  out.write(captchaHtml);
%>

<input id="captchaCode" type="text" name="captchaCode" />
<%
  if ("POST".equalsIgnoreCase(request.getMethod())) {
     // validate the Captcha to check we're not dealing with a bot
     boolean isHuman = captcha.validate(PreventXSS.filter(request.getParameter("captchaCode")));
     if (isHuman) {
     out.write("Human");
     } else {
     out.write("Bot");
     }
  }
%>
</form>
</body>
</html>
