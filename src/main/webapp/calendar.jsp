<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page isELIgnored="false"%>
<%@page language="java" import="com.oultoncollege.model.DailySchedule"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:useBean id="table" scope="session" class="com.oultoncollege.model.DailySchedule" />
<c:set var="pageName" scope="request" value="Calendar" />
<% table.loadAppointments(request); %>
<jsp:include page="head.jsp"></jsp:include>
<c:choose>
  <c:when test="${table.processError}">
	<jsp:include page="error.jsp"></jsp:include>
  </c:when>
  <c:otherwise>
	<%-- Calendar "Component" will get rendered by JavaScript --%>
	<div id="calendar">
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
  </c:otherwise>
</c:choose>
