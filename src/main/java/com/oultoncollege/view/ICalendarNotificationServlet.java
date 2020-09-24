package com.oultoncollege.view;

import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
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
import com.oultoncollege.util.PreventXSS;

/**
 *
 * @author bcopeland
 */
@WebServlet("/ical")
public class ICalendarNotificationServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = -4236352201369729017L;

	/**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        //input params "/ical?id=1&proctorEmail=bcopeland@oultoncollege.com"
        int appointmentID = Integer.parseInt(PreventXSS.filter(request.getParameter("id")));
        String proctorEmail = PreventXSS.filter(request.getParameter("proctorEmail"));        

        User user = new User();
        Appointment appointment = new Appointment();
        DatabaseConnection db = new DatabaseConnection();
        try {
            
            UserDAO userManager = new UserDAO(db.getConnection());
            user = userManager.getUserByEmail(proctorEmail);
            
            AppointmentDAO appointmentManager = new AppointmentDAO(db.getConnection());
            appointment = appointmentManager.getAppointmentByID(appointmentID);
            
        } catch(SQLException | ClassNotFoundException | URISyntaxException ex) {
            ex.printStackTrace();
        }

        //populate User and Appointment objects
        request.setAttribute("user", user);
        request.setAttribute("appointment", appointment);
        
        //additional page attributes
        request.setAttribute("url", "/");

        //route requests to this Servlet to "employee.jsp" which is our "JSTL-syntaxed" JSP
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/ical.jsp");
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
        return "User lookup";
    }// </editor-fold>

}
