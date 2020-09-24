<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Appointments - Search Page</title>
    <!-- Designers and CascadingStyleSheet specialists only need to look at the rendered page and modify the CSS file(s) -->
    <link rel="stylesheet" type="text/css" href="../css/main.css" />
</head>
<body>
  <%-- Java and Full-stack developers can help bridge the gap between Java-backend code and xHTML or HTML5 output modified to meet needs of Web Devs (these format of JSP/JSTL/JSF comments won't render on the web) --%>
  <div id="main">
    <div>
        <table>
            <tbody>
                <tr>
                    <th>ID</th><th>Title</th><th>Desc</th><th>Location</th><th>Start</th><th>End</th>
                </tr>
                <%-- Using JSTL forEach to loop through and output a list, displaying items in table --%>
                <c:forEach items="${requestScope.appointmentList}" var="appointment">
                <tr>
                    <td><c:out value="${appointment.appointmentID}"></c:out></td>
                    <td><c:out value="${appointment.title}"></c:out></td>
                    <td><c:out value="${appointment.description}"></c:out></td>
                    <td><c:out value="${appointment.location}"></c:out></td>
                    <td><c:out value="${appointment.startTime}"></c:out></td>
                    <td><c:out value="${appointment.endTime}"></c:out></td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <hr/>
    <%-- c:url example --%>
    <a href="<c:url value="${requestScope.url}"></c:url>">Home</a>
  </div>
  <!-- Web Developers and JavaScript/Front-end specialists only need to look at the rendered page and modify the JS file(s) -->
  <script type="text/javascript" src="../javascript/fontawesome.min.js"></script>
</body>
</html>
