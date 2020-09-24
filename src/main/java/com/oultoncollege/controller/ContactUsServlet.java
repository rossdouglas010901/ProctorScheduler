package com.oultoncollege.controller;

import com.oultoncollege.util.SendGridEmail;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.oultoncollege.util.PreventXSS;
/**
 * LogoutServlet.java Logs out the currently active User by invalidating their Session.
 *
 * @author Liu Youfeng
 * @author bcopeland
 */
@WebServlet("/contact")
public class ContactUsServlet extends HttpServlet {

    private static final long serialVersionUID = 23182742L;
    
    //TODO: this should be loaded from the database... assuming only one person set to ADMIN
    private static final String ADMIN_EMAIL = "";
    
    private static final String CONFIRMATION_TITLE = "Confirmation of Proctoring Request sent.";
    
    private final static String[] HIDDEN_FIELDS = {"CampusID", "FormToken", "request"};
    private final static String XSRF_TOKEN = "6af64553-f46d-49b4-a7b7-feb369b8c048";
    private boolean valid;
    
    public static final String DOCTYPE = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
    public StringBuilder html = new StringBuilder("");

    
    public static String headWithTitleAndBody(String title) {
        return (DOCTYPE + "\n"
                + "<html>\n"
                + "<head><title>" + title + "</title></head>\n"
                + "<body bgcolor=\"#FDF5E6\">\n");
    }
    
    public static String bodyClose() {
    	return ("</body></html>");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext appContext = getServletContext();
        String app = appContext.getContextPath();

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        html.insert(0, headWithTitleAndBody(CONFIRMATION_TITLE));
        html.append("<h1 align=\"center\">" + CONFIRMATION_TITLE + "</h1>\n");
        html.append("<table border=\"1\" align=\"center\">\n");
        html.append("<tr bgcolor=\"#FFAD00\">\n");
        html.append("<th>Field</th><th>Entered Value(s)</th>");
        
        Enumeration paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = (String) paramNames.nextElement();
            if (Arrays.stream(HIDDEN_FIELDS).anyMatch(paramName::equals)) {
        		//process Token to confirm security/authenticity of posted FORM prior to sending Email request
            	String paramValue = PreventXSS.filter(request.getParameterValues(paramName)[0]);
            	valid = (paramName.equals("FormToken") && paramValue.equals(XSRF_TOKEN)) ? true : false;
            } else {
	            html.append("<tr><td>" + paramName + "\n<td>");
	            String[] paramValues = request.getParameterValues(paramName);
	            if (paramValues.length == 1) {
	                String paramValue = paramValues[0];
	                if (paramValue.length() == 0) {
	                    html.append("<em>No Value</em>");
	                } else {
	                    html.append(paramValue);
	                }
	            } else {
	                html.append("<ul>");
	                for (int i = 0; i < paramValues.length; i++) {
	                    html.append("<li>" + paramValues[i]);
	                }
	                html.append("</ul>");
	            }
            } 
        }
        html.append("</table>\n");
        html.append(bodyClose());
/* DEBUG *
         out.println(html);
 * DEBUG */
        
        // send email via "SendGrid" (can also use JavaMail via Campus mail server, or public options like Gmail, Outlook/Hotmail, Yahoo Mail, Apple iCloud, Mailinator, etc)
        SendGridEmail.sendMessage(PreventXSS.filter(request.getParameter("Email")), ADMIN_EMAIL, "Request for Proctoring", html.toString());
        
        // redirect to Confirmation page
        String destination = "confirm.jsp";
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(destination);
        html.delete(0, headWithTitleAndBody(CONFIRMATION_TITLE).length());
        html.delete(html.length()-bodyClose().length(), html.length());
        request.setAttribute("confirmation", html);
        html = new StringBuilder(""); //reset HTML to avoid duplicates if user hits refresh in quick succession
        requestDispatcher.forward(request, response);
    }
}
