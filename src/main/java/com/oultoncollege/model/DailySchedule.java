package com.oultoncollege.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.text.ParseException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.net.URISyntaxException;
import java.sql.SQLException;
import com.oultoncollege.JspCalendar;
import com.oultoncollege.db.AppointmentDAO;
import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.db.UserDAO;
import com.oultoncollege.util.DateTimeConverter;
import java.sql.Timestamp;

/**
 * DailySchedule.java Daily Schedule to backing Bean.
 *
 * @author bcopeland
 */
public class DailySchedule {

    Hashtable<String, Entries> table;
    JspCalendar jspCal;
    Entries entries;
    String date;
    String name = null;
    String email = null;
    boolean processError = false;
    private User user = new User();

    public DailySchedule() {
        this.table = new Hashtable<String, Entries>(14);
        this.jspCal = new JspCalendar();
        this.date = jspCal.getCurrentDate();
    }

    public String getName() {
        return this.name;
    }

    public void setName(String nm) {
        this.name = nm;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String mail) {
        this.email = mail;
    }

    public String getDate() {
        return this.date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Entries getEntries() {
        return this.entries;
    }

    public boolean getProcessError() {
        return this.processError;
    }

    /**
     * Previously it could only process GET and POST requests to the DailySchedule class made via "dailyview.jsp", however now it also loads any
     * Database-stored Appointments as we need to have Appointment persistence beyond just a single request or session.
     *
     * @param request
     * @throws ParseException
     */
    public List<Appointment> loadAppointments(HttpServletRequest request) throws ParseException {
        List<Appointment> appointments = new ArrayList<>();

        HttpSession session = request.getSession();
        this.processError = false;

        setName("" + session.getAttribute("loggedInUserEmail"));
        // Get the name and e-mail.
        if (name == null || name.isEmpty() || name.equals("null")) {
            this.processError = true;
            return null;
        } else {
            setEmail(session.getAttribute("loggedInUserEmail").toString());
            try {
                DatabaseConnection dc = new DatabaseConnection();
                UserDAO userManager = new UserDAO(dc.getConnection());
                userManager.getUserByEmail(getEmail());
                setName(user.getFirstName() + " " + user.getLastName());
            } catch (ClassNotFoundException | SQLException | URISyntaxException ex) {
                ex.printStackTrace();
            }
        }

        // Get the date
        String dateInput = request.getParameter("date");
        if (dateInput == null) {
            date = jspCal.getCurrentDate();
        } else if (dateInput.equalsIgnoreCase("next")) {
            date = jspCal.getNextDate();
        } else if (dateInput.equalsIgnoreCase("prev")) {
            date = jspCal.getPrevDate();
        } else {
            date = dateInput;
            Date formattedDate = DateTimeConverter.convertDateTextToSQL(date);
            jspCal.setSelectedDate(formattedDate);
        }

        // Load any Appointments stored in DB
        DatabaseConnection db = new DatabaseConnection();
        try {
            AppointmentDAO appointmentManager = new AppointmentDAO(db.getConnection());
            Timestamp start = DateTimeConverter.convertDateTimeTextToSQL(date + " 00:00:00");
            Timestamp end = DateTimeConverter.convertDateTimeTextToSQL(date + " 23:59:59");
            appointments = appointmentManager.getAppointmentsByDate(start, end);

            // if time parameter is provided add the event
            String time = request.getParameter("startTime");
            String desc = request.getParameter("description");
            if (time != null) {
                System.out.println("***REQUEST*** | TIME: " + time + " | DESC: " + desc);
                entries.addAppointmentTimeslot(time, desc);
            } else if (appointments != null && appointments.size() > 0) {
                System.out.println("Appointments stored in DB on chosen day: ");
                for (Appointment appointment : appointments) {
                    Timestamp startTime = appointment.getStartTime();
                    Timestamp endTime = appointment.getEndTime();
                    String dateTime = DateTimeConverter.convertTimestampToText(startTime);
                    String description = appointment.getDescription();
                    System.out.println("***DB*** | START: " + startTime + " | END: " + endTime + " | DATETIME: " + dateTime + " | DESC: " + description);
                    entries.addAppointmentTimeslot(dateTime, description);
                }
            } else {
                System.out.println("No appointment times provided on this request, and none found in DB");
            }

            // Application scoped list of scheduled Appointments
            entries = table.get(date);
            if (entries == null) {
                entries = new Entries();
                table.put(date, entries);
            }
        } catch (SQLException | URISyntaxException | ClassNotFoundException | NullPointerException ex) {
            ex.printStackTrace();
        }
        return appointments;
    }

    public List<Appointment> loadPersonalEvents(HttpServletRequest request) throws ParseException {
        List<Appointment> appointments = new ArrayList<>();

        HttpSession session = request.getSession();
        this.processError = false;

        setName("" + session.getAttribute("loggedInUserEmail"));
        // Get the name and e-mail.
        if (name == null || name.isEmpty() || name.equals("null")) {
            this.processError = true;
            return null;
        } else {
            setEmail(session.getAttribute("loggedInUserEmail").toString());
            try {
                DatabaseConnection dc = new DatabaseConnection();
                UserDAO userManager = new UserDAO(dc.getConnection());
                userManager.getUserByEmail(getEmail());
                setName(user.getFirstName() + " " + user.getLastName());
            } catch (ClassNotFoundException | SQLException | URISyntaxException ex) {
                ex.printStackTrace();
            }
        }

        // Get the date
        String dateInput = request.getParameter("date");
        if (dateInput == null) {
            date = jspCal.getCurrentDate();
        } else if (dateInput.equalsIgnoreCase("next")) {
            date = jspCal.getNextDate();
        } else if (dateInput.equalsIgnoreCase("prev")) {
            date = jspCal.getPrevDate();
        } else {
            date = dateInput;
            Date formattedDate = DateTimeConverter.convertDateTextToSQL(date);
            jspCal.setSelectedDate(formattedDate);
        }

        // Load any Appointments stored in DB
        DatabaseConnection db = new DatabaseConnection();
        try {
            AppointmentDAO appointmentManager = new AppointmentDAO(db.getConnection());
            int proctorID = Integer.parseInt(session.getAttribute("loggedInUserID").toString());
            //int proctorID = 4;
            appointments = appointmentManager.getAppointmentsByUser(proctorID);

            // if time parameter is provided add the event
            String time = request.getParameter("startTime");
            String desc = request.getParameter("description");
            if (time != null) {
                System.out.println("***REQUEST*** | TIME: " + time + " | DESC: " + desc);
                entries.addAppointmentTimeslot(time, desc);
            } else if (appointments != null && appointments.size() > 0) {
                System.out.println("Appointments stored in DB on chosen day: ");
                for (Appointment appointment : appointments) {
                    Timestamp startTime = appointment.getStartTime();
                    Timestamp endTime = appointment.getEndTime();
                    String dateTime = DateTimeConverter.convertTimestampToText(startTime);
                    String description = appointment.getDescription();
                    System.out.println("***DB*** | START: " + startTime + " | END: " + endTime + " | DATETIME: " + dateTime + " | DESC: " + description);
                    entries.addAppointmentTimeslot(dateTime, description);
                }
            } else {
                System.out.println("No appointment times provided on this request, and none found in DB");
            }

            // Application scoped list of scheduled Appointments
            entries = table.get(date);
            if (entries == null) {
                entries = new Entries();
                table.put(date, entries);
            }
        } catch (SQLException | URISyntaxException | ClassNotFoundException | NullPointerException ex) {
            ex.printStackTrace();
        }
        return appointments;
    }
    
}
