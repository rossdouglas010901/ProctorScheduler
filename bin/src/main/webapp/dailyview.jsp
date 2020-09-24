<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page isELIgnored="false"%>
<%@page language="java" import="java.util.List"%>
<%@page language="java" import="com.oultoncollege.model.Appointment"%>
<%@page language="java" import="com.oultoncollege.model.Entry"%>
<%@page language="java" import="com.oultoncollege.model.Entries"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:useBean id="table" scope="session" class="com.oultoncollege.model.DailySchedule" />
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" scope="request" value="Dailey View"/>
<%
    //available timeslots
    Entries entries = table.getEntries();
    request.setAttribute("entries", entries);

    //DB appointments
    List<Appointment> appointments = table.loadAppointments(request);
    request.setAttribute("appointments", appointments);
 %>
<%-- Show "DailyView" or the error page --%>
<c:choose>
  <c:when test="${table.processError}">
    <%-- TODO: pass a specific message so the default "invalidCredentials" message isn't shown --%>
    <%-- ERROR page --%>
   <jsp:include page="error.jsp"></jsp:include>
  </c:when>
  <c:otherwise>
    <jsp:include page="head.jsp"></jsp:include>
    <div class="schedule">
        <div class="scheduleHeader">
             <h3>
                <a href="dailyview.jsp?date=prev"><i class="fas fa-chevron-left"></i></a>
                <span id="date" width="100%">${table.getDate()}</span>
                <a href="dailyview.jsp?date=next"><i class="fas fa-chevron-right"></i></a>
            </h3>
        </div>
        <!-- the main table -->
<%-- TODO FOREACH TEST (works on its own without SET and just the one JSP scriptlet to set appointments
<c:set var="appointments" scope="request" value="${table.loadAppointments(request)}" />
<c:forEach var="appointment" items="${appointments}">
    <c:out value="${appointment.title}"/> 
    <c:out value="${appointment.description}"/>
    <c:out value="${appointment.startTime}"/> - <c:out value="${appointment.endTime}"/>
</c:forEach>
--%>
          <%-- JSTL loop through available timeslots --%>
          <c:forEach var="i" begin="0" end="${entries.rows - 1}">
            <c:set var="entr" scope="request" value="${entries.getEntry(i)}" />
                <div class="event">
                    <div class="eventInfo">
                        <h2>${entr.hour} </h2>
                	    <p>${entr.description}
                        </p>
                    </div>
                    <div class="eventOptions">
                        <a class="eventOptionsDelete" href="#" onclick="makeRequest('<%=request.getContextPath()%>/deleteAppointment','?ID=1','DELETE','text/html');" title="Delete Appointment">
                            Delete Event 
                            <i class="far fa-calendar-times"></i>
                        </a><br/><br/>
                        <a class="eventOptionsEdit" href="#">
                            Edit Event 
                            <i class="fas fa-edit"></i>
                        </a><br/><br/>
                        <a class="eventOptionsAccept" href="#">
                            Accept Event 
                            <i class="fas fa-check"></i>
                        </a>
                    </div> 
                </div>     
          </c:forEach>
          <form action="<%=request.getContextPath()%>/schedule.jsp?date=${table.getDate()}">
            <button class="addNewEvent" onclick="<%=request.getContextPath()%>/schedule.jsp?date=${table.getDate()}"> <i class="fas fa-plus"></i> Add New </button>
          </form>
        </div>
        <%-- FOOTER --%>
        <jsp:include page="footer.jsp"></jsp:include>
  </c:otherwise>
</c:choose>
