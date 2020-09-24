<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="com.oultoncollege.model.DailySchedule"%>
<jsp:useBean id="table" scope="session" class="com.oultoncollege.model.DailySchedule" />
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" scope="request" value="Calendar"/>
<%
    table.loadAppointments(request);
    if (table.getProcessError() == false) {
%>
<title>ProctorScheduler - Calendar</title>
<jsp:include page="head.jsp"></jsp:include>

<%-- Calendar "Component" will get rendered by JavaScript --%>
<div id="calendar"></div>

<div id="appointmentThisMonth">

</div>


<jsp:include page="footer.jsp"></jsp:include>
<script defer="defer">
/*********************************************************/
/* initialize calendar                                   */
/*********************************************************/
var year = '<%= request.getParameter("year") %>';
var month = '<%= request.getParameter("month") %>';
if (isEmpty(year) || isEmpty(month)) {
    setCal(); //display current Year/Month
} else {
    setCal(year, month);
}
</script>
<script src="javascript/calendar.js"></script>
<script src="javascript/tableCell.js"></script>
<%
    } else {
%>
<jsp:include page="error.jsp"></jsp:include>
<%
    }
%>

