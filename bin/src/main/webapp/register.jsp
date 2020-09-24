<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="table" scope="session" class="com.oultoncollege.model.DailySchedule" />
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" scope="request" value="Registration"/>
<%
    table.loadAppointments(request);
    if (table.getProcessError() == false) {
%>
<jsp:include page="head.jsp"></jsp:include>
        <h2>ProctorScheduler - Account Registration</h2>
    </p>
    <form id="form1" name="form1" method="post" action="<%=request.getContextPath()%>/user">
        <table width="340" border="0" align="center">
            <tr>
                <td width="141">Email</td>
                <td width="189">
                    <label>
                        <input type="text" name="email" id="email" value="<%=request.getParameterValues("email")%>" />
                    </label>
                </td>
            </tr>
            <tr>
                <td>Password:</td>
                <td>
                    <label>
                        <input type="password" name="password" id="password" />
                    </label>
                </td>
            </tr>
            <tr>
                <td>Retype Password</td>
                <td>
                    <label> 
                        <input type="password" name="password1" id="password1" 
                            onblur="if(this.value !== document.getElementById('password').value) { alert('Password entries must match!'); }" />
                    </label>
                </td>
            </tr>
            <tr>
                <td>First Name:</td>
                <td>
                    <label>
                        <input type="text" name="firstname" id="firstname"
                            required="required" 
                            maxlength="35" 
                            placeholder=" "
                            title="Please fill out this field"
                            pattern="^[a-zA-ZàâèêéëîïôùûüçÀÂÈÊÉËÎÏÔÙÛÜÇ\.\s\-]{1,35}$"
                            data-error-message="Please enter a valid first name (given name)" 
                            oninvalid="setCustomValidity(this.getAttribute('data-error-message'));" 
                            onchange="setCustomValidity('');" />
                    </label>
                </td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td>
                    <label>
                        <input type="text" name="lastname" id="lastname"
                            required="required" 
                            maxlength="35" 
                            placeholder=" "
                            title="Please fill out this field"
                            pattern="^[a-zA-ZàâèêéëîïôùûüçÀÂÈÊÉËÎÏÔÙÛÜÇ\.\s\-]{1,35}$"
                            data-error-message="Please enter a valid last name (family name)" 
                            oninvalid="setCustomValidity(this.getAttribute('data-error-message'));" 
                            onchange="setCustomValidity('');" />
                    </label>
                </td>
            </tr>
            <tr>
                <td>Phone Number:</td>
                <td>
                    <label>
                        <input type="tel" name="phoneNumber" id="phoneNumber" 
                            required="required" 
                            minlength="7" 
                            maxlength="18" 
                            placeholder=" "
                            title="Please fill out this field"
                            pattern="^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})$"
                            data-error-message="Please enter a valid Phone Number in the requested format: '+99 (999) 999-9999'" 
                            oninvalid="setCustomValidity(this.getAttribute('data-error-message'));" 
                            onchange="setCustomValidity('');"
                            />
                    </label>
                </td>
            </tr>
            <tr>
                <td>Phone Extension (OPTIONAL):</td>
                <td>
                    <label>
                        <input type="number" name="phoneExtension" id="ext" />
                    </label>
                </td>
            </tr>
            <tr>
                <td>Account Type:</td>
                <td>
                    <label>
                        <select name="accounttype" id="accounttype">
                            <option value="1">Admin</option>
                            <option value="2">Teacher</option>
                            <option value="3">Proctor</option>
                            <option value="4">Student</option>
                          </select>
                    </label>
                </td>
            </tr>
            <tr>
                <td><label><input type="submit" name="Submit" value="submit" /></label></td>
                <td><label><input type="reset" name="reset" value="reset" /></label></td>
            </tr>
        </table>
    </form>
<jsp:include page="footer.jsp"></jsp:include>
<%
    } else {
%>
<jsp:include page="error.jsp"></jsp:include>
<%
    }
%>
