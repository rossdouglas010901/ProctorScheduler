package com.oultoncollege.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DateTimeException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oultoncollege.db.AppointmentDAO;
import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.model.Appointment;
import com.oultoncollege.util.DateTimeConverter;
import com.oultoncollege.util.PreventXSS;

import java.sql.Connection;
import javax.servlet.annotation.WebServlet;

/**
 * AddAppointmentServlet.java Servlet implementation class to facilitate adding appointments.
 *
 * @author JooHyung Song
 * @author bcopeland
 */
@WebServlet("/addAppointment")
public class AddAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddAppointmentServlet() {
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, DateTimeException {
        //fetch all the POST'ed FORM parameters required to schedule an Appointment event in the Calendar
        String title = PreventXSS.filter(request.getParameter("title"));
        String date = PreventXSS.filter(request.getParameter("date"));
        String start = PreventXSS.filter(request.getParameter("startTime"));
        if (date == null || date.equals("")) {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date today = new Date();
            date = dateFormat.format(today);
    	}
        Timestamp startTime = DateTimeConverter.convertDateTimeTextToSQL(date + " " + start + ":00");
        String end = PreventXSS.filter(request.getParameter("endTime"));
        if (DateTimeConverter.validTimeslot(start.split(":")[0], end.split(":")[0])) {
            Timestamp endTime = DateTimeConverter.convertDateTimeTextToSQL(date + " " + end + ":00");
            String description = PreventXSS.filter(request.getParameter("description"));
            // Add a special removal method and  
            description = description.replaceAll("[^A-Za-z0-9\n]|\n(?!(([^\"]*\"){2})*[^\"]*$)", "<br />");
            String location = PreventXSS.filter(request.getParameter("location"));
            int studentCount = Integer.parseInt(PreventXSS.filter(request.getParameter("studentCount")));
            int proctorID = (request.getParameter("proctor") == null) ? 1 : Integer.parseInt(PreventXSS.filter(request.getParameter("proctor")));
            int courseID = Integer.parseInt(PreventXSS.filter(request.getParameter("course")));
            int appointmentTypeID = Integer.parseInt(PreventXSS.filter(request.getParameter("appointmentType")));

            // build Appointment Object
            Appointment appointment = new Appointment(0, startTime, endTime, title, description, location, studentCount, proctorID, courseID, appointmentTypeID);

            // create Appointment in Database 
            try {
                DatabaseConnection db = new DatabaseConnection();
                Connection conn = db.getConnection();

                AppointmentDAO appointmentManager = new AppointmentDAO(conn);
                appointmentManager.createAppointment(appointment);

                db.cleanupConnection(conn);
                
            } catch (SQLException | ClassNotFoundException | URISyntaxException ex) {
                ex.printStackTrace();
            }

        } else {
        	throw new DateTimeException(end);
        }

        // send user back to the DailyView of the date which just had a record added
        response.sendRedirect("dailyview.jsp?date=" + date);
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

}
