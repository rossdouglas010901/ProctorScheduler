<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="com.oultoncollege.util.HTMLFilter"%>
<%@page language="java" import="com.oultoncollege.util.DateTimeConverter"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:useBean id="table" scope="session" class="com.oultoncollege.model.DailySchedule" />
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" scope="request" value="Schedule"/>
<%-- 
<%
    table.loadAppointments(request);
    if (table.getProcessError() == false) {
%>
<jsp:include page="head.jsp"></jsp:include>
<%
    String time = HTMLFilter.filter(request.getParameter("time"));
    String date = table.getDate();

    String timeInput = DateTimeConverter.padDateTime(time) + ":00";
    String dateInput = HTMLFilter.filter(date);
%>
<form class="scheduleForm" method="POST" action="<%=request.getContextPath()%>/appointment">
    <fieldset>
        <legend>Schedule an Event</legend>
        <ul class="wrapper">
            <li class="form-row">
                <label for="title">Title</label>
                <input type="text" id="title" name="title"/>
            </li>
            <li class="form-row">
                <label for="date">Date</label>
                <input type="date" name="date" value="<%=dateInput%>" required="required"
                       pattern="(?:19|20)[0-9]{2}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])-(?:30))|(?:(?:0[13578]|1[02])-31))" />
            </li>
            <li class="form-row">
                <label for="startTime">Start Time</label>
                <input type="time" name="startTime" value="<%=timeInput%>" required="required"
                       pattern="(0[0-9]|1[0-9]|2[0-3])(:[0-5][0-9]){2}(AM|PM)" />
            </li>
            <li class="form-row">
                <label for="endTime">End Time</label>
                <input type="time" name="endTime" value="<%=timeInput%>" required="required"
                       pattern="(0[0-9]|1[0-9]|2[0-3])(:[0-5][0-9]){2}(AM|PM)" />
            </li>
            <li class="form-row">
                <label for="appointmentType">Appointment Type</label>
                <select id="appointmentType" name="appointmentType">
                    <option value="3">Scribe</option>
                    <option value="1">Reader</option>
                    <option value="2">Proctor</option>
                </select>
            </li>
            <li class="form-row">
                <label for="student">Number Of Students</label>
                <input type="number" step="1" min="0" id="student" name="student" />
            </li>
            <li class="form-row">
                <label for="description">Event Description</label>
                <textarea id="description" name="description" placeholder="Description of Event..." autofocus="autofocus"></textarea>
            </li>
            <li class="form-row">
                <label for="location">Location</label>
                <input type="text" id="location" name="location"/>
            </li>
        </ul>
        <div>
            <input type="submit" class="submit" value="Schedule Now" />
        </div>
    </fieldset>
</form>
<jsp:include page="footer.jsp"></jsp:include>
<%
} else {
%>
<jsp:include page="error.jsp"></jsp:include>
<%
    }
%>
--%>
<c:choose>
  <c:when test="${table.processError}">
    <jsp:include page="error.jsp"></jsp:include>
  </c:when>
  
  <c:otherwise>
    <jsp:include page="head.jsp"></jsp:include>
    <%
        String time = HTMLFilter.filter(request.getParameter("time"));
        String date = table.getDate();

        String timeInput = DateTimeConverter.padDateTime(time) + ":00";
        String dateInput = HTMLFilter.filter(date);
    %>
    <form class="scheduleForm" method="POST" action="<%=request.getContextPath()%>/appointment">
        <fieldset>
            <legend>Schedule an Event</legend>
            <ul class="wrapper">
	            <li class="form-row">
	                <label for="title">Title</label>
	                <input type="text" id="title" name="title"/>
	            </li>
                <li class="form-row">
                    <label for="date">Date</label>
                    <input type="date" name="date" value="<%=dateInput%>" required="required"
                           pattern="(?:19|20)[0-9]{2}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])-(?:30))|(?:(?:0[13578]|1[02])-31))" />
                </li>
                <li class="form-row">
                    <label for="startTime">Start Time</label>
                    <input type="time" name="startTime" value="<%=timeInput%>" required="required" step="3600"
                           pattern="(0[0-9]|1[0-9]|2[0-3])(:[0-5][0-9]){2}(AM|PM)" />
                </li>
                <li class="form-row">
                    <label for="endTime">End Time</label>
                    <input type="time" name="endTime" value="<%=timeInput%>" required="required" step="3600"
                           pattern="(0[0-9]|1[0-9]|2[0-3])(:[0-5][0-9]){2}(AM|PM)" />
                </li>
                <li class="form-row">
                    <label for="appointmentType">Appointment Type</label>
                    <select id="appointmentType" name="appointmentType">
                        <option value="3">Scribe</option>
                        <option value="1">Reader</option>
                        <option value="2">Proctor</option>
                    </select>
                </li>
                <li class="form-row">
                    <label for="program">Program</label>
                    <select id="program" name="program">
                        <option value="1">Business Management and Entrepreneurship</option>
                        <option value="2">Medical Office Administration</option>
                        <option value="3">Paralegal/Legal Assistant</option>
                        <option value="4">Sales, Marketing and Business Development</option>
                        <option value="5">Travel and Hospitality</option>
                        <option value="6">Dental Assistant</option>
                        <option value="7">Dental Hygiene</option>
                        <option value="8">Medical Laboratory Assistant</option>
                        <option value="9">Medical Laboratory Technology</option>
                        <option value="10">Optician</option>
                        <option value="12">Practical Nurse</option>
                        <option value="13">Primary Care Paramedic</option>
                        <option value="14">Veterinary Assistant</option>
                        <option value="15">Veterinary Technician</option>
                        <option value="16">Child and Youth Care</option>
                        <option value="17">Early Childhood Education / Educational Assistant</option>
                        <option value="18">Human Services Counselor</option>
                        <option value="19">Policing and Corrections Foundation</option>
                        <option value="20">Web and Mobile Development</option>
                        <option value="21">Systems Management and Cybersecurity</option>
                        <option value="22">Academic Upgrading</option>
                        <option value="23">Employee Training</option>
                    </select>
                </li>
                <li class="form-row">
                    <label for="course">Course</label>
                    <input type="text" id="course" name="course" />
                </li>
                <li class="form-row">
                    <label for="student">Student</label>
                    <input type="text" id="student" name="student" />
                </li>
                <li class="form-row">
                    <label for="description">Event Description</label>
                    <textarea id="description" name="description" placeholder="Description of Event..." autofocus="autofocus"></textarea>
                </li>
                <li class="form-row">
                    <label for="location">Location</label>
                    <input type="text" id="location" name="location"/>
                </li>
            </ul>
            <hr/>
            <div>
                <input type="submit" class="submit" value="Schedule Now" />
            </div>
        </fieldset>
    </form>
    <br/>
    <br/>
    <jsp:include page="footer.jsp"></jsp:include>
  </c:otherwise>
</c:choose>
