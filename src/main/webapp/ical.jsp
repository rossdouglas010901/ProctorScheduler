<%@page language="java" contentType="text/calendar; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
   response.setHeader("Content-Disposition", "attachment; filename=appointment.ics");
   String API_KEY = "REAL_KEY_GOES_HERE";
   request.setAttribute("apiKey", API_KEY);
%>
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//ProctorScheduler/appointment//EN
BEGIN:VEVENT
UID:${user.email}<%-- Scheduler's Email (i.e. Teacher, Company, etc) --%>
DTSTAMP:${appointment.startTime}<%-- After adding a "lastUpdated" column to Table, this line should be  ${appointment.lastUpdated} --%>
ORGANIZER;CN=${user.lastName} ${user.firstName}:MAILTO:${user.email}<%-- Proctor Email --%>
DTSTART:${appointment.startTime}<%-- example of dates for DTSTART and DTEND:  19970714T170000Z --%>
DTEND:${appointment.endTime}
SUMMARY:${appointment.title}
LOCATION:${fn:split(appointment.location,' | ')[0]}
GEO:${fn:split(appointment.location,' | ')[1]}
X-ALT-DESC;FMTTYPE=text/html:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN"><HTML><BODY><DIV><P>${appointment.description}</P><HR><TABLE><TR><TH>START</TH><TH>END</TH></TR><TR><TD>${appointment.startTime}</TD><TD>${appointment.endTime}</TD></TR></TABLE><HR><DIV>Map: <BR><A href="https://www.google.com/maps/search/?api=1&amp;query=${fn:split(appointment.location,' | ')[1]}"><IMG src="http://maps.googleapis.com/maps/api/staticmap?center=${fn:split(appointment.location,' | ')[1]}&amp;zoom=11&amp;size=200x200&amp;key=${apiKey}" width="200" height="200" alt="Map"></A></DIV></DIV></BODY></HTML>
STATUS:CONFIRMED
BEGIN:VALARM
ACTION:DISPLAY
TRIGGER;RELATED=START:-PT15M
DESCRIPTION:${appointment.description}
END:VALARM
END:VEVENT
END:VCALENDAR
