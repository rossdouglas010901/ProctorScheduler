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
  <div id="main">
   	<%-- FORM1 -- View, Add, Edit and Remove --%>
        <form id="form1" name="form1" method="post" action="${app} }/addUser">
          <fieldset>
           <legend title="Create, Read, Update or Delete">Manage Appointment</legend>
		      
              <input type="submit" name="Submit" value="submit" />
              <input type="reset" name="reset" value="reset" />
        </fieldset>
    </form>
    <hr/>
	<%-- FORM2 -- Search for Users (for now overloading this MVC but could make AJAX call to a dedicated UserSearchServlet) --%>
	<form name="form2" action="${app}/users" method="GET">
	    <input type="search" id="q" name="q" placeholder="Jane Doe" autofocus="autofocus" title="Search by a User's first and/or last name" />
	    <input type="submit" name="Search" value="Search">
	</form>
	<%-- Result Table of all Users matching search (returns all users by default --%>
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
    </div>
  <!-- Web Developers and JavaScript/Front-end specialists only need to look at the rendered page and modify the JS file(s) -->
  <script type="text/javascript" src="../javascript/fontawesome.min.js"></script>
</body>
</html>
