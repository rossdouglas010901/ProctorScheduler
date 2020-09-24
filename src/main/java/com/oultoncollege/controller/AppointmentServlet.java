package com.oultoncollege.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.function.Predicate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oultoncollege.db.AppointmentDAO;
import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.model.Appointment;
import com.oultoncollege.util.DateTimeConverter;
import com.oultoncollege.util.PreventXSS;

/**
 * Servlet implementation class AppointmentServlet.
 */
@WebServlet(asyncSupported = true, urlPatterns = {"/appointment"})
public class AppointmentServlet extends HttpServlet {

// TODO migrate Add, Edit and Delete-specific AppointmentServlets to here, using HTTP Verb to decide which method/operation to perform
    private static final long serialVersionUID = -3008884043071308197L;

    private static final String DAY_START_TIME = "08:00:00";
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AppointmentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        //receive a date and calculate the whole month's "Daily Appointment" counts, for each day
        String start = PreventXSS.filter(request.getParameter("start"));
        String end = PreventXSS.filter(request.getParameter("end"));
        String type = (null != PreventXSS.filter(request.getParameter("type"))) ? PreventXSS.filter(request.getParameter("type")) : "";

        String monthStart = (start == null || start.isEmpty()) ? "" + DateTimeConverter.getMonthStart(LocalDate.now()) : start;
        String monthEnd = (end == null || end.isEmpty()) ? "" + DateTimeConverter.getMonthEnd(LocalDate.now()) : end;
        
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection connection = db.getConnection();

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss:SSS").withLocale(Locale.CANADA);
            LocalDateTime startDate = LocalDateTime.parse(monthStart + " 00:00:00:001", formatter);
            LocalDateTime endDate = LocalDateTime.parse(monthEnd + " 23:59:59:999", formatter);
            Timestamp startTimeStamp = Timestamp.valueOf(startDate);
            Timestamp endTimeStamp = Timestamp.valueOf(endDate);

            AppointmentDAO appointmentManager = new AppointmentDAO(connection);
            List<Appointment> appointments = appointmentManager.getAppointmentsByDate(startTimeStamp, endTimeStamp); //build list of Appointments in chosen month (just one query for a list of all appointments in date range)

            //build JSON response
            String appointmentJSON = "{ \"calendarAppointments\" : [";
            if (type.equalsIgnoreCase("day")) {
                // display all appointments and their details for a single day
                for (Appointment appointment : appointments) {
                    String startTime = appointment.getStartTime().toString().split(" ")[1];
                    String endTime = appointment.getEndTime().toString().split(" ")[1];
                    appointmentJSON += "{\"id\" : \""+appointment.getAppointmentID()+"\", "
                            + "\"title\" : \""+appointment.getTitle()+"\", "
                            + "\"description\" : \""+appointment.getDescription()+"\", "
                            + "\"students\" : \""+appointment.getStudentCount()+"\", "
                            + "\"start\" : " + DateTimeConverter.calculateTimeslot(DAY_START_TIME, startTime) + ", "
                            + "\"end\": " + DateTimeConverter.calculateTimeslot(DAY_START_TIME, endTime) + "}, ";
                }
            } else {
                // display all appointments without details for a full month                                
                for (LocalDateTime date = startDate; date.isBefore(endDate); date = date.plusDays(1)) {
                    String theDate = date.toString().split("T")[0];
                    System.out.println("Looking for any Appointments on date: '" + date + "'");
                    //build Stream of Appointments to perform a count on those occurring the same Date
                    Predicate<Appointment> predicate = s -> s.getStartTime().toString().contains(theDate);
                    long dateCount = appointments.stream().filter(predicate).count();
                    appointmentJSON += "{\"calendarDate\" : \"" + theDate + "\", \"appointmentCount\": \"" + dateCount + "\"}, ";
                }
            }
            if (appointments.size() >= 1) {
                appointmentJSON = appointmentJSON.substring(0, appointmentJSON.lastIndexOf(", ")) + "]}";
            } else {
                appointmentJSON += "]}";
            }

            response.setContentType("application/json");
            out.print(appointmentJSON);

            db.cleanupConnection(connection);

        } catch (SQLException | URISyntaxException | ClassNotFoundException ex) {
            ex.printStackTrace();
            out.print("{\"error\": \"Can't reach or query DB\"}");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
