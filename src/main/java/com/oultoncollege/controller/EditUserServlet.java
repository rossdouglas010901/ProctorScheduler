package com.oultoncollege.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.db.UserDAO;
import com.oultoncollege.model.User;
import com.oultoncollege.util.PreventXSS;
import com.oultoncollege.util.SHA256Util;
import java.sql.Connection;
import javax.servlet.annotation.WebServlet;

/**
 * AddUserServlet
 *
 * @author bcopeland
 */
@WebServlet("/editUser")
public class EditUserServlet extends HttpServlet {

    /**
     *
     */
    private static final long serialVersionUID = 2340912802304124L;

    /**
     * Destruction of the servlet. <br>
     */
    public void destroy() {
        super.destroy(); // Just puts "destroy" string in log
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().write("GET method not supported for /editUser");
    }
    
    public void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");
        int userID = Integer.parseInt(PreventXSS.filter(request.getParameter("userID")));
        String email = PreventXSS.filter(request.getParameter("email"));
        String password = PreventXSS.filter(request.getParameter("password"));
        String firstname = PreventXSS.filter(request.getParameter("firstname"));
        String lastname = PreventXSS.filter(request.getParameter("lastname"));
        String phoneNumber = PreventXSS.filter(request.getParameter("phoneNumber"));
        String ext = PreventXSS.filter(request.getParameter("phoneExtension"));
        int accountTypeID = Integer.parseInt(PreventXSS.filter(request.getParameter("accountType")));

        SHA256Util hash = new SHA256Util();
        byte[] salt = null;
        try {
            salt = hash.getSalt().getBytes();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        //NOTE: we need to store this securely, but separately from the "users" table using "m:n" mapping table
        String securePassword = hash.getSHA256(password, salt);

        User user = new User();
        user.setUserID(userID);
        user.setEmail(email);
        user.setPassword(securePassword);
        user.setFirstName(firstname);
        user.setLastName(lastname);
        user.setPhoneNumber(phoneNumber);
        user.setPhoneExt(ext);
        user.setAccountTypeID(accountTypeID);

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConnection();

            UserDAO userManager = new UserDAO(conn);
            userManager.updateUser(user);
            userManager.updateSalt(user, salt.toString());
            salt = null; //clear the salt prior to waiting for GC

            db.cleanupConnection(conn);
        } catch (ClassNotFoundException | SQLException | URISyntaxException ex) {
            ex.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/users");
    }

    /**
     * @see HttpServlet#doPut(HttpServletRequest request, HttpServletResponse response)
     */   
    public void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	processRequest(request, response); //used by FORM
    }
    
    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response); //used by FORM
    }
    
    public void init() throws ServletException {
    	// Put optional init code here
    }
}
