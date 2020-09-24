<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" scope="request" value="Proctor Request confirmation" />
<jsp:include page="head.jsp"></jsp:include>
<c:choose>
  <c:when test="${error}">
	<jsp:include page="error.jsp"></jsp:include>
  </c:when>
  <c:otherwise>
	<%-- Output a confirmation of the data which got Emailed to Teacher(s) / System Adminstrator(s) for Proctor request --%>
	<div id="confirmation">
		${confirmation}
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
  </c:otherwise>
</c:choose>
