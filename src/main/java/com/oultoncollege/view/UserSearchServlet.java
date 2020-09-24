package com.oultoncollege.view;

import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.db.UserDAO;
import com.oultoncollege.model.User;
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
 *
 * @author bcopeland
 */
@WebServlet("/users")
public class UserSearchServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = -8896781814869206494L;

	/**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = new ArrayList<>();

        DatabaseConnection db = new DatabaseConnection();
        try {
            UserDAO userManager = new UserDAO(db.getConnection());
            users = userManager.getUsers();
        } catch(SQLException | ClassNotFoundException | URISyntaxException ex) {
            ex.printStackTrace();
        }

        //populate list of User object
        request.setAttribute("userList", users);
        //additional page attributes
        request.setAttribute("url", "/");

        //route requests to this Servlet to "/admin/users.jsp" which is our "JSTL-syntaxed" JSP (for bulk User Management)
        RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin/users.jsp");
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
