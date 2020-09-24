<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" scope="session" value="Calendar"/>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <link rel="stylesheet" type="text/css" href="styles/google-fonts.css" />
        <link rel="stylesheet" type="text/css" href="styles/head.css" />
        <link rel="stylesheet" type="text/css" href="styles/main.css" />           
        <script src="javascript/fontawesome.min.js" crossorigin="anonymous"></script>
        <title> Proctor Scheduler - <c:out value = "${pageName}"/></title>
        <link rel="shortcut icon" href="images/favicon.ico" />
    </head>
    <body>
        <header class="topnav">
            <div id="headerNavigation">
                <h3> &nbsp;&nbsp; <a href="javascript:history.go(-1);"><i class="fas fa-chevron-left"></i>
                <span id="pageTitle"><img class="logo" src="images/oulton-college.png" alt="Oulton College" /> ProctorScheduler</span></a></h3>
            </div>
            <div id="headerAccount">
            <c:if test = "${pageName != 'Calendar'}">
                <a href="calendar.jsp"><i class="far fa-calendar-alt"></i> Calendar</a> | 
            </c:if>
                
                <a href="./logout"><i class="fas fa-user-lock"></i> Logout</a>               
            </div>
        </header>
        <%-- content START --%>
        <div class="content">
