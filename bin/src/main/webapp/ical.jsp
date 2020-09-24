<%@page language="java" contentType="text/calendar; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
   response.setHeader("Content-Disposition", "attachment; filename=appointment.ics"); 
%>
<%-- Using JSTL forEach to loop through and output a list, displaying items in table --%>
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//hacksw/handcal//NONSGML v1.0//EN
BEGIN:VEVENT
<%-- Teacher Email --%>
UID:${user.email}
<%-- later next line should be  ${appointment.lastUpdated} --%>
DTSTAMP:${appointment.startTime}
<%--                                                   Proctor Email --%>
ORGANIZER;CN=${user.lastName} ${user.firstName}:MAILTO:${user.email}
<%-- example of dates for DTSTART and DTEND:  19970714T170000Z --%>
DTSTART:${appointment.startTime}
DTEND:${appointment.endTime}
SUMMARY:${appointment.description}
<%-- hardcoded to Moncton Lat/Lon for now, later could retrieve depending on building selection --%>
GEO:46.11594;-64.80186
END:VEVENT
END:VCALENDAR