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
@WebServlet("/addUser")
public class AddUserServlet extends HttpServlet {

    /**
     *
     */
    private static final long serialVersionUID = 2632189596550376734L;

    /**
     * Destruction of the servlet. <br>
     */
    public void destroy() {
        super.destroy(); // Just puts "destroy" string in log
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");
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
            userManager.addUser(user);
            userManager.addSalt(user, salt.toString());
            salt = null; //clear the salt prior to waiting for GC

            db.cleanupConnection(conn);
        } catch (ClassNotFoundException | SQLException | URISyntaxException ex) {
            ex.printStackTrace();
        }

        response.sendRedirect("/");
    }

    public void init() throws ServletException {
// Put optional init code here
    }
}
