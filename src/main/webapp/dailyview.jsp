<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page isELIgnored="false"%>
<%@page language="java" import="java.util.List"%>
<%@page language="java" import="java.sql.SQLException"%>
<%@page language="java" import="com.oultoncollege.db.DatabaseConnection"%>
<%@page language="java" import="com.oultoncollege.db.UserDAO"%>
<%@page language="java" import="com.oultoncollege.model.User"%>
<%@page language="java" import="com.oultoncollege.model.Appointment"%>
<%@page language="java" import="com.oultoncollege.model.Entry"%>
<%@page language="java" import="com.oultoncollege.model.Entries"%>
<%@page language="java" import="com.oultoncollege.model.DailySchedule"%>
<%@page language="java" import="com.oultoncollege.util.DateTimeConverter"%>
<%@page language="java" import="com.oultoncollege.util.HTMLFilter"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<jsp:useBean id="table" scope="session" class="com.oultoncollege.model.DailySchedule" />
<c:set var="pageName" scope="request" value="Daily View" />
<c:set var="app" value="${pageContext.request.contextPath}" />
<%
    //DB appointments
    List<Appointment> appointments = table.loadAppointments(request);
    request.setAttribute("appointments", appointments);

    //available timeslots
    Entries entries = table.getEntries();
    request.setAttribute("entries", entries);
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
                <div class="left">
                    <a href="dailyview.jsp?date=prev"><i class="fas fa-chevron-left"></i></a>
                    <span id="date">${table.date}</span>
                    <a href="dailyview.jsp?date=next"><i class="fas fa-chevron-right"></i></a>
                </div>
                <div class="right">
                    <a href="#" id="timeslotViewIcon" title="Timeslot View"><i class="fas fa-grip-vertical"></i></a>
                    <a href="#" id="appointmentViewIcon" title="Appointment View"><i class="fas fa-list-ul"></i></a>
                </div>
            </div>
            <div class="clear">&nbsp;</div>
            <!-- Time-based sequential view (for days with lots of events) -->
            <div id="timeslotView">
                <table class="scheduleBody">
                    <tr>
                        <th class="scheduleSubtitles scheduleSubtitle1">Time</th>
                        <th class="scheduleSubtitles scheduleSubtitle2">Appointment</th>
                    </tr>
                </table>
                <div class="appointments">
                    <div class="timeslots">
                        <%-- Timeslots View - JSTL loop through available timeslots --%>
                        <c:forEach var="i" begin="0" end="${entries.rows - 1}">
                            <c:set var="entr" scope="request" value="${entries.getEntry(i)}" />	
                            <div class="scheduleHour"> <span><a href="${app}/schedule.jsp?date=${table.date}&time=${entr.hourValue}">${entr.hour}</a></span> </div>
                            <div> :30 </div>
                        </c:forEach>
                    </div>
                    <div class="days" id="appointments">
                    </div>
                </div>
            </div>
            <!-- main Appointment listing table -->
            <div id="appointmentView" class="hide">
                <%-- Appointment View - JSTL loop through appointments today --%>
                <ul>
                    <c:choose>
                        <c:when test="${fn:length(appointments) < 1}">
                            <li>No events scheduled yet...</li>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="appointment" items="${appointments}">
                                    <c:set var="appointmentStart" value="${fn:split(appointment.startTime,' ')[1]}" />
                                    <c:set var="appointmentEnd" value="${fn:split(appointment.endTime,' ')[1]}" />
                                <li class="event">
                                    <div class="eventInfo">
                                        <h4>(<span class="timeRange">${DateTimeConverter.convertSqlTimeTextToMilitary(appointmentStart)} - ${DateTimeConverter.convertSqlTimeTextToMilitary(appointmentEnd)}</span>) <span class="appointmentTitle">${appointment.title}</span></h4>
                                        <p>${appointment.description}</p>
                                        <c:if test="${appointment.proctorID == sessionScope.loggedInUserID}">
                                            <a class="ical" href="${app}/ical?id=${appointment.appointmentID}&proctorEmail=${loggedInUserEmail}" title="Download an iCalendar reminder"><i class="far fa-calendar-alt"></i> iCal reminder</a>
                                        </c:if>
                                    </div>
                                    <div class="eventOptions">
                                        <c:choose>
                                            <c:when test="${appointment.proctorID == 1}">
												<%-- Not reserved yet (default ADMIN user set as proctorID) --%>
                                                <c:url var="params" value="#">
                                                    <c:param name="id" value="${appointment.appointmentID}" />
                                                    <c:param name="proctorEmail" value="${loggedInUserEmail}" />
                                                    <c:param name="action" value="reserve" />
                                                </c:url>
                                                <%-- TODO replace "onclick" with external "addEventListener" in corresponding "dailyview.js" --%>
                                                <a class="eventOptionsReserve" href="#reserve" 
                                                   data-appointment-params="${fn:replace(params,'#','')}" 
                                                   data-appointment-title="${appointment.title}" 
                                                   title="Reserve Appointment (with yourself as the Proctor)">
                                                    Reserve <span class="eventText">Event</span>
                                                    <i class="fas fa-check"></i>
                                                </a>
                                            </c:when>
                                            <c:when test="${appointment.proctorID == sessionScope.loggedInUserID}">
												<%-- This user is the Proctor --%>
                                                <c:url var="params" value="#">
                                                    <c:param name="id" value="${appointment.appointmentID}" />
                                                    <c:param name="proctorEmail" value="${loggedInUserEmail}" />
                                                    <c:param name="action" value="release" />
                                                </c:url>
                                                <%-- TODO replace "onclick" with external "addEventListener" in corresponding "dailyview.js" --%>
                                                <a class="eventOptionsRelease" href="#release"
                                                   data-appointment-params="${fn:replace(params,'#','')}" 
                                                   data-appointment-title="${appointment.title}" 
                                                   title="Release your Proctoring reservation back to Calendar">
                                                    Release <span class="eventText">Proctored Event</span> 
                                                    <i class="far fa-calendar-times"></i>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
												<%-- Another user is the Proctor so retrieve their name --%>
                                                <c:set var="proctorID" value="${appointment.proctorID}" />
                                                <%
                                                    // TODO: this scriptlet should be migrated to a custom JSTL TagLib that looks up a User by ID or Email and returns a full User object usable by JSTL  
                                                    User user = new User();
                                                    String id = pageContext.getAttribute("proctorID").toString();
                                                    if (null != id && !id.isEmpty()) {
                                                        int userID = Integer.parseInt(id);
                                                        try {
                                                            DatabaseConnection db = new DatabaseConnection();
                                                            UserDAO userManager = new UserDAO(db.getConnection());
                                                            user = userManager.getUserByID(userID);
                                                            pageContext.setAttribute("proctorName", user.getFirstName() + " " + user.getLastName());
                                                        } catch (ClassNotFoundException | SQLException ex) {
                                                            ex.printStackTrace();
                                                        }
                                                    }
                                                %>
                                                Proctor: <span id="proctorName" title="Proctor reserving this event">${proctorName}</span>
                                            </c:otherwise>
                                        </c:choose>
                                        <br/>
                                        <br/>
                                        <a class="eventOptionsEdit" href="${app}/schedule.jsp?id=${appointment.appointmentID}#edit" title="Edit Appointment">
                                            Edit <span class="eventText">Event</span> 
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <br/>
                                        <br/>
                                        <a class="eventOptionsDelete" href="#delete" 
                                           data-appointment-params="?id=${appointment.appointmentID}" 
                                           data-appointment-title="${appointment.title}" 
                                           title="Delete Appointment">
                                            Delete <span class="eventText">Event</span> 
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div> 
                                </li>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <button class="button" onclick="document.location = '${app}/schedule.jsp?date=${table.date}&amp;time=8'"><i class="fas fa-plus"></i> Add New</button>
            </div>
        </div>
        <%-- FOOTER --%>
        <jsp:include page="footer.jsp"></jsp:include>
    </c:otherwise>
</c:choose>
