package com.oultoncollege.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URISyntaxException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oultoncollege.db.AppointmentDAO;
import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.model.Appointment;
import com.oultoncollege.util.PreventXSS;
import java.net.HttpURLConnection;
import java.sql.Connection;

/**
 * Servlet implementation class DeleteAppointment
 */
@WebServlet({"/DeleteAppointment", "/deleteAppointment"})
public class DeleteAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteAppointmentServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int appointmentID = Integer.parseInt(PreventXSS.filter(request.getParameter("id")));
        String statusMessage = "";
        int statusCode = 0;

        // create Appointment in Database 
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConnection();
            AppointmentDAO appointmentManager = new AppointmentDAO(conn);
            Appointment appointment = appointmentManager.getAppointmentByID(appointmentID);
//TODO: need to decide on final Auth approach to determine proper roles
            /*
            if (request.getUserPrincipal() != null && request.getRemoteUser() != null
                    && (request.getUserPrincipal().getName().equals("admin")
                    || request.getUserPrincipal().getName().equals("proctor")
                    || request.getUserPrincipal().getName().equals("teacher"))) {
             */
            int rowsAffected = appointmentManager.deleteAppointment(appointment);
            if (rowsAffected > 0) {
                statusMessage = "succeeded";
                statusCode = HttpURLConnection.HTTP_OK;
            } else {
                statusMessage = "error";
                statusCode = HttpURLConnection.HTTP_BAD_REQUEST;
            }
            /*
            } else {
                statusMessage = "unauthorized";
                statusCode = HttpURLConnection.HTTP_FORBIDDEN;
            }
             */
            db.cleanupConnection(conn);
        } catch (SQLException | URISyntaxException | ClassNotFoundException ex) {
            ex.printStackTrace();
            statusMessage = "failed";
            statusCode = HttpURLConnection.HTTP_INTERNAL_ERROR;
        }
        response.setStatus(statusCode);

        PrintWriter out = response.getWriter();

        if (request.getContentType() != null) {
            switch (request.getContentType().toLowerCase()) {
                case "text/json":
                case "application/json":
                    response.setContentType("text/json");
                    out.print("{\"action\":\"" + request.getMethod() + "\",\"status\":\"" + statusMessage + "\", \"id\":\"" + appointmentID + "\"}");
                    break;

                case "text/xml":
                case "application/xml":
                    response.setContentType("text/xml");
                    out.print("<appointment action=\"" + request.getMethod() + "\" status=\"" + statusMessage + "\"><id>" + appointmentID + "</id></appointment>");
                    break;
                default:
                    response.setContentType("text/html");
                    //when specifically requesting a non-JSON or non-XML Content-Type, use a full HTML output by default with fairly reliably unique IDs referencing class name
                    out.print("<div id=\"" + this.getClass().getCanonicalName() + "\" class=\"error\"><span id=\"" + this.getClass().getCanonicalName() + "-action\">" + request.getMethod() + "</span><span id=\"" + this.getClass().getCanonicalName() + "-status\">" + statusMessage + "</span></div>");
                    break;
            }
        } else {
            response.setContentType("text/html");
            //default basic text feedback
            out.print(request.getMethod() + " " + statusMessage);
        }
    }

}
