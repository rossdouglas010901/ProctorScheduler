<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page isELIgnored="false"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.oultoncollege.util.HTMLFilter"%>
<%@page import="com.oultoncollege.util.DateTimeConverter"%>
<%@page import="com.oultoncollege.db.DatabaseConnection"%>
<%@page import="com.oultoncollege.db.AppointmentDAO"%>
<%@page import="com.oultoncollege.model.Appointment"%>
<%@page import="com.oultoncollege.util.PreventXSS"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="pageName" scope="request" value="Schedule" />
<c:set var="app" value="${pageContext.request.contextPath}" />
<jsp:useBean id="table" scope="session" class="com.oultoncollege.model.DailySchedule" />
<%
    Appointment appointment = new Appointment();
    String id = PreventXSS.filter(request.getParameter("id"));
    if (null != id && !id.isEmpty()) {
        int apptID = Integer.parseInt(id);
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection connection = db.getConnection();
            AppointmentDAO appointmentManager = new AppointmentDAO(connection);
            appointment = appointmentManager.getAppointmentByID(apptID);
            request.setAttribute("currentAppt", appointment);
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
<c:choose>
    <c:when test="${table.processError}">
        <jsp:include page="error.jsp"></jsp:include>
    </c:when>
    <c:otherwise>
        <jsp:include page="head.jsp"></jsp:include>
        <c:set var="dateInput" scope="page" value="${HTMLFilter.filter(param.date)}" />
        <c:set var="time" scope="page" value="${HTMLFilter.filter(param.time)}" />
        <c:set var="timeInput" scope="page" value="${DateTimeConverter.padExpandTime(time)}" />
        <c:if test="${not empty currentAppt}">
            <c:set var="appointmentStart" value="${fn:split(currentAppt.startTime,' ')[1]}" />
            <c:set var="appointmentEnd" value="${fn:split(currentAppt.endTime,' ')[1]}" />
        </c:if>
        <form class="scheduleForm" method="POST" action="${app}/${empty param.id ? 'addAppointment' : 'editAppointment'}">
            <fieldset>
                <legend>Schedule an Event</legend>
                <ul class="wrapper">
                    <li class="form-row">
                        <label for="title">Title</label>
                        <input type="text" id="title" name="title" minlength="6" maxlength="50" required="required"
                               value="${empty currentAppt ? '' : currentAppt.title}" 
                               title="Summary of the Appointment (exam, test, certification, etc)" />
                    </li>
                    <li class="form-row">
                        <label for="date">Date</label>
                        <input type="date" name="date" required="required"
                               value="${empty currentAppt ? dateInput : fn:split(currentAppt.startTime,' ')[0]}" 
                               title="Date the Appointment will take place"
                               pattern="(?:19|20)[0-9]{2}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-9])|(?:(?!02)(?:0[1-9]|1[0-2])-(?:30))|(?:(?:0[13578]|1[02])-31))" />
                    </li>
                    <li class="form-row">
                        <label for="startTime">Start Time</label>
                        <input type="time" name="startTime" step="3600" required="required"
                               value="${empty currentAppt ? timeInput : DateTimeConverter.convertSqlTimeTextToMilitary(appointmentStart)}" 
                               title="Start Time of the Appointment (UP key increases, DOWN decreases)"
                               pattern="(0[0-9]|1[0-9]|2[0-3])(:[0-5][0-9]){2}(AM|PM)" />
                    </li>
                    <li class="form-row">
                        <label for="endTime">End Time</label>
                        <input type="time" name="endTime" step="3600" required="required"
                               value="${empty currentAppt ? timeInput :  DateTimeConverter.convertSqlTimeTextToMilitary(appointmentEnd)}" 
                               title="End Time of the Appointment (UP key increases, DOWN decreases)"
                               pattern="(0[0-9]|1[0-9]|2[0-3])(:[0-5][0-9]){2}(AM|PM)" />
                    </li>
                    <li class="form-row">
                        <label for="appointmentType">Type</label>
                        <select id="appointmentType" name="appointmentType">
                            <option value="1" ${currentAppt.appointmentTypeID == 1 ? 'selected' : ''}>Proctoring</option>
                            <option value="2" ${currentAppt.appointmentTypeID == 2 ? 'selected' : ''}>Reading</option>
                            <option value="3" ${currentAppt.appointmentTypeID == 3 ? 'selected' : ''}>Scribing</option>
                        </select>
                    </li>
                    <li class="form-row">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" minlength="1" maxlength="250" placeholder="Description of Event..." autofocus="autofocus">${empty currentAppt ? '' : currentAppt.description}</textarea>
                    </li>
                    <li class="form-row">
                        <label for="location">Location</label>
                        <input type="text" id="location" name="location" list="locations" autocomplete="off"  
                               value="${empty currentAppt ? '' : currentAppt.location}"
                               pattern="^(\d+).*?((?:[a-z](?:[a-z]|[^\S\r\n])+)).*?((?:Alley|ALY|Anex|ANX|Arcade|ARC|Avenue|AVE|Bayou|BYU|Beach|BCH|Bend|BND|Bluff|BLF|Bluffs|BLFS|Bottom|BTM|Boulevard|BLVD|Branch|BR|Bridge|BRG|Brook|BRK|Brooks|BRKS|Burg|BG|Burgs|BGS|Bypass|BYP|Camp|CP|Canyon|CYN|Cape|CPE|Causeway|CSWY|Center|CTR|Centers|CTRS|Circle|CIR|Circles|CIRS|Cliff|CLF|Cliffs|CLFS|Club|CLB|Common|CMN|Commons|CMNS|Corner|COR|Corners|CORS|Course|CRSE|Court|CT|Courts|CTS|Cove|CV|Coves|CVS|Creek|CRK|Crescent|CRES|Crest|CRST|Crossing|XING|Crossroad|XRD|Crossroads|XRDS|Curve|CURV|Dale|DL|Dam|DM|Divide|DV|Drive|DR|Drives|DRS|Estate|EST|Estates|ESTS|Expressway|EXPY|Extension|EXT|Extensions|EXTS|Fall|FALL|Falls|FLS|Ferry|FRY|Field|FLD|Fields|FLDS|Flat|FLT|Flats|FLTS|Ford|FRD|Fords|FRDS|Forest|FRST|Forge|FRG|Forges|FRGS|Fork|FRK|Forks|FRKS|Fort|FT|Freeway|FWY|Garden|GDN|Gardens|GDNS|Gateway|GTWY|Glen|GLN|Glens|GLNS|Green|GRN|Greens|GRNS|Grove|GRV|Groves|GRVS|Harbor|HBR|Harbors|HBRS|Haven|HVN|Heights|HTS|Highway|HWY|Hill|HL|Hills|HLS|Hollow|HOLW|Inlet|INLT|Island|IS|Islands|ISS|Isle|ISLE|Junction|JCT|Junctions|JCTS|Key|KY|Keys|KYS|Knoll|KNL|Knolls|KNLS|Lake|LK|Lakes|LKS|Land|LAND|Landing|LNDG|Lane|LN|Light|LGT|Lights|LGTS|Loaf|LF|Lock|LCK|Locks|LCKS|Lodge|LDG|Loop|LOOP|Mall|MALL|Manor|MNR|Manors|MNRS|Meadow|MDW|Meadows|MDWS|Mews|MEWS|Mill|ML|Mills|MLS|Mission|MSN|Motorway|MTWY|Mount|MT|Mountain|MTN|Mountains|MTNS|Neck|NCK|Orchard|ORCH|Oval|OVAL|Overpass|OPAS|Park|PARK|Parks|PARK|Parkway|PKWY|Pass|PASS|Passage|PSGE|Path|PATH|Pike|PIKE|Pine|PNE|Pines|PNES|Place|PL|Plain|PLN|Plains|PLNS|Plaza|PLZ|Point|PT|Points|PTS|Port|PRT|Ports|PRTS|Prairie|PR|Radial|RADL|Ramp|RAMP|Ranch|RNCH|Rapid|RPD|Rapids|RPDS|Rest|RST|Ridge|RDG|Ridges|RDGS|River|RIV|Road|RD|Roads|RDS|Route|RTE|Row|ROW|Rue|RUE|Run|RUN|Shoal|SHL|Shoals|SHLS|Shore|SHR|Shores|SHRS|Skyway|SKWY|Spring|SPG|Springs|SPGS|Spur|SPUR|Spurs|SPUR|Square|SQ|Squares|SQS|Station|STA|Stravenue|STRA|Stream|STRM|Street|ST|Streets|STS|Summit|SMT|Terrace|TER|Throughway|TRWY|Trace|TRCE|Track|TRAK|Trafficway|TRFY|Trail|TRL|Trailer|TRLR|Tunnel|TUNL|Turnpike|TPKE|Underpass|UPAS|Union|UN|Unions|UNS|Valley|VLY|Valleys|VLYS|Viaduct|VIA|View|VW|Views|VWS|Village|VLG|Villages|VLGS|Ville|VL|Vista|VIS|Walk|WALK|Walks|WALK|Wall|WALL|Way|WAY|Ways|WAYS|Well|WL|Wells|WLS)).*?((?:[a-z](?:[a-z]|[^\S\r\n])+)((?:AB|BC|NB|NL|NS|NT|NU|ON|PE|QC|SK|YT)).*?).*?(,) ([A-Z][0-9][A-Z] [0-9][A-Z][0-9]) (\|) [-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$"
                               title="Pick Location from list using DOWN key on your keyboard, or, add a new Geo-location" />
                        <datalist id="locations">
                            <option value="4 Flanders CT. Moncton NB, E1C 0K6 | 46.0881061,-64.7912451">4 Flanders CT. Moncton NB, E1C 0K6</option>
                            <option value="5 Pacific AVE. Moncton NB, E1E 1A1 | 46.0886411,-64.7991117">5 Pacific AVE. Moncton NB, E1E 1A1</option>
                            <option value="100 Cameron ST. Moncton NB, E1C 5Y6 | 46.0881061,-64.7912451">100 Cameron ST. Moncton NB, E1C 5Y6</option>
                        </datalist>
                    </li>
                    <li class="form-row">
                        <label for="studentCount">Student Count</label>
                        <input type="number" id="studentCount" name="studentCount" min="1" max="100" required="required" 
                               pattern="[1-9]+[0-9]{1,2}"
                               value="${empty currentAppt ? '' : currentAppt.studentCount}"
                               title="Number of students requiring Proctoring (UP key increases, DOWN decreases)" />
                    </li>
                    <li class="form-row">
                        <label for="course">Program/Course</label>
                        <select id="course" name="course" title="Program and/or Course area of study (defaults to N/A as usually won't matter)">
                            <option value="1" ${currentAppt.courseID == 1 ? 'selected' : ''}>N/A</option>
                            <optgroup label="Business">
                                <option value="2" ${currentAppt.courseID == 2 ? 'selected' : ''}>Business Management and Entrepreneurship</option>
                                <option value="3" ${currentAppt.courseID == 3 ? 'selected' : ''}>Medical Office Administration</option>
                                <option value="4" ${currentAppt.courseID == 4 ? 'selected' : ''}>Paralegal/Legal Assistant</option>
                                <option value="5" ${currentAppt.courseID == 5 ? 'selected' : ''}>Sales, Marketing and Business Development</option>
                                <option value="6" ${currentAppt.courseID == 6 ? 'selected' : ''}>Travel and Hospitality</option>
                            </optgroup>
                            <optgroup label="Health Sciences">
                                <option value="7" ${currentAppt.courseID == 7 ? 'selected' : ''}>Dental Assistant</option>
                                <option value="8" ${currentAppt.courseID == 8 ? 'selected' : ''}>Dental Hygiene</option>
                                <option value="9" ${currentAppt.courseID == 9 ? 'selected' : ''}>Medical Laboratory Assistant</option>
                                <option value="10" ${currentAppt.courseID == 10 ? 'selected' : ''}>Medical Laboratory Technology</option>
                                <option value="11" ${currentAppt.courseID == 11 ? 'selected' : ''}>Optician</option>
                                <option value="12" ${currentAppt.courseID == 12 ? 'selected' : ''}>Practical Nurse</option>
                                <option value="13" ${currentAppt.courseID == 13 ? 'selected' : ''}>Primary Care Paramedic</option>
                                <option value="14" ${currentAppt.courseID == 14 ? 'selected' : ''}>Veterinary Assistant</option>
                                <option value="15" ${currentAppt.courseID == 15 ? 'selected' : ''}>Veterinary Technician</option>
                            </optgroup>
                            <optgroup label="Human Services">
                                <option value="16" ${currentAppt.courseID == 16 ? 'selected' : ''}>Child and Youth Care</option>
                                <option value="17" ${currentAppt.courseID == 17 ? 'selected' : ''}>Early Childhood Education / Educational Assistant</option>
                                <option value="18" ${currentAppt.courseID == 18 ? 'selected' : ''}>Human Services Counselor</option>
                                <option value="19" ${currentAppt.courseID == 19 ? 'selected' : ''}>Policing and Corrections Foundation</option>
                            </optgroup>
                            <optgroup label="Information Technology">
                                <option value="20" ${currentAppt.courseID == 20 ? 'selected' : ''}>Web and Mobile Development</option>
                                <option value="21" ${currentAppt.courseID == 21 ? 'selected' : ''}>Systems Management and Cybersecurity</option>
                            </optgroup>
                            <optgroup label="Academic Upgrades &amp; Certifications">
                                <option value="22" ${currentAppt.courseID == 22 ? 'selected' : ''}>Academic Upgrading</option>
                                <option value="23" ${currentAppt.courseID == 23 ? 'selected' : ''}>Employee Training</option>
                            </optgroup>
                        </select>
                    </li>
                </ul>
                <%-- "id" used for passing "appointmentID" on existing appoinments (otherwise defaults to "0" and uses PRIMARY KEY's AUTO NUM) --%>
                <input type="hidden" id="id" name="id" value="${param.id}" />
                <%-- "proctorID" used to update existing Appointments when non-default proctor is already selected... default "proctorID", hardcoded for every request since we assume don't know Proctor at time of Appointment creation (default will be used to indicate its still available for proctoring) --%>
                <input type="hidden" id="proctorID" name="proctorID" value="${not empty param.proctorID ? param.proctorID : '1'}" />                
                <hr/>
                <div>
                    <input type="submit" class="button" value="${empty param.id ? 'Schedule Now' : 'Update Appointment'}" />
                </div>
            </fieldset>
        </form>
        <jsp:include page="footer.jsp"></jsp:include>
    </c:otherwise>
</c:choose>
