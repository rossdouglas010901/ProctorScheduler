<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="com.oultoncollege.util.HTMLFilter"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	<%-- content END --%>
	<br/>
    <br/>
    <br/>
	</div>
	<div class="footer">
       <i class="fas fa-user"></i>
       <span class="userFullname"><c:out value="${HTMLFilter.filter(loggedInUserFullname)}" /></span> :
       <span class="userEmail"><c:out value="${HTMLFilter.filter(loggedInUserEmail)}" /></span>
    </div>
	<%-- JavaScript includes --%>
	<script src="javascript/ajax.js"></script>
	<script src="javascript/calendar.js"></script>
    <script src="javascript/tableCell.js"></script>
	<c:if test = "${fn:contains(pageContext.request.requestURI, 'calendar')}">
		<script defer="defer">
		/*********************************************************/
		/* initialize calendar                                   */
		/*********************************************************/
		var year = '<c:out value="${HTMLFilter.filter(param.year)}" />';
		var month = '<c:out value="${HTMLFilter.filter(param.month)}" />';
		if (isEmpty(year) || isEmpty(month)) {
		    setCal(); //display current Year/Month
		    var now = new Date();
		    year = now.getFullYear();
		    month = now.getMonth();
		} else {
		    setCal(year, month);
		}
	    month++; //normalize month to human-understandable rather than zero-based index
		
		// AJAX call to get daily badges for chosen Month
		var json = makeRequest('./appointment','?start='+year+'-'+numberToString(month)+'-01&end='+year+'-'+numberToString(month)+'-'+getDays(year,(month-1)), 'GET', 'application/json');
		var appointmentsJSON = JSON.parse(json);
			
		// loop to determine rendering of "Daily Appointment Count" Badges
		for (i = 0; i < appointmentsJSON.calendarAppointments.length; i++) {
			if (appointmentsJSON.calendarAppointments[i].appointmentCount > 0) {
				var count = document.createTextNode(appointmentsJSON.calendarAppointments[i].appointmentCount);
				var badge = document.createElement('div');
					badge.setAttribute('class', 'badge');
					badge.setAttribute('title', appointmentsJSON.calendarAppointments[i].appointmentCount + ' events scheduled');
					badge.appendChild(count);
				document.getElementById('day-'+(i+1)).appendChild(badge);	
			}
		}
		</script>
	</c:if>
    <c:if test = "${fn:contains(pageContext.request.requestURI, 'dailyview')}">
      <script src="javascript/dailyview.js"></script>
      <script src="javascript/dateFormatter.js"></script>
    </c:if>
    </body>
</html>
