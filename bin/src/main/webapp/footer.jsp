<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="com.oultoncollege.util.HTMLFilter"%>
<%@page language="java" import="com.oultoncollege.model.DailySchedule"%>
<jsp:useBean id="table" scope="session" class="com.oultoncollege.model.DailySchedule" />
<%
    String name = HTMLFilter.filter(""+session.getAttribute("loggedInUserFullname"));
    String email = HTMLFilter.filter(""+session.getAttribute("loggedInUserEmail"));
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<%-- content END --%>
	<br/>
    <br/>
    <br/>
	</div>
	<div class="footer">
	        <i class="fas fa-user"></i> 
            <c:out value="${loggedInUserFullname}" /> :
            <c:out value="${loggedInUserEmail}" />
        </div>
	<%-- JavaScript includes --%>
	<script src="javascript/calendar.js"></script>
	<script src="javascript/ajax.js"></script>
  <script src="javascript/tableCell.js"></script>
        <c:if test = "${fn:contains(pageContext.request.requestURI, 'dailyview')}">
          <script src="javascript/dateFormatter.js"></script>
        </c:if>
    </body>
</html>
