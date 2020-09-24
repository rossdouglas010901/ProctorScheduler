package com.oultoncollege.view;

import com.oultoncollege.db.AppointmentDAO;
import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.model.Appointment;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * AppointmentSearchServlet.java
 *  Search for a specific Appointment or just list all Appointments.
 * s
 * @author bcopeland
 */
@WebServlet("/appointments")
public class AppointmentSearchServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 8470983723087881241L;

	/**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        

        DatabaseConnection db = new DatabaseConnection();
        List<Appointment> appointments = new ArrayList<>();
        try {
            AppointmentDAO appointmentManager = new AppointmentDAO(db.getConnection());
            appointments = appointmentManager.getAppointments();
        } catch(SQLException | ClassNotFoundException | URISyntaxException ex) {
            ex.printStackTrace();
        }

        //populate list of Appointment object
        request.setAttribute("appointmentList", appointments);
        //additional page attributes
        request.setAttribute("url", "/");

        //route requests to this Servlet to "/admin/appointments.jsp" which is our "JSTL-syntaxed" JSP listing all Appointments (and for bulk Appointment entry)
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin/appointments.jsp");
        rd.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Appointment lookup";
    }// </editor-fold>

}
