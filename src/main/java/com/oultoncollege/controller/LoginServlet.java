package com.oultoncollege.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oultoncollege.db.DatabaseConnection;
import com.oultoncollege.db.Login;
import com.oultoncollege.db.UserDAO;
import com.oultoncollege.model.User;
import java.sql.Connection;

/**
 * LoginServlet.java Logs a user in by checking their username (email) and password for validity.
 *
 * @author Liu Youfeng
 */
//@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public LoginServlet() {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ServletContext appContext = getServletContext();
        String app = appContext.getContextPath();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User loginBean = new User();
        loginBean.setEmail(email);
        loginBean.setPassword(password);

        Login loginDao = new Login();
        try {
            String userValidate = loginDao.authenticateUser(loginBean);

            // connect to DB
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConnection();

            // lookup User record
            UserDAO userManager = new UserDAO(conn);

            User user = userManager.getUserByEmail(email);
            if (user == null) {
            	request.setAttribute("badCredentials", true);
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
            db.cleanupConnection(conn);

            // Creating a session
            HttpSession session = request.getSession();
            // setting session attributes for the Logged in user's Email & Fullname
            session.setAttribute("loggedInUserID", user.getUserID());
            session.setAttribute("loggedInUserEmail", user.getEmail());
            session.setAttribute("loggedInUserFullname", user.getFirstName() + " " + user.getLastName());

            // route the user to the next URL based on their role
            if (userValidate.equals("admin")) {
                System.out.println("Administrative Panel");
                session.setMaxInactiveInterval(100 * 60); //ADMIN Users have the longer session as they may be entering alot of data
                response.sendRedirect(app + "/users");
            } else if (userValidate.equals("proctor") || userValidate.equals("teacher")) {
                System.out.println("Proctor Calendar entry");
                session.setMaxInactiveInterval(10 * 60); //PROCTOR & TEACHER Users are medium length, as they may be browsing the upcoming calendar
                response.sendRedirect(app + "/calendar.jsp");
            } else if (userValidate.equals("student")) {
                System.out.println("Student's Landing Page");
                session.setMaxInactiveInterval(1 * 60); //Users like STUDENT have a shorter session interval as all they can do is email Teachers
                response.sendRedirect(app + "/contact.jsp");
            } else {
                System.out.println("Error message = " + userValidate);
                System.out.println(userValidate);
            	request.setAttribute("badCredentials", true);
                request.setAttribute("errMessage", userValidate);
                //NOTE: don't need to prepend "app" context on error pages as its a request forward, not a full response redirect
                request.getRequestDispatcher("/error.jsp").forward(request, response);
            }
        } catch (IOException e1) {
            e1.printStackTrace();
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e2) {
            e2.printStackTrace();
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    } // End of doPost()
}
