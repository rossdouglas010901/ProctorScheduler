<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page isELIgnored="false"%>
<%@page language="java" import="java.sql.SQLException"%>
<%@page language="java" import="com.oultoncollege.db.DatabaseConnection"%>
<%@page language="java" import="com.oultoncollege.db.UserDAO"%>
<%@page language="java" import="com.oultoncollege.model.User"%>
<%@page language="java" import="com.oultoncollege.util.PreventXSS"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="app" value="${pageContext.request.contextPath}" />
<%
// TODO: this scriptlet should be migrated to a View that forwards to the JSP/JSTL  
User user = new User();
String id = PreventXSS.filter(request.getParameter("id"));
if (null != id && !id.isEmpty()) {
	int userID = Integer.parseInt(id);	
	try {
	    DatabaseConnection db = new DatabaseConnection();
	    UserDAO userManager = new UserDAO(db.getConnection());
	    user = userManager.getUserByID(userID);
	    request.setAttribute("currentUser", user);
	} catch (ClassNotFoundException | SQLException ex) {
	    ex.printStackTrace();
	}
} 
%>
<jsp:include page="/head.jsp"></jsp:include>
  <%-- flexbox split view --%>
  <div id="main" class="flex-container">    
    <div id="edit" class="flex-item">
   	<%-- FORM1 -- View, Add, Edit and Remove --%>
        <form id="form1" name="form1" method="post" action="${app}/${empty param.id ? 'addUser' : 'editUser'}">
          <fieldset>
           <legend title="Create, Read, Update or Delete">Manage User</legend>
           	  <input type="hidden" id="userID" name="userID" value="${param.id ? '' : currentUser.userID}" />
              <label for="email">Email: </label>
              <input type="email" name="email" id="email" class="field" required="required"
              		 value="${empty param.id ? '' : currentUser.email}" 
              		 placeholder="Email address of the new user" title="Please enter a valid Email address" />
              <label for="password">Password: </label>
              <input type="password" name="password" id="password" class="field" minlength="8" maxlength="40" required="required"
                    title="Must contain at least 8 Characters (including UpperCase, LowerCase, Number, Special Character like !@#$%^&*-_)" 
              		pattern="(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$" />
              <label for="passwordConfirmation">Re-type Password: </label>
              <input type="password" name="passwordConfirmation" id="password1" class="field" 
               		title="Must match the first Password as typed"  
                    onblur="if(this.value !== document.getElementById('password').value) { alert('Password entries must match!'); }" />
              <label for="firstName">First Name: </label>
              <input type="text" name="firstname" id="firstname" class="field" 
                  required="required" 
                  maxlength="35" 
                  value="${empty currentUser ? '' : currentUser.firstName}"
                  placeholder=" "
                  title="Please fill out this field"
                  pattern="^[a-zA-ZàâèêéëîïôùûüçÀÂÈÊÉËÎÏÔÙÛÜÇ\.\s\-]{1,35}$"
                  data-error-message="Please enter a valid first name (given name)" 
                  oninvalid="setCustomValidity(this.getAttribute('data-error-message'));" 
                  onchange="setCustomValidity('');" />
              <label for="lastName">Last Name: </label>
                  <input type="text" name="lastname" id="lastname" class="field" 
                      required="required" 
                      maxlength="35"
                      value="${empty currentUser ? '' : currentUser.lastName}" 
                      placeholder=" "
                      title="Please fill out this field"
                      pattern="^[a-zA-ZàâèêéëîïôùûüçÀÂÈÊÉËÎÏÔÙÛÜÇ\.\s\-]{1,35}$"
                      data-error-message="Please enter a valid last name (family name)" 
                      oninvalid="setCustomValidity(this.getAttribute('data-error-message'));" 
                      onchange="setCustomValidity('');" />
              <label for="phoneNumber">Phone Number: </label>
                  <input type="tel" name="phoneNumber" id="phoneNumber" class="field" 
                      required="required" 
                      minlength="7" 
                      maxlength="18" 
                      value="${empty currentUser ? '' : currentUser.phoneNumber}"
                      placeholder=" "
                      title="Please fill out this field"
                      pattern="^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$"
                      data-error-message="Please enter a valid Phone Number in the requested format: '+99 (999) 999-9999'" 
                      oninvalid="setCustomValidity(this.getAttribute('data-error-message'));" 
                      onchange="setCustomValidity('');" />
                  <input type="number" name="phoneExtension" id="ext" class="field" 
                  	minlength="0" 
                  	maxlength="4"
                  	title="Extension (optional)"
                  	placeholder="Ext."
                  	value="${empty currentUser || empty currentUser.phoneExt ? '' : currentUser.phoneExt}" 
                  	/>
              <a href="tel:${currentUser.phoneNumber}${currentUser.phoneExt}">Call now</a>
              <label>Account Type: </label>
                  <select name="accountType" id="accountType" class="field">
                      <option value="1" ${currentUser.accountTypeID == 1 ? 'selected' : ''}>Admin</option>
                      <option value="2" ${currentUser.accountTypeID == 2 ? 'selected' : ''}>Instructor</option>
                      <option value="3" ${currentUser.accountTypeID == 3 ? 'selected' : ''}>Proctor</option>
                      <option value="4" ${currentUser.accountTypeID == 4 ? 'selected' : ''}>Student</option>
                    </select>
              <hr/>
              <input type="submit" name="Submit" value="submit" />
              <input type="reset" name="reset" value="reset" />
        </fieldset>
      </form>
    </div>
    <hr/>
    <div id="searchForm" class="flex-item">
	    <%-- FORM2 -- Search for Users (for now overloading this MVC but could make AJAX call to a dedicated UserSearchServlet) --%>
	    <form name="form2" action="${app}/users" method="GET">
	        <input type="search" id="q" name="q" onkeyup="filterSearchResults(this);" placeholder="Jane Doe" autofocus="autofocus" title="Search by a User's first and/or last name" />
	    </form>
	    <%-- Result Table of all Users matching search (returns all users by default --%>
	    <div>
	        <ul id="results">
              <%-- Using JSTL forEach to loop through and output a list, displaying items in table --%>
              <c:forEach items="${requestScope.userList}" var="user">
                <li> 
                    <a href="${app}/users?id=${user.userID}">
	                    <c:out value="${user.firstName}" />&nbsp;
	                    <c:out value="${user.lastName}" /> 
	                     <span class="users-userEmail"> - <span class="users-userEmailData">${user.email}</span></span>
	                    &nbsp;&nbsp; 
                    </a>	                    
                </li>
              </c:forEach>
	        </ul>
	    </div>
    </div>
  </div>
<jsp:include page="/footer.jsp"></jsp:include>
