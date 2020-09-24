package com.oultoncollege.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oultoncollege.db.AppointmentDAO;
import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.db.UserDAO;
import com.oultoncollege.model.Appointment;
import com.oultoncollege.model.User;
import com.oultoncollege.util.DateTimeConverter;
import com.oultoncollege.util.PreventXSS;

/**
 * Servlet implementation class EditAppointmentServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/editAppointment"})
public class EditAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = -4858213416089845576L;
    
    private static final int ADMIN_USER_ID = 1; //the AccountID to use when an Event is not assigned for Proctoring yet
    private static final int PROCTOR_ACCOUNT_TYPE = 3;

    private String date = "";
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditAppointmentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int appointmentID = Integer.parseInt(PreventXSS.filter(request.getParameter("id")));
        String proctorID = PreventXSS.filter(request.getParameter("proctorID"));
        String proctorEmail = PreventXSS.filter(request.getParameter("proctorEmail")).replace("%40", "@").replace("&#64;", "@");
        String action = PreventXSS.filter(request.getParameter("action"));

        User proctorUser = null;
        
        String statusMessage = "";
        int statusCode = 0;
        // edit existing Appointment in Database
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConnection();
//TODO: likely need to switch to "j_security_check" to ensure proper role assignment
/*
            if (request.getUserPrincipal() != null && request.getRemoteUser() != null
                    && (request.getUserPrincipal().getName().equals("admin")
                    || request.getUserPrincipal().getName().equals("proctor")
                    || request.getUserPrincipal().getName().equals("teacher"))) {
             */
            if ((proctorID == null || proctorID.isEmpty()) && (proctorEmail == null || proctorEmail.isEmpty())) {
                // TODO: later probably want a failure reason HTTP status code or dedicated Error message
                statusMessage = "failed (Email and ID missing or invalid details passed)";
                statusCode = HttpURLConnection.HTTP_BAD_REQUEST;
            } else if (proctorID != null && !proctorID.isEmpty()) {
                // lookup this Proctor to ensure validity
                UserDAO userManager = new UserDAO(conn);
                proctorUser = userManager.getUserByID(Integer.parseInt(proctorID));            	
            } else {
                // lookup this Proctor to ensure validity
                UserDAO userManager = new UserDAO(conn);
                proctorUser = userManager.getUserByEmail(proctorEmail);
            }

// TODO: should have a proper DB lookup on "account_type" Table to find "Proctor" role's AccountTypeID instead of hardcoding roles 1-3 (Admin,Teacher,Proctor) as valid range... others could be Alumni, Student, ProspectiveStudent, Guest, etc...
            if (proctorUser != null && proctorUser.getAccountTypeID() <= PROCTOR_ACCOUNT_TYPE) {
                // update the Appointment's Proctor Identifier reference to formally Reserve
                AppointmentDAO appointmentManager = new AppointmentDAO(db.getConnection());
                Appointment appointment = appointmentManager.getAppointmentByID(appointmentID);

                if (action.equalsIgnoreCase("release")) {
                    appointment.setProctorID(ADMIN_USER_ID); //reset the Event back into the pool by re-assigning the default Account
                    appointmentManager.updateAppointment(appointment); //update the Appointment in the DB
                } else if (action.equalsIgnoreCase("reserve")) {
                    appointment.setProctorID(proctorUser.getUserID()); //set the Event to the passed-in UserID (if they are the ones logged-in)
                    appointmentManager.updateAppointment(appointment); //update the Appointment in the DB                	
                } else {
                	String title = PreventXSS.filter(request.getParameter("title"));
                	date = PreventXSS.filter(request.getParameter("date"));
                	if (date == null || date.equals("")) {
                		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Date today = new Date();
                        date = dateFormat.format(today);
                	}
                    String start = request.getParameter("startTime");
                    Timestamp startTime = DateTimeConverter.convertDateTimeTextToSQL(date + " " + start + ":00");
                    String end = request.getParameter("endTime");
                    Timestamp endTime = DateTimeConverter.convertDateTimeTextToSQL(date + " " + end + ":00");
                	String description = PreventXSS.filter(request.getParameter("description"));
                	description = description.replaceAll("[^A-Za-z0-9\n]|\n(?!(([^\"]*\"){2})*[^\"]*$)", "<br />");
                	String location = PreventXSS.filter(request.getParameter("location"));
                	int studentCount = Integer.parseInt(PreventXSS.filter(request.getParameter("studentCount")));
                	int courseID = Integer.parseInt(PreventXSS.filter(request.getParameter("course")));
                	int appointmentTypeID = Integer.parseInt(PreventXSS.filter(request.getParameter("appointmentType")));
                	
                	appointment.setTitle(title);
                	appointment.setStartTime(startTime);
                	appointment.setEndTime(endTime);
                	appointment.setDescription(description);
                	appointment.setLocation(location);
                	appointment.setStudentCount(studentCount);
                	appointment.setCourseID(courseID);
                	appointment.setAppointmentTypeID(appointmentTypeID);
                	
                	appointmentManager.updateAppointment(appointment); //update the Appointment in the DB
                }
                statusMessage = "succeeded";
                statusCode = HttpURLConnection.HTTP_OK;
            } else {
                statusMessage = "failed (User or ID invalid)";
                statusCode = HttpURLConnection.HTTP_FORBIDDEN;
            }
            /*
        } else {
            statusMessage = "unauthorized";
            statusCode = HttpURLConnection.HTTP_UNAUTHORIZED;
        }
             */
            db.cleanupConnection(conn);
        } catch (SQLException | ClassNotFoundException | URISyntaxException ex) {
            ex.printStackTrace();
            statusMessage = "failed (SQL exception)";
            statusCode = HttpURLConnection.HTTP_INTERNAL_ERROR;
        }

        PrintWriter out = response.getWriter();

        response.setStatus(statusCode);

        if (request.getContentType()
                != null) {
            switch (request.getContentType().toLowerCase()) {
                case "text/json":
                case "application/json":
                    response.setContentType("text/json");
                    out.print("{\"id\":\"" + appointmentID + "\" \"action\":\"" + request.getMethod() + "\",\"status\":\"" + statusMessage + "\"}");
                    break;
                case "text/xml":
                case "application/xml":
                    response.setContentType("text/xml");
                    out.print("<appointment id=\"" + appointmentID + "\" action=\"" + request.getMethod() + "\" status=\"" + statusMessage + "\" />");
                    break;
                default:
                    response.setContentType("text/html");
                    if (request.getMethod().equalsIgnoreCase("POST")) {
                    	response.sendRedirect("dailyview.jsp?date="+date);
                    } else {
                        // when specifically requesting a non-JSON or non-XML Content-Type, use a HTML output by default with fairly reliably unique IDs referencing class name
                        out.print("<div id=\"" + this.getClass().getCanonicalName() + "\" class=\"error\"><span id=\"" + this.getClass().getCanonicalName() + "-action\">" + request.getMethod() + "</span><span id=\"" + this.getClass().getCanonicalName() + "-status\">" + statusMessage + "</span></div>");                    	
                    }
                    break;
            }
        } else {
            response.setContentType("text/html");
            // default basic text feedback
            out.print(request.getMethod() + " " + statusMessage);
        }
    
    }
    
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response); //used by FORM
    }

    /**
     * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
     */
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response); //used by AJAX
    }

}
