<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.oultoncollege.db.Settings"%>
<%@page import="com.oultoncollege.db.DatabaseConnection"%>
<%@page import="com.oultoncollege.model.Appointment"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.sql.*"%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    <h1>User Information</h1>
       
    <%
        DatabaseConnection dc = new DatabaseConnection();
        try {
            //dc.getConnection();
            Class.forName(Settings.DB_DRIVER);
            String dbPath = "jdbc:" + Settings.DB_TYPE + "://" + Settings.DB_HOST + ":" + Settings.DB_PORT + "/" + Settings.DB_NAME;
            Connection dbConnection = DriverManager.getConnection(dbPath, Settings.DB_USER, Settings.DB_PWD);               

//TODO: Mocked out Appointment object since none in Database
            LocalDate today = LocalDate.now(ZoneId.of("America/Halifax"));
            Timestamp appointmentStart = Timestamp.valueOf(today.toString());
            Timestamp appointmentEnd = Timestamp.valueOf(today.plusDays(1).toString());
            Appointment testAppointment = new Appointment(); 
                    //new Appointment(1,"Super important meeting","Some thing","Some place", appointmentStart, appointmentEnd, 1);
            List<Appointment> appointments = new ArrayList<Appointment>();
            appointments.add(testAppointment);
                   
//List<Appointment> appointments = dc.getAppointment(null);           
            for (Appointment appointment : appointments) {
	           out.print("<h2>Title: " + appointment.getTitle() +  "</h2>" );
	           out.print("<p>Description: " + appointment.getDescription() +  "</p>" );
	           out.print("<p>Location: " + appointment.getLocation() +  "</p>" );
	           out.print("<p>Start Date: " + appointment.getStartTime() +  "</p>" );
	           out.print("<p>End Date: " + appointment.getEndTime() +  "</p>" );
            }
            
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
     %>
</body>
</html>